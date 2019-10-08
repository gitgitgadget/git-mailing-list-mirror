Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAA31F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 08:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfJHIfm (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 04:35:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34438 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfJHIfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 04:35:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id y35so9900140pgl.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxyOtNwqnKSMi+MlBTzUvIxqzDoInLr9W+wpKJPODL8=;
        b=pqvGbBePrXlBuyV8DZKzng/rs0Uq7vALmlPkDSjrwUvFouvot7o7OLfb1AhM2Rnvyv
         KKQ+6jsTZwG5cjvSW4NmGTeoDWMcSU5MW0kmwqoGdrWMt7xZluydpl7qD1+6vxWd8lHH
         vSQY+cJ4SLaXXZylh4owzyxFITBtmoEL2vU14Pw+j4cxMvY3l7GJ59CPPOzEHGFn8qB0
         6sn83c+hdJr74K8w5yya/2lY7Gslf7ew2BPTA7NxdsvIjP/25NcQjw2s6LvlnYlYQft2
         T5tXjKdFP51MUQ/ZL7+9Lz6PdPuuHaUnVyCtOoi76RnoQ3flns2pXXWz26UMRm9PBhWb
         0DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxyOtNwqnKSMi+MlBTzUvIxqzDoInLr9W+wpKJPODL8=;
        b=Mofalz/1lAYvbRqZs5UYweHJ2x/HVLMaGFdC+7dMwUOdpHrR1u/f7CbiUbWSvqBbZ0
         ZMmfw3ivAl8CSmgT4UWY0rLAC+hhTLoxUsJFNrvewrsWCMoBiLMPoa8FJgsTalbijQZj
         M6lzATynH6YG+MEdJSAyyhuqNgqifRRxJ3ATPyenb4qkdB38z9XbWBEnvhlp10P8QATY
         GIzRTGZW4pQ2WthneDWVxngrfd72i8z84UvBK/Knkd4ksY87Oj7NnT6YcyMIPRDAIGGg
         HdWmqLTQn4y+0nfWXkA1AG5QkhvdzP4XBgU0+HytKreZa/kZBIJ5xZCYA3gqFFiq9EBc
         j32A==
X-Gm-Message-State: APjAAAX+neOm8BSKFltm25XjGTr73PBR+QjOmVOLouRGTMGqJey7yYW7
        2km1ACPnmKQzgUJ8+yIu8k6aS3ho
X-Google-Smtp-Source: APXvYqxbLM3zdnH6tNWeeqOUoDtjFd4TZU0dfZIuSThhWlGoMkPb8JWC/Vi49LgyT5SFTF+3/ZnvuA==
X-Received: by 2002:a62:db84:: with SMTP id f126mr3248388pfg.25.1570523739403;
        Tue, 08 Oct 2019 01:35:39 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id s14sm18323019pfe.52.2019.10.08.01.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 01:35:38 -0700 (PDT)
Date:   Tue, 8 Oct 2019 01:35:37 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
Message-ID: <20191008083537.GA6727@generichostname>
References: <20191008074935.10972-1-toon@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008074935.10972-1-toon@iotcl.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the Git community, Toon!

Wow, I never realised that people actually read my braindump of issues
on GGG. Thanks for taking this on.

First some housekeeping, when formatting your patches, it's a good idea
to use `git format-patch --thread` so that your patches are grouped
together by thread.

On Tue, Oct 08, 2019 at 09:49:35AM +0200, Toon Claes wrote:
> Add support to provide the Co-author when committing. For each
> co-author provided with --coauthor=<coauthor>, a line is added at the

I know you're taking the name from my GGG issue but perhaps --co-author
would look better? 

> bottom of the commit message, like this:
> 
>     Co-authored-by: <coauthor>
> 
> It's a common practice use when pairing up with other people and both
> authors want to in the commit message.
> 
> Co-authored-by: Zeger-Jan van de Weg <git@zjvandeweg.nl>

Nice ;)

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-commit.txt |  5 ++++
>  builtin/commit.c             |  7 ++++++
>  sequencer.c                  | 44 ++++++++++++++++++++++++++----------
>  sequencer.h                  |  2 ++
>  t/t7502-commit-porcelain.sh  | 11 +++++++++
>  5 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index afa7b75a23..c059944e38 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -140,6 +140,11 @@ OPTIONS
>  	commit by that author (i.e. rev-list --all -i --author=<author>);
>  	the commit author is then copied from the first such commit found.
> 
> +--coauthor=<coauthor>::
> +        Add a Co-authored-by line with the specified author. Specify the

This line is indented with spaces but it should be changed to a single
tab.

