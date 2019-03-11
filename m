Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E9320248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfCKQ62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:58:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39222 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQ62 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:58:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id p8so4345167wrq.6
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AusJ10fYlTyTbp/iC2vzGt6cF7yqkAVgo9VVUy+vK6U=;
        b=hPKvYASB32ueUry6PA1reLQ+3EZyvzbgaYwCgfD9RpViuSOy0WiL93q45fgBjNbZ6C
         cMhdEpX/P+OllsDCiCqNtTJYn2gW3VQwOfUFDOoFiXESQ214VeANeofl625Nhk74GA0L
         Q3+xbYZl4nDLpWi9zbxILzXQvnzcw3osbVTb0rtqzwn8YEh8BiHUDdT4YlheNo2PkL+H
         d24/F3bq0yQxGYOr79E4P3RfH/uF7c02XjM5R8DVeTQ+7IVAHHC133SHGrJ/rwMDdmtE
         K9ZZGowvS1AylJ9FH9e6d2hRwlvtoDjBl/B5/zFNdzJQOmVTVUPjvCG2SHZ9WdJqEotX
         qhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AusJ10fYlTyTbp/iC2vzGt6cF7yqkAVgo9VVUy+vK6U=;
        b=ry984/P/iu6WnVHeqNji4XvbM2BV/SczfKvCTstenFMqtqZ2lJP4j3g5W8sKB4yLT8
         boGAdw8S/ucbqDfG/0jMbKBpwG5giWj11BmL2Z2MbOecAPKVGGlcSxnvXWStLsE6MntV
         PAVBuXYQU86mYrrD+BBfqN7Ix45wvWUhG4ID2XCn5GnCu4SRC2yFFtQnrF+NgGkZxyaS
         I0LzMuPRlF64hIjxAB27xh4wlVXQVpOH+BClvaI4R1dEZ7X7lv03SSfo0XRRAJF2fRpb
         8qOzO7iGcI+MoUmvGBWtoIJbyDl5MBsc9ex4+KZs7MFuNHIc/bIvokO46LWEncLUQ+Sd
         JVeA==
X-Gm-Message-State: APjAAAVvt5bS0L+ZuQKkeqZS+P70q4P0KFp/cL6fI0crcXbktheHbFyU
        8eLAARsJSdLicnWGWzi1K84=
X-Google-Smtp-Source: APXvYqyvQcS/QDo/egM/Yezwx9fkXLSn3UYZ2gqhZjhWTdBldwEMdxk+FiE2n/nFP1BiRn/oAz+rAA==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr20146216wrx.243.1552323504914;
        Mon, 11 Mar 2019 09:58:24 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-27-66.as13285.net. [92.22.27.66])
        by smtp.gmail.com with ESMTPSA id k6sm24677846wrq.82.2019.03.11.09.58.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:58:24 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 5/8] merge: cleanup messages like commit
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
 <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c151ea74-ed9b-f33c-eb14-03243325eaf7@gmail.com>
