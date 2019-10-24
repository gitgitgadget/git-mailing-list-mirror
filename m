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
	by dcvr.yhbt.net (Postfix) with ESMTP id B65451F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 13:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393578AbfJXN2t (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 09:28:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388733AbfJXN2t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 09:28:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so15299778wrw.13
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z6D1xh+Fjpgmbq8YN2zk7VCyq7XnQfWxTgm+dRlhIJQ=;
        b=PpIlK0ufVKubf7zsWbpwaABECWKN18wPvwTUmU/Ih2kJ00Cfx4njgbc6W/YRtqT74n
         Fzh67YMkaN9mAZ1SVsx9wxamzqxRL3hZRz7bRR7TeZ4J183H9YJF05MIfrP8sx0Rz11q
         gDV93YMILH3BEvhV22RpDseZH/QLGNXxAnB3J4IM/M+L1puU2ids6oyGYVIfCRnD9qY4
         2J/b4hqcggLAAEEBV/aY42ZELr/SRDqnpEyrExZ/YOA7FIXAvn/hVrFTzRFf+byYHyVU
         CtNZ+m3Is45LV3mM4GEvqIHX4u0+F4FcXobBFg5k5oOscGczOKbTTvAU3Mq8DMO1Zi3J
         CilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z6D1xh+Fjpgmbq8YN2zk7VCyq7XnQfWxTgm+dRlhIJQ=;
        b=Fo18CiH5bypM7RS9oveVRtUTdRIgLSgWnSwkcnKDUiLR+K2RkDQqPOOIUlGtDzMQ0A
         tgfix+9E8DhxiugUgWBvJwqZ+nHwsmyGMh07p9YleE+3aF51KTOwqnv9hGAKIceSCRHQ
         DASlb7jCm7iMXoRRFodj8a8mBOcFImDDlXGWwezx2eL/2CY7IWzgQSzDitPWN0TsQhHb
         snIiagfJnP+hi2GiKzBuxqd9QBlq5cyxCm0sF5hcjFo2mth86VDgI1qDJ6U9rKDlc6FE
         cq8mlAvuK6D0vrdU2V2VLh2n5FlB+0GcHGz0veNNfc/B6Ar4bEWDV41sUCvA8MRzL/cw
         rvjg==
X-Gm-Message-State: APjAAAWLJgmEO+dKRttmlMKdH4NWQU7UkBCy25JxfOrJOV/leXFAXEyR
        IlPQyIGb1w9nVr8N8027jKE=
X-Google-Smtp-Source: APXvYqwbFZ1qxjrZKp59mPvy/wunV18E1lXrYiUO9HjYaWhmj4IgGbXazu2V6m4Fx6k/6htin3LsNg==
X-Received: by 2002:adf:9bdc:: with SMTP id e28mr3707926wrc.309.1571923726175;
        Thu, 24 Oct 2019 06:28:46 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id c189sm3395824wme.24.2019.10.24.06.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:28:45 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/6] rebase -i: support --committer-date-is-author-date
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-4-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <103fc38d-48b4-c81f-a0ef-5163a1018e88@gmail.com>
Date:   Thu, 24 Oct 2019 14:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190907115034.14933-4-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 07/09/2019 12:50, Rohit Ashiwal wrote:
> rebase am already has this flag to "lie" about the committer date
> by changing it to the author date. Let's add the same for
> interactive machinery.
> [...]> diff --git a/sequencer.c b/sequencer.c
> index adeff2561e..fd925f2d72 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -147,6 +147,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>    * command-line.
>    */
>   static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
> +static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
>   static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>   static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>   static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -879,6 +880,17 @@ static char *get_author(const char *message)
>   	return NULL;
>   }
>   
> +/* Returns a "date" string that needs to be free()'d by the caller */
> +static char *read_author_date_or_null(void)
> +{
> +	char *date;
> +
> +	if (read_author_script(rebase_path_author_script(),
> +			       NULL, NULL, &date, 0))
> +		return NULL;
> +	return date;
> +}

This function and the hunk below are untested according to Stolee's 
latest test email [1]. We need a test that gets the sequencer to fork 
'git commit' rewording a commit should do that.

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/ed8e65a2-72e8-210c-d4a4-eacdb5c7b0e8@gmail.com/

