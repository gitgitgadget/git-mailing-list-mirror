Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C1D1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfJ2Kis (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:38:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54557 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfJ2Kis (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:38:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id g7so1960770wmk.4
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbLLQm0RCQnxT+0IPA57KK1V1lOUHOYQX6oCpF/H6G8=;
        b=hu4k4xh+aeaS3uCYPUWvx7x4oLCT2nbPHFeA7GAfp3KiW98ixMumJo8mtjKraj7Oa4
         scwP3cf1Hgy6X5u72Lmj7OU71z36d6zGSHckLROJ2vXLTg1lWH8XxsZKbxWUA66pWIR1
         5rfVf05aLs2BMLnijsFxh5jNl03FyTgewME0gvY10oofOBJ+y89Qs7UW8vUwhFEHZNZ7
         zj4HFEvpGdnXiEOTBG9UzfrqO7daDWcI4Aofn8DOe0c8fN1h+IkKpdUr/NxzvpKwZAsH
         xht3cphU2MWdSo4ERl48m4s++/LQaAYI1kRgr41H34emyQPd1evA2H7/1NAsOpChvJqu
         Tdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbLLQm0RCQnxT+0IPA57KK1V1lOUHOYQX6oCpF/H6G8=;
        b=oSx0WSzTe985upHVHTffJ756rmuhv3RaMy1mvDyciWVxoV2KHojSVu2mj4ySeICBk8
         ko6r3amXXDASBMvaGJeQHP7znvnbXQQf0Aj+3pLi+aWqYBWpn3uofucVMSa5r3PmRifm
         dzYOX4d/KAt/UwVr4f14W6fLYQ0qIGblByJyqQ5/kyYY/YxQ5ngrlkxn/E8MfzrHB+aj
         doqGQLlif48sirBgr+sWhPPJepGTXDb1k/Ea4qrZIZP4weWbXaylResQk0ifXfOii+or
         kKhU60KhIP+ERSO/uM+HSNuNUh2D+2+hP9rh1ui6Ogafy2hhB9f0TnEMAqub/tvuXBTp
         hi+g==
X-Gm-Message-State: APjAAAU+IVftcrJ/TA+5SV3UPxhFZ4ax/X+hych5TTNcP9N75hgb6oXX
        Rla48HjdBYYpjcvybbuIhEg=
X-Google-Smtp-Source: APXvYqy5qVrW0LBgXCnNZP6QlfL93goyIguyLsRz0HIPdkRRSeGu5L9mDFkA4h9SBgD7XldlVrJFug==
X-Received: by 2002:a1c:f401:: with SMTP id z1mr3328061wma.66.1572345526038;
        Tue, 29 Oct 2019 03:38:46 -0700 (PDT)
Received: from szeder.dev (x4db971f1.dyn.telefonica.de. [77.185.113.241])
        by smtp.gmail.com with ESMTPSA id 189sm1939722wmc.7.2019.10.29.03.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:38:45 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:38:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of
 unbuffered one
Message-ID: <20191029103842.GV4348@szeder.dev>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 03:00:59PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The MSVC runtime behavior differs from glibc's with respect to
> `fprintf(stderr, ...)` in that the former writes out the message
> character by character.
> 
> In t5516, this leads to a funny problem where a `git fetch` process as
> well as the `git upload-pack` process spawned by it _both_ call `die()`
> at the same time. The output can look like this:
> 
> 	fatal: git uploadfata-lp: raemcokte :error:  upload-pnot our arcef k6: n4ot our ea4cr1e3f 36d45ea94fca1398e86a771eda009872d63adb28598f6a9
> 	8e86a771eda009872d6ab2886

Heh.

> Let's avoid this predicament altogether by rendering the entire message,
> including the prefix and the trailing newline, into the buffer we
> already have (and which is still fixed size) and then write it out via
> `write_in_full()`.

s/write_in_full/xwrite/ perhaps?  Both the cover letter and the patch
below use xwrite().

> The history of `vreportf()` with regard to this issue includes the
> following commits:
> 
> d048a96e (2007-11-09) - 'char msg[256]' is introduced to avoid interleaving
> 389d1767 (2009-03-25) - Buffer size increased to 1024 to avoid truncation
> 625a860c (2009-11-22) - Buffer size increased to 4096 to avoid truncation
> f4c3edc0 (2015-08-11) - Buffer removed to avoid truncation
> b5a9e435 (2017-01-11) - Reverts f4c3edc0 to be able to replace control
>                         chars before sending to stderr
> 9ac13ec9 (2006-10-11) - Another attempt to solve interleaving.
>                         This is seemingly related to d048a96e.
> 137a0d0e (2007-11-19) - Addresses out-of-order for display()
> 34df8aba (2009-03-10) - Switches xwrite() to fprintf() in recv_sideband()
>                         to support UTF-8 emulation
> eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulation,
>                         so it's safe to use xwrite() again
> 5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again
> 
> Note that we need to be careful to handle the return value of
> `vsnprintf()` that indicates the _desired_ byte count.
> 
> Also please note that we `fflush(stderr)` here to help when running in a
> Git Bash on Windows: in this case, `stderr` is not actually truly
> unbuffered, and needs the extra help.
> 
> Co-authored-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  usage.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/usage.c b/usage.c
> index 2fdb20086b..4328894dce 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -10,13 +10,19 @@ void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
>  	char *p;
> -
> -	vsnprintf(msg, sizeof(msg), err, params);
> +	size_t off = strlcpy(msg, prefix, sizeof(msg));
> +	int ret = vsnprintf(msg + off, sizeof(msg) - off, err, params);
>  	for (p = msg; *p; p++) {
>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
>  			*p = '?';
>  	}
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +	if (ret > 0) {
> +		if (off + ret > sizeof(msg) - 1)
> +			ret = sizeof(msg) - 1 - off;
> +		msg[off + ret] = '\n'; /* we no longer need a NUL */
> +		fflush(stderr);
> +		xwrite(2, msg, off + ret + 1);
> +	}
>  }
>  
>  static NORETURN void usage_builtin(const char *err, va_list params)
> -- 
> gitgitgadget
