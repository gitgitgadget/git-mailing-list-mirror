Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872D204F70
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151464; cv=none; b=qQibcuyvQ3VncXyIN+5fRPHHAaZvimscEQUfU+UUuOBLJcAdt4Lq6mV7ssKsvWxDMHjfM3theC2cgqjuiEjoCpEQ/zM0awczQG3+q9fAiEQtGlco9uOoiihOATOYfiqn/YgDSePx1u8X/SgG/EUsxMM5dBNJ4d96pxw5YaQPaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151464; c=relaxed/simple;
	bh=E4PJty25nuMk87tWBp3zbXsM1Z91RplNryyjLVrgbas=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gXAq5y/Ekgjcofola5WAgNMrzGgWy8N7Ob+ts2WLRbIsdtbvhMti0XlTYdH0VdNTqcLaylxWN+32gmoIh3O7R2Rfm0NapHaBwy/Es3l+dz5vKsa2N8j9Mcm2bBQdJGcnok0vEMvNpRCDk5Kj7wGTaqjhGG5clk1kjmIg1LKspKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuagIfvL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuagIfvL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso40200545e9.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151461; x=1733756261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBtzfBnBB34PIk3dAjBDNsBnsie+BEjttqZAad3o/V4=;
        b=PuagIfvLPOzmjr2Of9t6jvSuczfWUJN816uXeDDujli9zV6AdGzJnKLyrTkKctLU4Q
         4zm0VucxkwEYMLef6AIlyg567kU2+FELfjWsOZJNCYGFreH+DPSDZGaSwqfmHOOADRrd
         Hg1sFox5T7YkCY8yfbzgIycDY71nnV05N/uP9xowf8CKd1uWTLRvPL56t6GaQP7/V0+l
         wQ+WEKaTCooH2JY917txFJvd17xs8cjg4RjXWs/gOFfjE5b8hjF7+PPCEBguDKYDwHQl
         VAmNYw6DtgwFWQtJNJKmnapf9lOw4rAajEwywVV6bw3UorOV6AbN1VdSlhvyocioFsB/
         AcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151461; x=1733756261;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBtzfBnBB34PIk3dAjBDNsBnsie+BEjttqZAad3o/V4=;
        b=bYB9C0NSE/d7O8cgUo0uUkkdwTkn7ZXm3tnGftR7qyj4LjMEK8t1uiHzZQJzEINMBX
         NgksCezg9yxoE+XnYH9E7ogl1mAqCooD3+k8RNh2r3x+W9t/JFdbXWJ/Nt/N2+T8GHK2
         ECsTOuHl0ks8tzBYzVjMHjuBva40rPDW7z33TcXiWm85PgpjENY8Swdq5A6fsXClO8WE
         lsmCW9Dmykrk0KKtgiXESWD/DXi2xce8K5HsITGzRFQOSN2s7NL9WwBEf3l8lnOl+0h7
         pcrZ4wimay9LkF/mFsOD19Zh0G14ipq/CVmPYzZlHKXOp6n8N7OrYLdd+t4c3CXYoANJ
         1KWw==
X-Forwarded-Encrypted: i=1; AJvYcCXR9BB9veyDHDUlMMI1a94QWrZbccOWURaIcQX7dTg5hjEtvoZf/xZbOfKY4ULmseUpul4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOzXLnOdQkNmhfNmV5XRMmwvDzf/DGYDFNh12Yj/n0NXlEXwg
	RT9vYgNiLyUuc7s11/Dx5cQd0xAEuHRzOgSNK24XAUpPIqRC3Yvw
X-Gm-Gg: ASbGncsSRBOGU+wfg1MVPdH3AGgCW9YU1e6mSjwA1/YRG2GxCkj2W0LyMG4MH3Nt/Sf
	HzrmPz4sIkdho0r2MQIZlgMSW70ABEY1ijXI8s4D1+VleiDroJnlPt0XXUddfEBGqkNOH30llKO
	j+8rwlhsmUR1yX4CA5/v8vzvelEJBf1N1X0JEMHm3YoIDupnqE+uhyfB4Njtnl3FqSAxGZpj//M
	RVIgHGW4npXBFWYONko2zTXOfHhB9V5zMstyJP7GFzVj0SZEmwT33EZAw3cteXc8ejXSVpILGtG
	ni6zVcA4b6hqyBU4mLx74yYx16w1
