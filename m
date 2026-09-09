Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810D47F795
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968417; cv=none; b=NK08xAg5DOea3fULExsuC4z95pRVi0D9JnmUW0FAnLMLhgeoqYY5NBllQzKxSKVMkoZW1slGC8DCsnwcBzd5Cg44vE0wkU+XAf7OhMlueqBNXc9v8B5h3l33mOiDQzENa+77eteH9KawLN8+INsC06AtIDkZ98WTXFuF7dn9qO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968417; c=relaxed/simple;
	bh=aNTEtdncykOZZY2LdFgO8ReRTRGakNBVvANPNpZNFhw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hdcYQoCdYjFUS/KdZGn7AtZD2iC+GOMyCw1czIhc9A2pRn1neXy1ucutDDMJjcEgixfKskNFrG5L7xZvUwwZ0UkSQAxfE4T26dRWB/iy/mZe3XEufRv4kCwfDdpqnGc3mPPHdUU7fosCGDp7L6DUO9vrDmEpwLpv0sED0mBMd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHmuxfIh; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHmuxfIh"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b5607bd3b5so3803070e87.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788968414; x=1789573214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jfzySJgMfLUzULBzCnRkNDyIxxnPBiiozcvfxjvHmw=;
        b=MHmuxfIhispJuvYC4FZNhy3vRilF/wYUJGgLuCvQ20Dw38PodEWOkAKhspQlrfPXSs
         Ki9zB9c8CPGFPODmgkGI/g3pgShnh/iArS1VhjapkJlpxtxqyPn42IPAjmOOkoHf9GDU
         l4Xq9rmZOZ5B6loPtM8lv13xKWk5ubpXUsGJAK6fKiLB+LxRJWbjL9qKNyEwOFOE9DDV
         ucz0iEANCr/vAQcvaKTRgMMAzQ9+vswJSwbWJ3UviNDnZqWyMTSIUUijp46SS8bduAEO
         jK2SJgDQcVA0sMx6uPEkNXzWfTfNwkKT+SbIabqIsdPD4CHMxgVnBerQ5vub7Lgq+sj9
         vl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968414; x=1789573214;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jfzySJgMfLUzULBzCnRkNDyIxxnPBiiozcvfxjvHmw=;
        b=XTslyDg48peMC7OAfooccJqePsvRRr0fWwjm/zdyWNy2pDEvp5GrLSssMexSK4Xs30
         ooPwrqqhrkjOIX5RJnTwuUiPKEoghhlrv0XNYj9zFVSqTHKWXhb6YlSqUEZ2ZoQv96NX
         A/DMKG62nS+/OXID34reEzXcvaiwxZGbkUuq+n2BWrxrFlu8rE6o2GOFziEj8oZ/eaK0
         xFbb0CuXFeNyc20+xLQtLA9EGqxAtQ1JV4Ic/kA0AbGNhOgyFnUcVqrqa0IdpOFMNQcp
         ySVBvz7JqIkt+T1OIr3QDmrh/B50g2M8Uv5NHCMSwcVFFyFEEbg48Boyb/O2sfuMTW3Y
         XxCw==
X-Forwarded-Encrypted: i=1; AKwUvBzisDhEWtnsngb0jiMo3WqZi4NHjeoFx13BlecgF39JsNeEs0JEOp8hjvh6juyYy0JseCw=@vger.kernel.org
X-Gm-Message-State: AFuF++mVhF2vCGnC3k349W44CYfaKz6ZqowtHLY/Mkjz9NdGv2dXVQAD
	Bc/sEMKZ+XpGJsyJyWtVhofD8/pbVI9SFUV83Qbh1kGkjSMgxvg7NYFY
X-Gm-Gg: AYBFou1OFE6whWJ49ENmT7+Jf7FLTB4ix0GOJdf1YUvtC5wgUmSBX74qNOi6Tbye846
	yYtjU0iexCqcKoZJ7MqzCd0S4a1GNRBJE1TW6C+lslWpLgdiJjnORicIJzO8052Vu81uYNSzmcf
	oULIwXwDYTVoup/PNMl21QsRrIxLPJcWbaGYJEbVIIHNTlmU8+/RtrkSAeV2+owAq0uy8Zw76pz
	5IOhxtojDE3UeUjEuaHJzi2MHiu9EP4COHhzKFfGkuHk1dRR4XR0Mp9ZSxMuNZE+uueLqduXB6g
	MSRafkkTH1G54ayyGGdY/yiFhpOftmovDNCeOoEC895fTaBoLod9KpXuvPMPkmaA+AbpAOleMOE
	ejgVll5U9xbPzhZjCw65s5yT2wjZWDWoSZrDyDHg4NymHPhI+mMKtoZrUeW1YZWoObIxGOhtuX2
	VTlXnK8leYmqMEjwnL7yXJCvFSZVqHhp/loYuYFFtb3ULWY1BCtR30XZICr3uzVBXdyiCX3v9xc
	/4XQdYx/FQdjfxtlg9SJ/0r2+IUPG9HJASwWkF9jhKy6CWDppKOHw==
