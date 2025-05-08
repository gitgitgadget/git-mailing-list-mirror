Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6282201100
	for <git@vger.kernel.org>; Thu,  8 May 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713843; cv=none; b=ulG0+rcs0DiA7srfnaUrBwJLsVkgI6IdOM/ZKUEepTIN4aqsxCTCOF4cEPmejxQ/YavvdbMU7yfL6jNkM2IpXVbu/v1kryIBZSoNxQNTrqFzfa58tAoHKxzhmgZp5TzNOjozseQyxZ3yRliOlgUjbqgmwwYVv8TLvgAYnGCcgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713843; c=relaxed/simple;
	bh=llv0vS+pWzS6hGqfP4UM8RycLL8KWnsUrlH3cvf7kIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SNNMqLckq5t1I6eHrMiuQoGVV9q2E7YkbZ3khAsYfM17gYMmSSv90XIFhXBMGzJNMBvV3wGVDAfYiXE7YDOTJWHzA32JzsjYstP2fkmQf/qVgA6bJ43urX3FJ+jBJm+e/7Aa8zyeeXdayASMaXW7OySGXSYLexifqc5pBuELM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xnbc3bBL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnbc3bBL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39efc1365e4so580691f8f.1
        for <git@vger.kernel.org>; Thu, 08 May 2025 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746713839; x=1747318639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BvN0YGdCzV3MJjcGSHKc5SX8a+fFSAmGJKTEWq9u/HE=;
        b=Xnbc3bBLqRhNlKKWiVea3ZDG5prZo/Oz8lvN/gSd/FfwiFy7Na8LY7MyfJIUdacdFZ
         NtJqbwIaDYcgDHCKx6zDBqMdmrg0dlgsPsH56qqVbcn9wB+sUQNHJK0SXI6Fh2D7nUwf
         QE9l18OyxCvUQtIEx7BFAclg8ukpYS1DfifWtvnjB+uAIo3yPCrRDFzjCwQcAgivkDz+
         DPgFvZ8+D79/BgX5YC81vNgApve4NIbPO2Zb2xQ+pVkW6piEuvTO8kHbSBuPpL8kJjKl
         Hxd6OuKjVErLXTrg2g3/vX9R5EKV2QiypuDO4yhS1rDXtCH4P1Qq1oAVh8Hy3+ya2JuN
         x6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713839; x=1747318639;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvN0YGdCzV3MJjcGSHKc5SX8a+fFSAmGJKTEWq9u/HE=;
        b=phezFzvleM0CL5fKlh0PtOzAmefPEIc4nVsRmfojf90EHyFUPDUd7YT9y6wB4HFdYO
         yyhxYYHptQFKHQMrwJorETXWqlczaM+u6H8MpVkObL66xtd4af2mo5dU6CIrj/v3DvwQ
         txIbDlUOgB9W5PRVgpAVa994g9EXeokFBWRmrUO0JGpkqkdjIprTdVb1ysigkee27Ly+
         u4qW9ilNsJ9wPvMUHDeequeKoq5eIEa7oEDNswvwnMHDj0SFOlLP5gE4Ah974s5SsLU5
         t5uoRpU1JdH0/I2QrGiK2iDmJVh5aNj8tJ0exPVgZiN6XSh/Avg+9AICXrd/dcC4r5pS
         /4eg==
X-Forwarded-Encrypted: i=1; AJvYcCVj/fW2yDGADtBUbW/CeZpaULlVTd9PyNJ57q9k+cCoWokSBtJUWA2BYnGYjF5Tjo3k5qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3rK8l+06RSWkTCbWS+t1XVIpRbKrQMEOY56WVxeZma67rVz2J
	jgbJuhTpZY6zUtpehNKGvpfCUIa+iPKxqy4vge7zAnIdksud3Z/sqFhsHA==
X-Gm-Gg: ASbGncu74Z7NvHohKeIE0yxlMuUN5/3MjKqZkRrlaoaXIWNuljDByp92fZYwEI5fbJu
	11FCuL0sQlp9EgzNmAEZTmIuWW40vbmhbQuLRsScNIsQbAKcMnJg0RlNwjVX8T3CfCRbe5omQVA
	fxVmlnExBrq67PWwrMGhVEQiQFS0Rmlz/l6m4S+bUaB3Z5yS4VQji42FOWjdOoCBmI8mW0xjv6j
	19XL+ZSdo9mKqksH14EgwvV39otQPcYjGy3DnW/RQUKLHkZUbqWVVtir8fSUMztdNCZG58f0Nxg
	10pxsxfPhu/5ep0QfyTcwzF8tchaC1rLYFmZomt+zrjvBNuP0XTW89FKtG6NXnYLbSANhsygtkI
	qNFrDGLw1MzhHFJAf
