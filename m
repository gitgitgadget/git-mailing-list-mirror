Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5D4A28
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408310; cv=none; b=lE4RgoPErr3AdboGmuqS7ShRSeMwXBBe3/xUAqbfRPY4xpOA3DY+Opf55r0g5wLUn4hEbdqUi+6iIqP0yZ3mvXWTi7GysTuf7Kaf1eSSK8msfcOB7DVr54eGrLdSuuLWkCwA0SUucP+XwAcwjXb2lmjoBM3Tdy+Mub8h+Tr46Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408310; c=relaxed/simple;
	bh=oguQZrz9eQmgVSVfnrfWw5yiTIfe1wBvzDZnC1eANtw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=RWjGk7YdwGfCYvwMK2PTezf3oP/XJn0CfShSm91+3Pn4BP2ofzjS8++96nbkOeMm45//+cwTHN6Iy12FBFUkCrVvtXQI5CyGevmq90iQn+0dumT1T5krvnfIqzAJjfJD6W2OhF4ZdXStmVmup5FxfGUzS3VNMmeaJ7AYvv5giX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXs3tTaj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXs3tTaj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45994a72356so59735e9.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754408307; x=1755013107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4klWJblREZsaZKAO25pjRW4hPIQUNwcowXU82WcWMyc=;
        b=nXs3tTaj/gvM2+g+Q7/jZIJAi9/honUTPC92NfxmuOmlWQjBLUq2Y1rLUTuOX+D4/l
         PNGxV1T7TZIgeaoLYv6x09OdNzihhGgoH7deDieou7bUhbPbVF2+zTk82SFpRI4013G6
         d81jcK4sKsLaUp/OG06dmoGPrRWEUUOAZL7NQQCivo1es4CKq9lnz1MxyRYPRJ/qVMyw
         Hp777V6yGHIuccg/v4Np7xUPz8aHpsGuXEkxJrhM4awOJvO3UUOkjGvCSnnYgfjbDNMy
         e/po6aFlfqqvnjY/XB3l9P4o9gbHn/ESsow3ohvOD0YQlwCtT4nRnjTLC0Ud89VLqLOz
         CUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408307; x=1755013107;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4klWJblREZsaZKAO25pjRW4hPIQUNwcowXU82WcWMyc=;
        b=c8Z+0bKWH88rrjkwgaZbXyHyPwoEu6UQ0PeE7riLoSDZnqmhMPA96oxryTbpnw1OcP
         umkdnwZRjCHgUee0q45VDeLXwkwC0wisWHgX7Cf6z5+1bTSUlY5dAJKLcXdQNY1ci9Oh
         CbNGEb3BtwtmUKqLYOfHP4PbFCyGStnO6Zd0WkTB+Ps6GywXKUyk1jIrDsD/k4AE51Tu
         PqGQxi5CdXGL/BD2y6zAzsYfSoX92riXUPHn4pY1wdh84578PvKKBJH047S+GC9LRxK/
         bAA1CrzF12okx9nJWP47qQ8JIyKP2ApWn/hoL+AsiBP5ywc+dwzxyi/kbY+aO2WEYdPj
         KJIA==
X-Forwarded-Encrypted: i=1; AJvYcCUUXzKNw0+0KfoVBWxvkAUWfZgBlxNwiiNn2fTjUh7SD2QpJ+NLKBFeXRE+IGBKdhW9tEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Tdh+AF2YuVm5KH4CrqLgiB+hC85yVacevgOVc/P7a8HWtgXr
	CF+vrFh6bwdiIhPVu2rhTgtdSNVjSqkvvK7MDaA+gKBme0cJKriosOW/
X-Gm-Gg: ASbGncs5R0nFhok32EUZw6JLEZiRcVt+YSvuZ2zEf0hhVOsFpwDAgFWZbNY4ljxiVDy
	NFEt0OnUFAVXrSfMTGeAA4j61sJ/7bh/cqNe9/Sfl5n2oZPBODYYc9jd8miniMIIF/YZJsuauyb
	RFX3n01HC5NR6ZgJP20ebVNVPYm8cv+Jcwh6gUPlOUuYozUW5hWPllXWgCNPQqjfh204OFQSRil
	a3D592ep0VVwgpAL8M46aYUnKxO3oH6ytd8QlNbMYNm07EKPJGoG+UcoUKso1Sf/rCD6YbSVZwJ
	xI5y/92Tyd/gxPEQpCpj3m61rJUCjch+CAPLzIHUFC0FIlnfTcC2MbFY2yBxpHRH5TNYdPETnCW
	fd2wNoCx8fNQXxqYpojTm7pA/rJJ95MNEzoiXcKEJMFmOyjcBIKrUSVggAat+8USZ4MKKPY6pmZ
	te
