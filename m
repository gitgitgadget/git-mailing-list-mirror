Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EECA1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 12:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfHYMHr (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 08:07:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42350 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYMHr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 08:07:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so12649260wrq.9
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0B7UYfuYZbGOpIBNdpPlCo4WT94cvMFrfRksbS056U4=;
        b=O/0GQiKsoBpxcFRLtO899ZEPuQk0gWX6u446uGoVx1xBENPABEM7VxjFahjRzCLlB6
         Q54QkNF4K5ussgFdNqbkj8Ja+wE9WthE8jrYo98zJqKDNzBwi8ZCKzaaJN49XTJd2i1d
         AlYgsbutty4kaN4Sl5Q6w5n+K/mxQSMsrWxaaGdI3at7S68UGADBSwit/rwdOs9jliCT
         KmC4V7SXVxB/ybsqavWEx+lMDeU/gZ/FSlFO6rsREUs8vaULkJYxxQlc6CyM6joQCQfC
         J92AtKSiAiZb8oLgWd1qcv0mQ3YjbM/93cbnRCFRO0DeYbEywcBMSYJa9yqm6NplVkpm
         Vqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0B7UYfuYZbGOpIBNdpPlCo4WT94cvMFrfRksbS056U4=;
        b=H6qwkL3Japti3lDDtX90rHj6cb0HzRpjCOIijy7VAoZYpoe1KTAf/g74QkvUo0sxDx
         tUZx9CgIjdPc5wQ1tmnZfEjNjETuRavnsOzU+fSgDkZb7QISF/sBxyc8Sy4Ow+M7E6iw
         hs/Nhc3hc+0Ba9WEbd1r5NQ1LY2r+cf34j50tkFBg/421qZQZv536LTSJDTO+777dfvo
         ySF+BGv/3Xr6UZej8F6ubsTZ+CRYhX2ax8eNL26vqCEuVXyeanlN93GNyapWBOTpNNqb
         YCkkfzy7ZS4OqFwmXoEI8PJKEqUZDcvo52cujIkja0QOafPjHQvfXFvNvA5Crvuu383q
         4FHA==
X-Gm-Message-State: APjAAAVCa0zQnTMDkzgM09iu7gdzLreDAUM5sVcGTO9qccc9fnz+1A4p
        Z60c6zdzK5uKr+SwqtyggwI=
X-Google-Smtp-Source: APXvYqzi/jEtjyEqEbQRUPAfoBpjCwho5YD2GVXcxUZ6vvq0c/FTzxZEIIL658Q6qD9gxrbQUE4wvw==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr16720967wro.215.1566734865011;
        Sun, 25 Aug 2019 05:07:45 -0700 (PDT)
Received: from szeder.dev (x4db347f6.dyn.telefonica.de. [77.179.71.246])
        by smtp.gmail.com with ESMTPSA id w13sm23324091wre.44.2019.08.25.05.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 05:07:44 -0700 (PDT)
Date:   Sun, 25 Aug 2019 14:07:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Cesar Eduardo Barros <cesarb@cesarb.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 20/23] .gitignore: touch up the entries regarding
 Visual Studio
Message-ID: <20190825120741.GM20404@szeder.dev>
References: <pull.287.git.gitgitgadget@gmail.com>
 <pull.287.v2.git.gitgitgadget@gmail.com>
 <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 01:08:14PM -0700, Philip Oakley via GitGitGadget wrote:
> Add the Microsoft .manifest pattern, and do not anchor the 'Debug'
> and 'Release' entries at the top-level directory, to allow for
> multiple projects (one per target).
> 
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index e096e0a51c..e7bb15d301 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -230,6 +230,7 @@
>  *.ipdb
>  *.dll
>  .vs/
> -/Debug/
> -/Release/
> +*.manifest

This new line ignores the tracked file 'compat/win32/git.manifest'
that was added fairly recently in fe90397604 (mingw: embed a manifest
to trick UAC into Doing The Right Thing, 2019-06-27).

I wonder whether that's intentional or accidental.

I'm inclined to think that it's merely accidental, because, as far as
I understand, this is an old-ish patch from times when there wasn't
any 'git.manifest' file in tree, and simply noone noticed that in the
meantime we got one.  But I have no idea about how a Git build with
Visual Studio is supposed to work, so it doesn't really matter what
I'm inclined to think :)

