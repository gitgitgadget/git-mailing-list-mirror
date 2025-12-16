Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD90163
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902226; cv=none; b=bfmA4MByXY4QPSNjzl1QeHUEtWB9V2L+JWUpm4SF5rCNaBikGIlAEk10ol4T/E62KuRqlrozlNIvd0CZ8UInDT1sGFkuKCNtILTqjhuivLXrJd4bH0ylviUJbEq7lsrVues3nPGOvj5KaeJ8SjUUSLH7OXKSjVOTCDVKJiezEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902226; c=relaxed/simple;
	bh=syJyZ0rUguYUzyb6F8BONhat3dbX8uoNg/bLE1/1w44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snQXbqww0p3/byoHH/Xyp0ljZve5a4ZrhwuJrAGM+cMotTRl97PWdMkmreqh89QrcITbjvOS+qIkXEIxWCluMIXL8P1ugUJdwnBewtHnIgySNfWwRvJB+v/BWfLAdBTqQV/AcnMibKBD/I/w2RGD79k1bJW3m1f58q8B58OBs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia3zCgNF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia3zCgNF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso21241575e9.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765902221; x=1766507021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h1q9e7COKrsX7xKMITD+vJOwjHyb55rA94PJOouzyco=;
        b=Ia3zCgNFC+vLKXch3LvYrrf7/kGdaZnysgGKYZXQ7UqwPuNghf1WLoUtjVibr7Z5Iq
         DIOpjg7s0jr6jTo4wCFo3nxRHxIIMr3rhwunbhGbgzi12U1vUrx6p494ZvRPWKkBtf63
         NCTRtCbWPa4FRjySlO21Z0XXgdW08gSuCXS9sTRXoqvFX+OHxAcbJo/477pEQVvNBZDz
         ZYxCclIfdgeu8opu5QRT3r96XDiCsctdQOv0+st0Vd81LURAHZkSaDFg17Gj8SkubNih
         hjgVCGjqp8AVZtLwz1Zsz+e6Rpsmn2EJzcDdOue/Aprm2opMrk/IJW/4Bto7s8oQoGq0
         rnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765902221; x=1766507021;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1q9e7COKrsX7xKMITD+vJOwjHyb55rA94PJOouzyco=;
        b=iblijHdyuApQq1C6sCX3xBFu46w8o0ufbnQVes0EVw0ayoPnDh4mfCqWqwSIucm6A2
         FjXHTdfELt1GkoKZS8GN24vIM3QLIhFiIjHcIEmUM4SalgZN3QCOMZpQ6PK/5Ixm+b3U
         H1oMxSmtihDc7LUIg27FuUoVQPZAp0sMSp7D/SaH6a3jlXF+jpZfATPfCH70mv1wOYv6
         I/m4NJ6/GG3D357+RaFLc1esGEvETcXTczby+jcDf4oXDriTd/aQncBVsAYHc5m0iYGS
         LlT5Myw/72ySsWbt5OTyXnNLCBwLnormDTv9Eo0DjdQsF/9yP4GJZAFWubX7gNWxrxU9
         aQiw==
X-Forwarded-Encrypted: i=1; AJvYcCWGRNNjPAydS1uFjJohoJTWnD2dCvpxwtqAUe9+yJeAz3LUHTNpE/8OeFEEk6u4PW2lFoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh59oYnRD+neQb7q8MWpd8/y2hMvNEQemOY62BwALHQ3wZm1pZ
	fX1ttcjnh1pyMpQKI97pMqoT5fKfQcbJviGU7l5WU2FgtUCW57YKyO9j
X-Gm-Gg: AY/fxX71IaM7DrMYt/wqTtD2qVtTeJ2yeR2R1aDw20uZI7OUepJ8QPHcAbMSM16yFRk
	w2MBlqjh6RYMTnxG26cfKHk4ecq8gsFuuWrcYmm/W3/5HUBD31Cm6pe+L28c0Zot9RVkZVs2KYz
	RPH3n99Tg81eu/0xCrPlcrHcW69g7gI6jsBzzpQhOZteDrpXqsKvp5sQuA+kr1tbR35FNHLXf1M
	LRhdqS+hjdPbviv0OcaLUklnxYJLstVQuVx0kgH/mdiLNSKb/XS2rVx1ussfgqps5e+iI1UIVCY
	QVa3iBlVhdqEjfth6OVeYOQfO53JBjMsfSSa9B2lJ8ib8E5zKZVCcklobTFYkHAAMOfsuN0t22M
	dlSoT4q7fou41BAsuS1Qo+0i9N1RZNs+5lh+CbQko7N6tCHFcSSkxbHjpjlfXZtYgSPjvhGj2iw
	5FgVBWtvXCDStmQ3CUy9PJ9oiR8GovE18p/OFO1wmdBv0s/cQ23umrZNEP9B7XqGiAWw==
