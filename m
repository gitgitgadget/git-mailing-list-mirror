Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2351F453
	for <e@80x24.org>; Fri,  2 Nov 2018 13:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKBWKL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 18:10:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41641 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeKBWKL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 18:10:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id c126-v6so723118ywd.8
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FThENHgU8fOzccZjclth6tYm+0DBXTqQShiKI9bphFM=;
        b=aU4qnxGQZg7INt0SQtq+s1NQVfFd1XoG9mqE9MYHUhge07A2ncluERuo5AZyeE/bCQ
         5teglKure1clx7OEgB8WhsT84UBdHwYkSRx6BYr4lqFqWiU74dEPYiRZ85CInj9S0ZTH
         YM5lm49Y9U/DcpRoSQEV/eh5u1D+olJTfr7Ep3U9N7VZc+0Gb1KRuIm/C5vRTatdKXV+
         jTtRBrPUG9wqO3nfnQD3k18snbpLR6YvQvBYmZwHsTqFlu+7Y/pUPW+8C+Hxs2808NGH
         rvzWj7QUDM7mDvMwk5GEyWhMOg9OZKKQKLAEkX9Tg1jL/rVxE1d19rms466u50taUOkY
         I45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FThENHgU8fOzccZjclth6tYm+0DBXTqQShiKI9bphFM=;
        b=mQhB456iORAB5lX5FxQTaYYXPChgaMfoGLreZTaq4daHHnQ1yZx3nJnaaQz28O2dJV
         8+ji2XhUQIOK+DYcBpXZSFq3VMJveDbElLfeLxZ+3pKBZc8cL+TyqZwQsVJ9PDnuLjbY
         Z3e6Q+jaEwAREzSzM1xI1kMYI3VaGXRWkBUL2RPph4WJIJqUJLAW9Wd/7OSAVYUyalRd
         hBfn40N8WiiW2IgJi8U3Lr23TEpdRh/C00wiZWhPiqjxF8hk4wDL8ss+t7h+z6oFGOqi
         CBf+m0pyAfB1czMuf3KBKgGCAVDEcQLswX+29CuBuv6tPIRTvOWdTzv6ppZpBwRU7J4Y
         PETg==
X-Gm-Message-State: AGRZ1gI/iTLOiujAB2P1zpnMMC4AUqjH7MP92uluTf9NDI0L8D8VeBVQ
        sl2t+z7MV++KTItH4wb6lSE=
X-Google-Smtp-Source: AJdET5fJnLBlZ+5zSp9z1ZNvY3n8Ai8fxMJHNIZMptcilNRcm2cxXd+QmT+PbiI4sk9xEoCyCXi2yQ==
X-Received: by 2002:a81:3a12:: with SMTP id h18-v6mr11161295ywa.6.1541163784263;
        Fri, 02 Nov 2018 06:03:04 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b73-v6sm8935463ywb.63.2018.11.02.06.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:03:03 -0700 (PDT)
Subject: Re: [PATCH 19/24] submodule: use submodule repos for object lookup
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com
References: <20181030220817.61691-1-sbeller@google.com>
 <20181030220817.61691-20-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <127add9b-d58c-ee46-73de-41bfe915589b@gmail.com>
Date:   Fri, 2 Nov 2018 09:03:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181030220817.61691-20-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30/2018 6:08 PM, Stefan Beller wrote:
> This converts the 'show_submodule_header' function to use
> the repository API properly, such that the submodule objects
> are not added to the main object store.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>

A couple tests are broken in 'pu' when run with GIT_TEST_COMMIT_GRAPH=1, 
including t4041-diff-submodule-option.sh. The failure bisects to this patch.

Here is a verbose output of the first failure in that script:;


expecting success:
         git diff-index -p --submodule=log HEAD >actual &&
         cat >expected <<-EOF &&
         Submodule sm1 $head2..$head3 (rewind):
           < Add foo3 ($added foo3)
           < Add foo2 ($added foo2)
         EOF
         test_cmp expected actual

+ git diff-index -p --submodule=log HEAD
+ cat
+ test_cmp expected actual
+ diff -u expected actual
--- expected    2018-11-02 12:58:43.429262380 +0000
+++ actual      2018-11-02 12:58:43.429262380 +0000
@@ -1,3 +1,5 @@
-Submodule sm1 30b9670..dafb207 (rewind):
+Submodule sm1 30b9670...dafb207:
    < Add foo3 (hinzugefügt foo3)
    < Add foo2 (hinzugefügt foo2)
+  > Add foo1 (hinzugefügt foo1)
+  < Add foo1 (hinzugefügt foo1)
error: last command exited with $?=1
not ok 9 - modified submodule(backward)

I've been looking into the patch below to see if there is an obvious 
problem, but the best I can think is that open_submodule() creates an 
alternate 'struct repository' and somehow the commit-graph feature is 
interacting poorly with that struct.

Stefan, do you know what's going on?

Thanks,

-Stolee

