Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBAC51FF40
	for <e@80x24.org>; Mon, 27 Jun 2016 04:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbcF0Eda (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 00:33:30 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33657 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbcF0Ed3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 00:33:29 -0400
Received: by mail-io0-f178.google.com with SMTP id t74so142989806ioi.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 21:33:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iqHclMLRkMhKYM6dqrn4z9xvXRGPRcSM9YAM51SZxYM=;
        b=Lmr6EICWv5NGPZ3ot4r74jE7dI02ufgHP4WGbiPj1+NHLXuEfZ1WUt8MncGCs8b9EV
         Fg2CPWWCHkyjZXrg+2TwJldxqyRa1SwcD1HJx5DVC4YW1fRFjVdOOtovOvZGgi9BHSJg
         9W8avuB4gmU+HWlXaZbDULP227FfaQTWIaJtKr76uMMTd407+LZwWkj8XEw70pvxZkxr
         yQVR3M4pZFmuaM4iGYCq5qG8C27fn5WgpIM42D7wV/sWMVJdRKwdFaKFHPMsKNWxJH5l
         vM7ldOjFtcO6hEfgLyQNoUgclHBb1AYz1ghCM4x4Kn++WIiGJcDopl8GsaE6UjdiG/uz
         WF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iqHclMLRkMhKYM6dqrn4z9xvXRGPRcSM9YAM51SZxYM=;
        b=m4co5ZTA0JPct/TLS3kFAvOk7Pfhancuh2OhcMa71Vb80+c2Fjq+CNWbhkC/K8b3Qe
         oiJHpq55QB1OuIYYRGkAbKFdJbDT4lXaR6kiELx8lt9eQkqGV919uS4YuiUf9a74CT+z
         N9jPGepiv9P5U1sk8GFaE1p943dF2Qe9cXblD8N09qMHfpHadC7rpjDFqOhWIPxt+Pul
         F1mqOkh5+O+zm6vGDBaJOeEdvv4rFi+as9mhfxP6UrSF9i356eECuTbZDEJCGgu9sFGM
         uQ0UzXEImY4lcNh/W6gyMn3IqE0ADgQ0N0vPsqF02EcT51n9+Km0hGEQy9N9exxHm1SO
         dRGw==
X-Gm-Message-State: ALyK8tIjSRo7sBSei9EEjp9k6/NlTlcXU8Q3sqq/5WXvpqWQZmdqcYEsOqaAFy4ekcSAl+jlweTG+XJ6pKrGoQ==
X-Received: by 10.107.132.28 with SMTP id g28mr16593603iod.34.1467002008695;
 Sun, 26 Jun 2016 21:33:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Sun, 26 Jun 2016 21:33:28 -0700 (PDT)
In-Reply-To: <20160626055810.26960-6-pclouds@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com> <20160626055810.26960-1-pclouds@gmail.com>
 <20160626055810.26960-6-pclouds@gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Mon, 27 Jun 2016 00:33:28 -0400
X-Google-Sender-Auth: HyDVrDcU_rhZOsFyk2IwM-QQ-vY
Message-ID: <CAPig+cT=BAuAbEmS5G1v2yGNczA+-WvW0bBZz_hrLcYi0bpO4g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] fetch: reduce duplicate in ref update status lines
 with placeholder
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 1:58 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> In the "remote -> local" line, if either ref is a substring of the
> other, the common part in the other string is replaced with "$". For
> example
>
>     abc                -> origin/abc
>     refs/pull/123/head -> pull/123
>
> become
>
>     abc         -> origin/$
>     refs/$/head -> pull/123

Bikeshedding...

I think I recall in an earlier iteration that you asked for opinions
about '$', but don't recall if there were responses. Have you
considered '*' rather than '$'?

In my brain, at least, '$' is associated so strongly with regex that
"origin/$" is interpreted automatically as anchoring "origin/" at the
end of string, and "refs/$/head" just feels weird.

On the other hand, given the familiarity of shell globbing, "origin/*"
and "refs/*/head" feel quite natural and intuitive.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> @@ -116,6 +116,11 @@ representing the status of a single ref. Each line is of the form:
> +In compact output mode, if either entire `<from>` or `<to>` is found
> +in the other string, it will be substituted with `$` in the other
> +string. or example, `master -> origin/master` becomes

s/or/For/

> +`master -> origin/$`.