X-Google-Smtp-Source: AGHT+IFsPYV9TevPZPwY+kJ3k+pZ1L4Pl3EY6ypnvkSlOJ3x1xuXnJZCC6lOIPFi+ZJKSRBKFoCD5A==
X-Received: by 2002:a05:600c:c16d:b0:47b:d914:98a7 with SMTP id 5b1f17b1804b1-47bda6c8380mr20615515e9.29.1765902221092;
        Tue, 16 Dec 2025 08:23:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f36b6a19sm21954142f8f.38.2025.12.16.08.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 08:23:40 -0800 (PST)
Message-ID: <c49b2375-c975-4591-b3e9-aa87771a8015@gmail.com>
Date: Tue, 16 Dec 2025 16:23:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] replay: add --revert mode to reverse commit
 changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, toon@iotcl.com
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-3-siddharthasthana31@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251202201611.22137-3-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddarth

I agree with Patrick's comments, I've added a few more of my own below

On 02/12/2025 20:16, Siddharth Asthana wrote:
> The `git replay` command performs server-side history rewriting without
> requiring a working tree. While it currently supports cherry-picking
> commits (--advance) and rebasing (--onto), it lacks the ability to
> revert them.
> 
> At GitLab, we use replay in Gitaly for efficient server-side operations
> on bare repositories. Adding revert functionality enables us to reverse
> problematic commits directly on the server, eliminating client-side
> roundtrips and reducing network overhead.
> 
> Add a `--revert <branch>` mode that reverses the changes introduced by
> the specified commits. Following the architecture of --onto and --advance,
> --revert is a standalone mode that takes a branch argument and updates
> that branch with the revert commits.

s/revert/reverted/?

> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index dcb26e8a8e..eb297c7530 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>   SYNOPSIS
>   --------
>   [verse]
> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
>   
>   DESCRIPTION
>   -----------
> @@ -42,6 +42,24 @@ The history is replayed on top of the <branch> and <branch> is updated to
>   point at the tip of the resulting history. This is different from `--onto`,
>   which uses the target only as a starting point without updating it.
>   
> +--revert <branch>::
> +	Starting point at which to create the new revert commits; must be a
> +	branch name.
> ++
> +When `--revert` is specified, the commits in the revision range are reverted
> +(their changes are undone) and the revert commits

s/revert/reverted/

> are applied on top of <branch>.
> +The <branch> is then updated to point at the new commits. This is similar to
> +running `git revert` for each commit in the range, but works without a working tree.

"git revert" takes a revision range so it is the same as running "git 
revert <revision-range>" but does not update the working tree.

> ++
> +The commit messages follow `git revert` conventions: prefixed with "Revert" and

s/conventions: prefixed/conventions: they are prefixed/

> +including the original commit SHA.

s/including/include/
s/SHA/hash/

