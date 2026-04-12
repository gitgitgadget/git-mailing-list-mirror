Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FD3264CA
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775994709; cv=none; b=MSEuZlNCaHA/MOCjXFSVwDpOnwCJtGJBgFjuQSITnzrBnTJKkVLar+zY9tLzddSiFREnLNHd7YbW72gt2KgdKuubR6y9rQiUaZX0BsZDKMjR7vhjZM/+OWcMYdyzNW+ssxNurLcbjY8R6sbFYiyvh9/tPw8B2SjSgevRT4mBkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775994709; c=relaxed/simple;
	bh=CJYlwvBSaXWNJAMLA8xwl4AehJkQvQl0XT4Oy7/AogM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lwhVkU2DfRBZdCmlvsfVJ0RcWkSWgYuVuL76nso9DTLoxLJSZVj6s8XNHBFNAE4ybnnG5JoNjdu8PfLLh3Z8484WLECnycHtRJpNAQQc8UwnriygJ0cgYI+pcLEEysOiwdaLq69/suoOu3TlTyLcKUIuTu2gjw/Vp3wUmjVQE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1iMjgB+; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1iMjgB+"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d7bdb5ffffso1897794eec.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775994707; x=1776599507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hfRtx+dLCnDTKZ3xyO/gweSItxOHjbs1V+Pp6aCMmw=;
        b=N1iMjgB+xA5NQT8BoI3c5bvT5G4mvaY2I1TD1u8u2GzIwEsaY55VHsqrhV2r1YfR33
         1RloRvA7lirYFEfq3nlUZFsELIxG3ySp9XZLu01spah1RNGzxQ3OHiSn2gGolEEfhnDC
         dWJ1X0qIGjmdZySmUCtGYssQjZBNZ/q+hu6j+Xrov40aaSafI8MFKIbtkCwyxqSzYA6b
         L4l5xtjBzSzDnMBwMcLUo97XM/4qjTyT6vUUaV9Z6M6Qj9Mf6YAkv/pC0GXRrm6FFyC1
         7PvFcpDv3yQSaBI1J1exZai9LGrDjWkaANE4nyklx7VrQd01nKvt1BYfnQWQ3JQTA/4b
         E1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775994707; x=1776599507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hfRtx+dLCnDTKZ3xyO/gweSItxOHjbs1V+Pp6aCMmw=;
        b=rjVauLxP7oMHiW3oPlLSuaPjI2GeM0nhMfFuswQ30/wKldpSRhEzJe1P9DxqeYHVxy
         rhJAWJe0yYCXW7OEbvdQbULtSaXC+dMzCC1MuKwAQc9OFcj17UMBjwVT4u4OJkxibFn1
         qNcnJeiVy02ucQVwEPJR0fXFZ79VOH14Fn5f3YKL1vBrKRTRXiJtM9tXL0KX+hGl02qa
         zEGav7gPghxKgP0YxWK9RFL/5vzY31c6Lzo31vMvunwWthXGBWUszmRT6MPCsBlHZRkl
         PeUPaPDcm33W2YB0PvDhjGGo0m8KrAKkpUywgbrOgibywvWqg9bt0l8n6LoIwwAH+sLD
         LaXA==
X-Gm-Message-State: AOJu0YyOmRbc0yie6+W2mQAgHJKmUUiDIrEGUQZ+kpnOFh2gSnxw06EE
	XreNNsAgptdQ1ZH/RytEocIYRoJlUCu+VvdDk34kyGxm9xayYdUmDN1m1Hpmfw==
X-Gm-Gg: AeBDieszhqnly9AJCCgjG0Of79KLFymcoblrNWQ7tKDCYmtMlCnK7AFsNc1aTzcDfYk
	jFArDbFf5bcSH5FR3F+mmefbYQrEiFnEbg5JZRlKePrZ2CWkx3/51a+EeBUp4SxGr6ImrMOlMO4
	YEgiKycBcXYUB2HwEW5v0OARQ7fASnTtlI9RSt096WnheU5PeI0znyPugGjrAG+ckIBHn/6p07P
	vIbZFz86BUZK6mrdaYqf3/bYu3xBImQRs8eZm5OS8RyDq4rbAyMO+v8nEhpI2yHJoQM2wRcXOr3
	NpKtxDR+8eMBfJdRz4hWKUJkPcpis+hCDWio5TtFZwjn0MHYAhloG3YFXaqKGmVD0IE+MUM4Z6Z
	H7xkhrNIMK3hWHh4y82RLJb8VFs8bDOw3n/61xa3p35KO/50+ZsXDXqBbIifO3M3PtJjxWZrYW0
	rqByWo5LZ+cB5u4zwno9A63WTRWNrW0xvf9Ap5nps=
X-Received: by 2002:a05:7300:7b86:b0:2c5:ed1b:ca9 with SMTP id 5a478bee46e88-2d586ea9a58mr6549771eec.1.1775994706975;
        Sun, 12 Apr 2026 04:51:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d5e43sm11850674eec.21.2026.04.12.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:51:46 -0700 (PDT)
Message-Id: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
References: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 12 Apr 2026 11:51:41 +0000
Subject: [PATCH v10 0/4] checkout: 'autostash' for branch switching
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>

Harald Nordgren (4):
  stash: add --label-ours, --label-theirs, --label-base for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 +++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  33 +++---
 builtin/checkout.c              | 138 ++++++++++------------
 builtin/stash.c                 |  32 ++++--
 sequencer.c                     |  67 ++++++++---
 sequencer.h                     |   4 +
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  29 +++++
 t/t7201-co.sh                   | 195 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 14 files changed, 455 insertions(+), 157 deletions(-)


base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v10
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v9:

 1:  5d5dc1f60e = 1:  aa519c50be stash: add --label-ours, --label-theirs, --label-base for apply
 2:  a1fa04a965 = 2:  8173a4eb72 sequencer: allow create_autostash to run silently
 3:  87216a633b = 3:  f36fedd8c2 sequencer: teach autostash apply to take optional conflict marker labels
 4:  00e0b3196c ! 4:  b6e5546d74 checkout: -m (--merge) uses autostash when switching branches
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		if (ret && opts->merge) {
      +			create_autostash_ref_silent(the_repository,
     -+						   "CHECKOUT_AUTOSTASH");
     ++						   "CHECKOUT_AUTOSTASH_HEAD");
      +			created_autostash = 1;
      +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		}
       		if (ret) {
      +			apply_autostash_ref_with_labels(the_repository,
     -+						       "CHECKOUT_AUTOSTASH",
     ++						       "CHECKOUT_AUTOSTASH_HEAD",
      +						       new_branch_info->name,
      +						       "local",
      +						       stash_label_base);
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +		git_config_push_parameter(cfg.buf);
      +		strbuf_release(&cfg);
      +	}
     -+	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH",
     ++	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
      +				       new_branch_info->name, "local",
      +				       stash_label_base);
      +

-- 
gitgitgadget