> ---
>   submodule.c | 76 ++++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 61 insertions(+), 15 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index d9d3046689..0fdda45252 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -443,7 +443,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
>   	return prepare_revision_walk(rev);
>   }
>   
> -static void print_submodule_summary(struct rev_info *rev, struct diff_options *o)
> +static void print_submodule_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
>   {
>   	static const char format[] = "  %m %s";
>   	struct strbuf sb = STRBUF_INIT;
> @@ -454,7 +454,8 @@ static void print_submodule_summary(struct rev_info *rev, struct diff_options *o
>   		ctx.date_mode = rev->date_mode;
>   		ctx.output_encoding = get_log_output_encoding();
>   		strbuf_setlen(&sb, 0);
> -		format_commit_message(commit, format, &sb, &ctx);
> +		repo_format_commit_message(r, commit, format, &sb,
> +				      &ctx);
>   		strbuf_addch(&sb, '\n');
>   		if (commit->object.flags & SYMMETRIC_LEFT)
>   			diff_emit_submodule_del(o, sb.buf);
> @@ -481,14 +482,47 @@ void prepare_submodule_repo_env(struct argv_array *out)
>   			 DEFAULT_GIT_DIR_ENVIRONMENT);
>   }
>   
> -/* Helper function to display the submodule header line prior to the full
> - * summary output. If it can locate the submodule objects directory it will
> - * attempt to lookup both the left and right commits and put them into the
> - * left and right pointers.
> +/*
> + * Initialize 'out' based on the provided submodule path.
> + *
> + * Unlike repo_submodule_init, this tolerates submodules not present
> + * in .gitmodules. This function exists only to preserve historical behavior,
> + *
> + * Returns 0 on success, -1 when the submodule is not present.
>    */
> -static void show_submodule_header(struct diff_options *o, const char *path,
> +static struct repository *open_submodule(const char *path)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct repository *out = xmalloc(sizeof(*out));
> +
> +	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> +		strbuf_release(&sb);
> +		free(out);
> +		return NULL;
> +	}
> +
> +	out->submodule_prefix = xstrfmt("%s%s/",
> +					the_repository->submodule_prefix ?
> +					the_repository->submodule_prefix :
> +					"", path);
> +
> +	strbuf_release(&sb);
> +	return out;
> +}
> +
> +/*
> + * Helper function to display the submodule header line prior to the full
> + * summary output.
> + *
> + * If it can locate the submodule git directory it will create a repository
> + * handle for the submodule and lookup both the left and right commits and
> + * put them into the left and right pointers.
> + */
> +static void show_submodule_header(struct diff_options *o,
> +		const char *path,
>   		struct object_id *one, struct object_id *two,
>   		unsigned dirty_submodule,
> +		struct repository *sub,
>   		struct commit **left, struct commit **right,
>   		struct commit_list **merge_bases)
>   {
> @@ -507,7 +541,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
>   	else if (is_null_oid(two))
>   		message = "(submodule deleted)";
>   
> -	if (add_submodule_odb(path)) {
> +	if (!sub) {
>   		if (!message)
>   			message = "(commits not present)";
>   		goto output_header;
> @@ -517,8 +551,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
>   	 * Attempt to lookup the commit references, and determine if this is
>   	 * a fast forward or fast backwards update.
>   	 */
> -	*left = lookup_commit_reference(the_repository, one);
> -	*right = lookup_commit_reference(the_repository, two);
> +	*left = lookup_commit_reference(sub, one);
> +	*right = lookup_commit_reference(sub, two);
>   
>   	/*
>   	 * Warn about missing commits in the submodule project, but only if
> @@ -528,7 +562,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
>   	     (!is_null_oid(two) && !*right))
>   		message = "(commits not present)";
>   
> -	*merge_bases = get_merge_bases(*left, *right);
> +	*merge_bases = repo_get_merge_bases(sub, *left, *right);
>   	if (*merge_bases) {
>   		if ((*merge_bases)->item == *left)
>   			fast_forward = 1;
> @@ -562,16 +596,18 @@ void show_submodule_summary(struct diff_options *o, const char *path,
>   	struct rev_info rev;
>   	struct commit *left = NULL, *right = NULL;
>   	struct commit_list *merge_bases = NULL;
> +	struct repository *sub;
>   
> +	sub = open_submodule(path);
>   	show_submodule_header(o, path, one, two, dirty_submodule,
> -			      &left, &right, &merge_bases);
> +			      sub, &left, &right, &merge_bases);
>   
>   	/*
>   	 * If we don't have both a left and a right pointer, there is no
>   	 * reason to try and display a summary. The header line should contain
>   	 * all the information the user needs.
>   	 */
> -	if (!left || !right)
> +	if (!left || !right || !sub)
>   		goto out;
>   
>   	/* Treat revision walker failure the same as missing commits */
> @@ -580,13 +616,17 @@ void show_submodule_summary(struct diff_options *o, const char *path,
>   		goto out;
>   	}
>   
> -	print_submodule_summary(&rev, o);
> +	print_submodule_summary(sub, &rev, o);
>   
>   out:
>   	if (merge_bases)
>   		free_commit_list(merge_bases);
>   	clear_commit_marks(left, ~0);
>   	clear_commit_marks(right, ~0);
> +	if (sub) {
> +		repo_clear(sub);
> +		free(sub);
> +	}
>   }
>   
>   void show_submodule_inline_diff(struct diff_options *o, const char *path,
> @@ -598,9 +638,11 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
>   	struct commit_list *merge_bases = NULL;
>   	struct child_process cp = CHILD_PROCESS_INIT;
>   	struct strbuf sb = STRBUF_INIT;
> +	struct repository *sub;
>   
> +	sub = open_submodule(path);
>   	show_submodule_header(o, path, one, two, dirty_submodule,
> -			      &left, &right, &merge_bases);
> +			      sub, &left, &right, &merge_bases);
>   
>   	/* We need a valid left and right commit to display a difference */
>   	if (!(left || is_null_oid(one)) ||
> @@ -661,6 +703,10 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
>   		clear_commit_marks(left, ~0);
>   	if (right)
>   		clear_commit_marks(right, ~0);
> +	if (sub) {
> +		repo_clear(sub);
> +		free(sub);
> +	}
>   }
>   
>   int should_update_submodules(void)
