Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC34D8DA2
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787556; cv=none; b=eBNqiti6yuzmfjSARPw3iBQOwHkMZ5vurAYOQG/ZwcDkVSmX7mZP0X7xd/mT2OzjwJ+hAcdeOhtN87tFFO8fD3B1o86tocHsDBHRJQDnT6NMrqNx1+F0hf3fzMaj4rVnOLYLwPpPA8+XtV2yybjBQ1AYHzSC1n7iIIAsWaoIUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787556; c=relaxed/simple;
	bh=iQLhlsrn8Y/K7JM6vOgfNY7G2WBcde+IVQOpT+/YAIM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rFD2ykxhrjDKogoh3o0RbJDW7OLZ4NRtR8GQTxvW9wfwBQmLY67dA1koCiOo69u5XsDEkYSN7hZ0jtKk4SYDeL1xM6F1QHmw3+/ebiaHEx/IDJLNI8bYyzO3NJx/wzji/L77R4i/KXQjZ5ev3BrKHZ2y3ARk/m/JERqCnayEYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inKTmRLV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inKTmRLV"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c263415982eso214112266b.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788787550; x=1789392350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqDSt0Qy4bMx26te7z7dd9iu7GRkmEh4jZkn3vxWa0c=;
        b=inKTmRLVIXHPP3h8PPAsUUB9KPyIm9EHC8PCtJOObGsarm7iMMEqt64cTWEcLIYWyA
         P4WQA8NmDku5D/dz6WUFdls1PZsPRKYWAKiy7fmsDbOcBfBMKORHRnCK43PZXGFoOJww
         S+eJsW9UkphhuEUxBCH5b0pQu6YvlvS7ZbF5bqREsSC+aNV44rPsbofGvaT04jSBcV9o
         jAYSg9tkP92LT+zUmVAysrviysBQFURsCXlap++FeUeF6NRMmJoWh1EO0OMePEzQ6yQh
         k96UbpbVjms6jWcg/lIOBMZ6BPb51mBzYMbg/aI6YrZF2JYTLoIys2LJ7fpEEhjinDhM
         IkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787550; x=1789392350;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqDSt0Qy4bMx26te7z7dd9iu7GRkmEh4jZkn3vxWa0c=;
        b=ez4jpQHNmj1aG9/BTaaCkDOaNVv7WF8cyK5pfGFd//JQV+x4sE8E4jREnfQ4gAWTYl
         LdNvgejlgeJ+aEiNpfkpmYOSR1JWTC1wzzx0eZzvegMES/HHnQO2fXqX3UgntIxKsqBF
         iYgFCytTHeXh42aZgIwDr2YVU9CIAruVpcJw4BdjpNM2aV4TJBXO1/JrAGYU7BwmLOj3
         0gwHAFTsH7fw78HGM/8jrZrNNIVyaRo/uo3Y1l7heaDfK4XkMwTiKS5qFkvpfxjUkUEk
         o8x09+yp2mhOKWjEjQCtsU9NE/sVVXOu11xqTapKi3f37V7+V1qbl5QXQnEQ/2HMPMOy
         Pm3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzoC9m/LTs2DS1IGeG3n2h57BlMfR9OWreMkczU4PAAxFaDR3dw4mK0upG0XYjQPzVomBo=@vger.kernel.org
X-Gm-Message-State: AFuF++n4S0ZJiNeuez6qaOwCyb17vfM62TabKMydlFYGf1dskKOO1W+G
	B27fRpuW7DbPowAJWzjqrvxS4Gd3wqScKxG6heW+FHZn0kOY2UzZTrPO
X-Gm-Gg: AYBFou24pcVvlojmwt2UGKb+q9YNLMLILRASg2Z4+xj3j53Imx6iezpjTDe4PB53T9Q
	MNMw0hZk57krNqkrTscFioyZ+zqqphdO/BK9lJez6y+vi+8pVa33mylBcTfhmSVL7ZMWreWq8vk
	PkT+6oB88xKOq7eMqdDHqzW+wxMZV5Ic9dDTQ3/e4+8k+HsWSXjz22ACrdZMx/0QV4cDeJsbHHz
	VBndPtevdFJ44KF59SlGvZ+McsnXb7hlpTINwXugISB10KB4mfOZYyt/LzlWcjoMr7W3jPOHTIZ
	In/GNj1OnT+ws5x1NGMHWwyCDkpzthtZZ175h40vYCGZuId27KI3EfD1XBLfcIgOOjkNLKQMHdo
	I6XGpUj5hHNzayHmkqb3XO6dqkmkb8T5RojAcwIF7FoFgW2ccIOZOb33gKcuCcKU7yupjhFd608
	7yt9ld4C7j+hCok1lFwwxwnnKQoeRe4HLq66+Gw+5o1NrNW+o0qWsrwMjqkMEJ64BnkNBtTqGEP
	EzmQUO1/PPeJbNjM0O4MNnPnOw/D+YVURadxmRIPvh7
