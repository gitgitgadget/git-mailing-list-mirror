Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813D3202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 06:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfCTGcU (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 02:32:20 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35287 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCTGcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 02:32:20 -0400
Received: by mail-pg1-f173.google.com with SMTP id g8so1033543pgf.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ZCic359h+v/I18WuKzD5Do5DUnbYrfa/+t1mSZHcI4=;
        b=fstjYGhTYKOa1tC3WG9IHZ9PSfQQafliWwoYwlA70qgCOp3UWAuumAE0ZXWk7rkipT
         yHDPUySNA2HtbvTqTFxXUt7WE1Tswq85Q/P3OVuMnpNqo/2hMoCENJKOKffnhj4Byg5q
         iqFcprjcAlnSTdGoUI5DcTHWJudDfvjRxwYLeilrRmVvAiJzDF6RLUoUHg+GOYjRi4zf
         Lpg/nUtjeW0Pxyc1DORKcvf1fDoFvKpk0gx6KHrIIkq1EaZ3/gGAvy77mBYG7TQChxgx
         zNm740ujd0UsmpeXEaOE056lSUESq1Kzwqrp+RZ51xHLFA0v5MEqR5QeTxCoWyW4MYZZ
         gzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ZCic359h+v/I18WuKzD5Do5DUnbYrfa/+t1mSZHcI4=;
        b=ZWNMbvyKudDQRXz5YdIcXEgoVCpRDICsWucyXOQ4ohuW2M4ap3Jc1eVMAm56BKcnr9
         fXwOljtF5ZyNHq4FZ7ENV2rWhIGqQVP8kfkI1i/2Zk/1uXqdjKxjzTESEI6bkTDQi0I0
         wlxH//msU6YLfA47Z1pdPsix0MMY0X1enZ9PHP639WDvpdiXqZzYBqMLOy1ff17rIh2x
         hWgq1WqNkGZYr8OM6LSj/Kn6WmCAyVEkhJYHcXnMobIC29ROcZxwTkDQyxXtktHF+XDI
         eEX6wjHxIo8rUvNrKWjZXYR824UCg1OBA/U6uHVyVWJDz0NfV2qETjf8BvrE10ue3aq+
         Lw+w==
X-Gm-Message-State: APjAAAVhZ8LJoDzcs5sA8tboqGMvhA2kgRktrZrRdtOrEnYF4iQfnwLE
        4n3bDM9ZRkAAesQaLy5Nq/s=
X-Google-Smtp-Source: APXvYqyUl1G/Y98g5hTUUw3rtjEJyWH3JuwqoS4SXYRmfkD1bqPA0W79Yn5yVgNGZ1I/N9YdVZxQeg==
X-Received: by 2002:a62:4287:: with SMTP id h7mr6127532pfd.110.1553063539303;
        Tue, 19 Mar 2019 23:32:19 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id u10sm1047027pgr.2.2019.03.19.23.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 23:32:17 -0700 (PDT)
Date:   Tue, 19 Mar 2019 23:32:15 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v8 08/11] merge: cleanup messages like commit
Message-ID: <20190320063215.GA9432@archbookpro.localdomain>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
 <cd5c764fbf2c7aa6fb09a08a93c171580a41940d.1552817044.git.liu.denton@gmail.com>
 <304e99ef-553c-f538-f1d8-aaa0937da62f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304e99ef-553c-f538-f1d8-aaa0937da62f@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, Mar 19, 2019 at 11:13:37AM +0000, Phillip Wood wrote:
> Hi Denton
> 
> On 17/03/2019 10:16, Denton Liu wrote:
> > This change allows git-merge messages to be cleaned up with the
> > commit.cleanup configuration or --cleanup option, just like how
> > git-commit does it.
> > 
> > We also give git-pull the passthrough option of --cleanup so that it can
> > also take advantage of this change.
> > 
> > Finally, add testing to ensure that messages are properly cleaned up.
> > Note that some newlines that were added to the commit message were
> > removed so that if a file were read via -F, it would be copied
> > faithfully.
> > 
> > Reviewed-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> I'd echo Eric's comments about Reviewed-by tags.