X-Google-Smtp-Source: AGHT+IFIMhtlL06bLkDmu8QSnzGFIaWaJTDF6xOhWwUk5uYxb3YlpPkIAU5CTmTt5iSN31k9gKSnYg==
X-Received: by 2002:a05:6000:420c:b0:3a0:b1de:1be0 with SMTP id ffacd0b85a97d-3a0b4a234c5mr6748451f8f.31.1746713838538;
        Thu, 08 May 2025 07:17:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc39sm77859f8f.100.2025.05.08.07.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:17:17 -0700 (PDT)
Message-ID: <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
Date: Thu, 8 May 2025 15:17:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/2] rebase: support --trailer
To: Li Chen <me@linux.beauty>, git <git@vger.kernel.org>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li

On 06/05/2025 13:58, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> Implement a new `--trailer <text>` option for `git rebase`
> (support merge backend only now), which appends arbitrary
> trailer lines to each rebased commit message. Reject early
> if used with the apply backend (git am) since it lacks
> message‑filter/trailer hook. Automatically set REBASE_FORCE when
> any trailer is supplied.

I think this is a reasonable idea but unfortunately I think the trailer 
API needs improving so that the implementation

(a) Checks the trailers given on the command-line before the user edits 
the todo list. That way we reject invalid trailers and exit before the 
user has spent any effort editing the todo list.

(b) Does not fork another process to add the trailers. Without this the 
performance is going to suffer. Hopefully it wont be too difficult to 
modify the existing code to take a struct strbuf and a list of trailers 
to append to it.

(c) Only adds the trailers on the commandline. I'm a bit confused by the 
various trailer config options - the man page reads to me like "git 
interpret-trailers" can add missing trailers that are configured but not 
passed on the commandline.

The changes to the trailer api should be made in one or more preparatory 
commits before adding support for --trailer to "git rebase"