> When reverting a commit whose message starts
> +with "Revert", the new message uses "Reapply" instead. The author of the revert
> +commits is the current user, not the original commit author.
> ++
> +This option is mutually exclusive with `--onto` and `--advance`. It is also
> +incompatible with `--contained` (which is a modifier for `--onto` only).
> +
> +
>   --ref-action[=<mode>]::
>   	Control how references are updated. The mode can be:
>   +
> @@ -141,6 +159,22 @@ all commits they have since `base`, playing them on top of
>   `origin/main`. These three branches may have commits on top of `base`
>   that they have in common, but that does not need to be the case.
>   
> +To revert commits from a branch:
> +
> +------------
> +$ git replay --revert main feature~2..feature
> +------------
> +
> +This reverts the last two commits from 'feature', creating revert commits on
> +top of 'main', and updates 'main' to point at the result. This is useful when
> +commits from 'feature' were previously merged or cherry-picked into 'main' and
> +need to be undone.
> +
> +NOTE: For reverting an entire merge request as a single commit (rather than
> +commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
> +which can avoid unnecessary merge conflicts.

That's a good suggestion

> +
>   GIT
>   ---
>   Part of the linkgit:git[1] suite
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6606a2c94b..7660f7412f 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -17,6 +17,7 @@
>   #include "parse-options.h"
>   #include "refs.h"
>   #include "revision.h"
> +#include "sequencer.h"
>   #include "strmap.h"
>   #include <oidset.h>
>   #include <tree.h>
> @@ -26,6 +27,11 @@ enum ref_action_mode {
>   	REF_ACTION_PRINT,
>   };
>   
> +enum replay_action {
> +	REPLAY_PICK,
> +	REPLAY_REVERT,
> +};

sequencer.h already defines enum replay_action with an extra member so 
this is a bit confusing, maybe we should use a different name?

> +static void generate_revert_message(struct strbuf *msg,
> +				    struct commit *commit,
> +				    struct repository *repo)
> +{
> +	const char *out_enc = get_commit_output_encoding();
> +	const char *message = repo_logmsg_reencode(repo, commit, NULL, out_enc);
> +	const char *subject_start;
> +	int subject_len;
> +	char *subject;
> +
> +	subject_len = find_commit_subject(message, &subject_start);
> +	subject = xmemdupz(subject_start, subject_len);
> +
> +	sequencer_format_revert_header(msg, subject);
> +	strbuf_addstr(msg, oid_to_hex(&commit->object.oid));
> +	strbuf_addstr(msg, ".\n");

It's a bit odd that sequencer_format_revert_header() actually adds the 
beginning of the body but we have to add the commit oid ourselves. It 
would be nicer if we could pass the oid to that function and have it 
format the message for us. It's a bit tricky because the sequencer needs 
to handle merges as well but it shouldn't be too difficult.

The function name is also a bit strange as header normally refers to the 
commit metadata not the subject line.

> @@ -77,9 +105,14 @@ static struct commit *create_commit(struct repository *repo,
>   
>   	commit_list_insert(parent, &parents);
>   	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
> -	find_commit_subject(message, &orig_message);
> -	strbuf_addstr(&msg, orig_message);
> -	author = get_author(message);
> +	if (action == REPLAY_REVERT) {
> +		generate_revert_message(&msg, based_on, repo);
> +		author = xstrdup(git_author_info(IDENT_STRICT));

write_commit_tree() will look up the author for us if we just pass NULL 
so I would just set author = NULL here or delete this line and 
initialize author to NULL at the beginning of this function.

> +	} else {
> +		find_commit_subject(message, &orig_message);
> +		strbuf_addstr(&msg, orig_message);
> +		author = get_author(message);
> +	}

This matches the deleted lines - good

> @@ -196,6 +230,20 @@ static void determine_replay_mode(struct repository *repo,
>   		}
>   		if (rinfo.positive_refexprs > 1)
>   			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
> +	} else if (*revert_name) {
> +		struct object_id oid;
> +		char *fullname = NULL;
> +
> +		*onto = peel_committish(repo, *revert_name);
> +		if (repo_dwim_ref(repo, *revert_name, strlen(*revert_name),
> +				  &oid, &fullname, 0) == 1) {
> +			free(*revert_name);
> +			*revert_name = fullname;
> +		} else {
> +			die(_("argument to --revert must be a reference"));
> +		}
> +		if (rinfo.positive_refexprs > 1)
> +			die(_("cannot revert with multiple sources because ordering would be ill-defined"));

This is a copy of what we do with --advance but with a different option 
name - can be factor this out into a common function that's called for 
both options?

> @@ -452,10 +535,13 @@ int cmd_replay(int argc,
>   	}
>   
>   	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
> +			      &revert_name,
>   			      &onto, &update_refs);

Let's not fold the line after "revert_name"

> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index cf3aacf355..1c4e1cb666 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -314,4 +314,115 @@ test_expect_success 'invalid replay.refAction value' '
>   	test_grep "invalid.*replay.refAction.*value" error
>   '
>   
> +test_expect_success 'setup for revert tests' '
> +	git switch -c revert-test main &&
> +	test_commit R1 &&
> +	test_commit R2 &&
> +	test_commit R3 &&
> +	git switch main
> +'

Why do we need a new branch for this? We already have topic3 built on 
top of topic1 so we can test reverting commits with

	git replay --revert=topic3 main..topic1

which should revert C and F

> +test_expect_success 'git replay --revert reverts commits' '
> +	# Store original state
> +	START=$(git rev-parse revert-test) &&
> +	test_when_finished "git branch -f revert-test $START" &&
> +
> +	git replay --revert revert-test revert-test~2..revert-test >output &&
> +	test_must_be_empty output &&
> +
> +	# Verify revert-test was updated with revert commits
> +	git log --format=%s -n 5 revert-test >actual &&
> +	cat >expect <<-\EOF &&
> +	Revert "R3"
> +	Revert "R2"
> +	R3
> +	R2
> +	R1
> +	EOF
> +	test_cmp expect actual &&
> +
> +	# Verify commit message format
> +	test_commit_message revert-test -m "Revert \"R3\"
> +
> +This reverts commit $(git rev-parse R3)."

test_commit_message accepts the expected message on stdin so you can write

	test_commit_message revert-test <<-EOF
	Revert "R3"

	This reverts commit $(git rev-parse R3)
	EOF

which is cleaner as we don't have to escape the double quotes and the 
message is nicely indented.

> +'
> +
> +test_expect_success 'git replay --revert with --ref-action=print' '

Given the ref updating code is independent of --advance, --revert etc 
I'm not sure what extra coverage this test adds. If the previous test 
passes what is a plausible scenario where this one fails?

> +	# Store original state
> +	START=$(git rev-parse revert-test) &&
> +	test_when_finished "git branch -f revert-test $START" &&
> +
> +	git replay --ref-action=print --revert revert-test revert-test~2..revert-test >result &&
> +	test_line_count = 1 result &&
> +
> +	# Verify output format: update refs/heads/revert-test <new> <old>
> +	cut -f 3 -d " " result >new-tip &&
> +	printf "update refs/heads/revert-test " >expect &&
> +	printf "%s " $(cat new-tip) >>expect &&
> +	printf "%s\n" $START >>expect &&
> +	test_cmp expect result
> +'
> +
> +test_expect_success 'git replay --revert reapply behavior' '

Good idea

> +	# Store original state
> +	START=$(git rev-parse revert-test) &&
> +	test_when_finished "git branch -f revert-test $START" &&
> +
> +	# First revert R3
> +	git replay --revert revert-test revert-test~1..revert-test &&
> +	REVERT_R3=$(git rev-parse revert-test) &&
> +
> +	# Now revert the revert (should create "Reapply" message)
> +	git replay --revert revert-test revert-test~1..revert-test >output &&
> +	test_must_be_empty output &&
> +
> +	# Verify Reapply message
> +	test_commit_message revert-test -m "Reapply \"R3\"
> +
> +This reverts commit $(git rev-parse $REVERT_R3)."
> +'
> +
> +test_expect_success 'git replay --revert with conflict' '
> +	# Create a conflicting scenario
> +	git switch -c revert-conflict main &&
> +	test_commit C1 &&
> +	echo conflict >C1.t &&
> +	test_commit C2 C1.t &&
> +	git switch main &&
> +	echo different >C1.t &&
> +	test_commit C3 C1.t &&
> +
> +	# Try to revert C2 onto main (which has conflicting C3)
> +	test_expect_code 1 git replay --revert main revert-conflict~1..revert-conflict
> +'
> +
> +test_expect_success 'git replay --revert reflog message' '

I think we should just check the reflog message in one of the earlier tests.

> +	# Store original state
> +	START=$(git rev-parse revert-test) &&
> +	test_when_finished "git branch -f revert-test $START" &&
> +
> +	git replay --revert revert-test revert-test~1..revert-test >output &&
> +	test_must_be_empty output &&
> +
> +	# Verify reflog message includes --revert and branch name
> +	git reflog revert-test -1 --format=%gs >reflog-msg &&
> +	echo "replay --revert revert-test" >expect-reflog &&
> +	test_cmp expect-reflog reflog-msg
> +'
> +
> +test_expect_success 'git replay --revert incompatible with --contained' '
> +	test_must_fail git replay --revert revert-test --contained revert-test~1..revert-test 2>error &&
> +	test_grep "requires --onto" error
> +'
> +
> +test_expect_success 'git replay --revert incompatible with --onto' '
> +	test_must_fail git replay --revert revert-test --onto main revert-test~1..revert-test 2>error &&
> +	test_grep "cannot be used together" error
> +'
> +
> +test_expect_success 'git replay --revert incompatible with --advance' '
> +	test_must_fail git replay --revert revert-test --advance main revert-test~1..revert-test 2>error &&
> +	test_grep "cannot be used together" error
> +'

These last three look good.

Thanks

Phillip