Will do.

> 
> > Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > 
> > Phillip Wood wrote:
> > > cleanup needs to take an argument so PARSE_OPT_NOARG does not look
> > > right. Also I think it would be bettor from the user's point of view if
> > > the value of the argument was checked by pull before it does any work
> > > rather otherwise if they pass in invalid value pull mostly runs and then
> > > merge errors out at the end.
> > 
> > I opted not to do a check on the validity of the value of the
> > --cleanup-mode argument because the strategy options that existed before
> > also didn't verify the validity of their values. In the future, it might
> > be a good idea to check the values of both cleanup-mode and the
> > strategy options but for now, I think we can leave it as it is.
> 
> With --strategy-option the valid values depend on the --strategy option
> which may invoke an external command so in general there is no way to check
> the values are valid (it could do for the strategies we know about). With
> --cleanup we know the valid values and have a function that can check for
> them so I think it would be worth doing.

Makes sense, I'll do it (and throw in a test case for free ;) )

> 
> >   Documentation/merge-options.txt |  5 +++
> >   builtin/merge.c                 | 31 +++++++++++----
> >   builtin/pull.c                  |  6 +++
> >   t/t7604-merge-custom-message.sh | 67 +++++++++++++++++++++++++++++++++
> >   wt-status.c                     | 12 ++++--
> >   wt-status.h                     |  1 +
> >   6 files changed, 112 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> > index 92a7d936c1..646100ea9a 100644
> > --- a/Documentation/merge-options.txt
> > +++ b/Documentation/merge-options.txt
> > @@ -32,6 +32,11 @@ they run `git merge`. To make it easier to adjust such scripts to the
> >   updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
> >   set to `no` at the beginning of them.
> > +--cleanup=<mode>::
> > +	This option determines how the merge message will be cleaned up
> > +	before commiting or being passed on. See linkgit:git-commit[1] for more
> 
> As I commented before I don't understand 'passed on'

I changed it in git-revert.txt and git-cherry-pick.txt but I forgot to
change it here. What do you think about this:

	--cleanup=<mode>::
		This option determines how the merge message will be cleaned up
		before commiting or being passed on to the commit machinery. See
		linkgit:git-commit[1] for more details.

