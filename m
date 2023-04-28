Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76784C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 18:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346581AbjD1S6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbjD1S5v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 14:57:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77AC6195
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:57:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a6bc48aec8so2491405ad.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682708230; x=1685300230;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LIqiqQi6zNttHb/x3AZg+c818BavRXQdi50noH1hAI=;
        b=Ro6tAhEmslvoD7g60SD/aV4cEMKMdGHjw9MFVUIQF7jdEc4LPU28ZC5TAnwp1tG3tS
         fmavxwlkijPTqg3ltnf29fr5d0WuoXMCYexyW7sCFEYdm+cBAi6PpOZ1N2ZpsnAP1dWx
         9Bjp9A83Tb+4if1yUIJaX2WBp2VR0h07gumIDPrkXy97s3BOnJQOHpB5cGHo/GKK84ld
         1qe1FTfJKQ+VRCyBwZIkcbk6oEEGQy4gypdCAWZc+ffc8ojEfZo62NsVU10o7AsAmMqo
         lEUKbGwLHxi6ePnbLpr2wRCgLBiLzQjjBK22zO80KVbCM9PA+8/7G622Efpazhuvxzhx
         nH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708230; x=1685300230;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5LIqiqQi6zNttHb/x3AZg+c818BavRXQdi50noH1hAI=;
        b=TO77pqXq/CZ1UZNlwjsgEhPwKVWsu6JEN2Pagw9GXcjWIwzZajwG8a70P1r7ALOS57
         tRJWEA4spGnv7YR9mKsd+q3bhXs8KzbPOEfTg/Cg5naBlK3ZT7wRroOpwjSkDKi/URXZ
         hwokIJvuemqFB8kROElzeH/h8f/MryMQ7NKkk0TsscItzj2QC2lEZzvYnSqtK70ig4bj
         N1PcHm5nBEH7QtJoTo0riRo+jJW4oexj4dDMF6C1YwUrH3TBTUVpVJdBqadkYwbwgwuD
         phcHvNVyceXj2302oKgGQNNF7n73VISSSRJFiX25DuIvRsfTDorAjS4AuTgIoT8btpZL
         cQQw==
X-Gm-Message-State: AC+VfDyE1App5MaYpnOgqGckWNCBdTIWU5l5ATiwrd8KnMhhN6l/aGSr
        ta/VipPIymnNjnlZBMu9A/E=
X-Google-Smtp-Source: ACHHUZ4Rs7frxyQMbK3uW2IvBY4fmJbub3N0LxuEWiVXuC2ctBPlxq1DAw2HAUffmVZ/4GcQsXcS2g==
X-Received: by 2002:a17:902:eb8b:b0:1a9:8c86:34f0 with SMTP id q11-20020a170902eb8b00b001a98c8634f0mr5050977plg.28.1682708230411;
        Fri, 28 Apr 2023 11:57:10 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902744900b001a656784229sm13509470plt.211.2023.04.28.11.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:57:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Capitalization and punctuation fixes to some
 user visible messages
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-3-oswald.buddenhagen@gmx.de>
Date:   Fri, 28 Apr 2023 11:57:09 -0700
In-Reply-To: <20230428125649.1719796-3-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Fri, 28 Apr 2023 14:56:49 +0200")
Message-ID: <xmqqttwzded6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> These are conscious violations of the usual rules for error messages,
> based on this reasoning:
> - If an error message is directly followed by another sentence, it needs
>   to be properly terminated with a period, lest the grammar looks broken
>   and becomes hard to read.
> - That second sentence isn't actually an error message any more, so it
>   should abide to conventional language rules for good looks and
>   legibility. Arguably, these should be converted to advice messages
>   (which the user can squelch, too), but that's a much bigger effort to
>   get right.

I think both of the above are good guidelines to follow, with a hint
for a longer-term plan.  Good description.

> - Neither of these apply to the first hunk in do_exec(), but this
>   two-line message looks just too much like a real sentence to not
>   terminate it. Also, leaving it alone would make it asymmetrical to
>   the other hunk.

I do not have a strong opinion on this one, in the sense that if
somebody writes a patch to terminate the sentence with the above
justification, I do not think I would object to it, and if somebody
omits this change from a patch like this, because the above two
guidelines do not apply to it, I would not object to it, either.

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> Cc: Junio C Hamano <gitster@pobox.com>

We generally do not want Cc: in the trailers.  Can you move them
after the three-dash lines (which I think is still read by
send-email) next time you create more patches and throw them at the
list?

Will queue.

> ---
> v2:
> - tried to make commit message more convincing
> - put it last in the series, to make the less controversial changes
>   easier to apply
> ---
>  builtin/pull.c | 2 +-
>  sequencer.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 56f679d94a..bb2ddc93ab 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1044,7 +1044,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		if (!opt_autostash)
>  			require_clean_work_tree(the_repository,
>  				N_("pull with rebase"),
> -				_("please commit or stash them."), 1, 0);
> +				_("Please commit or stash them."), 1, 0);
>  
>  		if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
>  			oidclr(&rebase_fork_point);
> diff --git a/sequencer.c b/sequencer.c
> index 0677c9ab09..21748bbfb0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3629,13 +3629,13 @@ static int do_exec(struct repository *r, const char *command_line)
>  			  "\n"),
>  			command_line,
>  			dirty ? _("and made changes to the index and/or the "
> -				"working tree\n") : "");
> +				"working tree.\n") : "");
>  		if (status == 127)
>  			/* command not found */
>  			status = 1;
>  	} else if (dirty) {
>  		warning(_("execution succeeded: %s\nbut "
> -			  "left changes to the index and/or the working tree\n"
> +			  "left changes to the index and/or the working tree.\n"
>  			  "Commit or stash your changes, and then run\n"
>  			  "\n"
>  			  "  git rebase --continue\n"
