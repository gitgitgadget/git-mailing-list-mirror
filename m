Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95D501F53
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787465; cv=none; b=rzCx56Im6vizsjmZbbMNKvrZJx9CQM1/Fh+0Dmr2WcAdKINK8xFF3/t0HDHD3LUTSAf5/sijZb3TivPJ0pOHzAWOi37VVBU7g+jc+jU81A4PXv1V1yO0Sqvu6BoTYqesLJTmLcJ1s7PvkEEHLmBH7lpgRXX5HBZEVfGk5U0g3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787465; c=relaxed/simple;
	bh=vD2VubceZzZYQUK2KQk6yHZNYiCM6ZTPLnQ4ARsd1HM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oIxHZy6TIAQnKZR/XfQ+bqhYY99z97d5rIfFq1OT6XbTmsJIMwkyCvGsapV9gKS0XuqezFFNkcMIw0mbBaWDqI1nIBBn5is/+c+F60ZFwZwMK6yg5QUEOqmoQP5VLvZRwbDzOK5QlG5Fq4g5MlrBg+yi31Yopao9XE8avt1YRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCPuOmgv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCPuOmgv"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so3037806a12.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788787457; x=1789392257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OkbNqM0+uhC0toZIcXuWe2zYdenPODw0NI9HBTy9fRc=;
        b=NCPuOmgv7PZjna7rbhGi064Vy+3wYrpsKi/LfN22Ed/JL5zpuT3OSEVkLPQEEQNYyu
         EBThw/Ymuw9qLYc4MsreKCnrgrwJb+AnLq4UikHTFH7GGj+9JkKuaKRVVlXvze0z9rPw
         ePI5PL5AA3Z/JyZEySATmhwljoo3+8DaSzGvFVB3ocAdHtxCi7Vdq2nZpJ5QmeKXDZ0m
         U+Olzs0IlG4qYX4E48IPR5Kaal/gOJfbkuEWvXBM4R2zhtQNKveEbrgRUxkgCJozB/qw
         vSBfqYuoGsDWaRYukb7HGnXwZfGp8GJTes9kPE3VPUv2m4Mzc5L6vQ9kDqCSJ//BC3cY
         oBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787457; x=1789392257;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkbNqM0+uhC0toZIcXuWe2zYdenPODw0NI9HBTy9fRc=;
        b=W+F+/la7uTMCDDf5T8zuAhVvHSioswlkcKMRoYdOR77kl1FMmQY/aXwgdtFt1gU2/W
         3rlkLTGIeae7uycyCXyxZW2cKxtuqFaeizvlTqKEz5EI0IjbTP5DMtfHIR/bFMazsSIO
         ZhaastLwGaes34r7EIJzLGLRDquXeqnKE9g/fqiWVNxV7ydJ74CbDAL0zy8Os9vHg4WU
         44q1cBWhUn0ZtAz9qF20iGDOeCbAQG6h29IhKL1gRC2jEBc+uGzLjPkyzkoDyezDD0+m
         RQ0Y3gTCaysQDj6bn/aYlpzwM7P8QEVFP+rYf9meN47vM0lh4NwT5PnvtkppBVtse+lE
         08UQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcDkCkrHyx7ygiNb/40CaB9tPewa+SeZ62lFlrauqMJCCS/BI6XeFnE1nFzq8OGWc1kAk=@vger.kernel.org
X-Gm-Message-State: AFuF++koR0jT0bV+vFzLHj37WCifjipL86ze18wspcUtgD8POic5gxSS
	+aqY7o5zQIMjhbG3uKaIWkq2KX1iNwSq/2C7RkKH2gRT5iLLLFr6wZTk
X-Gm-Gg: AYBFou1sDfcfKwA/4HZqYYm3ZG1GHdVjMeX0WeWkoc8fxfgyL3qjFbQ6VayKmrmzb/x
	4LEWPb/AUO7oPy6qsfQMnKrPkXDwcaGOYkJh9MS9x3hqfW8Cqm8RDRODg007FU3/zb0te3n0TqC
	HzxzALI9F6bsm7jMNOq+Ncmh3sL+RIsSnoomQDBAQULxfLotppwBrg8RGK5t/o3LEnj+en/Jbt5
	RrjKKtSVM0oMp/77HrDrkp79HuvtFKuq9NOlmyxMg4eOhjnrA8oLJ+Jrf0WkUDIiE8g2Rd3Ypxi
	QL54Jq8JNEm1usdaJySqDot1Gg+yIx3OiOlonDSyb9PsXRmZNdw50Jy6Stv4D22KOgU8D4w4jwI
	walTZ2HfH+bdnL71UHRxlaxpEo960Mq3d3AiaGnGrJRjG8cYSlUA3XIgxl500C7jAc6B2s1UGni
	oMEPh7JgBzeUt1t0jzcBkwf9Ml3x6d8iDnk/kA0un7U7erVOzNBi4y2tkKq728WM3akIXyMBl8Z
	r3xtdAmkFJdbD6Ly7ZiYzulJviHTf+fpNLdol4cLy0=
