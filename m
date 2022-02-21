Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE24C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 20:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiBUUfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:35:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBUUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 15:35:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91529237CC
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645475677;
        bh=v7mTNDPOWk2K+byYR3ZsaXL0GkUQ+aV0e8hm23SbN7Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Fcps9XOR7vRrYbpmo9TQWoKVCEYOinGLEbcoToKheHi8lJ/xYZ2s9R2ql9lRu0fBh
         Y4Sv58c9Fj6OdJ8wPYTmlTVGPpLM5IXt5O+lad97GHNYzoPMRxq03tNQ079zwDbFXd
         72w+aLBBCm8KnYDMNrdB7dFY2tPKtNpM4cjAeizE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1oOM4Z06aU-013icV; Mon, 21
 Feb 2022 21:34:37 +0100
Date:   Mon, 21 Feb 2022 21:34:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
In-Reply-To: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d8CJx1zCyb2f5c+f9paBJZl3fvqJc5KPJt50m7L+2ARD56+tC1q
 SjwC72avlrHtF9mwpXd3vqw8SttCRZMgWr5asuFrIvnyoZHcmPOP3jwTKHgoJLpZ74DC6vh
 JBNUoOockC4UjGUISdIol28zlfOqN6ZZNxDYFhkZN1I+k/2eONnshLK9tbFUM/8p+fC6oFm
 1ZkMppXg6RbkbtoQ/S6tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZV71udNtLwc=:TeGNjhlM7ePGk3UvOAR3Ml
 j0Sk1XAAwE2nK461m2Dm1rvyyY8zpdXrNlFfUWq8co8//UFF8rxifcaZY5ixF5Fg4r61zwzPN
 DKm3Ckw01K3lGOjQG9DZ235vrPGHkRHIT7PmRZYoR/MuZRELNkRYck5rfjR/c27d5WGav6G/b
 HhiInUspotAFVmytPBI6uFfBaCWkyW0bNmZFdhN57El1Vpd5lDvA9upgZmrwDzBuE1T0gt6ge
 fQUR8OZzRfJqS0asvFQ/k8CwpHOpqCroAZrTK/OiSokGE+twKAXBj6GqHON46NFQUo+CRPXm6
 w+xJUWOI7S/mxMN2/fPWj9f2n2B2EYUzo5N7RRPesQTFk3CupxMQ9y73452HH+giTRJJmzq9i
 kmJS/dsZRJfN0IQVkOaKWFcKW0VpnS9uy8POzOkPM7k0E7Efn2JFoRW96ZkvmLRvw6fURaFXv
 eYAV7nOfswBQYa7DJlV1zihsB6klEB4y0T70MA9wGpugHBfB0dQNpeAt4cYoU1eoKkw1hiDIi
 2kt5wdPlxjKvMjpd+n2OY8yB8WMqwdBziO493fLKCYdsFXlKy6vahsKiALSwDayDpsQI9h9KQ
 jd6VKl7yZQxxT9VOkYjLeipuTkpP4GA3qi/U0NSZotb8A5vOKtsfyUxQahdgrTJHVU9BOvUNZ
 WgVPEVJ4SdnhmInJq3CTVvA4AiqoFOo1jSGkCXHkVAnL73v308dAsdbADGjhsdvgW1cU33xiM
 z4LvEKV7ef4l9e9aCnwPp49XEYcTodmmKRTk4iaXTs+1oCzBrqJ6naNOfEJQdTQhYaXhkPkXF
 TWZ4Mtsze2WzgHQNnq4eyfxLibuNZqlIKuSYytR5z87Cd+uLCDhunSLl/dAB0gX8kFAM9PrU2
 QxxlgYSyVqyQh/IN/+eS93vPUqNQvVFUEuBGFzUCYugBiq6j6dpphyNaqsZPEJPMK4J2U5KGs
 MlONp3v3pr0WZLpmxXZMTF+h288Lj+udz1r3AZ+3Af0NS5AS0N4260JCR7juL2CxTydHRxNGP
 i5IsTGbqQMfKk7SZCl2F3tdd7YF6kpIZrW51lPIN3ep/O18MjL8IcHwlKrkfiXQFJD+UvQ3AQ
 w6JJyEoIbeac7U=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

In addition to Stolee's feedback...

On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:

> diff --git a/config.c b/config.c
> index 2bffa8d4a01..68e877a1d80 100644
> --- a/config.c
> +++ b/config.c
> @@ -1520,6 +1520,11 @@ static int git_default_core_config(const char *va=
r, const char *value, void *cb)
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
> +		core_expect_files_outside_sparse_patterns =3D git_config_bool(var, va=
lue);
> +		return 0;
> +	}

The `core` section is already quite crowded (for which I am partially
responsible, of course).

Maybe it would be a good idea to introduce the `sparse` section, using
`sparse.allowFilesMatchingPatterns` or `sparse.applyPatternsToWorktree =3D
false`?

Ciao,
Dscho
