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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4CC1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 10:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfJHKLu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 06:11:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40706 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHKLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 06:11:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so2487969wmj.5
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CFEixs87DOOQaRkroVT5+RL5zntPxOWr21/rkSfl7/Q=;
        b=V/vZngcCeuZRw992uaQzR9Es+04ZJ+6+W6kUHJWpwa1/OK4Thi/vY41rwSGptAKcIS
         HpWHMMBdj308NK+gV19C22tJxXBIgHtwWi+tbbsSYRWjmdCFKMdd2hnoE/7dC2gtBCdD
         zsrUYfEFLJCj8etyBTcv9Z/JtbRVWlRXrAQs+ECvBESfxgqBeIwOOZspp8Cur5wl0A4j
         pa1IR4NecbktMNxa/jAeYkpro3gg6Hl5Uew8O5nzuBlqlbsbo9ZcQfUjSNiugwbDssBi
         K0MHiT0DYJmTt0SPqU9+L3X4aMGyc6UM1ZJCwY4j7/qnDL2N+4XJKlX59l3Zam+7fFf2
         UQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CFEixs87DOOQaRkroVT5+RL5zntPxOWr21/rkSfl7/Q=;
        b=uJ20Y9wI0LE/UdofAgRxNy/1uZZd10PzGrCUjQokygSyeLH7q4ngmbekFfNCBcEx0v
         NfGoOukwpAeV+Uj1P17i2sDj1h3l2KoB8JR6P3Y0zKVi4QzxfmczpEwlPmPhsNmF/J04
         wBfOF3EbOZ1C9BVe4E5UuOj/QLhR5SyDMnwguDeKp+RlExbypyjOizNxVmG5o46Kpnxh
         D8f5TBBtptnNDEusgI2ljQJIvYP+TIcNpDJydflWlADLj9ku7ypRIKtUin4y5/6TGDPq
         AYY8dUYg1axiUK4mDcWpRqeGgtEOZRNNVX3iiEryQWdnWtwm1fHWg6ZBPgnwd8C7MRZt
         5Cig==
X-Gm-Message-State: APjAAAWuXsLlL8cAlNSyGlgc6bm/S9yGK/0mHjtDRsnJ8LlgXtBcTifo
        LBiG0EKOo12DuTTCrU6jyGU=
X-Google-Smtp-Source: APXvYqwAx+OJJflV3RzKwXp87rOWvza7mefdtEgcOhDw4VF0tyK9d5E6f6akuDF1dyvegRvaf0G2Wg==
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr2932588wmq.60.1570529507037;
        Tue, 08 Oct 2019 03:11:47 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id l13sm1771205wmj.25.2019.10.08.03.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:11:46 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
To:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>,
        Denton Liu <liu.denton@gmail.com>
References: <20191008074935.10972-1-toon@iotcl.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <76753409-34f2-d016-81a9-ea6e3d0e34bd@gmail.com>
Date:   Tue, 8 Oct 2019 11:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008074935.10972-1-toon@iotcl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Toon & Zeger-Jan

On 08/10/2019 08:49, Toon Claes wrote:
> Add support to provide the Co-author when committing. For each
> co-author provided with --coauthor=<coauthor>, a line is added at the
> bottom of the commit message, like this:
> 
>      Co-authored-by: <coauthor>
> 
> It's a common practice use when pairing up with other people and both
> authors want to in the commit message.

Thanks for the patch, it's looking good. I can see this being useful to 
some people - I like the way the patch itself is co-authored.

> 
> Co-authored-by: Zeger-Jan van de Weg <git@zjvandeweg.nl>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>   Documentation/git-commit.txt |  5 ++++
>   builtin/commit.c             |  7 ++++++
>   sequencer.c                  | 44 ++++++++++++++++++++++++++----------
>   sequencer.h                  |  2 ++
>   t/t7502-commit-porcelain.sh  | 11 +++++++++
>   5 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index afa7b75a23..c059944e38 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -140,6 +140,11 @@ OPTIONS
>   	commit by that author (i.e. rev-list --all -i --author=<author>);
>   	the commit author is then copied from the first such commit found.
> 
> +--coauthor=<coauthor>::
> +        Add a Co-authored-by line with the specified author. Specify the
> +	author using the standard `Co Artur <co-artur@example.com>`
> +	format.
> +
>   --date=<date>::
>   	Override the author date used in the commit.
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index ae7aaf6dc6..feb423ed6f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -110,6 +110,7 @@ static int config_commit_verbose = -1; /* unspecified */
>   static int no_post_rewrite, allow_empty_message;
>   static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>   static char *sign_commit;
> +static struct string_list coauthors = STRING_LIST_INIT_NODUP;
> 
>   /*
>    * The default commit message cleanup mode will remove the lines
> @@ -672,6 +673,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
>   	int old_display_comment_prefix;
>   	int merge_contains_scissors = 0;
> +	int i;
> 
>   	/* This checks and barfs if author is badly specified */
>   	determine_author_info(author_ident);
> @@ -803,6 +805,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	if (clean_message_contents)
>   		strbuf_stripspace(&sb, 0);
> 
> +	for (i = 0; i < coauthors.nr; i++) {
> +		append_coauthor(&sb, coauthors.items[i].string);

If you look at the existing code that's calling append_signoff() it does
   append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0)