X-Google-Smtp-Source: AGHT+IGPvdENF5vm2owveYxdPuoGQshmsDV2Rsabg5QvKUTGavQdTE8j2pH+42rY7/qyhVsdw2E+/g==
X-Received: by 2002:a05:600c:4f92:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-434a9d4f4edmr222513205e9.0.1733151460640;
        Mon, 02 Dec 2024 06:57:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b? ([2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc6352sm155150655e9.21.2024.12.02.06.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:57:40 -0800 (PST)
Message-ID: <103c7a4d-a74b-4381-a9c7-33a89d5db192@gmail.com>
Date: Mon, 2 Dec 2024 14:57:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/8] Allow relative worktree linking to be configured
 by the user
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
 <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
Content-Language: en-US
In-Reply-To: <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 29/11/2024 22:22, Caleb White wrote:
> Changes in v6:
> - Re-add test for extensions.relativeworktrees config setting
> - Link to v5: https://lore.kernel.org/r/20241125-wt_relative_options-v5-0-356d122ff3db@pm.me

The range-diff below looks good, thanks for working on this
I think it's ready for next

Best Wishes

Phillip

1:  0986f98022 = 1:  d897f2c16d setup: correctly reinitialize repository version
2:  c36e1a59fa = 2:  1860ba1a2a worktree: add `relativeWorktrees` extension
3:  5b19b63040 = 3:  5976310916 worktree: refactor infer_backlink return
4:  ec143ae00e = 4:  4dac9e3c01 worktree: add `write_worktree_linking_files()` function
5:  237206b08f ! 5:  b7016344f1 worktree: add relative cli/config options to `add` command
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" with initialized submodule,
      +  git init repo &&
      +  git -C repo commit --allow-empty -m base &&
      +  git -C repo worktree add --relative-paths ./foo &&
     -+  test_cmp_config -C repo 1 core.repositoryformatversion
     ++  test_cmp_config -C repo 1 core.repositoryformatversion &&
     ++  test_cmp_config -C repo true extensions.relativeworktrees
      +'
      +
       test_done
6:  8e4307f520 = 6:  298d2917e2 worktree: add relative cli/config options to `move` command
7:  4f951f4088 = 7:  e6df1ee2c1 worktree: add relative cli/config options to `repair` command
8:  28eb7f66b2 = 8:  2037ca85ad worktree: refactor `repair_worktree_after_gitdir_move()`

> Changes in v5:
> - Added docs to `--relative-paths` option.
> - Added test coverage for `repair_worktrees()` and relative paths.
> - Move `strbuf_reset` call in `infer_backlink()`.
> - Cleaned up tests.
> - Slight stylistic changes.
> - Tweaked commit messages.
> - Updated base to 090d24e9af.
> - Link to v4: https://lore.kernel.org/r/20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me
> Changes in v4:
> - Fixed failing test in ci
> - Link to v3: https://lore.kernel.org/r/20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me
> Changes in v3:
> - Split patches into smaller edits.
> - Moved tests into the patches with the relevant code changes.
> - Removed global `use_relative_paths` and instead pass parameter to functions.
> - Changed `infer_backlink` return type from `int` to `ssize_t`.
> - Updated `worktree.useRelativePaths` and `--relative-paths` descriptions.
> - Reordered patches
> - Link to v2: https://lore.kernel.org/r/20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me
> Changes in v2:
> - Fixed a bug where repositories with valid extensions would be downgraded
>    to v0 during reinitialization, causing future operations to fail.
> - Split patch [1/2] into three separate patches.
> - Updated cover letter and commit messages.
> - Updated documentation wording.
> - Link to v1: https://lore.kernel.org/r/20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me
> 
> ---
> Caleb White (8):
>        setup: correctly reinitialize repository version
>        worktree: add `relativeWorktrees` extension
>        worktree: refactor infer_backlink return
>        worktree: add `write_worktree_linking_files()` function
>        worktree: add relative cli/config options to `add` command
>        worktree: add relative cli/config options to `move` command
>        worktree: add relative cli/config options to `repair` command
>        worktree: refactor `repair_worktree_after_gitdir_move()`
> 
>   Documentation/config/extensions.txt |   6 ++
>   Documentation/config/worktree.txt   |  10 +++
>   Documentation/git-worktree.txt      |   8 ++
>   builtin/worktree.c                  |  29 ++++---
>   repository.c                        |   1 +
>   repository.h                        |   1 +
>   setup.c                             |  39 ++++++---
>   setup.h                             |   1 +
>   t/t0001-init.sh                     |  22 ++++-
>   t/t2400-worktree-add.sh             |  46 +++++++++++
>   t/t2401-worktree-prune.sh           |   3 +-
>   t/t2402-worktree-list.sh            |  22 +++++
>   t/t2403-worktree-move.sh            |  25 ++++++
>   t/t2406-worktree-repair.sh          |  39 +++++++++
>   t/t2408-worktree-relative.sh        |  39 ---------
>   t/t5504-fetch-receive-strict.sh     |   6 +-
>   worktree.c                          | 157 ++++++++++++++++++++----------------
>   worktree.h                          |  22 ++++-
>   18 files changed, 334 insertions(+), 142 deletions(-)
> ---
> base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
> change-id: 20241025-wt_relative_options-afa41987bc32
> 
> Best regards,