>   static const char staged_changes_advice[] =
>   N_("you have staged changes in your working tree\n"
>   "If these changes are meant to be squashed into the previous commit, run:\n"
> @@ -938,6 +950,24 @@ static int run_git_commit(struct repository *r,
>   
>   	cmd.git_cmd = 1;
>   
> +        if (opts->committer_date_is_author_date) {
> +	        int res = -1;
> +	        struct strbuf datebuf = STRBUF_INIT;
> +	        char *date = read_author_date_or_null();
> +
> +	        if (!date)
> +	                return -1;
> +
> +	        strbuf_addf(&datebuf, "@%s", date);
> +	        res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
> +
> +		strbuf_release(&datebuf);
> +	        free(date);
> +
> +	        if (res)
> +	                return -1;
> +        }
> +
>   	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
>   		const char *gpg_opt = gpg_sign_opt_quoted(opts);
>   
> @@ -1331,7 +1361,6 @@ static int try_to_commit(struct repository *r,
>   
>   	if (parse_head(r, &current_head))
>   		return -1;
> -
>   	if (flags & AMEND_MSG) {
>   		const char *exclude_gpgsig[] = { "gpgsig", NULL };
>   		const char *out_enc = get_commit_output_encoding();
> @@ -1359,6 +1388,26 @@ static int try_to_commit(struct repository *r,
>   		commit_list_insert(current_head, &parents);
>   	}
>   
> +	if (opts->committer_date_is_author_date) {
> +		int len = strlen(author);
> +		struct ident_split ident;
> +		struct strbuf date = STRBUF_INIT;
> +
> +		if (split_ident_line(&ident, author, len) < 0)
> +			return error(_("malformed ident line"));
> +		if (!ident.date_begin)
> +			return error(_("corrupted author without date information"));
> +
> +		strbuf_addf(&date, "@%.*s %.*s",
> +			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
> +			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
> +		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
> +		strbuf_release(&date);
> +
> +		if (res)
> +			goto out;
> +	}
> +
>   	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
>   		res = error(_("git write-tree failed to write a tree"));
>   		goto out;
> @@ -2473,6 +2522,11 @@ static int read_populate_opts(struct replay_opts *opts)
>   			opts->signoff = 1;
>   		}
>   
> +		if (file_exists(rebase_path_cdate_is_adate())) {
> +			opts->allow_ff = 0;
> +			opts->committer_date_is_author_date = 1;
> +		}
> +
>   		if (file_exists(rebase_path_reschedule_failed_exec()))
>   			opts->reschedule_failed_exec = 1;
>   
> @@ -2555,6 +2609,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>   		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
>   	if (opts->signoff)
>   		write_file(rebase_path_signoff(), "--signoff\n");
> +	if (opts->committer_date_is_author_date)
> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>   	if (opts->reschedule_failed_exec)
>   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>   
> @@ -3752,7 +3808,8 @@ static int pick_commits(struct repository *r,
>   	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>   	if (opts->allow_ff)
>   		assert(!(opts->signoff || opts->no_commit ||
> -				opts->record_origin || opts->edit));
> +				opts->record_origin || opts->edit ||
> +				opts->committer_date_is_author_date));
>   	if (read_and_refresh_cache(r, opts))
>   		return -1;
>   
> diff --git a/sequencer.h b/sequencer.h
> index 6704acbb9c..e3881e9275 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -43,6 +43,7 @@ struct replay_opts {
>   	int verbose;
>   	int quiet;
>   	int reschedule_failed_exec;
> +	int committer_date_is_author_date;
>   
>   	int mainline;
>   
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 4342f79eea..7402f7e3da 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>   }
>   
>   test_rebase_am_only --whitespace=fix
> -test_rebase_am_only --committer-date-is-author-date
>   test_rebase_am_only -C4
>   
>   test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> index 2e16e00a9d..6c1fbab4d8 100755
> --- a/t/t3433-rebase-options-compatibility.sh
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -7,6 +7,9 @@ test_description='tests to ensure compatibility between am and interactive backe
>   
>   . ./test-lib.sh
>   
> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
> +export GIT_AUTHOR_DATE
> +
>   # This is a special case in which both am and interactive backends
>   # provide the same output. It was done intentionally because
>   # both the backends fall short of optimal behaviour.
> @@ -26,8 +29,13 @@ test_expect_success 'setup' '
>   	EOF
>   	git commit -am "update file" &&
>   	git tag side &&
> +	test_commit commit1 foo foo1 &&
> +	test_commit commit2 foo foo2 &&
> +	test_commit commit3 foo foo3 &&
>   
>   	git checkout --orphan master &&
> +	git rm --cached foo &&
> +	rm foo &&
>   	sed -e "s/^|//" >file <<-\EOF &&
>   	|line 1
>   	|        line 2
> @@ -62,4 +70,33 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
>   	test_cmp expect file
>   '
>   
> +test_expect_success '--committer-date-is-author-date works with am backend' '
> +	git commit --amend &&
> +	git rebase --committer-date-is-author-date HEAD^ &&
> +	git show HEAD --pretty="format:%ai" >authortime &&
> +	git show HEAD --pretty="format:%ci" >committertime &&
> +	test_cmp authortime committertime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with interactive backend' '
> +	git commit --amend &&
> +	git rebase -i --committer-date-is-author-date HEAD^ &&
> +	git show HEAD --pretty="format:%ai" >authortime &&
> +	git show HEAD --pretty="format:%ci" >committertime &&
> +	test_cmp authortime committertime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with rebase -r' '
> +	git checkout side &&
> +	git merge commit3 &&
> +	git rebase -r --root --committer-date-is-author-date &&
> +	git rev-list HEAD >rev_list &&
> +	while read HASH
> +	do
> +		git show $HASH --pretty="format:%ai" >authortime
> +		git show $HASH --pretty="format:%ci" >committertime
> +		test_cmp authortime committertime
> +	done <rev_list
> +'
> +
>   test_done
> 
