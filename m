Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3757A20248
	for <e@80x24.org>; Tue, 12 Mar 2019 11:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfCLLLS (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 07:11:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50386 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLLLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 07:11:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id x7so2201626wmj.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Go82xnwq9nq0b5YheSBBLJFUGU1nLd+y3kfcny3TWIw=;
        b=RWCqjI8+f02f3oskR+G8DsOONsk8c4GWiAbsd9icmb5olJ7nPwGEG3jmftCSauJ+1/
         8LWs7Cn3Q2m7XtogiWkoUYhqHkb/lOXndGNRF4acHG9IKon0+I0b2xGiKGEme6tfthu3
         tEOrEv7x+uwdZdgaNmB5//CiFOy+F+RPqOyxQF5DNRHrP5n8jcEvjtdTNcLrGZl43bFU
         Uq+kjL8SAClgoAaTmSaG9Hz9hRwkbZS0E+hbv5q9hCOb1NRIytlDrQoPBy+CiJK6hc5Q
         yhsyk/HS/ZQf/M222OnQeRgYDsY9CMwgNVRh6Fpf4hjdXZEkScCC+uXQmWoQwd5Mnisq
         qi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Go82xnwq9nq0b5YheSBBLJFUGU1nLd+y3kfcny3TWIw=;
        b=Cmkzz74Wnxdct6gjgtc7wlRDJeuXxIjeD3VKq2bVOiGjOAglxVW+faOg4FRvH20zrM
         hyP/CGP5cTUhXsbyc5j1iIORwaOlSkqfuke8lknIMOontqYOSrC+KjRpf6KgHWG35Yrq
         LiPMlAhOfLgfDPRzE+hC+f+v6YJ8I08I06a2nfOC+CjM4qZk6ThynCsTCJfMnmbFFFAB
         oY05uYco7wQm7TlTtTlLIC3S9140tMK32KrAzdHg4MjHQWkZeKVdQdztV/N7w80oNzX3
         ipzDIGgKKCOuwunVkhBBwrb499LOvNrtty+eQkjvr25E0vxZ/+02RTu3Elv7coSywVWn
         OOGQ==
X-Gm-Message-State: APjAAAUJJN078rek5TnQanxizpP9EbMmwRRIakFtIy5qBEbsC84LAZq0
        lGEK3kFw2cUzbAGtezTfiWSt/qON10o=
X-Google-Smtp-Source: APXvYqzYtvkYe5lwHg1G2f6FOn1rKFmnbc2xzHVpvcBJ8ihk7GdIVHVzPC+j67Xb3DNXC8XQFa4cDw==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr1958774wmg.76.1552389075282;
        Tue, 12 Mar 2019 04:11:15 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-27-66.as13285.net. [92.22.27.66])
        by smtp.gmail.com with ESMTPSA id 132sm2511599wmd.30.2019.03.12.04.11.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 04:11:14 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 8/8] cherry-pick/revert: add scissors line on merge
 conflict
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
 <5b30d939674542b2cfeeeef8341ab25c7d6c0543.1552275703.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <646a1d6a-5e40-5ff1-4702-a41addd4b315@gmail.com>
Date:   Tue, 12 Mar 2019 11:11:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5b30d939674542b2cfeeeef8341ab25c7d6c0543.1552275703.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

I've got a couple of small comments, but this looks fine to me

On 11/03/2019 03:42, Denton Liu wrote:
> Fix a bug where the scissors line is placed after the Conflicts:
> section, in the case where a merge conflict occurs and
> commit.cleanup = scissors.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   Documentation/git-cherry-pick.txt |  7 +++
>   Documentation/git-revert.txt      |  7 +++
>   builtin/merge.c                   |  9 +---
>   builtin/rebase--interactive.c     |  2 +-
>   builtin/revert.c                  |  5 ++
>   sequencer.c                       | 22 +++++---
>   sequencer.h                       |  3 +-
>   t/t3507-cherry-pick-conflict.sh   | 86 +++++++++++++++++++++++++++++++
>   8 files changed, 123 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index b8cfeec67e..b4ff8e136d 100644
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
> +	be appended to MERGE_MSG before being passed on in the case of a
> +	conflict.

I'm not sure what you mean by before being passed on.

