Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B23043B9
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656715; cv=none; b=to6uHgZ3ancshQDVaZkXS3SzSV8FrE+blDjp36UaZDvYAj3rpVWLN7rTgztOzDcmuYoChXPx0heooWT5mwotExi4ewReNDgpSNH45X/gSqC1G+l10qEC5v0ACWZazHUuNFT1W9XIX/ZFtJXAlJcZgi/HHcJI7qHy/onzHSQO8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656715; c=relaxed/simple;
	bh=YDzgjpivu6TPnSYA2iSSudK9TwK2BQBZWCMAzda6Ci8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OHxFDDwDyNsytbZqhIzLr2xlXNs68aEp4pp8APXPyDT021H62SSMBTS7wl9pVMPUkccwINN1fGhvFGa3pwQaIVU4tjIeufizrVDCkmmANQLqW2tTPGl16IIeSdarLBi5fNc2B+SJftMr8Y2ahVDh1k35QMrQ8BN/4LrTk6Q52ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGBmSIRs; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGBmSIRs"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4248c9a64f7so1496945ab.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656712; x=1759261512; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFR1grZHtBpB2nhM7kw913+mjxSCrq+uYREgTlkM0fI=;
        b=QGBmSIRsK6QCfliI+k/aLicRGfCXME8u+iFm15R0q3ykdTcfugB40Gv4nm4x5+DK/7
         sKv1DF7VX5NEUkNqvrTPVn99J8k8YhOg1cTfZFnOpNMU/zz+93Qk1Igp9BZZ+6D3yi3B
         t/5n2dNMM0qTFVUuV/qPp2IgQrdIFT28mvbVWAWP+3Kx19YXn7DJW6oWiaUs3hs94te0
         YlicKuymBlCGPmWc1rTEp1vJOUuYk5Mj5ujxV0y4UMMQA0Xit/AvJwy1hUIwrRp7+aVi
         Vm4vNdtAcm/HkRDmk2KvknyAKgDlVyqImt/ANyJvlbBVYS8KJ88SRFUvru0H6V+RSaRO
         vQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656712; x=1759261512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFR1grZHtBpB2nhM7kw913+mjxSCrq+uYREgTlkM0fI=;
        b=Mq5vMKqxgieP2Hg3U45j9Dt1h56LR+SfXRQfRYKTe7L/BY/OlS/WbR5wQb0Twubw82
         F5WeFqxizLFvNGKqqztGULXRfC0K9aOfQKGeBRoyzwptOAFqgtTWTHL3XNXEp3DPCg5h
         c8Xo40rHDMGs8F9UX5IoWMJrtC500H/kZPdgcgpgY4f2KdXsUogudWxdbokRgM5SJYA3
         ciixRHJzkHd90j6wBBShQDl7PASTNAWnNnXzee79O2z4eaPBsvlt35UAsm/amd3G4vF4
         am827hb+/TqVq428XoKaFoKOIkOQV7MkZ/s/zh6emBrCCVYWOOfa1uMRfZLGyUGnbvfW
         kW+w==
X-Gm-Message-State: AOJu0Yx0Kd/cIDi3mzSHD6d1PTI8HWF8yAYa5sjw1vh2T+Yi2xlBmKNF
	Nuz5O8NPXFJCHx9m7wT76KkzSCgKst2xgvODUH4rWSe2gjFqpUQY6wFwS+bEABLI
X-Gm-Gg: ASbGncuTTqT1JunMVTfBLQj8ifAkwLlQxPtA507EtpIpQAhxaG/dJsW3J71xPLDSQEA
	AA5FooTHjEw5P6l4mUw65pt7kignN4cnYCtVTDHvy2jCtjg4grFJWuyEJ9UIdMUnNb5yuJrNZfr
	0Th5BTP4Eve2HWhQ0fahN2Lxv7hAo7+HaIgpz+Vt/2iDEWfLEFKXs0wgvExvvzOICiaKfpRMuia
	tYWwEeqR9Q5YhB58xg8Q92J7kcO1Y77aHQhuec8YyCoUOiCoFiUhLOC/ej9RGh3PLWVWQzNwnJS
	0Widmrdz2R+usuO27V+uM1Q1+XDBkWdDMiHGwHWkopml0GaiIHOpNgOKbXPSrm3kjbJldIhKgDe
	5vR0bAdr7/bXJLFIr+9btG5MxMg==
X-Google-Smtp-Source: AGHT+IFnBsznx4az3J81fNcsaGlmF+T3Yu0TnVAeQQfNT1++cnYlFtLE44h/BoVrnH1ldIzlkz22dw==
X-Received: by 2002:a05:6e02:156f:b0:425:51dc:5b6c with SMTP id e9e14a558f8ab-425823289dfmr53108095ab.13.1758656712108;
        Tue, 23 Sep 2025 12:45:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.130.210])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afae874sm74600165ab.24.2025.09.23.12.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:45:11 -0700 (PDT)
Message-Id: <c7f09c2bd32baf9e1dda355656bba811484e90a0.1758656702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 19:45:02 +0000
Subject: [PATCH 4/4] doc: git-pull: clarify how to exit a conflicted merge
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- One user is confused about why `git reset --merge`
  (why not just `git reset`?). Handle this by mentioning
  `git merge --abort` and `git reset --abort` instead, which have a
  more obvious meaning.
- 2 users want to know what "In older versions of Git" means exactly
  (in versions older than 1.7.0). Handle this by removing the warning
  since it was added 15 years ago (in 3f8fc184c0e2c)

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 91903b0a94..eec05ab6c7 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -30,15 +30,9 @@ branch. There are 4 main options for integrating the remote branch:
 You can also set the configuration options `pull.rebase`, `pull.squash`,
 or `pull.ff` with your preferred behaviour.
 
-In Git 1.7.0 or later, to cancel a conflicting merge, use
-`git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
-with uncommitted changes is discouraged: while possible, it leaves you
-in a state that may be hard to back out of in the case of a conflict.
-
-If any of the remote changes overlap with local uncommitted changes,
-the merge will be automatically canceled and the work tree untouched.
-It is generally best to get any local changes in working order before
-pulling or stash them away with linkgit:git-stash[1].
+If there's a merge conflict during the merge or rebase that you don't
+want to handle, you can safely abort it with `git merge --abort` or `git
+--rebase abort`.
 
 OPTIONS
 -------
-- 
gitgitgadget
