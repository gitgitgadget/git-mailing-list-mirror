Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C383420248
	for <e@80x24.org>; Wed,  6 Mar 2019 16:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfCFQ31 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 11:29:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40230 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCFQ31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 11:29:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so14138539wrp.7
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJCHzRAtsy9wkteR1V+h8gCLheP3u0IO2HWF7ZPB54Q=;
        b=pfBMkWlWCiZEWGAZrefc8bABVAWuBz9wZ9RqBqMDn+syQzO6GKek13kvJWILXKSVom
         pXZfV6sDrESmIqWnNM90opMt3T4ijz0Nr5olkAExpzTTOiNI/wh2cFyQHCrPgzvrOFxh
         2Sroe+0MAXImtqzvl/M+vaJf5ldYFYB5vGFUwIOclkGMKnd1OXQ6Wzk0NN2JysMYbBKz
         Vul3Ok1TXqqR6MRVXUTEYPPF+MQaoVFgbiXC0ma3yDMUop+oOWA5FkUNDzFrcLvKImzl
         j1+4MmU0QXcBUStA/atIh+3yhI/nMFVDF5ZJBTkRXwiLlNXtMKW904NNnvI+rNN6/5An
         BIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fJCHzRAtsy9wkteR1V+h8gCLheP3u0IO2HWF7ZPB54Q=;
        b=iBnDe5MsGTm7WBDWRElQw/x4vzVZmTLouuamaw6ZTeuQf97pLtc3zsbErSkD0nHf8g
         HYn4RSuq8E64lFXlDiDZhp9ewdsyskpG6Xd6bhTbj7ilAbDn1ECuDX7W39DtKVYG+bKF
         Bghdb+7lumLeFJ912vLAsAS+N8ysNwy+jD4pYemd9ADernMHmJ3VP9f5PyCNvAn/FTw3
         YKo6etXeCy8N/mLlqIBL6FsUl0rbwiKaJVwZNlYV3vIyS7mmf1XJL45IyIje0Ilwk6gq
         dEXFAohalNbw4aqGk6lUqJy3WoLy+0l66Wdg+NNRK8Ong+97wAbePE9jALyJRpi8gwy7
         /zFA==
X-Gm-Message-State: APjAAAVFLBmqD6LGZAoVogBkV2T2Dz7Z/ywqeqjRS806gygZJH2DnKd2
        kW4BAAsnzyEUtueqdt6mqHk=
X-Google-Smtp-Source: APXvYqzV5O4loaLku6KElQIYCT9cJAPYpGB+5G+sIfMd0L+/RQE061B/EV5gceGpCr7uABE7BZ8sSg==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr3972398wrp.227.1551889763869;
        Wed, 06 Mar 2019 08:29:23 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.gmail.com with ESMTPSA id e193sm4101724wmg.18.2019.03.06.08.29.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:29:22 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] cherry-pick/revert: add scissors line on merge
 conflict
To:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <cover.1551867827.git.liu.denton@gmail.com>
 <70a508ca0b2d837b311afefcc2b0ffb6cfbd34fb.1551867827.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1fa469d7-76ef-36b5-9688-43853fa2b2ee@gmail.com>
Date:   Wed, 6 Mar 2019 16:29:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <70a508ca0b2d837b311afefcc2b0ffb6cfbd34fb.1551867827.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 06/03/2019 10:30, Denton Liu wrote:
> Fix a bug where the scissors line is placed after the Conflicts:
> section, in the case where a merge conflict occurs and
> commit.cleanup = scissors.

Was that the case with cherry-pick and revert as well as merge, or were 
they missing the scissors line entirely as the subject line suggests?

> Note that the removal of the if-else tower in git_sequencer_config may
> appear to be a no-op refactor but it actually isn't. First of all, we
> now accept "default" as a configuration option and also we die on an
> invalid cleanup mode. Most importantly, though, if
> commit.cleanup = scissors, the cleanup enum will be set to
> COMMIT_MSG_CLEANUP_SCISSORS instead of COMMIT_MSG_CLEANUP_SPACE. This
> allows us to append scissors to MERGE_MSG in the case of a conflict.