X-Google-Smtp-Source: AGHT+IFFuctw1HNRblDNeBUKe1JY9miFDpufI8S9S9jnEob+jjqSvbvRvi1YNEs744NXuB7qPcF6JQ==
X-Received: by 2002:a05:600c:c102:b0:459:dd1d:2ee0 with SMTP id 5b1f17b1804b1-459e60f134emr2088865e9.0.1754408306556;
        Tue, 05 Aug 2025 08:38:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5862be7sm9399075e9.15.2025.08.05.08.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:38:26 -0700 (PDT)
Message-ID: <539639d8-8751-453a-b445-9651842bca1e@gmail.com>
Date: Tue, 5 Aug 2025 16:38:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/2] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20250803150059.402017-1-me@linux.beauty>
 <20250803150059.402017-3-me@linux.beauty>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <20250803150059.402017-3-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/08/2025 16:00, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> Implement a new `--trailer <text>` option for `git rebase`
> (support merge backend only now), which appends arbitrary
> trailer lines to each rebased commit message. Reject early
> if used with the apply backend (git am) since it lacks
> message‑filter/trailer hook.

We only want to reject it if the user passes an option that requires the 
apply backend, otherwise we can just use the merge backend.

> Automatically set REBASE_FORCE when
> any trailer is supplied.

Makes sense
> And reject invalid input before user edit the interactive file.

> +--trailer <trailer>::
> +       Append the given trailer line(s) to every rebased commit
> +       message, processed via linkgit:git-interpret-trailers[1].
> +       When this option is present *rebase automatically enables*
> +       `--force-rebase` so that fast‑forwarded commits are also
> +       rewritten.

The options like --reset-author-date just say "implies `--force-rebase`"

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e90562a3b8..3b4c45a616 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -36,6 +36,8 @@
>   #include "reset.h"
>   #include "trace2.h"
>   #include "hook.h"
> +#include "trailer.h"
> +#include "parse-options.h"

"parse-options.h" is already included.
> @@ -435,6 +444,8 @@ static int read_basic_state(struct rebase_options *opts)
>   	struct strbuf head_name = STRBUF_INIT;
>   	struct strbuf buf = STRBUF_INIT;
>   	struct object_id oid;
> +	const char trailer_state_name[] = "trailer";
> +	const char *path = state_dir_path(trailer_state_name, opts);

We only use this once, so lets pass state_dir_path("trailer", opts) 
directly to strbuf_read_file() like we do when reading all the other 
state files in this function.

>   	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
>   			   READ_ONELINER_WARN_MISSING) ||
> @@ -503,11 +514,31 @@ static int read_basic_state(struct rebase_options *opts)
>   
>   	strbuf_release(&buf);

This should become strbuf_reset(&buf) so that we can reuse the allocation.

> +	if (strbuf_read_file(&buf, path, 0) >= 0) {
> +		const char *p = buf.buf, *end = buf.buf + buf.len;
> +
> +		while (p < end) {
> +			char *nl = memchr(p, '\n', end - p);
> +			if (!nl)
> +				die("nl shouldn't be NULL");
> +			*nl = '\0';
> +
> +			if (*p)

This is needed because we allow an empty file but reading an empty file 
is a bug because we only write this file if the user gave --trailers on 
the command line and we should reject empty trailers before getting here.

> +				strvec_push(&opts->trailer_args, p);
> +
> +			p = nl + 1;
> +		}
> +		strbuf_release(&buf);

This is unnecessary, it is released below which is a better place as it 
means the buffer is freed even if strbuf_read_file() fails.

> +	}
> +	strbuf_release(&buf);
> +
>   	return 0;
>   }
>   
>   static int rebase_write_basic_state(struct rebase_options *opts)
>   {
> +	const char trailer_state_name[] = "trailer";

This is unnecessary, lets follow the existing style of just using the 
filename directly in the one place it is needed.

> +    /*
> +     * save opts->trailer_args into state_dir/trailer
> +     */
> +    if (opts->trailer_args.nr) {
> +            struct strbuf buf = STRBUF_INIT;
> +            size_t i;
> +
> +            for (i = 0; i < opts->trailer_args.nr; i++) {

We can use "for (size_t i = 0; i < ...) {" here

> +                    strbuf_addstr(&buf, opts->trailer_args.v[i]);
> +                    strbuf_addch(&buf, '\n');
> +            }
> +            write_file(state_dir_path(trailer_state_name, opts),
> +                       "%s", buf.buf);
> +            strbuf_release(&buf);
> +    }
> +
>   	return 0;
>   }