X-Received: by 2002:a05:6512:304d:b0:5b7:674f:caba with SMTP id 2adb3069b0e04-5b7674fcbe8mr989277e87.13.1788968413693;
        Wed, 09 Sep 2026 08:40:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166fcdf9sm3846748e87.46.2026.09.09.08.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:40:13 -0700 (PDT)
Message-ID: <cd3d98ef-ad80-405d-98b8-fc40e7c5ec9b@gmail.com>
Date: Wed, 9 Sep 2026 16:40:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/3] sequencer: disable auto maintenance in spawned
 commands
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
 <031b3bd498bd5efee7e0d9752a6dd36fe7a55360.1788942331.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <031b3bd498bd5efee7e0d9752a6dd36fe7a55360.1788942331.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 09/09/2026 09:25, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> Sequencer-spawned commands like 'commit' and 'merge' run
> background auto maintenance, which interferes with ongoing
> operations (e.g. 'rerere gc' holding MERGE_RR.lock or repacks
> deleting active packs).

This is much more concise, but still sounds a bit strange to me. I'd suggest

When the sequencer spawns "git commit", or "git merge", those commands
run "git maintenance --auto" in the background which can interfere with
the sequencer (e.g. 'rerere gc' holding MERGE_RR.lock or repacks 
deleting active packs).
> Pass maintenance.auto=false via GIT_CONFIG_PARAMETERS to the
> spawned commit, merge and exec commands. Appending it after the
> user's own settings ensures it wins, and the environment reaches
> whatever they spawn in turn.
> 
> Auto maintenance now runs exactly once when the sequence
> completes. Commands run manually by the user while stopped are
> unaffected and continue to run auto maintenance normally.

Good, and the implementation changes look correct.

> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 025787b5f2..16def261b0 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -398,13 +398,18 @@ test_orig_head --merge
>   test_expect_success 'rebase runs auto maintenance once it is done' '
>   	git checkout -b auto-maintenance topic &&
>   	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
> -		git rebase -x false main &&
> +		git rebase -x "git commit --allow-empty -m exec && false" main &&
>   	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
>   	echo resolved >F2 &&
>   	git add F2 &&
> -	test_must_fail git rebase --continue &&
> +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
> +		git rebase --continue &&

What's this trying to check - there wasn't a conflict so 
commit_staged_changes() will error out without trying to commit 
anything. This series is looking pretty good now. Just to let you know 
I'll be off the list from tomorrow until the middle of next week so it 
will be a few days before I look at any new versions of this patch.

Thanks

Phillip

> +	test_subcommand_flex git commit <mid.txt &&
> +	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
>   	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
> -	test_subcommand_flex git maintenance run --auto <end.txt
> +	test_subcommand_flex git maintenance run --auto <end.txt &&
> +	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
> +	test_line_count = 1 maintenance
>   '
>   
>   test_done
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 2bea55c3b6..1e3fa1803c 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -723,8 +723,11 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
>   
>   test_expect_success 'cherry-pick runs auto maintenance once it is done' '
>   	pristine_detach base &&
> -	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
> +	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick --edit picked &&
> +	test_subcommand_flex git commit <single.txt &&
>   	test_subcommand_flex git maintenance run --auto <single.txt &&
> +	grep "\"child_start\".*\"maintenance\"" single.txt >maintenance &&
> +	test_line_count = 1 maintenance &&
>   	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
>   		git cherry-pick anotherpick yetanotherpick &&
>   	test_subcommand_flex git maintenance run --auto <sequence.txt &&
> @@ -739,9 +742,14 @@ test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence i
>   	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
>   	echo resolved >foo &&
>   	git add foo &&
> -	test_must_fail git cherry-pick --continue &&
> +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
> +		git cherry-pick --continue &&
> +	test_subcommand_flex git commit <mid.txt &&
> +	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
>   	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
> -	test_subcommand_flex git maintenance run --auto <end.txt
> +	test_subcommand_flex git maintenance run --auto <end.txt &&
> +	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
> +	test_line_count = 1 maintenance
>   '
>   
>   test_done