I've got some comments about this change below

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   Documentation/git-cherry-pick.txt |  7 +++
>   Documentation/git-revert.txt      |  7 +++
>   builtin/merge.c                   | 13 ++---
>   builtin/revert.c                  |  5 ++
>   sequencer.c                       | 22 ++++----
>   sequencer.h                       |  3 +-
>   t/t3507-cherry-pick-conflict.sh   | 88 +++++++++++++++++++++++++++++++
>   7 files changed, 121 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index d35d771fc8..5c086d78c8 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -57,6 +57,13 @@ OPTIONS
>   	With this option, 'git cherry-pick' will let you edit the commit
>   	message prior to committing.
>   
> +--cleanup=<mode>::
> +	This option determines how the commit message will be cleaned up before
> +	being passed on. See linkgit:git-commit[1] for more details. In
> +	addition, if the '<mode>' is given a value of `scissors`, scissors will
> +	be prepended to MERGE_MSG before being passed on in the case of a
> +	conflict.
> +
>   -x::
>   	When recording the commit, append a line that says
>   	"(cherry picked from commit ...)" to the original commit
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 837707a8fd..1894010e60 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -66,6 +66,13 @@ more details.
>   	With this option, 'git revert' will not start the commit
>   	message editor.
>   
> +--cleanup=<mode>::
> +	This option determines how the commit message will be cleaned up before
> +	being passed on. See linkgit:git-commit[1] for more details. In
> +	addition, if the '<mode>' is given a value of `scissors`, scissors will
> +	be prepended to MERGE_MSG before being passed on in the case of a
> +	conflict.
> +
>   -n::
>   --no-commit::
>   	Usually the command automatically creates some commits with
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 92efc3d8fa..d4217ebcf5 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -913,17 +913,10 @@ static int suggest_conflicts(void)
>   	 * We can't use cleanup_mode because if we're not using the editor,
>   	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
>   	 * though the message is meant to be processed later by git-commit.
> -	 * Thus, we will get the cleanup mode is returned we _are_ using an
> -	 * editor.
> +	 * Thus, we will get the cleanup mode which is returned when we _are_ using
> +	 * an editor.
>   	 */
> -	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
> -	    fputc('\n', fp);
> -	    wt_status_add_cut_line(fp);
> -	    /* comments out the newline from append_conflicts_hint */
> -	    fputc(comment_line_char, fp);
> -	}
> -
> -	append_conflicts_hint(&msgbuf);
> +	append_conflicts_hint(&msgbuf, get_cleanup_mode(cleanup_arg, 1));
>   	fputs(msgbuf.buf, fp);
>   	strbuf_release(&msgbuf);
>   	fclose(fp);
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 9a66720cfc..fe18036be7 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -95,11 +95,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   {
>   	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
>   	const char *me = action_name(opts);
> +	const char *cleanup_arg = NULL;
>   	int cmd = 0;
>   	struct option base_options[] = {
>   		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
>   		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
>   		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
> +		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
>   		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
>   		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
>   		OPT_NOOP_NOARG('r', NULL),
> @@ -136,6 +138,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   	if (opts->keep_redundant_commits)
>   		opts->allow_empty = 1;
>   
> +	if (cleanup_arg)
> +		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
> +
>   	/* Check for incompatible command line arguments */
>   	if (cmd) {
>   		char *this_operation;
> diff --git a/sequencer.c b/sequencer.c
> index 707e72fb39..85ad58555d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -165,17 +165,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   		if (status)
>   			return status;
>   
> -		if (!strcmp(s, "verbatim"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
> -		else if (!strcmp(s, "whitespace"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
> -		else if (!strcmp(s, "strip"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
> -		else if (!strcmp(s, "scissors"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
> -		else
> -			warning(_("invalid commit message cleanup mode '%s'"),
> -				  s);
> +		opts->default_msg_cleanup = get_cleanup_mode(s, 1);

If we're rebasing then I'm not sure we want to pass 1 here, we won't be 
using an editor unless the user is rewording a commit message. Also I'm 
not clear about the implications of changing the cleanup mode for 
scissors - will whitespace and comments still be cleaned up?

I'm not terribly happy with the idea that this will now die while 
reading the config file if there's on invalid cleanup option. If you 
really want to enforce a valid value then it would be better to return 
an error from get_cleanup_mode().

Best Wishes

Phillip

>   
>   		free((char *)s);
>   		return status;
> @@ -516,10 +506,16 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>   		die(_("Invalid cleanup mode %s"), cleanup_arg);
>   }
>   
> -void append_conflicts_hint(struct strbuf *msgbuf)
> +void append_conflicts_hint(struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
>   {
>   	int i;
>   
> +	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
> +		strbuf_addch(msgbuf, '\n');
> +		wt_status_append_cut_line(msgbuf);
> +		strbuf_addch(msgbuf, comment_line_char);
> +	}
> +
>   	strbuf_addch(msgbuf, '\n');
>   	strbuf_commented_addf(msgbuf, "Conflicts:\n");
>   	for (i = 0; i < active_nr;) {
> @@ -586,7 +582,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>   			_(action_name(opts)));
>   
>   	if (!clean)
> -		append_conflicts_hint(msgbuf);
> +		append_conflicts_hint(msgbuf, opts->default_msg_cleanup);
>   
>   	return !clean;
>   }
> diff --git a/sequencer.h b/sequencer.h
> index 5690e0c27e..aa99503dd7 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -91,7 +91,8 @@ int rearrange_squash(void);
>   extern const char sign_off_header[];
>   
>   void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
> -void append_conflicts_hint(struct strbuf *msgbuf);
> +void append_conflicts_hint(struct strbuf *msgbuf,
> +		enum commit_msg_cleanup_mode cleanup_mode);
>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>   	int use_editor);
>   
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 74ff925526..c94e44dad0 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -189,6 +189,48 @@ test_expect_success 'failed cherry-pick registers participants in index' '
>   	test_cmp expected actual
>   '
>   
> +test_expect_success \
> +	'cherry-pick conflict, ensure commit.cleanup = scissors places scissors line properly' '
> +	pristine_detach initial &&
> +	git config commit.cleanup scissors &&
> +	cat <<-EOF >expected &&
> +		picked
> +
> +		# ------------------------ >8 ------------------------
> +		# Do not modify or remove the line above.
> +		# Everything below it will be ignored.
> +		#
> +		# Conflicts:
> +		#	foo
> +		EOF
> +
> +	test_must_fail git cherry-pick picked &&
> +
> +	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
> +	test_i18ncmp expected actual
> +'
> +
> +test_expect_success \
> +	'cherry-pick conflict, ensure cleanup=scissors places scissors line properly' '
> +	pristine_detach initial &&
> +	git config --unset commit.cleanup &&
> +	cat <<-EOF >expected &&
> +		picked
> +
> +		# ------------------------ >8 ------------------------
> +		# Do not modify or remove the line above.
> +		# Everything below it will be ignored.
> +		#
> +		# Conflicts:
> +		#	foo
> +		EOF
> +
> +	test_must_fail git cherry-pick --cleanup=scissors picked &&
> +
> +	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
> +	test_i18ncmp expected actual
> +'
> +
>   test_expect_success 'failed cherry-pick describes conflict in work tree' '
>   	pristine_detach initial &&
>   	cat <<-EOF >expected &&
> @@ -335,6 +377,52 @@ test_expect_success 'revert conflict, diff3 -m style' '
>   	test_cmp expected actual
>   '
>   
> +test_expect_success \
> +	'revert conflict, ensure commit.cleanup = scissors places scissors line properly' '
> +	pristine_detach initial &&
> +	git config commit.cleanup scissors &&
> +	cat >expected <<-EOF &&
> +		Revert "picked"
> +
> +		This reverts commit objid.
> +
> +		# ------------------------ >8 ------------------------
> +		# Do not modify or remove the line above.
> +		# Everything below it will be ignored.
> +		#
> +		# Conflicts:
> +		#	foo
> +		EOF
> +
> +	test_must_fail git revert picked &&
> +
> +	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
> +	test_i18ncmp expected actual
> +'
> +
> +test_expect_success \
> +	'revert conflict, ensure cleanup=scissors places scissors line properly' '
> +	pristine_detach initial &&
> +	git config --unset commit.cleanup &&
> +	cat >expected <<-EOF &&
> +		Revert "picked"
> +
> +		This reverts commit objid.
> +
> +		# ------------------------ >8 ------------------------
> +		# Do not modify or remove the line above.
> +		# Everything below it will be ignored.
> +		#
> +		# Conflicts:
> +		#	foo
> +		EOF
> +
> +	test_must_fail git revert --cleanup=scissors picked &&
> +
> +	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
> +	test_i18ncmp expected actual
> +'
> +
>   test_expect_success 'failed cherry-pick does not forget -s' '
>   	pristine_detach initial &&
>   	test_must_fail git cherry-pick -s picked &&
> 