> +	author using the standard `Co Artur <co-artur@example.com>`
> +	format.
> +
>  --date=<date>::
>  	Override the author date used in the commit.
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index ae7aaf6dc6..feb423ed6f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -110,6 +110,7 @@ static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit;
> +static struct string_list coauthors = STRING_LIST_INIT_NODUP;
> 
>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -672,6 +673,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
>  	int old_display_comment_prefix;
>  	int merge_contains_scissors = 0;
> +	int i;
> 
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
> @@ -803,6 +805,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	if (clean_message_contents)
>  		strbuf_stripspace(&sb, 0);
> 
> +	for (i = 0; i < coauthors.nr; i++) {
> +		append_coauthor(&sb, coauthors.items[i].string);
> +	}
> +
>  	if (signoff)
>  		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
> 
> @@ -1504,6 +1510,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
> +		OPT_STRING_LIST(0, "coauthor", &coauthors, N_("co-author"), N_("add Co-authored-by:")),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
>  		OPT_CLEANUP(&cleanup_arg),
> diff --git a/sequencer.c b/sequencer.c
> index d648aaf416..8958a22470 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -36,6 +36,7 @@
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
> 
>  static const char sign_off_header[] = "Signed-off-by: ";
> +static const char coauthor_header[] = "Co-authored-by: ";
>  static const char cherry_picked_prefix[] = "(cherry picked from commit ";
> 
>  GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
> @@ -4385,15 +4386,9 @@ int sequencer_pick_revisions(struct repository *r,
>  	return res;
>  }
> 
> -void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
> +static void append_footer(struct strbuf *msgbuf, struct strbuf* sob, size_t ignore_footer, size_t no_dup_sob)

The * for pointers should go with the name, not the type. Also, `sob` is
a misleading name since it means "Signed-off-by". In this case, we're
using it as a general footer (since it can include Co-author lines too)
so perhaps rename this to `footer`? 

Finally, as a nit, can we mark sob as const?

>  {
> -	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
> -	struct strbuf sob = STRBUF_INIT;
> -	int has_footer;
> -
> -	strbuf_addstr(&sob, sign_off_header);
> -	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
> -	strbuf_addch(&sob, '\n');
> +	size_t has_footer;

Why was this changed into a size_t? has_conforming_footer() below
returns int so we should leave it as is.

> 
>  	if (!ignore_footer)
>  		strbuf_complete_line(msgbuf);
> @@ -4402,11 +4397,11 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
>  	 * If the whole message buffer is equal to the sob, pretend that we
>  	 * found a conforming footer with a matching sob
>  	 */
> -	if (msgbuf->len - ignore_footer == sob.len &&
> -	    !strncmp(msgbuf->buf, sob.buf, sob.len))
> +	if (msgbuf->len - ignore_footer == sob->len &&
> +	    !strncmp(msgbuf->buf, sob->buf, sob->len))
>  		has_footer = 3;
>  	else
> -		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
> +		has_footer = has_conforming_footer(msgbuf, sob, ignore_footer);

Since you're touching this area, could you please a prepatory patch
before this one that changes the function signature:

	- static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob, size_t ignore_footer)                                                          
	+ static int has_conforming_footer(struct strbuf *sb, const struct strbuf *footer, size_t ignore_footer)                                                          

That way, you'll be able to mark `sob` const in append_footer() and
also, `sob` can be renamed to `footer` which should be less misleading.

> 
>  	if (!has_footer) {
>  		const char *append_newlines = NULL;
> @@ -4440,7 +4435,32 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
> 
>  	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
>  		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
> -				sob.buf, sob.len);
> +				sob->buf, sob->len);
> +}
> +
> +void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
> +{
> +	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
> +	struct strbuf sob = STRBUF_INIT;
> +
> +	strbuf_addstr(&sob, sign_off_header);
> +	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
> +	strbuf_addch(&sob, '\n');
> +
> +	append_footer(msgbuf, &sob, ignore_footer, no_dup_sob);
> +
> +	strbuf_release(&sob);
> +}
> +
> +void append_coauthor(struct strbuf *msgbuf, const char *coauthor)
> +{
> +	struct strbuf sob = STRBUF_INIT;

Same, this `sob` should definitely be written as `footer` or maybe
`coauthor`.
> +
> +	strbuf_addstr(&sob, coauthor_header);
> +	strbuf_addstr(&sob, coauthor);
> +	strbuf_addch(&sob, '\n');
> +
> +	append_footer(msgbuf, &sob, 0, 1);
> 
>  	strbuf_release(&sob);
>  }
> diff --git a/sequencer.h b/sequencer.h
> index 574260f621..e36489fce7 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -170,6 +170,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
>   */
>  void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
> 
> +void append_coauthor(struct strbuf *msgbuf, const char* co_author);

Asterisk should also be attached to the name.

> +
>  void append_conflicts_hint(struct index_state *istate,
>  		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
>  enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 14c92e4c25..5ed6735cf4 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -138,6 +138,17 @@ test_expect_success 'partial removal' '
> 
>  '
> 
> +test_expect_success 'co-author' '
> +
> +	>coauthor &&
> +	git add coauthor &&
> +	git commit -m "thank you" --co-author="Author <author@example.com>" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -ne "s/Co-authored-by: //p" commit.msg >actual &&
> +	echo "Author <author@example.com>" >expected &&
> +	test_cmp expected actual
> +'
> +

This test looks good to me.

Thanks again for taking this on,

Denton

>  test_expect_success 'sign off' '
> 
>  	>positive &&
> --
> 2.22.0.rc3
