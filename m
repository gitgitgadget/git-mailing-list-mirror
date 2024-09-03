Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59618DF90
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386050; cv=none; b=bjQualNfNMb1NO3ADRe61StZPpomVqiyM1y5OYRaiJIfCo5VrVEnj3r0Vf2TucngdM20VELiVLA4P+bQsgFBIZ1769Kgg9xHcnVlcO33b43BZfYKolbOkBtx1Ju8bkbDw1iR5m6VG5rnUiOuc2QLDLOEVg+C/rkNXIxdiEbInyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386050; c=relaxed/simple;
	bh=dwvZ3SEMNk8rjR18kh8tn24s16LIOEiM+a5eKWOcnRw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c5v6SPpmXQR3FPwE/cY1y8+ap+eI5TXb9s+Dvx5JsZlo4WcpTZj7pCXMPZYYqfTon2452rdUEmbJKv9xxlkoENPX2u7yZsZQP7+idmkCZukec7ZtSAXT8c6yuRdsT0Ty8JlPjanmGnTcoEIXElcz8DhzVfn6C0+c50CP4PY9ufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoQNP6Iy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoQNP6Iy"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so5376724a12.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386047; x=1725990847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjsILut70YgoN0tVRfOIFS+nHenJFg491LI07Lt+3Y0=;
        b=YoQNP6Iy3Xq6UZZgEyVBmhb6fsclL+9CDZyCh6FHX/zdUpBCz2pgb0vEP+wczI+vw0
         Mv0zLeey5AZ60XrJ3BgdVtMruOfXtI0ymthwsYVAG9hWZhuriOsH0jMfK7lyRzhP3dff
         ds4O595wkgmwImHPGhbEHY5FMFBjl12boexkJCDaxnoR7S/ifgw/7Vc/N4uBEEs2feZr
         a0ZYBRIL/gmDA0AxD4iIFhorXLm9FCWIezwfbQT0Vugx29Fx4Cb2HMtpPxH3PoBnlOu3
         khSCznZWmVVSeS+7uMiFL0Wdm9/ygAlNMXTaDCJPsmS16KPGw1syhhCFDsHFbkO4G/zP
         vlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386047; x=1725990847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjsILut70YgoN0tVRfOIFS+nHenJFg491LI07Lt+3Y0=;
        b=YjTNH0xtRXbrucV7slyrCxsoaB68BbUWkxNEMgeQcHdiO61DL52RSha7jiUNnryal5
         wf17kkTrmAwP+4rWI12ebpm4ikY6xU/TNFP+XNPDGEzXesC0bfseuM1w5ad1phvSukSd
         0iEdiwHKrzlzR1JEG8sz7SMDWCpt7SChgHiyOzHawBPH5xwr97JnNjA4xWQKB/ovfBgM
         AnomQ2SEglryMN3aH1MD77DKpCnTfFUdVjiUWWpvr/GMG1bPoM1bBdK+fGlY8q3ZIv1Z
         xfyjWWEnUK4yG6Mq/kwNOroSR9HKDNJE8SuvhL6D+NUGFghIz099+yK0901WfWbxDipM
         kbww==
X-Gm-Message-State: AOJu0YzX8ztKNf81RR1TwnumbEJzyFyGdWSD6eQmA/0RPtmj12hMkLxV
	QW6hSTQjCzQaLOTPy8VC2ztnXWBS3ISMPLA/f9Q0VELpbN/RKirZu2W+ng==
X-Google-Smtp-Source: AGHT+IE4KVpPz+XTT1wU2y/O3VVLiXH5bAtewSZozEyov1QmVUapbko9smq86k2moxRXf05X/uyZkQ==
X-Received: by 2002:a17:907:1c94:b0:a7a:b643:654f with SMTP id a640c23a62f3a-a89a358274emr1093304266b.15.1725386046058;
        Tue, 03 Sep 2024 10:54:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb25asm708156366b.41.2024.09.03.10.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:54:05 -0700 (PDT)
Message-Id: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
References: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 17:54:02 +0000
Subject: [PATCH v3 0/2] Mark 'git cat-file' sparse-index compatible
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Kevin Lyles <klyles+github@epic.com>

Please note that this is my first contribution to git. I've tried to follow
the instructions about how to correctly submit a patch (I'm using
GitGitGadget as getting Outlook to do plain text e-mail correctly seems
impossible), but please let me know if I've missed something.

My motivation for making this change is purely performance. We have a large
repository that we enable the sparse index for, and I am developing a
pre-commit hook that (among other things) uses git cat-file to get the
staged contents of certain files. Without this change, getting the contents
of a single small file from the index can take upwards of 10 seconds due to
the index expansion. After this change, it only takes ~0.3 seconds unless
the file is outside of the sparse index.

Kevin Lyles (2):
  Allow using stdin in run_on_* functions
  Mark 'git cat-file' sparse-index compatible

 builtin/cat-file.c                       |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 50 +++++++++++++++++++++---
 2 files changed, 48 insertions(+), 5 deletions(-)


base-commit: 4590f2e9412378c61eac95966709c78766d326ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1770%2Fklylesatepic%2Fkl%2Fmark-cat-file-sparse-index-compatible-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1770/klylesatepic/kl/mark-cat-file-sparse-index-compatible-v3
Pull-Request: https://github.com/git/git/pull/1770

Range-diff vs v2:

 1:  7067a4c5da2 = 1:  b310593aec2 Allow using stdin in run_on_* functions
 2:  a92825e502f ! 2:  f4d1461b993 Mark 'git cat-file' sparse-index compatible
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'advice.sparseInde
      +	test_all_match git cat-file -p :deep/a &&
      +	ensure_not_expanded cat-file -p :deep/a &&
      +	test_all_match git cat-file -p :folder1/a &&
     -+	ensure_expanded cat-file -p :folder1/a'
     ++	ensure_expanded cat-file -p :folder1/a
     ++'
      +
      +test_expect_success 'cat-file --batch' '
      +	init_repos &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'advice.sparseInde
      +	echo "new content" >>sparse-index/deep/a &&
      +	run_on_all git add deep/a &&
      +
     -+	echo ":deep/a">in &&
     ++	echo ":deep/a" >in &&
      +	test_all_match git cat-file --batch <in &&
      +	ensure_not_expanded cat-file --batch <in &&
      +
     -+	echo ":folder1/a">in &&
     ++	echo ":folder1/a" >in &&
      +	test_all_match git cat-file --batch <in &&
      +	ensure_expanded cat-file --batch <in &&
      +
     -+	cat <<-\EOF >in &&
     ++	cat >in <<-\EOF &&
      +	:deep/a
      +	:folder1/a
      +	EOF
      +	test_all_match git cat-file --batch <in &&
     -+	ensure_expanded cat-file --batch <in'
     ++	ensure_expanded cat-file --batch <in
     ++'
      +
       test_done

-- 
gitgitgadget
