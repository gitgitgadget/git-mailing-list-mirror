Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F57263E
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226718; cv=none; b=RIsVVA7Ik2krzdY5jeNoKfg/Alj21l4Xnq9+JN/Om+nGM4g9qaa1XEL6fO4TyU3ha1TjUD1llTaOnZx23J9LYQXXRsuCnv5pAu+CmSywRyAboK98YUCNYcG5r/TgoNkX5UgjZVle+tL2omKSGzms+J6SP236rzMz2C1CHUCHVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226718; c=relaxed/simple;
	bh=HchRiSpBPooKUc2uwryteZfLbsIOzALn4C0bCtS57so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIBzrJX6fhk6h44mI9OQRIoY77nqdtqzILmhDrGPDUAa1qXHyARGVURvg6jJWf+a3iQfwR/YF5NA3rlYLA96FmoBIVyBTAoZDOBUAJN1eUxLBSdpC45LSsckUGN80zeGtiz6lp3Q9Ao3lHnjlI/2cbJdAc7htDuzlV++igDgvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJy6Vyu0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJy6Vyu0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so31969025e9.0
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759226714; x=1759831514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZxBSpza5IUTm92xPEWqtDb9Jpzno5ShOBr6ki+CRGg=;
        b=FJy6Vyu0yQpa8frRit7+faqhhshiXk2tGuAAwHCnua79UU/DczF8H2FxsNh6WgQkWA
         QeyL/U9HoWp3dk1ZX/qXNvRaY46qlapUJY7PK6jf0BKMk3zEBbTrOEQa6arvK4RbUmRX
         kXys6d9/+8oQAkysmoJ/j1bxvcz/YB918FLTtWhwl9u9/TC3gTLuSVdTds3NEIFE5hb4
         hzuC5xxzcucGBZyA9h0ed+ZAKcEsiLiCb2gHv5f/b8H4D4fkgLt3/jpSKdFn3AbFZvLe
         9NMWOMFkH0SrPWnEiv4PRJJGzSV4fa/beKxlv8YL52H/WLgW6Zq8dMBjTfBC27+MSvfp
         ZT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226714; x=1759831514;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZxBSpza5IUTm92xPEWqtDb9Jpzno5ShOBr6ki+CRGg=;
        b=n8hhmYb7zFAA1D5PeKHK6jkv8LBTQvzmj/Hkrcbznt6DgDQBpA+1YCqZ/63lyWzJpy
         bFiLm7iXxxUdGReqD2yVlNmmyrj3oRhDYMs88qboACRuLJ7SLouL7q7qKtJyN0Fy48Pe
         Re4e88A2QEYAe9gwqlG8KIcf8Jnv45+l1HZXOhp3y0QOrKjhVcBf+MdA7i02K4GfnEnA
         0Es4eDUAn8NZQ4pfNKePXK8Y491xODoK9kv1tDmTShHIzxInC2Uvs5fAY5CgEaQrZxIT
         sKi0p0IusxAI/2z8NWj/cGiBjBoav8BO2RgV0XBWyM0/ggbs2149gJc6QheYkhISVtfe
         YS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkkYoyjOuN1N+MMJ4226UmPYFD+OlfSPzCnkpO2jNzQmpnIdfqtGMw7eaRrnz1G48eJiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYgmMmL29l6oxRaRMU1AcHvnZpclgmBGf4BnkHcr0LGTnBgco
	sZPq4d7ope5JOpETR/0yKFcd9KKUCYLgqR9o+Lcg6taZsIopYAtHOhlhpNpWA+qdVvs=