> 
> > +	details.
> > +
> >   --ff::
> >   	When the merge resolves as a fast-forward, only update the branch
> >   	pointer, without creating a merge commit.  This is the default
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 5ce8946d39..7be03a2610 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -38,6 +38,7 @@
> >   #include "tag.h"
> >   #include "alias.h"
> >   #include "commit-reach.h"
> > +#include "wt-status.h"
> >   #define DEFAULT_TWOHEAD (1<<0)
> >   #define DEFAULT_OCTOPUS (1<<1)
> > @@ -98,6 +99,9 @@ enum ff_type {
> >   static enum ff_type fast_forward = FF_ALLOW;
> > +static const char *cleanup_arg;
> > +static enum commit_msg_cleanup_mode cleanup_mode;
> > +
> >   static int option_parse_message(const struct option *opt,
> >   				const char *arg, int unset)
> >   {
> > @@ -249,6 +253,7 @@ static struct option builtin_merge_options[] = {
> >   		N_("perform a commit if the merge succeeds (default)")),
> >   	OPT_BOOL('e', "edit", &option_edit,
> >   		N_("edit message before committing")),
> > +	OPT_CLEANUP(&cleanup_arg),
> >   	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
> >   	OPT_SET_INT_F(0, "ff-only", &fast_forward,
> >   		      N_("abort if fast-forward is not possible"),
> > @@ -612,6 +617,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
> >   		return git_config_string(&pull_twohead, k, v);
> >   	else if (!strcmp(k, "pull.octopus"))
> >   		return git_config_string(&pull_octopus, k, v);
> > +	else if (!strcmp(k, "commit.cleanup"))
> > +		return git_config_string(&cleanup_arg, k, v);
> >   	else if (!strcmp(k, "merge.renormalize"))
> >   		option_renormalize = git_config_bool(k, v);
> >   	else if (!strcmp(k, "merge.ff")) {
> > @@ -797,23 +804,32 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
> >   	exit(1);
> >   }
> > +static const char comment_line_explanation[] =
> > +N_("Lines starting with '%c' will be ignored.\n");
> > +
> >   static const char merge_editor_comment[] =
> >   N_("Please enter a commit message to explain why this merge is necessary,\n"
> >      "especially if it merges an updated upstream into a topic branch.\n"
> >      "\n"
> > -   "Lines starting with '%c' will be ignored, and an empty message aborts\n"
> > -   "the commit.\n");
> > +   "An empty message aborts the commit.\n");
> >   static void write_merge_heads(struct commit_list *);
> >   static void prepare_to_commit(struct commit_list *remoteheads)
> >   {
> >   	struct strbuf msg = STRBUF_INIT;
> >   	strbuf_addbuf(&msg, &merge_msg);
> > -	strbuf_addch(&msg, '\n');
> >   	if (squash)
> >   		BUG("the control must not reach here under --squash");
> > -	if (0 < option_edit)
> > -		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
> > +	if (0 < option_edit) {
> > +		strbuf_addch(&msg, '\n');
> > +		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
> > +			wt_status_append_cut_line(&msg);
> > +		else
> > +			strbuf_commented_addf(&msg, _(comment_line_explanation), comment_line_char);
> > +
> > +		strbuf_commented_addf(&msg, "\n");
> > +		strbuf_commented_addf(&msg, _(merge_editor_comment));
> > +	}
> 
> This still changes the wording of the message cf https://public-inbox.org/git/cover.1552275703.git.liu.denton@gmail.com/T/#m09cb1a05eb3bffb47ee9f25572904a7279efa362

Will do.

Thanks again for reviewing carefully!

> 
> Best Wishes
> 
> Phillip
> 
> >   	if (signoff)
> >   		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
> >   	write_merge_heads(remoteheads);
> > @@ -832,7 +848,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
> >   		abort_commit(remoteheads, NULL);
> >   	read_merge_msg(&msg);
> > -	strbuf_stripspace(&msg, 0 < option_edit);
> > +	cleanup_message(&msg, cleanup_mode, 0);
> >   	if (!msg.len)
> >   		abort_commit(remoteheads, _("Empty commit message."));
> >   	strbuf_release(&merge_msg);
> > @@ -880,7 +896,6 @@ static int finish_automerge(struct commit *head,
> >   	parents = remoteheads;
> >   	if (!head_subsumed || fast_forward == FF_NO)
> >   		commit_list_insert(head, &parents);
> > -	strbuf_addch(&merge_msg, '\n');
> >   	prepare_to_commit(remoteheads);
> >   	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
> >   			&result_commit, NULL, sign_commit))
> > @@ -1389,6 +1404,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> >   	if (option_edit < 0)
> >   		option_edit = default_edit_option();
> > +	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit, 1);
> > +
> >   	if (!use_strategies) {
> >   		if (!remoteheads)
> >   			; /* already up-to-date */
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 33db889955..292c1dac27 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -101,6 +101,7 @@ static char *opt_signoff;
> >   static char *opt_squash;
> >   static char *opt_commit;
> >   static char *opt_edit;
> > +static char *opt_cleanup;
> >   static char *opt_ff;
> >   static char *opt_verify_signatures;
> >   static int opt_autostash = -1;
> > @@ -168,6 +169,9 @@ static struct option pull_options[] = {
> >   	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
> >   		N_("edit message before committing"),
> >   		PARSE_OPT_NOARG),
> > +	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
> > +		N_("how to strip spaces and #comments from message"),
> > +		0),
> >   	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
> >   		N_("allow fast-forward"),
> >   		PARSE_OPT_NOARG),
> > @@ -644,6 +648,8 @@ static int run_merge(void)
> >   		argv_array_push(&args, opt_commit);
> >   	if (opt_edit)
> >   		argv_array_push(&args, opt_edit);
> > +	if (opt_cleanup)
> > +		argv_array_push(&args, opt_cleanup);
> >   	if (opt_ff)
> >   		argv_array_push(&args, opt_ff);
> >   	if (opt_verify_signatures)
> > diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
> > index b045fdb413..c9685a318d 100755
> > --- a/t/t7604-merge-custom-message.sh
> > +++ b/t/t7604-merge-custom-message.sh
> > @@ -51,4 +51,71 @@ test_expect_success 'merge --log appends to custom message' '
> >   	test_cmp exp.log actual
> >   '
> > +mesg_with_comment_and_newlines='
> > +# text
> > +
> > +'
> > +
> > +test_expect_success 'prepare file with comment line and trailing newlines'  '
> > +	printf "%s" "$mesg_with_comment_and_newlines" >expect
> > +'
> > +
> > +test_expect_success 'cleanup commit messages (verbatim option)' '
> > +	git reset --hard c1 &&
> > +	git merge --cleanup=verbatim -F expect c2 &&
> > +	git cat-file commit HEAD >actual &&
> > +	sed -e "1,/^$/d" <actual >tmp &&
> > +	mv tmp actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'cleanup commit messages (whitespace option)' '
> > +	git reset --hard c1 &&
> > +	test_write_lines "" "# text" "" >text &&
> > +	echo "# text" >expect &&
> > +	git merge --cleanup=whitespace -F text c2 &&
> > +	git cat-file commit HEAD >actual &&
> > +	sed -e "1,/^$/d" <actual >tmp &&
> > +	mv tmp actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'cleanup merge messages (scissors option)' '
> > +	git reset --hard c1 &&
> > +	cat >text <<-\EOF &&
> > +
> > +	# to be kept
> > +
> > +	  # ------------------------ >8 ------------------------
> > +	# to be kept, too
> > +	# ------------------------ >8 ------------------------
> > +	to be removed
> > +	# ------------------------ >8 ------------------------
> > +	to be removed, too
> > +	EOF
> > +
> > +	cat >expect <<-\EOF &&
> > +	# to be kept
> > +
> > +	  # ------------------------ >8 ------------------------
> > +	# to be kept, too
> > +	EOF
> > +	git merge --cleanup=scissors -e -F text c2 &&
> > +	git cat-file commit HEAD >actual &&
> > +	sed -e "1,/^$/d" <actual >tmp &&
> > +	mv tmp actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'cleanup commit messages (strip option)' '
> > +	git reset --hard c1 &&
> > +	test_write_lines "" "# text" "sample" "" >text &&
> > +	echo sample >expect &&
> > +	git merge --cleanup=strip -F text c2 &&
> > +	git cat-file commit HEAD >actual &&
> > +	sed -e "1,/^$/d" <actual >tmp &&
> > +	mv tmp actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >   test_done
> > diff --git a/wt-status.c b/wt-status.c
> > index 445a36204a..b81fcd428d 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1006,13 +1006,19 @@ size_t wt_status_locate_end(const char *s, size_t len)
> >   	return len;
> >   }
> > -void wt_status_add_cut_line(FILE *fp)
> > +void wt_status_append_cut_line(struct strbuf *buf)
> >   {
> >   	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
> > +
> > +	strbuf_commented_addf(buf, "%s", cut_line);
> > +	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
> > +}
> > +
> > +void wt_status_add_cut_line(FILE *fp)
> > +{
> >   	struct strbuf buf = STRBUF_INIT;
> > -	fprintf(fp, "%c %s", comment_line_char, cut_line);
> > -	strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
> > +	wt_status_append_cut_line(&buf);
> >   	fputs(buf.buf, fp);
> >   	strbuf_release(&buf);
> >   }
> > diff --git a/wt-status.h b/wt-status.h
> > index 3a95975032..64f1ddc9fd 100644
> > --- a/wt-status.h
> > +++ b/wt-status.h
> > @@ -129,6 +129,7 @@ struct wt_status {
> >   };
> >   size_t wt_status_locate_end(const char *s, size_t len);
> > +void wt_status_append_cut_line(struct strbuf *buf);
> >   void wt_status_add_cut_line(FILE *fp);
> >   void wt_status_prepare(struct repository *r, struct wt_status *s);
> >   void wt_status_print(struct wt_status *s);
> > 
