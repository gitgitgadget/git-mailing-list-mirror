Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D41DA62E
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435466; cv=none; b=hKOZAlv79nPvEzK4OywAYXIKjDrfROMkNybqqi/K4qwJkmnPffTmQhgctQIaPhZ3xtZZR4GU8ImnIsCp0RJ+cl7/Iep7KqsiZXF7zgTmkTl1P4J0JFK+I1w8SHHjMcDhlGfbsWx5lL5bcvdgH/GZ2cIYXLk9rnuuB1P6aEeV6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435466; c=relaxed/simple;
	bh=cFDtxeli3Ebq8uNtuZUlfUKSx4v1zaniRXVfkaAiBGQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oIAQV4TvVorFLljrzCeEjS/wjnaFi51Fis/916Q/GhXq1N/JHehJNTu2IdpKIc0G2tI/81dSOJC/fvjwdlLx+vDMdaqjOEjutt5d+p93GgBRS8wGYsxZnFCdwTB17Ar3yyGFKuhm6tMKHlH8JtVBahjeegd+NC7FDe95YWEEX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVhKc9N1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVhKc9N1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so29088155e9.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743435463; x=1744040263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rn8Ew4NfHuvXIAfiQTerXOY5TmuLXSvGmYyyJ9J8aec=;
        b=VVhKc9N1az6d038ajr9pNNQELbQb47q6cllOcKdu4sfsqGBRqQU/0N/eYbSH6ll7mB
         k639cgz47GOgrgh6PEzlIVqA8X7EHgETh9KBWRBJykFLFsZnjODBTKYL7UQ11u+ppz/T
         A6QW64IgGonm5V2BSXV4X2sio9bOAzh1lQBcD0QBI3jyA3WJ62oPg34TtwjqKyg8KAIM
         mudCBPPQTEWIMzLsmMVtUXBMub/pLKyVSvsjJe68ZMAiovgnMqwjC27JGOTDpbZ9W/4t
         5qeRDvrzvprIaqe3j5xfKfpJ/wdFaW9nTOHH//iZm3wWzy7TmFlLQw/1xe/EwTFICd1F
         e+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435463; x=1744040263;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn8Ew4NfHuvXIAfiQTerXOY5TmuLXSvGmYyyJ9J8aec=;
        b=px6PSxtPdF5yBIONfuw1pT9rJe7NghSyn/8ZxPq8GJZRaK0QRWhRyCsvCuD2pnf7UQ
         ZgqPAoJRzhw59GYmvX4vwc2O5dj+pFsKi1ZLlPVSrAKP8/uaKFLJxu0xrbNZdZiUxDiH
         jpblRSpoWLEs+qDm4NC+aGHhrTam2SdeoZksrhMMgzR2u12jKWZaJZHbIQ4Kc3b3LJqI
         6o5K6iyFPqOrWwZbWXHeSxIPJoljUZyC3VqEvXj/ZVgJZPHJsJfsEyt5yHybjiQ/MLCY
         y5RSwbthfupmITerzSVrhyNCGaI3uSa+Om0q4hTwzZDhQfpKniItw08QoIhwTq3ZdcOz
         JjxA==
X-Forwarded-Encrypted: i=1; AJvYcCUrdi1C11NnnTwTlUb8hmuvem2CmFEUgMiqUnMawnSqBLFv62jMqeco7Xi74zZiVNApW/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxWebtlXBl094cS7pdxPKLo9eRbnjbUKbb5c1/jvcDZh7czq5
	d4M/zV+7jhyxMKegHgpADy5oUSTJXGH/QeG+jXtCAlgRiv6sOsjsxFeFow==
X-Gm-Gg: ASbGncuNQnEZF477GGI9kPZqUWRxj2A2VdxZV+5h8U0stOtXQSDwJ8zITovwaaDMhwI
	qhFhC2pxuN7YpDZGro+CT1bAwP2dRSWGSzkqlBWejNQYVmZz4LI1tKT3BWyNt9c7Ay0Mtho7FIe
	O2wy5fyGMGUqe44FGAXFFvsReQEIVTBAROiBO2hXDWAmFt+w2PJXwu3Q7TFI8+lMrv4wN18i+zo
	usvTDn9J6HG3q96WF41C6S0ADeNnzk27RjX+MOoTUEG2KTPjjshXTY+CcQpDtC5l0z8eFFuVQPL
	SBQX52OKMqOjduOUvWYS35CGdBUafXTUlqDPGcZBKbRjYz+bDoD1o96/d9oCSC1hGne9BWdAaZ3
	f0Qf0Sne6je+Ay5jexRBR