X-Gm-Gg: ASbGncufRhx+BL3DTdp8vJz1b4BnWzE6t/VMlilx8bNWSNg2j4O2hpo2faCvY3JmgpF
	1w1tVe6bU8PAy+M0vsf1jxjRHLA6afZ3e2lWJ5b61i3G+xqRzxt2sY82CIy8kNKfEKObruJUmr8
	1YyMtcFvAXRcV203ZYeCHzTTEtW7qyoBsG3DfOY+Zt4kLO5/HWtGP4qWPWc1UJT2x6CYTuM0p2T
	39b2/uQxRv9xFKMVcHDn5q96TiIYAYmg06dgmbZxcxhX8A+IukkEQluvInePpBAX9cnF1Mu09oJ
	utn66SzMxjfMHv2e5qnP8Yl4rhYKUMhQE6OkuiS/RhAQYK8LDLnl1Hku7mtHixRL+2cPsKV6WaL
	NJD+lPMDns2o8YvOfmXvHegq62xen5XWf6LPvIVUYcRmQP7rB4VDYzhKoDhA0idaO7GaqbhOK1O
	/oDJ+xbRquQ80p0/U1d0oDIjGy/nnMgy4peMPBsOA=
X-Google-Smtp-Source: AGHT+IGVHoyzUNMOXiZvpSIjx//ZrqHspAg8ImCYR98x4fg4WmKFKr7nUj9h+TKy7LTYH2GF3ojLlQ==
X-Received: by 2002:a05:6000:1a85:b0:406:5e66:ae65 with SMTP id ffacd0b85a97d-40e4d9c9f20mr20172415f8f.60.1759226713668;
        Tue, 30 Sep 2025 03:05:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9768bdesm22206613f8f.23.2025.09.30.03.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:05:12 -0700 (PDT)
Message-ID: <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
Date: Tue, 30 Sep 2025 11:05:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 karthik.188@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250926230838.35870-2-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddharth

On 27/09/2025 00:08, Siddharth Asthana wrote:
> The git replay command currently outputs update commands that must be
> piped to git update-ref --stdin to actually update references:
> 
>      git replay --onto main topic1..topic2 | git update-ref --stdin
> 
> This design has significant limitations for server-side operations. The
> two-command pipeline creates coordination complexity, provides no atomic
> transaction guarantees by default

Are you sure that's true? Maybe I'm missing something but my reading of 
builtin/update-ref.c is that it when "--stdin" is given it starts a ref 
transaction, reads the commands from stdin and applies them to that 
transaction and then commits the transaction which will make the updates 
atomic.

> , and complicates automation in bare
> repository environments where git replay is primarily used.

How does it complicate automation in bare repositories?

Christian has given detailed feedback on the rest of the commit message 
so I'll not comment on it further.

> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index 0b12bf8aa4..e104e0bc03 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -9,16 +9,16 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>   SYNOPSIS
>   --------
>   [verse]
> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--output-commands | --allow-partial] <revision-range>...

Please wrap this very long line

> @@ -42,6 +42,20 @@ When `--advance` is specified, the update-ref command(s) in the output
>   will update the branch passed as an argument to `--advance` to point at
>   the new commits (in other words, this mimics a cherry-pick operation).
>   
> +--output-commands::
> +	Output update-ref commands instead of updating refs directly.
> +	When this option is used, the output can be piped to `git update-ref --stdin`
> +	for successive, relatively slow, ref updates. This is equivalent to the
> +	old default behavior.
> +
> +--allow-partial::
> +	Allow some ref updates to succeed even if others fail. By default,
> +	ref updates are atomic (all succeed or all fail). With this option,
> +	failed updates are reported as warnings rather than causing the entire
> +	command to fail. The command exits with code 0 only if all updates
> +	succeed; any failures result in exit code 1. Cannot be used with
> +	`--output-commands`.

Rather than having two incompatible options perhaps we could have a 
single "--update-refs=(yes|print|allow-partial-updates)" argument. I 
think the name "--allow-partial" is rather ambiguous as it does not say 
what it is allowing to be partial.

> +static int add_ref_to_transaction(struct ref_transaction *transaction,
> +				  const char *refname,
> +				  const struct object_id *new_oid,
> +				  const struct object_id *old_oid,
> +				  struct strbuf *err)
> +{
> +	return ref_transaction_update(transaction, refname, new_oid, old_oid,
> +				      NULL, NULL, 0, "git replay", err);
> +}

