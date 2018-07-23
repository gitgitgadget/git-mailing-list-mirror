Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290E31F597
	for <e@80x24.org>; Mon, 23 Jul 2018 22:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeGWXai (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 19:30:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37757 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbeGWXai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 19:30:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so2181496wrd.4
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=24wiBe8Gx3hgTDKbKj1ImTf++UPBLZzGHcn69UfLoiU=;
        b=vgwUwXPMAunV5nbmd1MraIzUH5TQaUn1/jlYLc7P3dd+dTqE+OI85BrEbPNpmDLBLM
         vSqb1iiT1gvCQjeHZdelNTpmxyp31ac6MC/7VvgMpDlGx5gA9AHfH2OgR0S5ZDCuHxDh
         qSXAiR9piOXGgn9Z0GbSw0ySA/OAvHkhgE1Bzp3y0YiNLsalEb2nUHFZwIWkOr0mNXld
         kIKsHGiOhbBr658xrJUNOCZ4J6F+GvI++U3Fkr9GomtEotQCtmY2NRGlUkmYk7fN72tj
         7LFUYbqru6q1BQwn7X5VpqyKXda8b8N/OmRK3by5xZMxHtc5bk9DZUoj+xvMbEfi7nkw
         Px6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=24wiBe8Gx3hgTDKbKj1ImTf++UPBLZzGHcn69UfLoiU=;
        b=iO/EoFEeDyUmZtpQZNL3vgV86Ag/tm1uxan5+L/tm+gzMt0aiceIpqeOl9gsNzLlu4
         WpE601uCQav67cvtH4f2aieuS1y09Kj3tm+y3B58x/zgYhFRtM3unVMAR1F7vd9EGGHh
         x5EUtAkUCUN+UtZVhviZ7BjauILgslQHABdt8OxtzoYYS1vAq8h4a0CsQwnpkkgm3LP+
         KZtVvC6a6kr86+Dzd1pFdDYlVJo9u98TJoPMH8IYLr+uqfD4ybsXA/9KmV/2JFJg0Cbc
         qRLsf1azEYj0Cwswq5tyiYSSZs8H/fBBRg9bjN6z8G2TY+tMdGrfA4Ykteo0GLSKQx5I
         OciQ==
X-Gm-Message-State: AOUpUlEI0S5mnorLKji0x7lD8fGRHxGczT3J/S+sG6SFSQ/NA0j3wDvH
        d5tTk5foRTIFiBx0b6Ioslgcu6A3
X-Google-Smtp-Source: AAOMgpcmPQRd2BpGX3ETKpHmmXjrsY+Fb+QvW+iMZRcmdy/LNppaPQPd0Y7Nzuo/BC67iQ+2cvVxlQ==
X-Received: by 2002:adf:dfcd:: with SMTP id q13-v6mr9571070wrn.113.1532384835770;
        Mon, 23 Jul 2018 15:27:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w8-v6sm7482316wrp.72.2018.07.23.15.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:27:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 14/21] diff: add an internal option to dual-color diffs of diffs
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
        <9de5bd2299eedbc78494cadc9dd8bda59430b2df.1532210683.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Jul 2018 15:27:14 -0700
In-Reply-To: <9de5bd2299eedbc78494cadc9dd8bda59430b2df.1532210683.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 21 Jul 2018
        15:05:04 -0700 (PDT)")
Message-ID: <xmqqy3e137wd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When diffing diffs, it can be quite daunting to figure out what the heck
> is going on, as there are nested +/- signs.
>
> Let's make this easier by adding a flag in diff_options that allows
> color-coding the outer diff sign with inverted colors, so that the
> preimage and postimage is colored like the diff it is.
>
> Of course, this really only makes sense when the preimage and postimage
> *are* diffs. So let's not expose this flag via a command-line option for
> now.
>
> This is a feature that was invented by git-tbdiff, and it will be used
> by `git range-diff` in the next commit, by offering it via a new option:
> `--dual-color`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++-----------
>  diff.h |  1 +
>  2 files changed, 69 insertions(+), 15 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index a94a8214f..e163bc8a3 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -563,14 +563,18 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>  }
>  
> -static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
> +static void emit_line_0(struct diff_options *o,
> +			const char *set, unsigned reverse, const char *reset,
>  			int first, const char *line, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
>  	int nofirst;
>  	FILE *file = o->file;
>  
> -	fputs(diff_line_prefix(o), file);
> +	if (first)
> +		fputs(diff_line_prefix(o), file);
> +	else if (!len)
> +		return;

Can you explain this hunk in the log message?  I am not sure how the
description in the log message relates to this change.  Is the idea
of this change essentially "all the existing callers that aren't
doing the diff-of-diffs send a non-NUL first character, and for them
this change is a no-op.  New callers share most of the remainder of
emit_line_0() logic but do not want to show the prefix, so the
support for it is piggy-backing by a special case where first could
be NUL"?