I've left some comments on the changes to builtin/rebase.c and the 
tests, I've skipped the changes to sequencer.c for now as they'll have 
to be updated to avoid forking "git interpret-trailers"

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b288aedfb1..df65a1e040 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -36,6 +36,9 @@
>   #include "reset.h"
>   #include "trace2.h"
>   #include "hook.h"
> +#include "trailer.h"
> +
> +static const char trailer_state_name[] = "trailer";
>   
>   static char const * const builtin_rebase_usage[] = {
>   	N_("git rebase [-i] [options] [--exec <cmd>] "
> @@ -46,6 +49,8 @@ static char const * const builtin_rebase_usage[] = {
>   	NULL
>   };
>   
> +static struct strvec trailer_args = STRVEC_INIT;

We should not need to add any file scope variables

>   static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
>   static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
>   static GIT_PATH_FUNC(apply_dir, "rebase-apply")
> @@ -114,6 +119,7 @@ struct rebase_options {
>   	char *reflog_action;
>   	int signoff;
>   	int reviewby;
> +	struct strvec trailer_args;

This is good and means we don't need the file-scope declaration above.

>   	int allow_rerere_autoupdate;
>   	int keep_empty;
>   	int autosquash;
> @@ -144,6 +150,7 @@ struct rebase_options {
>   		.flags = REBASE_NO_QUIET, 		\
>   		.git_am_opts = STRVEC_INIT,		\
>   		.exec = STRING_LIST_INIT_NODUP,		\
> +		.trailer_args = STRVEC_INIT,  \
>   		.git_format_patch_opt = STRBUF_INIT,	\
>   		.fork_point = -1,			\
>   		.reapply_cherry_picks = -1,             \
> @@ -167,6 +174,7 @@ static void rebase_options_release(struct rebase_options *opts)
>   	free(opts->strategy);
>   	string_list_clear(&opts->strategy_opts, 0);
>   	strbuf_release(&opts->git_format_patch_opt);
> +	strvec_clear(&opts->trailer_args);
>   }
>   
>   static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> @@ -179,6 +187,10 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   
>   	replay.signoff = opts->signoff;
>   	replay.reviewby = opts->reviewby;
> +
> +	for (size_t i = 0; i < opts->trailer_args.nr; i++)
> +        strvec_push(&replay.trailer_args, opts->trailer_args.v[i]);

The indentation is off here

> +
>   	replay.allow_ff = !(opts->flags & REBASE_FORCE);
>   	if (opts->allow_rerere_autoupdate)
>   		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
> @@ -437,6 +449,8 @@ static int read_basic_state(struct rebase_options *opts)
>   	struct strbuf head_name = STRBUF_INIT;
>   	struct strbuf buf = STRBUF_INIT;
>   	struct object_id oid;
> +	struct strbuf t = STRBUF_INIT, one = STRBUF_INIT;

You can just use the existing "buf" instead of adding "t" and "one" is 
unneeded (see below)

> +	const char *path = state_dir_path(trailer_state_name, opts);
>   
>   	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
>   			   READ_ONELINER_WARN_MISSING) ||
> @@ -509,6 +523,22 @@ static int read_basic_state(struct rebase_options *opts)
>   
>   	strbuf_release(&buf);
>   
> +	if (strbuf_read_file(&t, path, 0) >= 0) {
> +		const char *p = t.buf, *end = t.buf + t.len;
> +
> +		while (p < end) {
> +			const char *nl = memchr(p, '\n', end - p);

We expect each line to be terminated with '\n' so we should die if nl is 
NULL
> +			strbuf_reset(&one);
> +			strbuf_add(&one, p, nl ? nl - p : end - p);

Instead of copying the string into an strbuf we can just do "*nl == '\0';"

> +			if (one.len) /* skip empty line */

There should not be any empty lines so we should die here if it is empty

> +				strvec_push(&opts->trailer_args,
> +					    strbuf_detach(&one, NULL));
> +			p = nl ? nl + 1 : end;
> +		}
> +		strbuf_release(&one);
> +	}
> +	strbuf_release(&t);
> +
>   	return 0;
>   }
>   
> @@ -537,6 +567,28 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>   	if (opts->reviewby)
>   		write_file(state_dir_path("reviewby", opts), "--reviewby");
>   
> +    /*
> +     * save opts->trailer_args into state_dir/trailer
> +     */
> +    if (opts->trailer_args.nr) {
> +            struct strbuf buf = STRBUF_INIT;
> +            size_t i;
> +
> +            for (i = 0; i < opts->trailer_args.nr; i++) {
> +                    strbuf_addstr(&buf, opts->trailer_args.v[i]);
> +                    strbuf_addch(&buf, '\n');
> +            }
> +            write_file(state_dir_path(trailer_state_name, opts),
> +                       "%s", buf.buf);
> +            strbuf_release(&buf);

This looks good

> +    } else {
> +            /*
> +             * but if rebase doesn't pass any --trailer，
> +             * and state dir still have residual files，let's delete it。
> +             */

This should never happen should it?

> +            unlink_or_warn(state_dir_path(trailer_state_name, opts));
> +    }
> +
>   	return 0;
>   }
>   
> @@ -1140,6 +1192,7 @@ int cmd_rebase(int argc,
>   			.flags = PARSE_OPT_NOARG,
>   			.defval = REBASE_DIFFSTAT,
>   		},
> +		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),

This should be OPT_STRVEC() and should populate &options.trailers