X-Received: by 2002:a17:907:e143:b0:c26:2fae:afdd with SMTP id a640c23a62f3a-c262faeb770mr576416566b.22.1788787549714;
        Mon, 07 Sep 2026 06:25:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm476261166b.15.2026.09.07.06.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:25:49 -0700 (PDT)
Message-ID: <d09ef622-1398-4e38-8a04-8542e7347a98@gmail.com>
Date: Mon, 7 Sep 2026 14:25:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence is
 done
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 04/09/2026 16:51, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> The apply backend of "git rebase" runs "git maintenance run --auto"
> from finish_rebase() once it has applied its patches. The merge
> backend, "git cherry-pick" and "git revert" do not run it when they

     The merge backend which is also used by "git cherry-pick" and "git
     revert" does not run it when it finishes.

would be clearer to me

> finish. They create their commits in process, and only the "git
> commit" they spawn for an edited message or a resolved conflict, the
> "git merge" a "rebase -r" spawns and an exec command start it, in the
> middle of the sequence.

Like Patrick I cannot understand what this is saying, let alone whether 
it is saying anything useful.


> Run it where the sequencer finishes, so that every sequence ends the
> way the apply backend does, and so that the next commit can keep it
> out of the commands a sequence spawns.

     Run "git maintenace --auto" at the end of all sequencer operations,
     ...

would be clearer to me

> diff --git a/sequencer.c b/sequencer.c
> index 65afd100d9..67e1c38762 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5313,6 +5313,12 @@ cleanup_head_ref:

This makes me think we should change the fragment re for c files to 
exclude ':', but that's a digression and would mean having different 
expressions for c and c++.

Anyway this change is at the end of pick_commits(), just before we 
finish so looks like the right place to call run_auto_maintenance()

>   			return -1;
>   	}
>   
> +	/*
> +	 * We ignore errors in 'git maintenance run --auto', since the
> +	 * user should see them.
> +	 */
> +	run_auto_maintenance(r, opts->quiet);
> +
>   	/*
>   	 * Sequence of picks finished successfully; cleanup by
>   	 * removing the .git/sequencer directory
> @@ -5577,10 +5583,14 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>   			res = -1;
>   			goto release_todo_list;
>   		}
> -	} else if (!file_exists(get_todo_path(opts)))
> -		return continue_single_pick(r, opts);
> -	else if ((res = read_populate_todo(r, &todo_list, opts)))
> +	} else if (!file_exists(get_todo_path(opts))) {
> +		res = continue_single_pick(r, opts);

It is a shame the single pick variants of "git cherry-pick" and "git 
revert" do not share the same code path as the multiple pick variants. 
continue_single_pick() runs "git commit" without calling 
run_git_commit() which is also unfortunate, but means that we could just 
rely and "git commit" to call run_auto_maintenance() for us.

> +		if (!res)
> +			run_auto_maintenance(r, opts->quiet);
> +		return res;
> +	} else if ((res = read_populate_todo(r, &todo_list, opts))) {
>   		goto release_todo_list;
> +	}
>   
>   	if (!is_rebase_i(opts)) {
>   		/* Verify that the conflict has been resolved */
> @@ -5698,6 +5708,8 @@ int sequencer_pick_revisions(struct repository *r,
>   			BUG("unexpected extra commit from walk");
>   
>   		res = single_pick(r, cmit, opts);
> +		if (!res)
> +			run_auto_maintenance(r, opts->quiet);
>   		goto out;
>   	}
>   
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index cb5c3a1cb5..2c34cf8a01 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -395,4 +395,12 @@ test_orig_head () {
>   test_orig_head --apply
>   test_orig_head --merge
>   
> +test_expect_success 'rebase runs auto maintenance at its end' '
> +	git checkout -b one-exec main^ &&
> +	test_commit F4 &&
> +	test_must_fail git rebase -x false main &&

Do we want to assert that we don't run auto maintenance up to this point?

> +	GIT_TRACE2_EVENT="$(pwd)/finish.txt" git rebase --continue &&
> +	test_subcommand_flex git maintenance run --auto <finish.txt
> +'
> +
>   test_done
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 5777dff496..304981ccd6 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -721,4 +721,14 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
>   	test_line_count = 4 commits
>   '
>   
> +test_expect_success 'cherry-pick runs auto maintenance once it is done' '
> +	pristine_detach base &&
> +	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
> +	test_subcommand_flex git maintenance run --auto <single.txt &&
> +	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
> +		git cherry-pick anotherpick yetanotherpick &&
> +	grep "\"child_start\".*\"maintenance\"" sequence.txt >maintenance &&

Using test_grep here would mean we get some useful test output if there 
are not matches in the file. Without that test_line_count just says the 
line count didn't match and prints an empty file.


Thanks

Phillip

> +	test_line_count = 1 maintenance
> +'
> +
>   test_done