Date:   Mon, 11 Mar 2019 16:58:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 11/03/2019 03:42, Denton Liu wrote:
> This change allows git-merge messages to be cleaned up with the
> commit.cleanup configuration or --cleanup option, just like how
> git-commit does it.
> 
> We also give git-pull the passthrough option of --cleanup so that it can
> also take advantage of this change.
> 
> Finally, add testing to ensure that messages are properly cleaned up.
> Note that some newlines that were added to the commit message were
> removed so that if a file were read via -F, it would be copied
> faithfully.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   Documentation/merge-options.txt |  5 +++
>   builtin/merge.c                 | 31 +++++++++++++----
>   builtin/pull.c                  |  6 ++++
>   t/t7604-merge-custom-message.sh | 61 +++++++++++++++++++++++++++++++++
>   wt-status.c                     | 12 +++++--
>   wt-status.h                     |  1 +
>   6 files changed, 106 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 92a7d936c1..646100ea9a 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -32,6 +32,11 @@ they run `git merge`. To make it easier to adjust such scripts to the
>   updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
>   set to `no` at the beginning of them.
>   
> +--cleanup=<mode>::
> +	This option determines how the merge message will be cleaned up
> +	before commiting or being passed on. See linkgit:git-commit[1] for more
> +	details.
> +
>   --ff::
>   	When the merge resolves as a fast-forward, only update the branch
>   	pointer, without creating a merge commit.  This is the default
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5ce8946d39..4f5fcf5ce9 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -38,6 +38,7 @@
>   #include "tag.h"
>   #include "alias.h"
>   #include "commit-reach.h"
> +#include "wt-status.h"
>   
>   #define DEFAULT_TWOHEAD (1<<0)
>   #define DEFAULT_OCTOPUS (1<<1)
> @@ -98,6 +99,9 @@ enum ff_type {
>   
>   static enum ff_type fast_forward = FF_ALLOW;
>   
> +static const char *cleanup_arg;
> +static enum commit_msg_cleanup_mode cleanup_mode;
> +
>   static int option_parse_message(const struct option *opt,
>   				const char *arg, int unset)
>   {
> @@ -249,6 +253,7 @@ static struct option builtin_merge_options[] = {
>   		N_("perform a commit if the merge succeeds (default)")),
>   	OPT_BOOL('e', "edit", &option_edit,
>   		N_("edit message before committing")),
> +	OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
>   	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
>   	OPT_SET_INT_F(0, "ff-only", &fast_forward,
>   		      N_("abort if fast-forward is not possible"),
> @@ -612,6 +617,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>   		return git_config_string(&pull_twohead, k, v);
>   	else if (!strcmp(k, "pull.octopus"))
>   		return git_config_string(&pull_octopus, k, v);
> +	else if (!strcmp(k, "commit.cleanup"))
> +		return git_config_string(&cleanup_arg, k, v);
>   	else if (!strcmp(k, "merge.renormalize"))
>   		option_renormalize = git_config_bool(k, v);
>   	else if (!strcmp(k, "merge.ff")) {
> @@ -797,23 +804,32 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
>   	exit(1);
>   }
>   
> +static const char comment_line_explanation[] =
> +N_("Lines starting with '%c' will be ignored.\n");
> +
>   static const char merge_editor_comment[] =
>   N_("Please enter a commit message to explain why this merge is necessary,\n"
>      "especially if it merges an updated upstream into a topic branch.\n"
>      "\n"
> -   "Lines starting with '%c' will be ignored, and an empty message aborts\n"
> -   "the commit.\n");
> +   "An empty message aborts the commit.\n");
>   
>   static void write_merge_heads(struct commit_list *);
>   static void prepare_to_commit(struct commit_list *remoteheads)
>   {
>   	struct strbuf msg = STRBUF_INIT;
>   	strbuf_addbuf(&msg, &merge_msg);
> -	strbuf_addch(&msg, '\n');
>   	if (squash)
>   		BUG("the control must not reach here under --squash");
> -	if (0 < option_edit)
> -		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
> +	if (0 < option_edit) {
> +		strbuf_addch(&msg, '\n');
> +		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
> +			wt_status_append_cut_line(&msg);
> +		else
> +			strbuf_commented_addf(&msg, _(comment_line_explanation), comment_line_char);
> +
> +		strbuf_commented_addf(&msg, "\n");
> +		strbuf_commented_addf(&msg, _(merge_editor_comment));

I think this has rearranged the message presented to the user so it now 
reads

Lines starting with '#' will be ignored.
Please enter a commit message to explain why this merge is necessary,
especially if it merges an updated upstream into a topic branch.

An empty message aborts the commit.

To me it read better before, it would be a little more work but I think 
it would be worth preserving the message (especially as this is the 
message people will see unless they specify --cleanup=scissors)

> +	}
>   	if (signoff)
>   		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
>   	write_merge_heads(remoteheads);
> @@ -832,7 +848,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>   		abort_commit(remoteheads, NULL);
>   
>   	read_merge_msg(&msg);
> -	strbuf_stripspace(&msg, 0 < option_edit);
> +	cleanup_message(&msg, cleanup_mode, 0);
>   	if (!msg.len)
>   		abort_commit(remoteheads, _("Empty commit message."));
>   	strbuf_release(&merge_msg);
> @@ -880,7 +896,6 @@ static int finish_automerge(struct commit *head,
>   	parents = remoteheads;
>   	if (!head_subsumed || fast_forward == FF_NO)
>   		commit_list_insert(head, &parents);
> -	strbuf_addch(&merge_msg, '\n');
>   	prepare_to_commit(remoteheads);
>   	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
>   			&result_commit, NULL, sign_commit))
> @@ -1389,6 +1404,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   	if (option_edit < 0)
>   		option_edit = default_edit_option();
>   
> +	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit, 1);
> +
>   	if (!use_strategies) {
>   		if (!remoteheads)
>   			; /* already up-to-date */
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 33db889955..3ec7882375 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -101,6 +101,7 @@ static char *opt_signoff;
>   static char *opt_squash;
>   static char *opt_commit;
>   static char *opt_edit;
> +static char *opt_cleanup;
>   static char *opt_ff;
>   static char *opt_verify_signatures;
>   static int opt_autostash = -1;
> @@ -168,6 +169,9 @@ static struct option pull_options[] = {
>   	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
>   		N_("edit message before committing"),
>   		PARSE_OPT_NOARG),
> +	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
> +		N_("how to strip spaces and #comments from message"),
> +		PARSE_OPT_NOARG),

cleanup needs to take an argument so PARSE_OPT_NOARG does not look 
right. Also I think it would be bettor from the user's point of view if 
the value of the argument was checked by pull before it does any work 
rather otherwise if they pass in invalid value pull mostly runs and then 
merge errors out at the end.

Best Wishes

Phillip


>   	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
>   		N_("allow fast-forward"),
>   		PARSE_OPT_NOARG),
> @@ -644,6 +648,8 @@ static int run_merge(void)
>   		argv_array_push(&args, opt_commit);
>   	if (opt_edit)
>   		argv_array_push(&args, opt_edit);
> +	if (opt_cleanup)
> +		argv_array_push(&args, opt_cleanup);
>   	if (opt_ff)
>   		argv_array_push(&args, opt_ff);
>   	if (opt_verify_signatures)
> diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
> index 89619cf446..3fcd58eb2c 100755
> --- a/t/t7604-merge-custom-message.sh
> +++ b/t/t7604-merge-custom-message.sh
> @@ -47,4 +47,65 @@ test_expect_success 'merge --log appends to custom message' '
>   	test_cmp exp.log actual
>   '
>   
> +mesg_with_comment_and_newlines='
> +# text
> +
> +'
> +
> +test_expect_success 'prepare file with comment line and trailing newlines'  '
> +	printf "%s" "$mesg_with_comment_and_newlines" >expect
> +'
> +
> +test_expect_success 'cleanup commit messages (verbatim option)' '
> +	git reset --hard c1 &&
> +	git merge --cleanup=verbatim -F expect c2 &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'cleanup commit messages (whitespace option)' '
> +	git reset --hard c1 &&
> +	{ echo;echo "# text";echo; } >text &&
> +	echo "# text" >expect &&
> +	git merge --cleanup=whitespace -F text c2 &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> +	test_cmp expect actual
> +
> +'
> +
> +test_expect_success 'cleanup merge messages (scissors option)' '
> +	git reset --hard c1 &&
> +	cat >text <<EOF &&
> +
> +# to be kept
> +
> +  # ------------------------ >8 ------------------------
> +# to be kept, too
> +# ------------------------ >8 ------------------------
> +to be removed
> +# ------------------------ >8 ------------------------
> +to be removed, too
> +EOF
> +
> +	cat >expect <<EOF &&
> +# to be kept
> +
> +  # ------------------------ >8 ------------------------
> +# to be kept, too
> +EOF
> +	git merge --cleanup=scissors -e -F text c2 &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'cleanup commit messages (strip option)' '
> +	git reset --hard c1 &&
> +	{ echo;echo "# text";echo sample;echo; } >text &&
> +	echo sample >expect &&
> +	git merge --cleanup=strip -F text c2 &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> +	test_cmp expect actual
> +
> +'
> +
>   test_done
> diff --git a/wt-status.c b/wt-status.c
> index 445a36204a..b81fcd428d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1006,13 +1006,19 @@ size_t wt_status_locate_end(const char *s, size_t len)
>   	return len;
>   }
>   
> -void wt_status_add_cut_line(FILE *fp)
> +void wt_status_append_cut_line(struct strbuf *buf)
>   {
>   	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
> +
> +	strbuf_commented_addf(buf, "%s", cut_line);
> +	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
> +}
> +
> +void wt_status_add_cut_line(FILE *fp)
> +{
>   	struct strbuf buf = STRBUF_INIT;
>   
> -	fprintf(fp, "%c %s", comment_line_char, cut_line);
> -	strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
> +	wt_status_append_cut_line(&buf);
>   	fputs(buf.buf, fp);
>   	strbuf_release(&buf);
>   }
> diff --git a/wt-status.h b/wt-status.h
> index 3a95975032..64f1ddc9fd 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -129,6 +129,7 @@ struct wt_status {
>   };
>   
>   size_t wt_status_locate_end(const char *s, size_t len);
> +void wt_status_append_cut_line(struct strbuf *buf);
>   void wt_status_add_cut_line(FILE *fp);
>   void wt_status_prepare(struct repository *r, struct wt_status *s);
>   void wt_status_print(struct wt_status *s);
> 
