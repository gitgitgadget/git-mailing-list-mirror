Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6781F461
	for <e@80x24.org>; Tue, 20 Aug 2019 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfHTN4L (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 09:56:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42290 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTN4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 09:56:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so12511284wrq.9
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y0/6sMdpF9s+fqTJN5vbPoX/4XMpmvx5y+wzHU+kbu4=;
        b=fgl1wkKc58fdPS1eOrQ7mo86szEC/4b+hTsV7RI/t94GRCmoTaACN2+3fyaKXMSY+B
         Dfp+P9ML+6YRPQv/AcsEpjBU5+nohPj7y6CkFN+NgOvOvqiVtBme5B30GoEI9jJUxZuh
         TzqRqq19OFTO6LlhxvU99C6NH0jB3yFmuS5BwmtOx4WssQKze8iQzN7dGgwybU12x311
         86sKKpBkmrij5pkfY59ZYkh6b4l4wAkpNQvOpGNiTEHTkRpiFwvNjeF1WBmd1jDJ9M7d
         Ecc9loEJ6SIxKGwpmzPKGFpVhR56VtwjbH3L32pkX9ntYzoW6LsdTH8+4tP8FBlI3ott
         Jyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y0/6sMdpF9s+fqTJN5vbPoX/4XMpmvx5y+wzHU+kbu4=;
        b=tXhbqcvKjkQ5jr3996U3C7Bk74cXQ0uafVe0gI7CgVpb90l4yG3csGQvd5UK/ZbLkc
         9w8cjJgtSKLxT1nK3RnJnhuVujVRhymBa/UXDjXTnZd00zyHloOOsPP/HTRThdXwPyLQ
         1rCON4zwUkxKJtcYE4GeBm58cobEU4yh8aTL8KeRDDUgveVEDv36jPx7I8p0V9xRYPc0
         bfRqffUBOgDcvKcteC+or0EMEt89O5EqczLqPYPV7j/i5UdgBM8YDyGKy1yp/9VWUKWq
         ZjhrzJjxXY3KHcXJgXTiZlXVyKAQbRJ4rDC5RgAEG6aPnA4i1sDe+DAt5lis7XK3+QH6
         FjNA==
X-Gm-Message-State: APjAAAVw2wIBaGdxsG8hStE3ry8qVchPWrnfXsAjAFSmyyWVcGwOAT0K
        YbsAgbslBogOtD003mD5tv6tGUDAKGw=
X-Google-Smtp-Source: APXvYqxpQ8acVbEsMdrOF6cA5UTlgnOVNCfCYdVd3BQ0CHDjMA0XSnnU9ORIstceabx3YeDXm9h7CQ==
X-Received: by 2002:adf:ea08:: with SMTP id q8mr11313724wrm.188.1566309368375;
        Tue, 20 Aug 2019 06:56:08 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id o11sm54437wmh.46.2019.08.20.06.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 06:56:07 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/6] rebase -i: support more options
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <71c313d7-e08d-f62f-c52e-aabca0d97002@gmail.com>
Date:   Tue, 20 Aug 2019 14:56:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 20/08/2019 04:45, Rohit Ashiwal wrote:
> I've tries to incorporated all the suggestions.

It is helpful if you can list the changes to remind us all what we said. 
(as a patch author I find composing that is helpful to remind me if 
there's anything I've forgotten to address)

Also there are a couple of things that were discussed such as splitting 
up the author and passing it round as a <name, email, date, tz> tuple 
and testing a non-default timezone which aren't included - that's fine 
but it helps if you take a moment to explain why in the cover letter.

> 
> Some points:
>    - According to v2.0.0's git-am.sh, ignore-date should override
>      committer-date-is-author-date. Ergo, we are not barfing out
>      when both flags are provided.
>    - Should the 'const' qualifier be removed[2]? Since it is leaving
>      a false impression that author should not be free()'d.

The author returned by read_author_ident() is owned by the strbuf that 
you pass to read_author_ident() which is confusing.

Best Wishes

Phillip

