Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15935F174
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652095; cv=none; b=DOrdVQgxEt8PgvS+vZwwXdXFe6pkrUCpMaRe3Dxfcj/UCc8Ekb9EWpzMPH49JkoN45EpXXbbc2i1i2zPhMLQXooMwxXSyGxuuy9qjkLSYkhLRWEAJ6hu//D8BrOpYLXxI8Sa1H6vGRXIqFr4ZEF2szg2Sfa+M1oSrxyAonCzLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652095; c=relaxed/simple;
	bh=ln6oJmzk6uB8zK1GZq1y5GKOQSRnAmbyMdEPrxFArak=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mhBrE7khcdH7Ru51khxoRJy7lzWTUpwXLnLVdCmlOUxqR7ZGC5ko3bKQ+ooPGGWjUnAsMCOgLL8DwOQJbsmGipztbkTBxNCNFYDeDo1gKNpTvzmuq6lfyhNDtIb44RpA9euK+WqANbQKu9uFx+5YsOzB+47YukqQuVW2Wv9JAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6TU6ycY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6TU6ycY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cbae8f69cbso741974685a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 11:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652093; x=1773256893; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8cS5ACGPlRaod6CivyBe9R8hwe/aOdnSWpXK7CQVpw=;
        b=S6TU6ycYdqtKjT68+NTMCpzh4wtgJFZKQ76+6K291hTw2N0+JrIRd+oIHQJ8nASDPm
         v7bQCTXBJ3ra+oh264LCR/VZ0FZbXDpf3velxA5rhKhDAglpHi09pR0XN77FJMMB/QVU
         12iXC3fKXeiSP72jpzYK2Lhj7AaL44MdvB0osYwhsZvFqPWyQEBPS+9xBM1UOZLJwi5K
         qDzC+Xy4Rv4paHRGGAbkt5GLX0+HZaWBaUmrJ//1oTojtmHULJ9NCgS38XexvtOfe1WC
         BeDwt+eHt0UAmphxFK3hWqWmYLyiI9I+XVpIoiNXXX7bQdwzzmehGDUgCnBYB81AWIbP
         Qy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652093; x=1773256893;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8cS5ACGPlRaod6CivyBe9R8hwe/aOdnSWpXK7CQVpw=;
        b=Nak6WO8WiywNcZrpjz/VY+kwNsrGuRUJfCivBFxbcuNTw756Yw0QP7KFkBtB0GQugr
         lnruxKqHBTU6PM2MgAR3GJEmJ0v2A7qrUdR1TILij+WG+Ch/9kHg58D2F0UUN7hAe2rO
         SLWNNWd/Sogbs6zX0Eck6fkNpV0jCDD7jReEdBtuvemVbTQLBvwiTOw++643cpdfBCjS
         ll4NeCIyDREsy44EgD8PHAixwaS3h50GpjOmkokzdNS3/pmoAH2zIAQ3GNWIyGhc0/Ex
         g6fXgYEeyWY4meMmSSw5t76z5OM1QEtGAVS35a92PilgYl1ZaIBAdWmjTuWyMZ2tcchA
         +2og==
X-Gm-Message-State: AOJu0YyNRxaRHc3TvR5DyaJQ+neYK0GDQvtKPId5MNSVLHB/bnLT+29j
	EvOJDnDTE17SGB0KpM0PBbB67uc0KMgnzmFmmb/caBCyq/ol12tNLkGTV5qn1Q==
