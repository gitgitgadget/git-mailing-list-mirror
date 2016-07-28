Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3041F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbcG1Q02 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:26:28 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35608 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516AbcG1Q01 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:26:27 -0400
Received: by mail-io0-f176.google.com with SMTP id m101so104387988ioi.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:26:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M6uSrFhNxbyMn4k5+mp97sauvUilMsCYTADWlEE0BPg=;
        b=hxhuW6r7DlEIhIx3rieP4uvP+VDIcUS3Q2nPGIAwZBQmUcFhv8A/roFYWrzLpbMNOk
         6feeN8pkEa/riqXNIs1U3V8OCDML/QAIykTyUeBSuyZJ1RXREplNg6VjR3HsDSNwNnIf
         k+YJn4sXoTlkPICUOQx+LuH7VfpBiGKyuyj+7o2LU6oSenpV2Q+qU+CmQKIm7Xdj2iLe
         GbZgt81AUhRpiA1t0kftM4LzVCbfUuG0sB17r2kNrcalgG2Sq9T8hPDThndJw9yU7G3a
         yVVo0J8RLPc2tcwNI0saLb+JI+VVt1o2xJVmBxVAOaxNEhIC8xIz3gA341FE2E71jDvk
         wNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M6uSrFhNxbyMn4k5+mp97sauvUilMsCYTADWlEE0BPg=;
        b=JXbODfQJ9Yzes0DhUFzr7PQu7RsLeQxMzWyXx3xZJhAUeX788xmzqv1PZDVEAKoDvp
         lPb84sxCl70hpqiAbiZwsIoDj0aZvjDQ2DsR1wbmnvWwjk4sl7WPO7aacJjnrBSr0VIk
         Ka/ss1ME2crG6ws9P9nS4EK6H/tXOLSjagus9iUCMK041WL+HLozqYs++b3cuR2G+jJZ
         5OSz/+6snipTXp+4Y5D0PNblvxGAkOhrFf5x24WPInid7Oco0HmWoKoXpLXjWFK2T52K
         2fyFQOdQIt6tzXb4ElGssIB1n9YwzTAoRVgdkAUMsy6eCaD+OYRnsboySxk4gMk3z7rk
         4xtw==
X-Gm-Message-State: AEkoousMeK0CHwtVrmwGMp0YzgLXWMTRG+a6H5+hUc6ikMbf0oBAJKcD0ogUj36ucclMu2bw+ZKURXf2HeLL6Tiy
X-Received: by 10.107.144.10 with SMTP id s10mr37701082iod.165.1469723186372;
 Thu, 28 Jul 2016 09:26:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 28 Jul 2016 09:26:26 -0700 (PDT)
In-Reply-To: <20160728124910.GA2530@sandbox>
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox> <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net> <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
 <xmqqmvl4xdlm.fsf@gitster.mtv.corp.google.com> <20160728124910.GA2530@sandbox>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 28 Jul 2016 09:26:26 -0700
Message-ID: <CAGZ79kbjDvOziGn+202gOc19Y6omwin9CGhhL3YydS=1qSPjwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule-config: passing name reference for
 .gitmodule blobs
To:	Heiko Voigt <hvoigt@hvoigt.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 5:49 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Commit 959b5455 (submodule: implement a config API for lookup of
> .gitmodules values, 2015-08-18) implemented the initial version of the
> submodule config cache. During development of that initial version we
> extracted the function gitmodule_sha1_from_commit(). During that process
> we missed that the strbuf rev was still used in config_from() and now is
> left empty. Lets fix this by also returning this string.
>
> This means that now when reading .gitmodules from revisions, the error
> messages also contain a reference to the blob they are from.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> Here you go. Now including a test.

All 3 patches look good to me, thanks!

>
> +test_expect_success 'error message contains blob reference' '
> +       (cd super &&
> +               sha1=$(git rev-parse HEAD) &&
> +               test-submodule-config \
> +                       HEAD b \
> +                       HEAD submodule \
> +                               2>actual_err &&
> +               grep "submodule-blob $sha1:.gitmodules" actual_err >/dev/null

Makes sense!