> 
> [1]: git show v2.0.0:git-am.sh
> [2]: https://github.com/git/git/blob/v2.23.0/sequencer.c#L959
> 
> Rohit Ashiwal (6):
>    rebase -i: add --ignore-whitespace flag
>    sequencer: add NULL checks under read_author_script
>    rebase -i: support --committer-date-is-author-date
>    sequencer: rename amend_author to author_to_rename
>    rebase -i: support --ignore-date
>    rebase: add --reset-author-date
> 
>   Documentation/git-rebase.txt            |  26 +++--
>   builtin/rebase.c                        |  53 +++++++---
>   sequencer.c                             | 135 ++++++++++++++++++++++--
>   sequencer.h                             |   2 +
>   t/t3422-rebase-incompatible-options.sh  |   2 -
>   t/t3433-rebase-options-compatibility.sh | 100 ++++++++++++++++++
>   6 files changed, 289 insertions(+), 29 deletions(-)
>   create mode 100755 t/t3433-rebase-options-compatibility.sh
> 
> Range-diff:
> 1:  4cd0aa3084 ! 1:  e82ed8cad5 rebase -i: add --ignore-whitespace flag
>      @@ -19,10 +19,13 @@
>        default is `--no-fork-point`, otherwise the default is `--fork-point`.
>        
>        --ignore-whitespace::
>      -+	This flag is either passed to the 'git apply' program
>      -+	(see linkgit:git-apply[1]), or to 'git merge' program
>      -+	(see linkgit:git-merge[1]) as `-Xignore-space-change`,
>      -+	depending on which backend is selected by other options.
>      ++	Behaves differently depending on which backend is selected.
>      +++
>      ++'am' backend: When applying a patch, ignore changes in whitespace in
>      ++context lines if necessary.
>      +++
>      ++'interactive' backend: Treat lines with only whitespace changes as
>      ++unchanged for the sake of a three-way merge.
>       +
>        --whitespace=<option>::
>       -	These flag are passed to the 'git apply' program
>      @@ -63,7 +66,7 @@
>        
>        static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>        {
>      -+	char *strategy_opts = opts->strategy_opts;
>      ++	struct strbuf strategy_buf = STRBUF_INIT;
>        	struct replay_opts replay = REPLAY_OPTS_INIT;
>        
>        	replay.action = REPLAY_INTERACTIVE_REBASE;
>      @@ -71,24 +74,19 @@
>        	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>        	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>        	replay.strategy = opts->strategy;
>      --	if (opts->strategy_opts)
>      --		parse_strategy_opts(&replay, opts->strategy_opts);
>      -+
>      -+	if (opts->ignore_whitespace) {
>      -+		struct strbuf buf = STRBUF_INIT;
>      -+
>      -+		if (strategy_opts)
>      -+			strbuf_addstr(&buf, strategy_opts);
>       +
>      -+		strbuf_addstr(&buf, " --ignore-space-change");
>      -+		free(strategy_opts);
>      -+		strategy_opts = strbuf_detach(&buf, NULL);
>      -+	}
>      -+	if (strategy_opts)
>      -+		parse_strategy_opts(&replay, strategy_opts);
>      + 	if (opts->strategy_opts)
>      +-		parse_strategy_opts(&replay, opts->strategy_opts);
>      ++		strbuf_addstr(&strategy_buf, opts->strategy_opts);
>      ++	if (opts->ignore_whitespace)
>      ++		strbuf_addstr(&strategy_buf, " --ignore-space-change");
>      ++	if (strategy_buf.len)
>      ++		parse_strategy_opts(&replay, strategy_buf.buf);
>        
>      ++	strbuf_release(&strategy_buf);
>        	return replay;
>        }
>      +
>       @@
>        	argc = parse_options(argc, argv, prefix, options,
>        			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
> 2:  e2c0304587 = 2:  209057b361 sequencer: add NULL checks under read_author_script
> 3:  6aed57ae2e ! 3:  a4e6644ef8 rebase -i: support --committer-date-is-author-date
>      @@ -21,10 +21,12 @@
>       +
>        --ignore-date::
>       -	These flags are passed to 'git am' to easily change the dates
>      +-	of the rebased commits (see linkgit:git-am[1]).
>       +	This flag is passed to 'git am' to change the author date
>      - 	of the rebased commits (see linkgit:git-am[1]).
>      ++	of each rebased commit (see linkgit:git-am[1]).
>        +
>        See also INCOMPATIBLE OPTIONS below.
>      +
>       @@
>        
>        The following options:
>      @@ -62,16 +64,6 @@
>        	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>        	replay.strategy = opts->strategy;
>        
>      -@@
>      - 		warning(_("--[no-]rebase-cousins has no effect without "
>      - 			  "--rebase-merges"));
>      -
>      -+	if (opts.committer_date_is_author_date)
>      -+		opts.flags |= REBASE_FORCE;
>      -+
>      - 	return !!run_rebase_interactive(&opts, command);
>      - }
>      -
>       @@
>        
>        	if (opts->ignore_whitespace)
>      @@ -149,14 +141,14 @@
>       +		struct strbuf datebuf = STRBUF_INIT;
>       +		char *date = read_author_date_or_null();
>       +
>      ++		if (!date)
>      ++			return -1;
>      ++
>       +		strbuf_addf(&datebuf, "@%s", date);
>       +		free(date);
>       +
>       +		date = strbuf_detach(&datebuf, &len);
>      -+
>      -+		if (len > 1)
>      -+			res = setenv("GIT_COMMITTER_DATE", date, 1);
>      -+
>      ++		res = setenv("GIT_COMMITTER_DATE", date, 1);
>       +		free(date);
>       +
>       +		if (res)
>      @@ -187,7 +179,7 @@
>       +		if (!ident.date_begin)
>       +			return error(_("corrupted author without date information"));
>       +
>      -+		strbuf_addf(&date, "@%s",ident.date_begin);
>      ++		strbuf_addf(&date, "@%s", ident.date_begin);
>       +		setenv("GIT_COMMITTER_DATE", date.buf, 1);
>       +		strbuf_release(&date);
>       +	}
> 4:  36a0c017c2 = 4:  6ac1885c54 sequencer: rename amend_author to author_to_rename
> 5:  3a4ffeb995 ! 5:  a69749dd67 rebase -i: support --ignore-date
>      @@ -16,9 +16,9 @@
>        
>        --ignore-date::
>       -	This flag is passed to 'git am' to change the author date
>      --	of the rebased commits (see linkgit:git-am[1]).
>      -+	Instead of using the given author date, re-set it to the value
>      -+	same as committer (current) date. This implies --force-rebase.
>      +-	of each rebased commit (see linkgit:git-am[1]).
>      ++	Instead of using the given author date, reset it to the value
>      ++	same as the current time. This implies --force-rebase.
>        +
>        See also INCOMPATIBLE OPTIONS below.
>        
>      @@ -58,18 +58,6 @@
>        	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>        	replay.strategy = opts->strategy;
>        
>      -@@
>      - 		warning(_("--[no-]rebase-cousins has no effect without "
>      - 			  "--rebase-merges"));
>      -
>      --	if (opts.committer_date_is_author_date)
>      -+	if (opts.ignore_date)
>      -+		opts.committer_date_is_author_date = 0;
>      -+	if (opts.committer_date_is_author_date ||
>      -+	    opts.ignore_date)
>      - 		opts.flags |= REBASE_FORCE;
>      -
>      - 	return !!run_rebase_interactive(&opts, command);
>       @@
>        		argv_array_push(&am.args, "--ignore-whitespace");
>        	if (opts->committer_date_is_author_date)
>      @@ -125,18 +113,19 @@
>        	return buf->buf;
>        }
>        
>      -+static void ignore_author_date(const char **author)
>      ++/* Construct a free()able author string with current time as the author date */
>      ++static char *ignore_author_date(const char *author)
>       +{
>      -+	int len = strlen(*author);
>      ++	int len = strlen(author);
>       +	struct ident_split ident;
>       +	struct strbuf new_author = STRBUF_INIT;
>       +
>      -+	split_ident_line(&ident, *author, len);
>      ++	split_ident_line(&ident, author, len);
>       +	len = ident.mail_end - ident.name_begin + 1;
>       +
>      -+	strbuf_addf(&new_author, "%.*s", len, *author);
>      ++	strbuf_addf(&new_author, "%.*s ", len, author);
>       +	datestamp(&new_author);
>      -+	*author = strbuf_detach(&new_author, NULL);
>      ++	return strbuf_detach(&new_author, NULL);
>       +}
>       +
>       +static void push_dates(struct child_process *child)
>      @@ -160,11 +149,13 @@
>       -		else
>       +		else {
>       +			if (opts->ignore_date) {
>      ++				char *new_author = ignore_author_date(author);
>       +				if (!author)
>       +					BUG("ignore-date can only be used with "
>       +					    "rebase, which must set the author "
>       +					    "before committing the tree");
>      -+				ignore_author_date(&author);
>      ++				free((void *)author);
>      ++				author = new_author;
>       +			}
>        			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
>        					  NULL, &root_commit, author,
>      @@ -187,7 +178,7 @@
>        	reset_ident_date();
>        
>       +	if (opts->ignore_date) {
>      -+		ignore_author_date(&author);
>      ++		author = ignore_author_date(author);
>       +		free(author_to_free);
>       +		author_to_free = (char *)author;
>       +	}
> 6:  cb81e6c4e5 ! 6:  210d15cca0 rebase: add --author-date-is-committer-date
>      @@ -1,6 +1,6 @@
>       Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>       
>      -    rebase: add --author-date-is-committer-date
>      +    rebase: add --reset-author-date
>       
>           The previous commit introduced --ignore-date flag to interactive
>           rebase, but the name is actually very vague in context of rebase -i
>      @@ -16,9 +16,9 @@
>        	as the committer date. This implies --force-rebase.
>        
>        --ignore-date::
>      -+--author-date-is-committer-date::
>      - 	Instead of using the given author date, re-set it to the value
>      - 	same as committer (current) date. This implies --force-rebase.
>      ++--reset-author-date::
>      + 	Instead of using the given author date, reset it to the value
>      + 	same as the current time. This implies --force-rebase.
>        +
>       
>        diff --git a/builtin/rebase.c b/builtin/rebase.c
>      @@ -28,7 +28,7 @@
>        		OPT_BOOL(0, "committer-date-is-author-date",
>        			 &options.committer_date_is_author_date,
>        			 N_("make committer date match author date")),
>      -+		OPT_BOOL(0, "author-date-is-committer-date", &options.ignore_date,
>      ++		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
>       +			 "ignore author date and use current date"),
>        		OPT_BOOL(0, "ignore-date", &options.ignore_date,
>        			 "ignore author date and use current date"),
> 
