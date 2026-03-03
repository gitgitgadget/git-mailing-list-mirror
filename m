Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574147F2F0
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550321; cv=none; b=bohRlGGUoM1uryNYlZySv4tnWmGgK+n3E4uzY3yBJndj7VjEJqAsIf7DHdG7sQ7ZQDJdVKVe9QHoToxGEBIYxJ2GL+pQv20hLfDvBZI+X0p+WFW/2tu9DqWkFJgJxoyYjMpfBlQDA2dMCOMQn5Sk9XqsZsIaOBwRmkqw1EalwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550321; c=relaxed/simple;
	bh=iM06+L+6HIcv2/O+xcmAn0bSnLH8s7A2/M0mg0NWCwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cmh53s1MS0hmlORkaPcpiIcbsM3J2CrKmNo7JCEyB7TIHDBsmJeDDqinLFw+ya8CEP7bCoxllpFISoKUvF9vRIJ2FBdYQKXo74f61zDdpExc1Fy5RlOtp6o6bE7TMQ4uuvgVllJp7Ai7p5Mpjoop2M8EHHB+9d2sbYPNA1oRww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhIi8Vaj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhIi8Vaj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4398f8e2837so4961193f8f.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772550316; x=1773155116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=thDpeSsPPrtVzXxfiJbe4uofEWrTPm2ohtkmDJqZc/Q=;
        b=WhIi8VajXDIDhbV3NfsJSnYR7O72xwX/OkwEHyZGV3LtdS85hhAWEHKKpfS12xBBzv
         nmS/IOWpImkPRR/3R4du2RkUzhavhEz9joq0qqqGuFhXQJFetpBFLcFCyVCqrBWbKLeN
         w9DYSytANShvR1Ja6NUwrX14aNzavapHje3c2MjcT9aE5NHGBLS9Cra0QLqO967fTfTV
         +hIx1/USjX47zDIA+cziFoZc0Nru0KAVEpTO9ZVTQFfnEFJVzHq+3Kvkbg39nsL6kDvE
         KVNCXTTtiOVlmwW6pBgq5vjw8Fmidho9zBn8prmwkMRgMiYgRA8RAe5dE5EmEUzcGgC0
         J2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772550316; x=1773155116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thDpeSsPPrtVzXxfiJbe4uofEWrTPm2ohtkmDJqZc/Q=;
        b=Rg1R133Jit3NNllEmXO+1j7ZF8aE7GIOkCIOVeGvdzD2Mnypt/vQ4osFaZ0qOqhoXz
         C77IoS0wB+niuyVMPUxj2W1vCIU3vM74eYumekKy2bgR93OzfjZd9BCpLzGLDs9jzqG8
         j7/zWoZVD9gQcNdRpfw9RP2NsZ7Cf1D/6o2q8aeXiIa3NjKgJKHLmE6yBfnewOIwavya
         Jst5UMiAYWojN/lCs4nd7KJcrceW/P2ZBa2BuQhdIGh/nuK8rsSe3fdlqPOj4nnVvGE8
         PrA4T6CqXaxhXwqBGVNk4/53UYu6kOA1EMQP1LK+BlNmaRSxwJM5NkldVnAL7GgA7+Jn
         M4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWUHr4Ph9Rud00gghV1mOX0BR4BdLrGPMXTGSK3M9DdJiPdHhKdVdQQDtuvBTLCsPQfdo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMS99rRZY8uQz1VyiyZ92VLtZg93pJ7QYbtI+yyiybij1zHGV
	2YBdyOgU3Y1gtTo8NFrXbx15KE+5kMb2rX1uycjyywOrIqpTT5J/NFaR
X-Gm-Gg: ATEYQzz4HqAsKb16TaA8fqrDSSSTMxEBISLGUPj6CdOBQZBKRxttIJRpjblB4dk6HkS
	yqppxxV3TGe8Pb6ik7LSQx0DMwbowAg3HJwhmZRavII5aQhZOtZcgdOCmYadRfCdM0K4Hgv1mei
	w1wBHKa800e/1QMOyob7TD1mC6xRRw9Fqp6ibt7RY2wrbKOsbWH1to3dth/cNMABYdqiKHxO4la
	BmH/TIDllYi4PVLYpGdqglByXnThfc2eQJp4TW4VQGyFywNMCwqQ0IsG8bJHWhLdp/k4r06kfP4
	8dMyPkc0mOWwF+H5AzI+5mSnyQ96MJ/nJFA0H1jpevJ7GaK3992yN2WYtIqqZONjtn4Uq9NELKN
	ROxBdM7SDYuKOVCm45HmGb9iMzmum2Kl9gXawl7JbcKUTWTQ8qjQ1TBXVKsZQzcE4LLfuz3M81B
	Er6a1t4Mh4IUFXUUCRG8/ts+BPkZw58KTQJmdrb4P5TUrzaoSHrfchJP+O82TLHOZHYN1Ny8ZPR
	k3cYQ==
