Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811101AAC9
	for <git@vger.kernel.org>; Sat, 31 May 2025 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748662751; cv=none; b=T2OeL4eKaDav765I2e+eNpf2i/U20MXdOElMG5pZp8ZKjB1YVG5hRuQ3mDxZzAzNM0cxwWK4NQF4HmoJr1UeHSC7vc9Zo4FUPZjvvbOGkfU1sbi/Fc2Ud9q26qwrwvc432bK0V8u765XSq1pprKmsBMOzbli7B7dL2juMMtONcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748662751; c=relaxed/simple;
	bh=fq88++vUHX60EN4DE47pmJGC0fW7CwjdsuBo/hotSvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTZgL2/DAuajIACPsJpotKrCAcOQx16//Zy1iAh7Xa1A2+cTrhfnemiSooiEOPoH4o59c7CfgJBC+bPEBVX7t0kwIGIk3EaFFLimzvRBQ+zogsiUzxvR0MWS9eV7ChbgFeJ4svGDiX5y4m1GkLlZXNe7kTuVvwVj0Bx3a0Jz9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUi5gLcn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUi5gLcn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2353a2bc210so11667145ad.2
        for <git@vger.kernel.org>; Fri, 30 May 2025 20:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748662749; x=1749267549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzVm11JW7ufVL8dlcBD9S0JHzP34L5wnOaqyg1PAIRw=;
        b=lUi5gLcnFHktkrd+ILbDDweOfnK8AEg0Yq+pk/KBlciH49Viftt/7bhOQKlRv0iTis
         kMc7lzeEVEvpQi5Qgp8c74Ni0aLcR2IFjHa1IjJURJND8FtM5FIspurBJt3Vd8O9TAm0
         05fVq6INXoSLNbF2IpnkinGB4ErD9r9D8/G5Z3NV04Fj0tg8oyiAYcnu3bf8gyrSyKIT
         4Ql5/5addS8fNhXkoJZTZIuHFIAnuAcJtzrXeM2BMRsqFQA0+seXTPcesIGKGKxLvPRC
         jtqyB/vBiTN3nkfow+h+3aObfTES+IQ0dcvO3oXG3x75i0y26JyJdT7+OU0S69enJQYk
         iyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748662749; x=1749267549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzVm11JW7ufVL8dlcBD9S0JHzP34L5wnOaqyg1PAIRw=;
        b=xDHNcj/RqNLhUMD8BLDsGaF0Ef6z2OrZpoEMGx2338oYzhhYkPZduDAr9EFqrX6WyW
         z14E8/ddFTs+E8O8yti71/9rMD3wELMRe0WA/SKiQd4BT4Ei45uzYwf30WLjGq0+SQH/
         2zu+4bKrIGx3LyhXZLerOTq34OpT4k8cIDjimkFKIMSU3ZUGxNFp3ZY3wW0ZwSGTjzL3
         8NFBJF0ghvoj/6ni5dTWw2NcoOJTJl1Igec/rpPjlf7AfJjzW3rLv7/ZOioMpbTERQhO
         p8S8WOe2v67Hf0NakAciHP9qcj/CgMOKLFirolU45zdJ1gd3icpouQNo10AX0K6vubHV
         XxPQ==
X-Gm-Message-State: AOJu0YwoxPxYh7wZOjoUhed1NZVG5X63vYWdzFpLUpW5csvv+RefMEW+
	RbTSvV507kwM3okIdXCkaM4lvIwFevcNwfbZm2/0bWU8jDDxZ/OoRadA3Yjtm4eC
X-Gm-Gg: ASbGncvUwEox4OJ/ifVM9aXuSigPdpCEunmwuKVBgizOt8GicC6c2LLv09lZOHlQJq/
	uTvRxJ6I8gkaMrGKcvT/BzOpfxzxoH1corTheAj/z3b7O7+vtiXx1OQ5ETAKN5Gyf9Dx5WVKFyD
	fyLs1r65MbznDBIn6e8XPhUhQfxW1f2a4r+S/Sk9/elwsnUWNJUpxOv5O7sBEa7q4t0Zz+9JU7g
	sa1vCbUqFJP8XcMuEQEkwbNKhvo+cuUcvwBRk0JqG9URtGhU35lTAV8WaNHCx0frvJrkquDHcdf
	cSZ0S7xDWeEIPomQEiKsJQwu0dG1Cc9QbCYsbESnYvCt4UffPZSMa9Slew==
X-Google-Smtp-Source: AGHT+IGdu+xwol/DlCJiNmIZWJxEJmgWCPjtfDJWl70EK14iMScjyFjE7/9Twj6dpJTAvpe9RFWp2Q==
X-Received: by 2002:a17:903:32c8:b0:234:d292:be8c with SMTP id d9443c01a7336-23539564775mr66059825ad.16.1748662749283;
        Fri, 30 May 2025 20:39:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cf39e1sm35088255ad.160.2025.05.30.20.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 20:39:08 -0700 (PDT)
Date: Sat, 31 May 2025 11:39:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] fsck: ignore missing "refs" directory for linked worktrees
Message-ID: <aDp55upE6AhYunz7@ArchLinux>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>

It is reported that "git refs verify" would fail when encountering
worktrees created on Git v2.43.0 or older versions. These versions
don't automatically create the "refs" directory, causing the error:

    error: cannot open directory .git/worktrees/<worktree name>/refs:
    No such file or directory

Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
2024-01-08), we automatically create the "refs" directory for new
worktrees. However, the fsck code incorrectly assumes all linked
worktrees have this directory, thus introducing compatibility issue.

Check for ENOENT errno before reporting directory access errors for
linked worktrees to maintain backward compatibility.

Reported-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     |  3 +++
 t/t0602-reffiles-fsck.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d1f65a57a..bf6f89b1d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 	iter = dir_iterator_begin(sb.buf, 0);
 	if (!iter) {
+		if (errno == ENOENT && !is_main_worktree(wt))
+			goto out;
+
 		ret = error_errno(_("cannot open directory %s"), sb.buf);
 		goto out;
 	}
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index f671ac4d3a..615b7c0683 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -110,6 +110,21 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	)
 '
 
+test_expect_success 'no refs directory of worktree should not cause problems' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+
+		git worktree add --detach ./worktree &&
+		# Simulate old directory layout
+		rm -rf ./git/worktrees/worktree/refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_expect_success 'ref name check should work for multiple worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.49.0

