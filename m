Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235591FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 00:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdBFAPG (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 19:15:06 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36463 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbdBFAPF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 19:15:05 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so5550517pfo.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 16:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EDBOidtd+76x4IvJpG/Ho4zY4fA/IAFjmcV+Ex/UOZM=;
        b=tEnebMw52HFsdj3y0Ym3S40b+yWabEPtqmZPHw13Sn2vABYxIL8b4qVOX4+/fT/pIB
         4TVKGc4Z6U2o99TRnKVQ3jAl6GrgAcPVC9ZE9VnM3PES80Fo0tV6SmTEdBq/mPWvACtT
         ux+i9nPQ0dA5zATwhyHIcBbDihQAikS0lbHsvXZTPmC9ClSvc0uX85LCawz1XNLy7ZHX
         mFx2IYQIB8Vd0DBF0LwQzlYrqRXU74hkPArHbR+jy64zic8JHfD0E4JVX25ZQNvqtdIP
         S0Pd3STMUi6AgtC0oOWnGCgI08B2HGlOwopx/2LDTOjxAmhTRxTRi6UCUwjet9x/acjF
         bs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EDBOidtd+76x4IvJpG/Ho4zY4fA/IAFjmcV+Ex/UOZM=;
        b=W1v52Nk9BuX4fR/hyEghFf7eNlxdcsk+Bvs4u57+KQ1uRtN36pQfTu7xo7CZQQeEt9
         IxuxB7OZ/P8p1XrC1YUl0sWOgFg8VLZkAHcHj/FdcOfFvClm2UksdmeZCcfaNGD6BmlO
         880OXw0ZRastEsXKxyGZZbKiIr0VdRJSPaw56PnPhU5eVw2g5FbAIgdqeUbGSN8itEEX
         46eNxXNZe4FHHXLPKQZu/w3twNAXHklnjKQlIJatbpbNC4wBNsB4WEvY+LxTF+mwilz3
         TfEflGBnwIooTjpCF+GrUXFubydgYVWxbfqHojDat/b51ahxDqJ+TzedGvNPrA9VJcbQ
         86Aw==
X-Gm-Message-State: AIkVDXLARIgh5WXuZiegFvVLWUtnxDq/zSDDpwaZvLKEBzyiyZB5teA3JvUoI4fJOkjssQ==
X-Received: by 10.98.117.10 with SMTP id q10mr10024443pfc.31.1486340104729;
        Sun, 05 Feb 2017 16:15:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:ac74:31b6:1bdf:d117])
        by smtp.gmail.com with ESMTPSA id g70sm83371726pfb.50.2017.02.05.16.15.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 05 Feb 2017 16:15:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, pranit.bauva@gmail.com, Matthieu.Moy@imag.fr,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
Date:   Sun, 05 Feb 2017 16:15:03 -0800
In-Reply-To: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Sun, 5 Feb 2017 12:57:19 +0000")
Message-ID: <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> @@ -158,6 +158,51 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>
>  	if (quiet)
>  		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
> +
> +	/*
> +	 * Check if any argument has a "-" in it, which has been referred to as a
> +	 * shorthand for @{-1}.  Handles methods that might be used to list commits
> +	 * as mentioned in git rev-list --help
> +	 */
> +
> +	for(i = 0; i < argc; ++i) {
> +		if (!strcmp(argv[i], "-")) {
> +			argv[i] = "@{-1}";
> +		} else if (!strcmp(argv[i], "^-")) {
> +			argv[i] = "^@{-1}";
> +		} else if (strlen(argv[i]) >= 4) {
> +
> +	...
> +		}
> +	}
> +
>  	argc = setup_revisions(argc, argv, rev, opt);

"Turn '-' to '@{-1}' before we do the real parsing" can never be a
reasonable strategy to implement the desired "'-' means the tip of
the previous branch" correctly.  To understand why, you only need to
imagine what happens to this command:

    $ git log --grep '^-'

Turning it into "git log --grep '^@{-1}'" obviously is not what the
end-users want, so that is an immediate bug in the version of Git
with this patch applied.

Even if this were not a patch for the "log" command but for some
other command, a change with the above approach is very much
unwelcome, even if that other command does not currently have any
option that takes arbitrary string the user may want to specify
(like "find commit with a line that matches this pattern" option
called "--grep" the "log" command has).  That is because it will
make it impossible to enhance the command by adding such an option
in the future.  So it is also adding the problems to future
developers (and users) of Git.

A correct solution needs to know if the argument is at the position
where a revision (or revision range) is expected and then give the
tip of the previous branch when it sees "-" (and other combinations
this patch tries to cover).  In other words, the parser always knows
what it is parsing, and if and only if it is parsing a rev, react to
"-" and think "ah, the user wants me to use the tip of the previous
branch".

But the code that knows that it expects to see a revision already
exists, and it is the real parser.  In the above snippet,
setup_revisions() is the one that does the real parsing of argv[].
The code there knows when it wants to see a rev, and takes argv[i]
and turns into an object to call add_pending_object().  That codepath
may not yet know that "-" means the tip of the previous branch, and
that is where the change needs to go.

Such a properly-done update does not need to textually replace "-"
with "@{-1}" in argv[]; the codepath is where it understands what
any textual representation of a rev the user gave it means, and it
understands "@{-1}" there.  It would be the matter of updating it to
also understand what "-" means.

A correct solution will be a lot more involved, of course, and I
think it will be larger than a reasonable microproject for people
new to the codebase.

I didn't check the microproject ideas page myself; whether it says
that turning "-" unconditionally to "@{-1}" is a good idea, or it
hints that supporting "-" as "the tip of the previous branch" in
more commands is a reasonable byte-sized microproject, I think it is
misleading and misguided.  Can somebody remove that entry so that we
won't waste time of new developers (which would lead to discouraging
them)?  Thanks.