I'm not sure this function adds much value. I think it would be better 
to instead have a helper function that updates refs or prints the ref 
updates so that we do not duplicate that code in the two places below.

> @@ -434,10 +481,18 @@ int cmd_replay(int argc,
>   			if (decoration->type == DECORATION_REF_LOCAL &&
>   			    (contained || strset_contains(update_refs,
>   							  decoration->name))) {
> -				printf("update %s %s %s\n",
> -				       decoration->name,
> -				       oid_to_hex(&last_commit->object.oid),
> -				       oid_to_hex(&commit->object.oid));
> +				if (output_commands) {
> +					printf("update %s %s %s\n",
> +					       decoration->name,
> +					       oid_to_hex(&last_commit->object.oid),
> +					       oid_to_hex(&commit->object.oid));
> +				} else if (add_ref_to_transaction(transaction, decoration->name,
> +								  &last_commit->object.oid,
> +								  &commit->object.oid,
> +								  &transaction_err) < 0) {
> +					ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
> +					goto cleanup;
> +				}
>   			}

The lines here are very long due to the indentation, having a separate 
function to update the refs or print the ref updates would be much more 
readable.

>   			decoration = decoration->next;
>   		}
> @@ -445,10 +500,33 @@ int cmd_replay(int argc,
>   
>   	/* In --advance mode, advance the target ref */
>   	if (result.clean == 1 && advance_name) {
> -		printf("update %s %s %s\n",
> -		       advance_name,
> -		       oid_to_hex(&last_commit->object.oid),
> -		       oid_to_hex(&onto->object.oid));
> +		if (output_commands) {
> +			printf("update %s %s %s\n",
> +			       advance_name,
> +			       oid_to_hex(&last_commit->object.oid),
> +			       oid_to_hex(&onto->object.oid));
> +		} else if (add_ref_to_transaction(transaction, advance_name,
> +						  &last_commit->object.oid,
> +						  &onto->object.oid,
> +						  &transaction_err) < 0) {
> +			ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
> +			goto cleanup;
> +		}
> +	}

Putting the code to update the refs or print the ref updates into a 
single function would avoid this duplication and over-long lines.

Thanks

Phillip

> +	/* Commit the ref transaction if we have one */
> +	if (transaction && result.clean == 1) {
> +		if (ref_transaction_commit(transaction, &transaction_err)) {
> +			if (allow_partial) {
> +				warning(_("some ref updates failed: %s"), transaction_err.buf);
> +				ref_transaction_for_each_rejected_update(transaction,
> +									 print_rejected_update, NULL);
> +				ret = 0; /* Set failure even with allow_partial */
> +			} else {
> +				ret = error(_("failed to update refs: %s"), transaction_err.buf);
> +				goto cleanup;
> +			}
> +		}
>   	}
>   
>   	merge_finalize(&merge_opt, &result);
> @@ -457,9 +535,17 @@ int cmd_replay(int argc,
>   		strset_clear(update_refs);
>   		free(update_refs);
>   	}
> -	ret = result.clean;
> +
> +	/* Handle empty ranges: if no commits were processed, treat as success */
> +	if (!commits_processed)
> +		ret = 1; /* Success - no commits to replay is not an error */
> +	else
> +		ret = result.clean;
>   
>   cleanup:
> +	if (transaction)
> +		ref_transaction_free(transaction);
> +	strbuf_release(&transaction_err);
>   	release_revisions(&revs);
>   	free(advance_name);
>   
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 58b3759935..8b4301e227 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
>   '
>   
>   test_expect_success 'using replay to rebase two branches, one on top of other' '
> -	git replay --onto main topic1..topic2 >result &&
> +	git replay --output-commands --onto main topic1..topic2 >result &&
>   
>   	test_line_count = 1 result &&
>   
> @@ -67,9 +67,30 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
>   	test_cmp expect result
>   '
>   
> +test_expect_success 'using replay with default atomic behavior (no output)' '
> +	# Create a test branch that wont interfere with others
> +	git branch atomic-test topic2 &&
> +	git rev-parse atomic-test >atomic-test-old &&
> +
> +	# Default behavior: atomic ref updates (no output)
> +	git replay --onto main topic1..atomic-test >output &&
> +	test_must_be_empty output &&
> +
> +	# Verify the branch was updated
> +	git rev-parse atomic-test >atomic-test-new &&
> +	! test_cmp atomic-test-old atomic-test-new &&
> +
> +	# Verify the history is correct
> +	git log --format=%s atomic-test >actual &&
> +	test_write_lines E D M L B A >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
> -	git -C bare replay --onto main topic1..topic2 >result-bare &&
> -	test_cmp expect result-bare
> +	git -C bare replay --output-commands --onto main topic1..topic2 >result-bare &&
> +
> +	# The result should match what we got from the regular repo
> +	test_cmp result result-bare
>   '
>   
>   test_expect_success 'using replay to rebase with a conflict' '
> @@ -86,7 +107,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
>   	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
>   	# 4th field of result is hash for main instead of hash for topic2
>   
> -	git replay --advance main topic1..topic2 >result &&
> +	git replay --output-commands --advance main topic1..topic2 >result &&
>   
>   	test_line_count = 1 result &&
>   
> @@ -102,7 +123,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
>   '
>   
>   test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
> -	git -C bare replay --advance main topic1..topic2 >result-bare &&
> +	git -C bare replay --output-commands --advance main topic1..topic2 >result-bare &&
>   	test_cmp expect result-bare
>   '
>   
> @@ -115,7 +136,7 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
>   '
>   
>   test_expect_success 'using replay to also rebase a contained branch' '
> -	git replay --contained --onto main main..topic3 >result &&
> +	git replay --output-commands --contained --onto main main..topic3 >result &&
>   
>   	test_line_count = 2 result &&
>   	cut -f 3 -d " " result >new-branch-tips &&
> @@ -139,12 +160,12 @@ test_expect_success 'using replay to also rebase a contained branch' '
>   '
>   
>   test_expect_success 'using replay on bare repo to also rebase a contained branch' '
> -	git -C bare replay --contained --onto main main..topic3 >result-bare &&
> +	git -C bare replay --output-commands --contained --onto main main..topic3 >result-bare &&
>   	test_cmp expect result-bare
>   '
>   
>   test_expect_success 'using replay to rebase multiple divergent branches' '
> -	git replay --onto main ^topic1 topic2 topic4 >result &&
> +	git replay --output-commands --onto main ^topic1 topic2 topic4 >result &&
>   
>   	test_line_count = 2 result &&
>   	cut -f 3 -d " " result >new-branch-tips &&
> @@ -168,7 +189,7 @@ test_expect_success 'using replay to rebase multiple divergent branches' '
>   '
>   
>   test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
> -	git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
> +	git -C bare replay --output-commands --contained --onto main ^main topic2 topic3 topic4 >result &&
>   
>   	test_line_count = 4 result &&
>   	cut -f 3 -d " " result >new-branch-tips &&
> @@ -217,4 +238,131 @@ test_expect_success 'merge.directoryRenames=false' '
>   		--onto rename-onto rename-onto..rename-from
>   '
>   
> +# Tests for new default atomic behavior and options> > +test_expect_success 'replay default behavior should not produce 
output when successful' '
> +	git replay --onto main topic1..topic3 >output &&
> +	test_must_be_empty output
> +'
> +
> +test_expect_success 'replay with --output-commands produces traditional output' '
> +	git replay --output-commands --onto main topic1..topic3 >output &&
> +	test_line_count = 1 output &&
> +	grep "^update refs/heads/topic3 " output
> +'
> +
> +test_expect_success 'replay with --allow-partial should not produce output when successful' '
> +	git replay --allow-partial --onto main topic1..topic3 >output &&
> +	test_must_be_empty output
> +'
> +
> +test_expect_success 'replay fails when --output-commands and --allow-partial are used together' '
> +	test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
> +	grep "cannot be used together" error
> +'
> +
> +test_expect_success 'replay with --contained updates multiple branches atomically' '
> +	# Create fresh test branches based on the original structure
> +	# contained-topic1 should be contained within the range to contained-topic3
> +	git branch contained-base main &&
> +	git checkout -b contained-topic1 contained-base &&
> +	test_commit ContainedC &&
> +	git checkout -b contained-topic3 contained-topic1 &&
> +	test_commit ContainedG &&
> +	test_commit ContainedH &&
> +	git checkout main &&
> +
> +	# Store original states
> +	git rev-parse contained-topic1 >contained-topic1-old &&
> +	git rev-parse contained-topic3 >contained-topic3-old &&
> +
> +	# Use --contained to update multiple branches - this should update both
> +	git replay --contained --onto main contained-base..contained-topic3 &&
> +
> +	# Verify both branches were updated
> +	git rev-parse contained-topic1 >contained-topic1-new &&
> +	git rev-parse contained-topic3 >contained-topic3-new &&
> +	! test_cmp contained-topic1-old contained-topic1-new &&
> +	! test_cmp contained-topic3-old contained-topic3-new
> +'
> +
> +test_expect_success 'replay atomic behavior: all refs updated or none' '
> +	# Store original state
> +	git rev-parse topic4 >topic4-old &&
> +
> +	# Default atomic behavior
> +	git replay --onto main main..topic4 &&
> +
> +	# Verify ref was updated
> +	git rev-parse topic4 >topic4-new &&
> +	! test_cmp topic4-old topic4-new &&
> +
> +	# Verify no partial state
> +	git log --format=%s topic4 >actual &&
> +	test_write_lines J I M L B A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'replay works correctly with bare repositories' '
> +	# Test atomic behavior in bare repo (important for Gitaly)
> +	git checkout -b bare-test topic1 &&
> +	test_commit BareTest &&
> +
> +	# Test with bare repo - replay the commits from main..bare-test to get the full history
> +	git -C bare fetch .. bare-test:bare-test &&
> +	git -C bare replay --onto main main..bare-test &&
> +
> +	# Verify the bare repo was updated correctly (no output)
> +	git -C bare log --format=%s bare-test >actual &&
> +	test_write_lines BareTest F C M L B A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'replay --allow-partial with no failures produces no output' '
> +	git checkout -b partial-test topic1 &&
> +	test_commit PartialTest &&
> +
> +	# Should succeed silently even with partial mode
> +	git replay --allow-partial --onto main topic1..partial-test >output &&
> +	test_must_be_empty output
> +'
> +
> +test_expect_success 'replay maintains ref update consistency' '
> +	# Test that traditional vs atomic produce equivalent results
> +	git checkout -b method1-test topic2 &&
> +	git checkout -b method2-test topic2 &&
> +
> +	# Both methods should update refs to point to the same replayed commits
> +	git replay --output-commands --onto main topic1..method1-test >update-commands &&
> +	git update-ref --stdin <update-commands &&
> +	git log --format=%s method1-test >traditional-result &&
> +
> +	# Direct atomic method should produce same commit history
> +	git replay --onto main topic1..method2-test &&
> +	git log --format=%s method2-test >atomic-result &&
> +
> +	# Both methods should produce identical commit histories
> +	test_cmp traditional-result atomic-result
> +'
> +
> +test_expect_success 'replay error messages are helpful and clear' '
> +	# Test that error messages are clear
> +	test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
> +	grep "cannot be used together" error
> +'
> +
> +test_expect_success 'replay with empty range produces no output and no changes' '
> +	# Create a test branch for empty range testing
> +	git checkout -b empty-test topic1 &&
> +	git rev-parse empty-test >empty-test-before &&
> +
> +	# Empty range should succeed but do nothing
> +	git replay --onto main empty-test..empty-test >output &&
> +	test_must_be_empty output &&
> +
> +	# Branch should be unchanged
> +	git rev-parse empty-test >empty-test-after &&
> +	test_cmp empty-test-before empty-test-after
> +'
> +
>   test_done