X-Gm-Gg: ATEYQzxmUiRACz/iLOUOGo8x2see7q9MJNDj++3SJUsgDYuOS6FWKfV+h0ASG76ZQqb
	ZfLX4b0rWm7JPz+pCTX5p8Cn72c0vkDoMi5y/878T58/J6Lwe9Pcxqk54aLD+JUxm33YVPvJTKy
	dc7ZTn6JpfmtE/0gp1p3b69HSrmI12SRbtKRpKcD4O3M0JD7ddDyQ7Pbfk8rAttTmdWl7D/48Lb
	HGO2HRgLzbdcVR+QH52s66nv5D1tiB5hRiSPlAJF1eqOsycYZ2SQeq53K3ODPNLPcy9Vv27FCny
	KcLgPWNTeTsSI0X5FG/ZpsEVcL6KPov2HGE8KZFqOA+K2EROOiyuKf7bjGOvFnA7LUZ8aHMDyUH
	jK0u2+xbwHnvhPx7QxSbQ7uRCp02P7Zjwd5ZAhbidEmCi5Lq0CvZDF/QlOvApXzOirUC1y/53Ef
	mdjx6CiY68xcA8Z5beQ6w2WtrYj9jHKrdq/w==
X-Received: by 2002:a05:620a:450f:b0:8cb:5566:c947 with SMTP id af79cd13be357-8cd5093be5bmr833669385a.17.1772652092785;
        Wed, 04 Mar 2026 11:21:32 -0800 (PST)
Received: from [127.0.0.1] ([52.150.28.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716cbf5sm186496616d6.16.2026.03.04.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:21:32 -0800 (PST)
Message-Id: <pull.2061.v2.git.1772652091.gitgitgadget@gmail.com>
In-Reply-To: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 19:21:29 +0000
Subject: [PATCH v2 0/2] line-log: fix -L with pickaxe options
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
Cc: Matthew Hughes <matthewhughes934@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

This series fixes a crash in git log -L when combined with pickaxe options
(-G, -S, or --find-object) on a history involving renames, reported in [1].

The crash bisects to a2bb801f6a (line-log: avoid unnecessary full tree
diffs, 2019-08-21). Before that commit, the same combination silently
truncated history at rename boundaries rather than crashing. The root cause
is that diffcore_std() runs diffcore_pickaxe(), which may discard diff pairs
needed for rename detection.

Patch 1 fixes the crash by calling diffcore_rename() directly instead of
diffcore_std(), and adds tests including known-breakage markers showing that
the pickaxe options are silently ignored by -L.

Patch 2 explicitly rejects the unsupported combination with die(), replacing
the known-breakage tests with rejection tests.

[1] https://lore.kernel.org/git/aac-QdjY1ohAqgw_@desktop/

Michael Montalbo (2):
  line-log: fix crash when combined with pickaxe options
  log: reject pickaxe options when combined with -L

 builtin/log.c       |  4 ++++
 line-log.c          |  8 +++++++-
 t/t4211-line-log.sh | 15 +++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2061%2Fmmontalbo%2Ffix-line-log-G-crash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2061/mmontalbo/fix-line-log-G-crash-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2061

Range-diff vs v1:

 1:  6e97d88993 ! 1:  273ebf640d line-log: fix crash when combined with pickaxe options
     @@ Commit message
          Before a2bb801f6a (line-log: avoid unnecessary full tree diffs,
          2019-08-21), diffcore_std() was only invoked when a rename was already
          suspected, so the pickaxe interference was unlikely in practice.  That
     -    commit made the diffcore_std() call unconditional, and with
     -    filter_diffs_for_paths() now framing that call, a queue pruned by
     -    pickaxe violates filter_diffs_for_paths()'s expectation that diff
     -    pairs correspond to tracked paths, triggering an assertion failure.
     +    commit restructured queue_diffs() to gate both diffcore_std() and the
     +    surrounding filter_diffs_for_paths() calls behind
     +    diff_might_be_rename().  When pickaxe breaks rename following at one
     +    commit, a later commit may produce a deletion pair that bypasses this
     +    gate entirely, reaching process_diff_filepair() with an invalid
     +    filespec and triggering an assertion failure.
      
          Fix this by calling diffcore_rename() directly instead of
          diffcore_std().  The line-log machinery only needs rename detection
 2:  ae5269af0b = 2:  81cb521401 log: reject pickaxe options when combined with -L

-- 
gitgitgadget
