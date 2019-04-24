Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE2E1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 09:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfDXJv7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 05:51:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46234 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfDXJv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 05:51:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so24180262wrw.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oiJPHU/zzocY9UXQLVpbo7vLSnMpMMYDqy/gpnLZ/l8=;
        b=Xf9BPZ/UqTm6BM2NXPXnToG5RisIEaufpNxancP8Y4twb9XAMgxRaBfNMxLMSBIbYX
         Af3jt5ywedZrSLZRykjXAjqhLJ3WZA8dm/kWbuurF5fXSCDepdwX4DLq77qecBq46KsP
         G5oSMryuwJxk/3FoPuft7ypoBfac2/Sb4qjBbsVedRJXIE5NWtz8wRFSSNvnRNMs0V7E
         1D4YYWnhb9rIiBdcqHpCSzhUm5LZQWFdNqCIomWDskjAK82XoDmh6YjX9u7VD+8JSX77
         BL0g22ocM43OQYqWjT/RZ/ElZmGILro5ojBCpWQt9LKaWW4aD6AJhm5VRL6n003lRYlW
         iRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oiJPHU/zzocY9UXQLVpbo7vLSnMpMMYDqy/gpnLZ/l8=;
        b=FVSyG8uOgxXu7IQBDFiOWnRXZb00dT/hmYiPY71hGL1M0YWPwiXA7zYDNjdeyNQaUf
         A5N9vC+oQpU+vKPTqivXa4F4vTCZpgdUnkCb5QuwPldsk/AK3XH1k10vRCmevqrkLhO0
         fZmo5rEtGkmc51xBYJ4R9jTVAExtNooci6CSXx9XLHFlaux87z0JNeKhpLi+xuQYpSVE
         l5f152wyiiAxUE+SfJqn+lyOSpP4h3hiGkmYnWoc8s4lrWvN+z7AO6f1/lWfXXDLxZX2
         J54OsnNRztyahq6itpuKMLQiOKPwVBmSIiIYCJnTKM4UlUGPklhoh+tovxiyeRIVYbu8
         m8ag==
X-Gm-Message-State: APjAAAWysps14+mF1yJkm32Gv9r6Y/CjxeEPmCBIq6uOzQRfqbIQXYE8
        mDWcDpGItMS2gZYoA9tZXwqli4Gy
X-Google-Smtp-Source: APXvYqw/haVWi5IGigxq4MdNkYLHqeEGwtII9Ikfvy7YdUzAgXH+8U+6tu2VypqeuyEwdlKtnmQwyw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr20947705wrm.300.1556099516987;
        Wed, 24 Apr 2019 02:51:56 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-7-19.as13285.net. [92.22.7.19])
        by smtp.googlemail.com with ESMTPSA id m6sm5464088wro.4.2019.04.24.02.51.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 02:51:56 -0700 (PDT)
Subject: Re: [PATCH 3/5] sequencer: add support for multiple hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-4-sandals@crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ed0312f5-d174-76e0-fea7-5de93f5840b8@gmail.com>
Date:   Wed, 24 Apr 2019 10:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424004948.728326-4-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/04/2019 01:49, brian m. carlson wrote:
> Add support for multiple post-rewrite hooks, both for "git commit
> --amend" and "git rebase".
> 
> Additionally add support for multiple prepare-commit-msg hooks.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/am.c                       | 28 ++++++---

Having read the patch subject I was surprised to see this touching
bulitin/am.c

