Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8221C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 17:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJFRQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJFRQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 13:16:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FCE2F00F
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 10:16:44 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f193so2481325pgc.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UjKdWEHCFGI9iwV0ZeD9Q91eEQ+5J1ohguxu+9vFzyk=;
        b=AZJ+R5rkWyNu+es0jTNJlNdnGPlHjiRYFcCi0kkdGeo2cD8dai8phTsWbMxKF6qDZ5
         vQs5m93lF9J92aGYysaDhL3Qo3Vfzj84xLQ7DBZBirXuOFCYVAkkyp9e3e70gV3V7rhw
         xXC8BhDVMjAFa5CF8CP0aryrnIy9yMogru+JldoRwkCPtks8WhbddvFgd/K9Noxp1mnU
         cfkngpL/XzgyBN5qZ1GOHTZSiGH5dOuLapunBHoDBnSXVQtYl6ZN1ZPm0EkeuzVam8b9
         sS3zuv1U3kcfJrWhZzH+i0TXzOkNQfCONOdeZEaSAQ8Ct9vEY3PCj2uHzkJAUb6zBuyD
         D8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjKdWEHCFGI9iwV0ZeD9Q91eEQ+5J1ohguxu+9vFzyk=;
        b=a+xp5sp59i5c2Vw7uaGzQTlQlnpZChur1BLTIHrp46mHvIKc1D5NnPeyotmXO7/5hm
         SR4dIh2Vz2a+svIQ7p6lmOH+4kUkNXB+9NoEDn0GFoDzvP9F5iClPPecJOsiiLsz4bLg
         qYwxoaizG+1WN849wrlP/NIJ6lcKMyGMBuqkF2R6PGj3zNslBtYZ5mp4b4Bk4FdapOJC
         9zPuKJTFYX7h2PmFn39NpCyWzcU3s+LYHt5B/yyyU/NMJyO8C8TsDUCQ++mfM5zc3xeQ
         2wkLKxG0hMo0v1BrsrVpw4pRVchblcj6vev6+amP5igKBmbSRY48VuctDpy2HJKaNs5s
         Ggww==
X-Gm-Message-State: ACrzQf3RyJxNGodRMCfbeggO5j5lMVDLfxI5bjW9pZ4RCrmkai1zx2qC
        nQcHc7V4v2YNZKDtIZ+MN4A=
X-Google-Smtp-Source: AMsMyM5P7eQPfpDP4RnM9skHcXYQnME+TMgBtDBvdY0E7gHLJo7PqxzTvWbpYPM0I3jDLXuYqpgEiQ==
X-Received: by 2002:a63:4c5f:0:b0:439:49b4:809f with SMTP id m31-20020a634c5f000000b0043949b4809fmr732330pgl.382.1665076604184;
        Thu, 06 Oct 2022 10:16:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 72-20020a62194b000000b005627470944dsm1836780pfz.189.2022.10.06.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:16:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "dsal3389 via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dsal3389 <dsal3389@gmail.com>
Subject: Re: [PATCH 1/2] python file more pytonic, adjust "if" and "for"
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
        <71da6f53a44cd3390d122ff2c0446824313e5101.1665056747.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 10:16:43 -0700
Message-ID: <xmqqh70glvno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"dsal3389 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: dsal3389 <dsal3389@gmail.com>
>
> L371
> redesign few lines to get rid of the "else" statement
>
> L404
> moved the if statement below another if statement that
> checks if it should exit the code, only if it doesnt need to,
> then we can iterate the for loop and decode the text
>
> Changes to be committed:
> 	modified:   git-p4.py

Compare this with the commits by others in "git log --no-merges"
output of this project.

> Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>

Please have this on the in-body "From:" line we see above.  I think
GitGitGadget takes it from the author of the commit object it sends
out, so you may have to go back to your branch and fix them with
"rebase -i".

> ---
>  git-p4.py | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index d26a980e5ac..0ba5115fa2e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -368,10 +368,9 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
>         """
>      retcode, out, err = read_pipe_full(c, *k, **kw)
>      if retcode != 0:
> -        if ignore_error:
> -            out = ""
> -        else:
> +        if not ignore_error:
>              die('Command failed: {}\nError: {}'.format(' '.join(c), err))
> +        out = ""

I think the code with or without the patch is about the same
complexity, but people tend to have harder time understanding logic
that involves double negation, so I can imagine that some readers
may find the code with the patch harder to understand.  In any case,
the difference falls into the "it is minor enough that once it is
written in one way, it is not worth the churn to rewrite it in the
other way" category.

> @@ -400,10 +399,10 @@ def read_pipe_lines(c, raw=False, *k, **kw):
>      p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
>      pipe = p.stdout
>      lines = pipe.readlines()
> -    if not raw:
> -        lines = [decode_text_stream(line) for line in lines]
>      if pipe.close() or p.wait():
>          die('Command failed: {}'.format(' '.join(c)))
> +    if not raw:
> +        lines = [decode_text_stream(line) for line in lines]
>      return lines

This is in the same "the difference is minor enough that once it is
written in one way, it is not worth the churn to rewrite it in the
other way" category.  Your reasoning might be that massaging of the
lines is only needed when we do not die() and it is more efficient
to check and die first, but that is optimizing for the wrong case.
The code should not die in its normal operation and there is no
point optimizing for an error code path.

One thing that might deserve benchmarking and optimizing here is if
we can do better than reading everything in lines array and holding
onto the original until decoding the whole thing at once at the end
of input.  If converting each line and appending the result as it is
read from the pipe turns out to be more efficient, it may be an
optimization worth considering, as it is optimizaing for the normal
case.