X-Received: by 2002:a5d:5d88:0:b0:439:b440:b8b0 with SMTP id ffacd0b85a97d-439b440ba0dmr15327482f8f.45.1772550315648;
        Tue, 03 Mar 2026 07:05:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c765c38sm34602838f8f.31.2026.03.03.07.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 07:05:14 -0800 (PST)
Message-ID: <824809c3-72ac-43fb-8a93-4f48e0727e6a@gmail.com>
Date: Tue, 3 Mar 2026 15:05:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 5/5] rebase: support --trailer
To: Li Chen <me@linux.beauty>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-6-me@linux.beauty>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260224070552.148591-6-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 24/02/2026 07:05, Li Chen wrote:
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index e177808004..908717991a 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -497,6 +497,13 @@ See also INCOMPATIBLE OPTIONS below.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> +--trailer=<trailer>::
> +	Append the given trailer to every rebased commit message, processed
> +	via linkgit:git-interpret-trailers[1]. This option implies
> +	`--force-rebase` so that fast-forwarded commits are also rewritten.

If the commits are rewritten then they're not fast-forwarded, I just say 
"This option implies `--force-rebase`." as all the other options that 
imply `--force-rebase` do.

> +See also INCOMPATIBLE OPTIONS below.

That section needs updating to include `--trailer`