>  sequencer.c                        | 96 +++++++++++++++++++-----------
>  t/t5407-post-rewrite-hook.sh       | 15 +++++
>  t/t7505-prepare-commit-msg-hook.sh |  9 +++
>  4 files changed, 105 insertions(+), 43 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 4fb107a9d1..303abc98c2 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -442,22 +442,32 @@ static int run_applypatch_msg_hook(struct am_state *state)
>  static int run_post_rewrite_hook(const struct am_state *state)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> -	const char *hook = find_hook("post-rewrite");
> +	struct child_process proc;
> +	struct string_list *hooks;
> +	struct string_list_item *p;
>  	int ret;
>  
> -	if (!hook)
> +	hooks = find_hooks("post-rewrite");
> +	if (!hooks)
>  		return 0;
>  
> -	argv_array_push(&cp.args, hook);
> -	argv_array_push(&cp.args, "rebase");
> +	for_each_string_list_item(p, hooks) {
> +		child_process_init(&proc);
>  
> -	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
> -	cp.stdout_to_stderr = 1;
> -	cp.trace2_hook_name = "post-rewrite";
> +		argv_array_push(&cp.args, p->string);
> +		argv_array_push(&cp.args, "rebase");
>  
> -	ret = run_command(&cp);
> +		cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
> +		cp.stdout_to_stderr = 1;
> +		cp.trace2_hook_name = "post-rewrite";
>  
> -	close(cp.in);
> +		ret = run_command(&cp);
> +
> +		close(cp.in);
> +		if (ret)
> +			break;
> +	}
> +	free_hooks(hooks);
>  	return ret;
>  }
>  
> diff --git a/sequencer.c b/sequencer.c
> index 79a046d748..3a616ceba6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1088,33 +1088,69 @@ int update_head_with_reflog(const struct commit *old_head,
>  static int run_rewrite_hook(const struct object_id *oldoid,
>  			    const struct object_id *newoid)
>  {
> -	struct child_process proc = CHILD_PROCESS_INIT;
> +	struct child_process proc;
> +	struct string_list *hooks;
> +	struct string_list_item *p;
>  	const char *argv[3];
>  	int code;
>  	struct strbuf sb = STRBUF_INIT;
>  
> -	argv[0] = find_hook("post-rewrite");
> -	if (!argv[0])
> +	hooks = find_hooks("post-rewrite");
> +	if (!hooks)
>  		return 0;
>  
> -	argv[1] = "amend";
> -	argv[2] = NULL;
> +	for_each_string_list_item(p, hooks) {
> +		child_process_init(&proc);
>  
> -	proc.argv = argv;
> -	proc.in = -1;
> -	proc.stdout_to_stderr = 1;
> -	proc.trace2_hook_name = "post-rewrite";
> +		argv[0] = p->string;
> +		argv[1] = "amend";
> +		argv[2] = NULL;
>  
> -	code = start_command(&proc);
> -	if (code)
> -		return code;
> -	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
> -	sigchain_push(SIGPIPE, SIG_IGN);
> -	write_in_full(proc.in, sb.buf, sb.len);
> -	close(proc.in);
> -	strbuf_release(&sb);
> -	sigchain_pop(SIGPIPE);
> -	return finish_command(&proc);
> +		proc.argv = argv;
> +		proc.in = -1;
> +		proc.stdout_to_stderr = 1;
> +		proc.trace2_hook_name = "post-rewrite";
> +
> +		code = start_command(&proc);
> +		if (code)
> +			return code;
> +		strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
> +		sigchain_push(SIGPIPE, SIG_IGN);
> +		write_in_full(proc.in, sb.buf, sb.len);
> +		close(proc.in);
> +		strbuf_release(&sb);
> +		sigchain_pop(SIGPIPE);
> +		code = finish_command(&proc);
> +		if (code)
> +			break;
> +	}
> +	free_hooks(hooks);
> +	return code;
> +}
> +
> +static void run_interactive_rewrite_hook(void)
> +{
> +	struct string_list *hooks;
> +	struct string_list_item *p;
> +	struct child_process child;
> +
> +	hooks = find_hooks("post-rewrite");
> +	if (!hooks)
> +		return;
> +
> +	for_each_string_list_item(p, hooks) {
> +		child_process_init(&child);
> +
> +		child.in = open(rebase_path_rewritten_list(),
> +			O_RDONLY);
> +		child.stdout_to_stderr = 1;
> +		child.trace2_hook_name = "post-rewrite";
> +		argv_array_push(&child.args, p->string);
> +		argv_array_push(&child.args, "rebase");
> +		if (run_command(&child))
> +			break;
> +	}
> +	free_hooks(hooks);
>  }

If you're adding a function to do this it would be nice to use it from
am.c as well rather than duplicating essentially the same code. Is there
any way to use a helper to run all the hooks, rather than introducing a
similar loop everywhere where we call a hook?

>  void commit_post_rewrite(struct repository *r,
> @@ -1326,6 +1362,7 @@ static int try_to_commit(struct repository *r,
>  	char *amend_author = NULL;
>  	const char *hook_commit = NULL;
>  	enum commit_msg_cleanup_mode cleanup;
> +	struct string_list *hooks;
>  	int res = 0;
>  
>  	if (parse_head(r, &current_head))
> @@ -1369,7 +1406,10 @@ static int try_to_commit(struct repository *r,
>  		goto out;
>  	}
>  
> -	if (find_hook("prepare-commit-msg")) {
> +	hooks = find_hooks("prepare-commit-msg");
> +	if (hooks) {
> +		free_hooks(hooks);

I think you forgot to update run_prepare_commit_msg_hook(), it should
probably be passed this list now. It might be outside the scope of this
series but unifying this with builtin/commit.c

> +
>  		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
>  		if (res)
>  			goto out;
> @@ -3771,8 +3811,6 @@ static int pick_commits(struct repository *r,
>  		if (!stat(rebase_path_rewritten_list(), &st) &&
>  				st.st_size > 0) {
>  			struct child_process child = CHILD_PROCESS_INIT;
> -			const char *post_rewrite_hook =
> -				find_hook("post-rewrite");
>  
>  			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
>  			child.git_cmd = 1;
> @@ -3782,18 +3820,8 @@ static int pick_commits(struct repository *r,
>  			/* we don't care if this copying failed */
>  			run_command(&child);
>  
> -			if (post_rewrite_hook) {
> -				struct child_process hook = CHILD_PROCESS_INIT;
> -
> -				hook.in = open(rebase_path_rewritten_list(),
> -					O_RDONLY);
> -				hook.stdout_to_stderr = 1;
> -				hook.trace2_hook_name = "post-rewrite";
> -				argv_array_push(&hook.args, post_rewrite_hook);
> -				argv_array_push(&hook.args, "rebase");
> -				/* we don't care if this hook failed */
> -				run_command(&hook);
> -			}
> +			/* we don't care if this hook failed */
> +			run_interactive_rewrite_hook();
>  		}
>  		apply_autostash(opts);
>  
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index 7344253bfb..f8ce32fe3b 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -5,6 +5,7 @@
>  
>  test_description='Test the post-rewrite hook.'
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-hooks.sh"
>  
>  test_expect_success 'setup' '
>  	test_commit A foo A &&
> @@ -263,4 +264,18 @@ test_expect_success 'git rebase -i (exec)' '
>  	verify_hook_input
>  '
>  
> +cmd_rebase () {
> +	git reset --hard D &&
> +	FAKE_LINES="1 fixup 2" git rebase -i B
> +}
> +
> +cmd_amend () {
> +	git reset --hard D &&
> +	echo "D new message" > newmsg &&
> +	git commit -Fnewmsg --amend
> +}
> +
> +test_multiple_hooks --ignore-exit-status post-rewrite cmd_rebase
> +test_multiple_hooks --ignore-exit-status post-rewrite cmd_amend
> +
>  test_done
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index ba8bd1b514..5b83f037b5 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -3,6 +3,7 @@
>  test_description='prepare-commit-msg hook'
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-hooks.sh"
>  
>  test_expect_success 'set up commits for rebasing' '
>  	test_commit root &&
> @@ -317,4 +318,12 @@ test_expect_success C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
>  	test $(grep -c prepare-commit-msg actual) = 1
>  '
>  
> +commit_command () {
> +	echo "$1" >>file &&
> +	git add file &&
> +	git commit -m "$1"
> +}
> +
> +test_multiple_hooks prepare-commit-msg commit_command

It's not clear to me that this is testing the sequencer

Best Wishes

Phillip

> +
>  test_done
> 

