Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9B3ED131
	for <git@vger.kernel.org>; Thu,  7 May 2026 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158277; cv=none; b=UuybPWk4p9vffmdULNGaHBWqLsGOepaN/kqBH/MlbA1q/W7qsfg/tJpIFsU4Hn+tZBXD+cQJiWWqAcFm5nXRf76z8lMkImYIs+9gothAlwT6QXb1bJL2F8VuPlRIcM16nRP4ibAE4FIY33FW23CtmjAmRSK1CZxAx8X9Zj9LVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158277; c=relaxed/simple;
	bh=eWqj16H3IdKBGWA7Pp1e60/vl1mfLTtCqdYLhBQi5IA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h65+7U4V3mZ/ij8nKGZEmz9P7JXPkRKFTFwv8zgdRWk5VpandjHntZJkcLbkmOMPhqZQlp7VMSr07CFIS9lecjNpTcoY+gLQgkIqKwcFEP7VjQoby0Ove1IutENBQiW0shgfAXEaFYeXWGgNtVTDOvYSLKc+9029CGYAVPCI5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWarmnoy; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWarmnoy"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so7874996d6.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158275; x=1778763075; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDqvI4TqArnaMKehAwOaVPq1hNTGxn79JDiCdXiU0n4=;
        b=IWarmnoyDckfn5W25YNTE5n8l6fHCFXfJjlQoD1ZfCfMltbfb6Ch8uNa2cXch6SRtj
         RiRlmAFQtlPwiQhsDiBHwCmhCZtvFPnMajhpP/nIat7YeeSuyU1iTokzBVoySQoDdBlL
         Mie4hPVLxb5sFj7LugMGnnbi0hBJjpC+mslhLa6EnnDqvk24XRgWXu63wZXKWX0P+k65
         PPQV4zbDiGf4/LhXBhPzWIzihKjEDs6HsZJmTOHyi/w+bqrniIzkmY/BaQNSWNOkL5ZI
         6OqyCZuNtSqCpf9dTS0fnexVjoRG7yP4/DVdnNP5W4zq8yOIz3WAjRCQOR8+Orz1pORR
         veeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158275; x=1778763075;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDqvI4TqArnaMKehAwOaVPq1hNTGxn79JDiCdXiU0n4=;
        b=STVSXRt/7Rf0n67FQqs1rl8ZVD7mkf03W4gJKwuMRXm0YsGgzFO+95h55Xod7H0K7O
         dadXZXtLRmr5bXeJuKDMkDLGUMiDPc6IIim64yUnO/KvS6ePs77GiQxiYa9Qpddo5iFU
         1XEt6y6jACJ/f/WbIjVrU6d0ZQ6ZrdypmfDxHaPrsvriIYpRwMPV2tV84QW88xD3q4zS
         niy9cQYOpvSPqgAOoONRlHaItAU6iL43bOaW+zrOIf0W0IesbL2U7UTHctrcGHAWZnRm
         C7mzDWRQyVfM8kFbrsKIHpJQqkl7VSCCZmpM8WBHAWWRDfAjEmwSVpEZfLERVn1hPdhu
         wuiA==
X-Gm-Message-State: AOJu0YwaIab2RrCgW1gZyIJkdcYPYk/6Pb6iWUDSdlmSDCI+qryNjv4e
	1x7tUtsHPlgdmYTjSSY0cJrHxKgeURCxr/4waHyLjI9UB0TRdFAAI5FjwnwYwg==
X-Gm-Gg: AeBDietozNgDyHheIBrR1g99AurKqN3QM3JoX+uTo9haTFyKwC6V6sk8D6TnhrVLLwD
	RwvxlAGQIut3TRFPJWWUMBJzD+5K5sVjP9+NUmH5ZjTPqO0DvWGVbjn7xFCovw2DhR/G8jyP+ks
	YAnvQB6LC9rzUo42wD30E5iNhYKqgPV3tfiX0C1dH7prO/WYBDIWAYM06VscGPG+4D4/EFxNu+m
	CvLnWJi8SMJuf78fVWdxO7viFehme5izqOcg3wo0AKzx2M5XKpkQNMrdKIPrYfsnTTdKpMc0rmB
	FZ8hLeX/G8iLDaaf76oJitW9zrBcSXCJzg4hau16iV8YXUxpd0vsurfTO6LVucQohB+u5XHsr9k
	A016Mf8GLxUfEgieSabcrkrSdBbsld6SL4mHSx1N8/SBHXWr0vMoxmAbLIagFwn50BorK2koNHn
	NDGLoXgRRwAGdNFXGeGhR90jkFIoT6mVvhVNZAp2M2HCNOzQ==
X-Received: by 2002:ad4:5c8b:0:b0:8ac:aaac:4034 with SMTP id 6a1803df08f44-8bc454650d4mr110438106d6.29.1778158274869;
        Thu, 07 May 2026 05:51:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm208208006d6.21.2026.05.07.05.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:51:14 -0700 (PDT)
Message-Id: <pull.2103.v2.git.1778158273.gitgitgadget@gmail.com>
In-Reply-To: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 May 2026 12:51:11 +0000
Subject: [PATCH v2 0/2] maintenance(geometric): avoid deadlocks on Windows 10
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
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, maintenance_task_geometric_repack() opens pack index files via
pack_geometry_init() (which mmap()s the .idx files), then spawns git repack
as a child process without setting child.odb_to_close. The parent's mmap()s
prevent the child from deleting old .idx files.

On Windows 10 builds before the POSIX delete semantics change (between Build
17134.1304 and 18363.657, see https://stackoverflow.com/a/60512798), this
results in Unlink of file '.git/objects/pack/pack-<hash>.idx' failed. Should
I try again? during fetch-triggered auto-maintenance with the geometric
strategy.

The fix adds the missing child.odb_to_close = the_repository->objects line,
matching all other maintenance tasks.

The first commit introduces a GIT_TEST_LEGACY_DELETE environment variable to
simulate legacy (pre-POSIX) delete semantics on modern Windows, so the
regression test can verify the fix even on Windows 11.

This fixes https://github.com/git-for-windows/git/issues/6210.

Changes since v1:

 * The code now uses git_env_bool() as appropriate (thanks Patrick!)

Johannes Schindelin (2):
  mingw: optionally use legacy (non-POSIX) delete semantics
  maintenance(geometric): do release the `.idx` files before repacking

 builtin/gc.c           |  1 +
 compat/mingw.c         | 47 ++++++++++++++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh | 22 +++++++++++++++++++-
 3 files changed, 67 insertions(+), 3 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2103%2Fdscho%2Favoid-deadlocks-in-geometric-repacking-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2103/dscho/avoid-deadlocks-in-geometric-repacking-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2103

Range-diff vs v1:

 1:  97508e91b6 ! 1:  8ee749dd2f mingw: optionally use legacy (non-POSIX) delete semantics
     @@ compat/mingw.c: static wchar_t *normalize_ntpath(wchar_t *wbuf)
       
      -	if (DeleteFileW(wpathname))
      +	if (use_legacy_delete < 0)
     -+		use_legacy_delete = !!getenv("GIT_TEST_LEGACY_DELETE");
     ++		use_legacy_delete = git_env_bool("GIT_TEST_LEGACY_DELETE", 0);
      +
      +	if (try_delete_file(wpathname, use_legacy_delete))
       		return 0;
 2:  12ebd5c56f = 2:  66219b79fa maintenance(geometric): do release the `.idx` files before repacking

-- 
gitgitgadget