X-Google-Smtp-Source: AGHT+IFQaj7JfALiwo0ACZiGKdYFXbLMyowmEHLdf2tPe3ABP3p9dgYn5yfWGEf7AtX6yponfs7xPA==
X-Received: by 2002:a05:600c:198c:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-43db6289b35mr67276355e9.21.1743435463065;
        Mon, 31 Mar 2025 08:37:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b65b985sm11644143f8f.12.2025.03.31.08.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 08:37:42 -0700 (PDT)
Message-ID: <b0263bdb-002a-4a88-b277-fd2afe59cfe6@gmail.com>
Date: Mon, 31 Mar 2025 16:37:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/3] rebase -r: do create merge commit after empty
 resolution
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
 <6c8f77cb71c7e0c820704b1725331f4601d8876e.1743181401.git.gitgitgadget@gmail.com>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <6c8f77cb71c7e0c820704b1725331f4601d8876e.1743181401.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 28/03/2025 17:03, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> When a user runs 'git rebase --continue' to conclude a conflicted merge
> during a 'git rebase -r' invocation, we do not create a merge commit if
> the resolution was empty (i.e. if the index and HEAD are identical). We
> simply continue the rebase as if no 'merge' instruction had been given.
> This is confusing since all commits from the side branch are absent from
> the rebased history. What's more, if that 'merge' is the last
> instruction in the todo list, we fail to remove the merge state, such
> that running 'git status' shows we are still merging after the rebase
> has concluded.
> 
> This happens because in 'sequencer.c::commit_staged_changes', we exit
> early before calling 'run_git_commit' if 'is_clean' is true, i.e. if
> nothing is staged. Fix this by also checking for the presence of
> MERGE_HEAD before exiting early, such that we do call 'run_git_commit'
> when MERGE_HEAD is present. This also ensures that we unlink
> git_path_merge_head later in 'commit_staged_changes' to clear the merge
> state.
> 
> Make sure to also remove MERGE_HEAD when a merge command fails to start.
> We already remove MERGE_MSG since e032abd5a0 (rebase: fix rewritten list
> for failed pick, 2023-09-06). Removing MERGE_HEAD ensures that in this
> situation, upon 'git rebase --continue' we still exit early in
> 'commit_staged_changes', without calling 'run_git_commit'. This is
> already covered by t5407.11, which fails without this change because we
> enter 'run_git_commit' and then fail to find 'rebase_path_message'.

Thanks for fixing this.

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>   sequencer.c                |  3 ++-
>   t/t3418-rebase-continue.sh | 24 ++++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index ad0ab75c8d4..2baaf716a3c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4349,6 +4349,7 @@ static int do_merge(struct repository *r,
>   		error(_("could not even attempt to merge '%.*s'"),
>   		      merge_arg_len, arg);
>   		unlink(git_path_merge_msg(r));
> +		unlink(git_path_merge_head(r));


I think we want to clean up git_path_merge_mode() as well. Perhaps we 
should call remove_merge_branch_state() instead of deleting the 
individual files ourselves here.

> +test_expect_success '--continue creates merge commit after empty resolution' '
> +	git reset --hard main &&
> +	git checkout -b rebase_i_merge &&
> +	test_commit unrelated &&
> +	git checkout -b rebase_i_merge_side &&
> +	test_commit side2 main.txt &&
> +	git checkout rebase_i_merge &&
> +	test_commit side1 main.txt &&
> +	PICK=$(git rev-parse --short rebase_i_merge) &&
> +	test_must_fail git merge rebase_i_merge_side &&
> +	echo side1 >main.txt &&
> +	git add main.txt &&
> +	test_tick &&
> +	git commit --no-edit &&
> +	FAKE_LINES="1 2 3 5 6 7 8 9 10 11" &&
> +	export FAKE_LINES &&
> +	test_must_fail git rebase -ir main &&
> +	echo side1 >main.txt &&
> +	git add main.txt &&
> +	git rebase --continue &&
> +	git log --merges >out &&
> +	test_grep "Merge branch '\''rebase_i_merge_side'\''" out
> +'

I wonder if t3430 would be a better home for this as it already has the 
setup necessary to create a failing merge. It would be good to add a 
test to check that "git rebase --skip" does not create an empty merge as 
well.

Thanks

Phillip

>   test_expect_success '--skip after failed fixup cleans commit message' '
>   	test_when_finished "test_might_fail git rebase --abort" &&
>   	git checkout -b with-conflicting-fixup &&