>   -x::
>   	When recording the commit, append a line that says
>   	"(cherry picked from commit ...)" to the original commit
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 837707a8fd..bd4ad395a9 100644
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
> +	be appended to MERGE_MSG before being passed on in the case of a
> +	conflict.
> +
>   -n::
>   --no-commit::
>   	Usually the command automatically creates some commits with
> diff --git a/builtin/merge.c b/builtin/merge.c
> index b620d4bfcb..671d6a19a4 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -923,14 +923,7 @@ static int suggest_conflicts(void)
>   	 * Thus, we will get the cleanup mode which is returned when we _are_ using
>   	 * an editor.
>   	 */
> -	if (get_cleanup_mode(cleanup_arg, 1, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
> -	    fputc('\n', fp);
> -	    wt_status_add_cut_line(fp);
> -	    /* comments out the newline from append_conflicts_hint */
> -	    fputc(comment_line_char, fp);
> -	}
> -
> -	append_conflicts_hint(&the_index, &msgbuf);
> +	append_conflicts_hint(&the_index, &msgbuf, get_cleanup_mode(cleanup_arg, 1, 1));
>   	fputs(msgbuf.buf, fp);
>   	strbuf_release(&msgbuf);
>   	fclose(fp);
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index 888390f911..cf2151b271 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -199,10 +199,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   		OPT_END()
>   	};
>   
> +	opts.action = REPLAY_INTERACTIVE_REBASE;
>   	sequencer_init_config(&opts);
>   	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
>   
> -	opts.action = REPLAY_INTERACTIVE_REBASE;
>   	opts.allow_ff = 1;
>   	opts.allow_empty = 1;
>   
> diff --git a/builtin/revert.c b/builtin/revert.c
> index a47b53ceaf..e8168e0214 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -96,11 +96,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
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

This line is rather long. As you're adding --cleanup to several commands 
it might be an idea to add an OPT_CLEANUP macro to parse-options.h. That 
would ensure the help is consistent across all the commands and save 
repeating the option declaration.

Best Wishes

Phillip

>   		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
>   		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
>   		OPT_NOOP_NOARG('r', NULL),
> @@ -137,6 +139,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   	if (opts->keep_redundant_commits)
>   		opts->allow_empty = 1;
>   
> +	if (cleanup_arg)
> +		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1, 1);
> +
>   	/* Check for incompatible command line arguments */
>   	if (cmd) {
>   		char *this_operation;
> diff --git a/sequencer.c b/sequencer.c
> index 5d94e2c865..496554a474 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -176,6 +176,11 @@ struct cleanup_config_mapping cleanup_config_mappings[] = {
>   	{ NULL, 0, 0 }
>   };
>   
> +static inline int is_rebase_i(const struct replay_opts *opts)
> +{
> +	return opts->action == REPLAY_INTERACTIVE_REBASE;
> +}
> +
>   static int git_sequencer_config(const char *k, const char *v, void *cb)
>   {
>   	struct replay_opts *opts = cb;
> @@ -188,7 +193,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   		if (status)
>   			return status;
>   
> -		opts->default_msg_cleanup = get_cleanup_mode(s, 0, 0);
> +		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts), 0);
>   
>   		free((char *)s);
>   		return status;
> @@ -212,11 +217,6 @@ void sequencer_init_config(struct replay_opts *opts)
>   	git_config(git_sequencer_config, opts);
>   }
>   
> -static inline int is_rebase_i(const struct replay_opts *opts)
> -{
> -	return opts->action == REPLAY_INTERACTIVE_REBASE;
> -}
> -
>   static const char *get_dir(const struct replay_opts *opts)
>   {
>   	if (is_rebase_i(opts))
> @@ -557,10 +557,16 @@ const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode)
>   }
>   
>   void append_conflicts_hint(struct index_state *istate,
> -			   struct strbuf *msgbuf)
> +		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
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
>   	for (i = 0; i < istate->cache_nr;) {
> @@ -628,7 +634,7 @@ static int do_recursive_merge(struct repository *r,
>   			_(action_name(opts)));
>   
>   	if (!clean)
> -		append_conflicts_hint(r->index, msgbuf);
> +		append_conflicts_hint(r->index, msgbuf, opts->default_msg_cleanup);
>   
>   	return !clean;
>   }
> diff --git a/sequencer.h b/sequencer.h
> index e3c1f44807..95ff9db508 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -115,7 +115,8 @@ int rearrange_squash(struct repository *r);
>    */
>   void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
>   
> -void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
> +void append_conflicts_hint(struct index_state *istate,
> +		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>   	int use_editor, int die_on_error);
>   const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode);
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 74ff925526..c3894ca9d6 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -189,6 +189,46 @@ test_expect_success 'failed cherry-pick registers participants in index' '
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
> +	test_i18ncmp expected .git/MERGE_MSG
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
> +	test_i18ncmp expected .git/MERGE_MSG
> +'
> +
>   test_expect_success 'failed cherry-pick describes conflict in work tree' '
>   	pristine_detach initial &&
>   	cat <<-EOF >expected &&
> @@ -335,6 +375,52 @@ test_expect_success 'revert conflict, diff3 -m style' '
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
> +		This reverts commit OBJID.
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
> +	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
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
> +		This reverts commit OBJID.
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
> +	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
> +	test_i18ncmp expected actual
> +'
> +
>   test_expect_success 'failed cherry-pick does not forget -s' '
>   	pristine_detach initial &&
>   	test_must_fail git cherry-pick -s picked &&
> 