> diff --git a/sequencer.c b/sequencer.c
> index a3eb39bb25..a60c2a0cde 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> [...]
> @@ -2025,6 +2027,9 @@ static int append_squash_message(struct strbuf *buf, const char *body,
>   		if (opts->signoff)
>   			append_signoff(buf, 0, 0);
>   
> +		if (opts->trailer_args.nr)
> +			amend_strbuf_with_trailers(buf, &opts->trailer_args);

I wonder if it would be better to add the trailers before the signoff so 
that "git rebase --signoff --trailer='Reviewed-by: ...'" adds the 
"Reviewed-by:" trailer before the "Signed-off-by:" trailer.

> @@ -3234,6 +3242,18 @@ static int read_populate_opts(struct replay_opts *opts)
>   
>   		read_strategy_opts(opts, &buf);
>   		strbuf_reset(&buf);
> +		if (strbuf_read_file(&buf, rebase_path_trailer(), 0) >= 0) {

Most of the other options are read with read_oneliner() which warns if 
there is a read error - we should do the same here. We should also warn 
if this file is empty as we only write it when trailer_args.nr > 0.

This is all looking pretty good

Thanks

Phillip

> +			char *p = buf.buf, *nl;
> +
> +			while ((nl = strchr(p, '\n'))) {
> +				*nl = '\0';
> +				if (!*p)
> +					BUG("rebase-merge/trailer has an empty line");
> +				strvec_push(&opts->trailer_args, p);
> +				p = nl + 1;
> +			}
> +			strbuf_reset(&buf);
> +		}
>   
>   		if (read_oneliner(&ctx->current_fixups,
>   				  rebase_path_current_fixups(),
> @@ -3328,6 +3348,14 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>   	else
>   		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
> +	if (opts->trailer_args.nr) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		for (size_t i = 0; i < opts->trailer_args.nr; i++)
> +			strbuf_addf(&buf, "%s\n", opts->trailer_args.v[i]);
> +		write_file(rebase_path_trailer(), "%s", buf.buf);
> +		strbuf_release(&buf);
> +	}
>   
>   	return 0;
>   }
> diff --git a/sequencer.h b/sequencer.h
> index 719684c8a9..bea20da085 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -57,6 +57,8 @@ struct replay_opts {
>   	int ignore_date;
>   	int commit_use_reference;
>   
> +	struct strvec trailer_args;
> +
>   	int mainline;
>   
>   	char *gpg_sign;
> @@ -84,6 +86,7 @@ struct replay_opts {
>   #define REPLAY_OPTS_INIT {			\
>   	.edit = -1,				\
>   	.action = -1,				\
> +	.trailer_args = STRVEC_INIT,		\
>   	.xopts = STRVEC_INIT,			\
>   	.ctx = replay_ctx_new(),		\
>   }
> diff --git a/t/meson.build b/t/meson.build
> index f80e366cff..1f6f8ac20b 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -388,6 +388,7 @@ integration_tests = [
>     't3436-rebase-more-options.sh',
>     't3437-rebase-fixup-options.sh',
>     't3438-rebase-broken-files.sh',
> +  't3440-rebase-trailer.sh',
>     't3450-history.sh',
>     't3451-history-reword.sh',
>     't3500-cherry.sh',
> diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
> new file mode 100755
> index 0000000000..8b47579566
> --- /dev/null
> +++ b/t/t3440-rebase-trailer.sh
> @@ -0,0 +1,147 @@
> +#!/bin/sh
> +#
> +
> +test_description='git rebase --trailer integration tests
> +We verify that --trailer works with the merge backend,
> +and that it is rejected early when the apply backend is requested.'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
> +
> +REVIEWED_BY_TRAILER="Reviewed-by: Dev <dev@example.com>"
> +SP=" "
> +
> +test_expect_success 'setup repo with a small history' '
> +	git commit --allow-empty -m "Initial empty commit" &&
> +	test_commit first file a &&
> +	test_commit second file &&
> +	git checkout -b conflict-branch first &&
> +	test_commit file-2 file-2 &&
> +	test_commit conflict file &&
> +	test_commit third file &&
> +	git checkout main
> +'
> +
> +test_expect_success 'apply backend is rejected with --trailer' '
> +	git checkout -B apply-backend third &&
> +	test_expect_code 128 \
> +		git rebase --apply --trailer "$REVIEWED_BY_TRAILER" HEAD^ 2>err &&
> +	test_grep "fatal: --trailer requires the merge backend" err
> +'
> +
> +test_expect_success 'reject empty --trailer argument' '
> +	git checkout -B empty-trailer third &&
> +	test_expect_code 128 git rebase --trailer "" HEAD^ 2>err &&
> +	test_grep "empty --trailer" err
> +'
> +
> +test_expect_success 'reject trailer with missing key before separator' '
> +	git checkout -B missing-key third &&
> +	test_expect_code 128 git rebase --trailer ": no-key" HEAD^ 2>err &&
> +	test_grep "missing key before separator" err
> +'
> +
> +test_expect_success 'allow trailer with missing value after separator' '
> +	git checkout -B missing-value third &&
> +	git rebase --trailer "Acked-by:" HEAD^ &&
> +	test_commit_message HEAD <<-EOF
> +	third
> +
> +	Acked-by:${SP}
> +	EOF
> +'
> +
> +test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
> +	git checkout -B replace-policy third &&
> +	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
> +		rebase --trailer "Bug: 123" --trailer "Bug: 456" HEAD^ &&
> +	test_commit_message HEAD <<-EOF
> +	third
> +
> +	Bug: 456
> +	EOF
> +'
> +
> +test_expect_success 'multiple Signed-off-by trailers all preserved' '
> +	git checkout -B multiple-signoff third &&
> +	git rebase --trailer "Signed-off-by: Dev A <a@example.com>" \
> +		--trailer "Signed-off-by: Dev B <b@example.com>" HEAD^ &&
> +	test_commit_message HEAD <<-EOF
> +	third
> +
> +	Signed-off-by: Dev A <a@example.com>
> +	Signed-off-by: Dev B <b@example.com>
> +	EOF
> +'
> +
> +test_expect_success 'rebase --trailer adds trailer after conflicts' '
> +	git checkout -B trailer-conflict third &&
> +	test_commit fourth file &&
> +	test_must_fail git rebase --trailer "$REVIEWED_BY_TRAILER" second &&
> +	git checkout --theirs file &&
> +	git add file &&
> +	git rebase --continue &&
> +	test_commit_message HEAD <<-EOF &&
> +	fourth
> +
> +	$REVIEWED_BY_TRAILER
> +	EOF
> +	test_commit_message HEAD^ <<-EOF
> +	third
> +
> +	$REVIEWED_BY_TRAILER
> +	EOF
> +'
> +
> +test_expect_success '--trailer handles fixup commands in todo list' '
> +	git checkout -B fixup-trailer third &&
> +	test_commit fixup-base base &&
> +	test_commit fixup-second second &&
> +	cat >todo <<-\EOF &&
> +	pick fixup-base fixup-base
> +	fixup fixup-second fixup-second
> +	EOF
> +	(
> +		set_replace_editor todo &&
> +		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
> +	) &&
> +	test_commit_message HEAD <<-EOF &&
> +	fixup-base
> +
> +	$REVIEWED_BY_TRAILER
> +	EOF
> +	git reset --hard fixup-second &&
> +	cat >todo <<-\EOF &&
> +	pick fixup-base fixup-base
> +	fixup -C fixup-second fixup-second
> +	EOF
> +	(
> +		set_replace_editor todo &&
> +		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
> +	) &&
> +	test_commit_message HEAD <<-EOF
> +	fixup-second
> +
> +	$REVIEWED_BY_TRAILER
> +	EOF
> +'
> +
> +test_expect_success 'rebase --root honors trailer.<name>.key' '
> +	git checkout -B root-trailer first &&
> +	git -c trailer.review.key=Reviewed-by rebase --root \
> +		--trailer=review="Dev <dev@example.com>" &&
> +	test_commit_message HEAD <<-EOF &&
> +	first
> +
> +	Reviewed-by: Dev <dev@example.com>
> +	EOF
> +	test_commit_message HEAD^ <<-EOF
> +	Initial empty commit
> +
> +	Reviewed-by: Dev <dev@example.com>
> +	EOF
> +'
> +test_done