The purpose of ignore_non_trailer is to ignore comment and conflicts 
messages at the end of the commit message (there's more detail in a 
comment above it's definition in builtin/commit.c). I think we need to 
pass this offset when adding co-authors as well.

One question - what is the desired de-duplication behavior of 
Co-authored-by:? What happens if there is already a matching 
Co-authored-by: footer? (It is also possible for the trailers code to 
only ignore an existing footer if it's the last one.) What happens if 
the same Co-authored-by: is duplicated on the command line? It would be 
nice to have this defined and tests to check it's enforced.

Another useful addition would be to check that the footer value looks 
sane but that could come later - I don't think we do that for any other 
footers at the moment (though I haven't checked to see if that's really 
true)

> +	}
> +
>   	if (signoff)
>   		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
> 
> @@ -1504,6 +1510,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>   		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>   		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
>   		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
> +		OPT_STRING_LIST(0, "coauthor", &coauthors, N_("co-author"), N_("add Co-authored-by:")),
>   		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>   		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
>   		OPT_CLEANUP(&cleanup_arg),
> diff --git a/sequencer.c b/sequencer.c
> index d648aaf416..8958a22470 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -36,6 +36,7 @@
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
> 
>   static const char sign_off_header[] = "Signed-off-by: ";
> +static const char coauthor_header[] = "Co-authored-by: ";
>   static const char cherry_picked_prefix[] = "(cherry picked from commit ";
> 
>   GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
> @@ -4385,15 +4386,9 @@ int sequencer_pick_revisions(struct repository *r,
>   	return res;
>   }
> 
> -void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
> +static void append_footer(struct strbuf *msgbuf, struct strbuf* sob, size_t ignore_footer, size_t no_dup_sob)
>   {
> -	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
> -	struct strbuf sob = STRBUF_INIT;
> -	int has_footer;
> -
> -	strbuf_addstr(&sob, sign_off_header);
> -	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
> -	strbuf_addch(&sob, '\n');
> +	size_t has_footer;
> 
>   	if (!ignore_footer)
>   		strbuf_complete_line(msgbuf);
> @@ -4402,11 +4397,11 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
>   	 * If the whole message buffer is equal to the sob, pretend that we
>   	 * found a conforming footer with a matching sob
>   	 */
> -	if (msgbuf->len - ignore_footer == sob.len &&
> -	    !strncmp(msgbuf->buf, sob.buf, sob.len))
> +	if (msgbuf->len - ignore_footer == sob->len &&
> +	    !strncmp(msgbuf->buf, sob->buf, sob->len))
>   		has_footer = 3;
>   	else
> -		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
> +		has_footer = has_conforming_footer(msgbuf, sob, ignore_footer);
> 
>   	if (!has_footer) {
>   		const char *append_newlines = NULL;
> @@ -4440,7 +4435,32 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
> 
>   	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
>   		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
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
> +
> +	strbuf_addstr(&sob, coauthor_header);
> +	strbuf_addstr(&sob, coauthor);
> +	strbuf_addch(&sob, '\n');
> +
> +	append_footer(msgbuf, &sob, 0, 1);

As we have a constant for APPEND_SIGNOFF_DEDUP can we use it here please 
rather than '1' which does not covey the same meaning to the author. 
Also as I said above I think you want to pass in a real value for 
ignore_footer not zero

> 
>   	strbuf_release(&sob);
>   }
> diff --git a/sequencer.h b/sequencer.h
> index 574260f621..e36489fce7 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -170,6 +170,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
>    */
>   void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
> 
> +void append_coauthor(struct strbuf *msgbuf, const char* co_author);
> +
>   void append_conflicts_hint(struct index_state *istate,
>   		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 14c92e4c25..5ed6735cf4 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -138,6 +138,17 @@ test_expect_success 'partial removal' '
> 
>   '
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

This is fine as far as it goes but it would be nice to test the 
de-duplication behavior once that's defined

Best Wishes

Phillip

>   test_expect_success 'sign off' '
> 
>   	>positive &&
> --
> 2.22.0.rc3
> 