X-Received: by 2002:a05:6402:52d8:b0:6a7:ee54:f8a3 with SMTP id 4fb4d7f45d1cf-6a7ee5500c2mr6597861a12.39.1788787456136;
        Mon, 07 Sep 2026 06:24:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68e9889sm4278590a12.22.2026.09.07.06.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:24:15 -0700 (PDT)
Message-ID: <7493f0b7-a6cb-4b7d-bfd4-f4a318ff7e32@gmail.com>
Date: Mon, 7 Sep 2026 14:24:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] sequencer: keep auto maintenance out of the
 commands a sequence spawns
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2026 16:51, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> The "git commit" and "git merge" the sequencer spawns, and the git
> commands an exec runs, each start "git maintenance run --auto
> --detach", which then works in the background against the sequence
> itself. 

I don't think maintenance is actively working against other commands, it 
just creates lock contention. Maybe something like

     When the sequencer runs "git commit" or "git merge", either directly
     or via a user supplied exec command, those commands run "git
     maintenance --auto --detach" which can cause lock contention with
     the sequencer.

> A "rerere gc" started by the commit of one "git rebase
> --continue" holds MERGE_RR.lock when the next pick needs it, and a
> repack deletes packs the sequencer still has open, which 65cda10d5b
> (sequencer: release the ODB before spawning git commit, 2026-08-12)
> had to work around.

This is pretty hard to understand. What does 'the commit of one "git 
rebase --continue"' mean? Also whether the next pick needs to take 
MERGE_RR.lock is conditional on there being conflicts which isn't at all 
clear.
> The loose objects a sequence creates wait for the run at its end that
> the previous commit added.

What does that mean?

> Whether a sequence can be long enough to
> suffer from them before that remains to be seen. Pass
> maintenance.auto=false and gc.auto=0 to the spawned commands through
> GIT_CONFIG_PARAMETERS, which the shell of an exec command hands on to
> whatever it runs,

Talking about the shell here is unnecessarily confusing as the command 
is not necessarily run by the shell: if it is a single word that does 
not contain any shell metacharacters it is passed directly to exec()

> appended after the user's own -c settings so that
> ours win, and built once per run. A command the user runs while the
> sequence is stopped, like "git commit --amend" at an edit, is not the
> sequencer's to control and still runs maintenance.
> 

> @@ -1107,6 +1114,27 @@ static int run_command_silent_on_success(struct child_process *cmd)
>   	return rc;
>   }
>   
> +/*
> + * A sequence runs auto maintenance once it is done, not from every command
> + * it spawns along the way: their background "rerere gc" or repack would
> + * race the sequencer for locks and files it still holds.
> + */

This comment isn't wrong but sounds like an LLM, rather than something a 
person would write.

> +static void disable_auto_maintenance(struct replay_opts *opts,
> +				     struct child_process *cmd)
> +{
> +	struct strbuf *params = &opts->ctx->config_parameters;
> +
> +	if (!params->len) {
> +		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
> +
> +		if (old && *old)
> +			strbuf_addstr(params, old);
> +		git_config_append_parameter(params, "maintenance.auto", "false");
> +		git_config_append_parameter(params, "gc.auto", "0");

This is much nicer now we have the helper function and the calls to 
disable_auto_maintenance() that I've trimmed all look good.
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 2c34cf8a01..cf6d20ce79 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -403,4 +403,22 @@ test_expect_success 'rebase runs auto maintenance at its end' '
>   	test_subcommand_flex git maintenance run --auto <finish.txt
>   '
>   
> +test_expect_success 'rebase spawns no auto maintenance before its end' '
> +	git checkout -b two-conflicts topic &&
> +	test_commit F2-again F2 222 &&
> +	test_must_fail git rebase -x "git commit --allow-empty -m exec" main &&
> +	echo resolved >F2 &&
> +	git add F2 &&
> +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
> +		git rebase --continue &&
> +	test_subcommand_flex git commit <mid.txt &&
> +	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
> +	echo resolved >F2 &&
> +	git add F2 &&
> +	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
> +	test_subcommand_flex git maintenance run --auto <end.txt &&
> +	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
> +	test_line_count = 1 maintenance

Shouldn't this just extend the test added in the previous patch, rather 
than duplicating the coverage for auto maintenance being run at the end 
of a rebase?

> +'
> +
>   test_done
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 304981ccd6..57a77d91bd 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -731,4 +731,21 @@ test_expect_success 'cherry-pick runs auto maintenance once it is done' '
>   	test_line_count = 1 maintenance
>   '
>   
> +test_expect_success 'cherry-pick spawns no auto maintenance before it is done' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick base..anotherpick &&
> +	echo resolved >foo &&
> +	git add foo &&
> +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
> +		git cherry-pick --continue &&
> +	test_subcommand_flex git commit <mid.txt &&
> +	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
> +	echo d >foo &&
> +	git add foo &&
> +	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --continue &&
> +	test_subcommand_flex git commit <end.txt &&
> +	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
> +	test_line_count = 1 maintenance

Again why do we need a separate test, rather than extending the one 
we've just added in the previous commit?

Thanks

Phillip

> +'
> +
>   test_done