This looks good
> +static int validate_trailer_args_after_config(const struct strvec *cli_args,
> +				       struct strbuf *err)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < cli_args->nr; i++) {

As i is only used in the loop we can say "for (size_t i = 0; ...) {" and 
drop the declaration above.

> +		const char *raw = cli_args->v[i];
> +		const char *txt; // Key[:=]Val
> +		const char *sep;
> +
> +		if (!skip_prefix(raw, "--trailer=", &txt))
> +			txt = raw;

OPT_STRVEC() only stores the argument, not the option name so we don't 
need this

> +
> +		if (!*txt) {
> +			strbuf_addstr(err, _("empty --trailer argument"));
> +			return -1;

I'm not sure we need the err buf here - we can just

	return error(_("empty --trailer argument"));

> +		}
> +
> +		sep = strpbrk(txt, ":=");

The list of separators is configurable - if we move this function into 
trailer.c then we can use find_separator().

> +
> +		/* there must be key bfore seperator */
> +		if (sep && sep == txt) {
> +			strbuf_addf(err,
> +				    _("invalid trailer '%s': missing key before separator"),
> +				    txt);

We can use return error(...) here as well.

> @@ -1133,6 +1211,7 @@ int cmd_rebase(int argc,
>   			.flags = PARSE_OPT_NOARG,
>   			.defval = REBASE_DIFFSTAT,
>   		},
> +		OPT_STRVEC(0, "trailer", &options.trailer_args, N_("trailer"), N_("add custom trailer(s)")),

This line is rather long, can we fold it like the one below please.

>   		OPT_BOOL(0, "signoff", &options.signoff,
>   			 N_("add a Signed-off-by trailer to each commit")),
>   		OPT_BOOL(0, "committer-date-is-author-date",
> @@ -1283,6 +1362,17 @@ int cmd_rebase(int argc,
>   			     builtin_rebase_options,
>   			     builtin_rebase_usage, 0);
>   
> +    /* if add --trailer，force rebase */

I'm not sure what "add --trailer" means. Forcing the rebase when 
--trailer is given is a good idea.

> +	if (options.trailer_args.nr) {
> +        struct strbuf err = STRBUF_INIT;

The indentation in this block is off here and below

> +		if (validate_trailer_args_after_config(&options.trailer_args, &err))
> +			die("%s", err.buf);
> +
> +        options.flags |= REBASE_FORCE;
> +        strbuf_release(&err);
> +	}

> +	/*
> +	 * The apply‑based backend (git am) cannot append trailers because
> +	 * it lacks a message‑filter facility.  Reject early, before any
> +	 * state (index, HEAD, etc.) is modified.
> +	 */

This comment is a bit confusing - what are we rejecting here? The call 
to imply_merge() is correct.

> +	if (options.trailer_args.nr)
> +		imply_merge(&options, "--trailer");
> +
>   	if (isatty(2) && options.flags & REBASE_NO_QUIET)
>   		strbuf_addstr(&options.git_format_patch_opt, " --progress");
>   
> diff --git a/sequencer.c b/sequencer.c
> index 67e4310edc..58faf6aed5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -422,6 +422,7 @@ void replay_opts_release(struct replay_opts *opts)
>   	free(opts->revs);
>   	replay_ctx_release(ctx);
>   	free(opts->ctx);
> +	strvec_clear(&opts->trailer_args);

Lets move this up a bit before the ctx stuff as that should the last 
member of the struct.

> @@ -2529,6 +2530,18 @@ static int do_pick_commit(struct repository *r,
>   			_("dropping %s %s -- patch contents already upstream\n"),
>   			oid_to_hex(&commit->object.oid), msg.subject);
>   	} /* else allow == 0 and there's nothing special to do */

This feels a bit late in the function to be doing this. Can be add the 
trailers just after we add the sign off around line 2457. That way we 
can add the trailers to ctx->message before writing the commit message 
file. Like --signoff we also need to make sure we don't add trailers 
when we're processing a fixup or squash command.

> +    if (!res && opts->trailer_args.nr && !drop_commit) {
> +            const char *trailer_file =
> +                    msg_file ? msg_file : git_path_merge_msg(r);
> +
> +            if (amend_file_with_trailers(trailer_file,
> +                                         &opts->trailer_args)) {
> +                    res = error(_("unable to add trailers to commit message"));
> +                    goto leave;
> +            }
> +    }
> +
>   	if (!opts->no_commit && !drop_commit) {
>   		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
>   			res = do_commit(r, msg_file, author, reflog_action,
> diff --git a/sequencer.h b/sequencer.h
> index 304ba4b4d3..28f2da6375 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -4,6 +4,7 @@
>   #include "strbuf.h"
>   #include "strvec.h"
>   #include "wt-status.h"
> +#include <stddef.h>

We never add system headers like this. git-compat-util.h takes care of 
that in a portable manner.

>   struct commit;
>   struct index_state;
> @@ -44,6 +45,7 @@ struct replay_opts {
>   	int record_origin;
>   	int no_commit;
>   	int signoff;
> +	struct strvec trailer_args;
>   	int allow_ff;
>   	int allow_rerere_auto;
>   	int allow_empty;
> @@ -86,6 +88,7 @@ struct replay_opts {
>   	.action = -1,				\
>   	.xopts = STRVEC_INIT,			\
>   	.ctx = replay_ctx_new(),		\
> +	.trailer_args = STRVEC_INIT, \
>   }

Lets keep the order of members in the initializer the same as in the 
struct declaration.

I've run out of time for today, I'll take a look at the tests later in 
the week. Although I've left quite a few comments the code in this patch 
looks basically sound.

Thanks

Phillip
>   /*
> diff --git a/t/meson.build b/t/meson.build
> index 09f3068f98..3c58f562da 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -373,6 +373,7 @@ integration_tests = [
>     't3436-rebase-more-options.sh',
>     't3437-rebase-fixup-options.sh',
>     't3438-rebase-broken-files.sh',
> +  't3440-rebase-trailer.sh',
>     't3500-cherry.sh',
>     't3501-revert-cherry-pick.sh',
>     't3502-cherry-pick-merge.sh',
> diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
> new file mode 100755
> index 0000000000..a580449628
> --- /dev/null
> +++ b/t/t3440-rebase-trailer.sh
> @@ -0,0 +1,95 @@
> +#!/bin/sh
> +#
> +
> +test_description='git rebase --trailer integration tests
> +We verify that --trailer on the merge/interactive/exec/root backends,
> +and that it is rejected early when the apply backend is requested.'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
> +
> +create_expect() {
> +	cat >"$1" <<-EOF
> +		$2
> +
> +		Reviewed-by: Dev <dev@example.com>
> +	EOF
> +}
> +
> +test_expect_success 'setup repo with a small history' '
> +	git commit --allow-empty -m "Initial empty commit" &&
> +	test_commit first file a &&
> +	test_commit second file &&
> +	git checkout -b conflict-branch first &&
> +	test_commit file-2 file-2 &&
> +	test_commit conflict file &&
> +	test_commit third file &&
> +	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
> +	create_expect initial-signed  "Initial empty commit" &&
> +	create_expect first-signed    "first"                 &&
> +	create_expect second-signed   "second"                &&
> +	create_expect file2-signed    "file-2"                &&
> +	create_expect third-signed    "third"                 &&
> +	create_expect conflict-signed "conflict"
> +'
> +
> +test_expect_success 'apply backend is rejected with --trailer' '
> +	git reset --hard third &&
> +	head_before=$(git rev-parse HEAD) &&
> +    test_expect_code 128 \
> +    		git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
> +    			HEAD^ 2>err &&
> +	test_grep "requires the merge backend" err &&
> +	test_cmp_rev HEAD $head_before
> +'
> +
> +test_expect_success 'reject empty --trailer argument' '
> +        git reset --hard third &&
> +        test_expect_code 128 git rebase -m --trailer "" HEAD^ 2>err &&
> +        test_grep "empty --trailer" err
> +'
> +
> +test_expect_success 'reject trailer with missing key before separator' '
> +        git reset --hard third &&
> +        test_expect_code 128 git rebase -m --trailer ": no-key" HEAD^ 2>err &&
> +        test_grep "missing key before separator" err
> +'
> +
> +test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
> +        git reset --hard third &&
> +        git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 &&
> +        git cat-file commit HEAD | grep "^Bug: 456" &&
> +        git cat-file commit HEAD | grep -v "^Bug: 123"
> +'
> +
> +test_expect_success 'multiple Signed-off-by trailers all preserved' '
> +        git reset --hard third &&
> +        git rebase -m \
> +            --trailer "Signed-off-by: Dev A <a@ex.com>" \
> +            --trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
> +        git cat-file commit HEAD | grep -c "^Signed-off-by:" >count &&
> +        test "$(cat count)" = 2   # two new commits
> +'
> +
> +test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
> +	git reset --hard third &&
> +	test_must_fail git rebase -m \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" \
> +		second third &&
> +	git checkout --theirs file &&
> +	git add file &&
> +    git rebase --continue &&
> +	test_commit_message HEAD~2 file2-signed
> +'
> +
> +test_expect_success 'rebase --root --trailer updates every commit' '
> +	git checkout first &&
> +	git rebase --root --keep-empty \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" &&
> +	test_commit_message HEAD   first-signed &&
> +	test_commit_message HEAD^  initial-signed
> +'
> +test_done