>   		OPT_BOOL(0, "signoff", &options.signoff,
>   			 N_("add a Signed-off-by trailer to each commit")),
>   		OPT_BOOL(0, "reviewby", &options.reviewby,
> @@ -1292,6 +1345,13 @@ int cmd_rebase(int argc,
>   			     builtin_rebase_options,
>   			     builtin_rebase_usage, 0);
>   
> +    for (i = 0; i < trailer_args.nr; i++)
> + 	   strvec_push(&options.trailer_args, trailer_args.v[i]);
> +
> +    /* if add --trailer，force rebase */
> +    if (options.trailer_args.nr)
> +		   options.flags |= REBASE_FORCE;

This is good

>   	if (preserve_merges_selected)
>   		die(_("--preserve-merges was replaced by --rebase-merges\n"
>   			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
> @@ -1549,6 +1609,16 @@ int cmd_rebase(int argc,
>   	if (options.root && !options.onto_name)
>   		imply_merge(&options, "--root without --onto");
>   
> +	/*
> +	 * The apply‑based backend (git am) cannot append trailers because
> +	 * it lacks a message‑filter facility.  Reject early, before any
> +	 * state (index, HEAD, etc.) is modified.
> +	 */
> +	if (options.type == REBASE_APPLY && options.trailer_args.nr)
> +		die(_("the --apply backend (git am) cannot currently handle "
> +		      "--trailer; please omit --apply or use "
> +		      "the merge/interactive backend"));

It's good you're checking this but we should call imply_merge() to do 
that instead.

> +test_description='git rebase --trailer integration tests
> +We verify that --trailer on the merge/interactive/exec/root backends,
> +and that it is rejected early when the apply backend is requested.'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh       # test_commit_message, helpers
> +
> +############################################################################
> +# 1.  repository setup
> +############################################################################
> +
> +test_expect_success 'setup repo with a small history' '
> +	git commit --allow-empty -m "Initial empty commit" &&
> +	test_commit first   file a &&
> +	test_commit second  file &&
> +	git checkout -b conflict-branch first &&
> +	test_commit file-2  file-2 &&
> +	test_commit conflict file &&
> +	test_commit third   file &&

The alignment is off here - it would be much simpler just to separate 
each argument with a single space

> +	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> +'
> +
> +create_expect () {
> +	cat >"$1" <<-EOF
> +	$2
> +
> +	Reviewed-by: Dev <dev@example.com>
> +	EOF
> +}
> +# golden files:
> +create_expect initial-signed  "Initial empty commit"
> +create_expect first-signed    "first"
> +create_expect second-signed   "second"
> +create_expect file2-signed    "file-2"
> +create_expect third-signed    "third"
> +create_expect conflict-signed "conflict"

Thanks for adding these tests. This should be inside the setup test - 
noting should be run outside of test_expect_success()

> +
> +############################################################################
> +# 2.  explicitly reject --apply + --trailer
> +############################################################################
> +
> +test_expect_success 'apply backend is rejected when --trailer is given' '
> +	git reset --hard third &&
> +	git tag before-apply &&
> +	test_expect_code 128 \
> +		git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
> +			HEAD^ &&

We should check the error message here by redirecting stderr to a file 
and checking that with test_grep or test_cmp so we can be confidant that 
rebase is failing for the reason it should be and not some other bug.

> +	git diff --quiet before-apply..HEAD      # prove nothing moved

If you want to check that HEAD is unchanged I'd run "head=$(git show-ref 
--verify -s HEAD)" before the rebase and "test_cmp_rev HEAD $head" 
afterwards.

> +'
> +
> +############################################################################
> +# 3.  --no‑op: same range, no changes
> +############################################################################
> +
> +test_expect_success '--trailer without range change is a no‑op' '
> +	git checkout main &&
> +	git tag before-noop &&
> +	git rebase --trailer "Reviewed-by: Dev <dev@example.com>" HEAD &&
> +	git diff --quiet before-noop..HEAD

Do we really need this - it isn't really checking anything to do with 
the implementation of --trailer.

> +
> +############################################################################
> +# 4.  merge backend (-m), conflict resolution path
> +############################################################################

Excellent

> +
> +test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
> +	git reset --hard third &&
> +	test_must_fail git rebase -m \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" \
> +		second third &&
> +	git checkout --theirs file &&
> +	git add file &&
> +    GIT_EDITOR=: git rebase --continue &&
GIT_EDITOR=: unless you call test_set_editor() which should always be 
done in a subshell so this isn't needed.

> +	git show --no-patch --pretty=format:%B HEAD~2 >actual &&
> +	test_cmp file2-signed actual

I think test_commit_message would help simplify this

> +'
> +
> +############################################################################
> +# 5.  --exec path
> +############################################################################
> +
> +test_expect_success 'rebase --exec --trailer adds trailer' '
> +	test_when_finished "rm -f touched" &&
> +	git rebase --exec "touch touched" \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" \
> +		first^ first &&
> +	test_path_is_file touched &&
> +	test_commit_message HEAD first-signed

I'm not sure this has anything to do with --trailer

> +'
> +
> +############################################################################
> +# 6.  --root path
> +############################################################################
> +
> +test_expect_success 'rebase --root --trailer updates every commit' '
> +	git checkout first &&
> +	git rebase --root --keep-empty \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" &&
> +	test_commit_message HEAD   first-signed &&
> +	test_commit_message HEAD^  initial-signed

This test looks good.

Best Wishes

Phillip

> +'
> +test_done
G
