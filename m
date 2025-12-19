Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2A28641F
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170463; cv=none; b=ZBzxsOenHKLYkrG8zOdaM1mtnxgkbxdVBrftDC2cuPufLpymq82OB+jNaqKBqXAOR+F/ztxtOOpUoal2kKNMw0WZpLam4WcNfzHtGuGT32kP0xpPYaUK3jCsjamqTqJriquOFxL5ATpmy8hDGFASdUjx9JxDrGGIaNcuiRs61zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170463; c=relaxed/simple;
	bh=cVLwLljE7nN+sOd+fnwZF7bhMQBFsMH+F+RKw7oNI/w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=p488fyYRbxIwsCxrpJRkm4ofxROd3ZAVEWHUzr49prUI1M2yh7N06+1CgMz3u9XdY564tSg3iIJ7KnbUm8Zu9j3Cch6eqnzBn/vy86iE+pPWXzpUrR5A3SQ4OpXfeYDSHwoh27uYG842nWk533q8LA7BUFTj8XbybhbvvfML3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InjxJ2P/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InjxJ2P/"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2f2c5ec36so228175185a.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766170459; x=1766775259; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiGfde9sL2ltlPis+NeONeWCZYEj31WoeNrY5n4vXTM=;
        b=InjxJ2P/HB2Qi3K94HsIvxIEbZQrfmtSZM0kTlcDRpCIH8JKvsvO0F5Mv09Qnd9uml
         HEdy/ILc4GrvRFuFy4nEvXN70FoO54DA1LSEI5Cxwz8x9Q4DOHc4qrClKvxSd67QDxjv
         rE1gNe9KwLmp/XhlscE85yEAjxXAsFFhgDCZYOD2g78I1LClb+rrlUC4VuiCiQ41RqwN
         5Tqkljydk40zvN7Ouls2F/fZyVMCP0CkvLXHCNtBRIau47zhJ0WW/Q0CyFmCbDI9Bl2d
         V49NcjOLnVjmWU8kqyaw5UEe7SJGRvGDgV4SB3irpM0N3dCWEKQFDQX0PkssGLbcpouT
         NPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766170459; x=1766775259;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiGfde9sL2ltlPis+NeONeWCZYEj31WoeNrY5n4vXTM=;
        b=nw66Jo+cnsog10QBKEd+N+e6s9xeq9Khyi49XTjvSqZU7ewir6/sKqH2O4/G0Js7bS
         VvWaO0TBaiOM1UZBhQurGql5gxY4geq/BP/l+I1AWU9glkk92JM6buXc9jHwL2aNTWJw
         9Ee3jl9JkHEf2WJLOC00HDmTHzIbve6s6qu8BCJRqOa/6fGdw+hHlQGXHYuwhXWQ9hR1
         SxsOzEB1KF5XbtYe3NOv+F3FlHfpAC4PHGcZtF+Ri/MUBkmNXJ4cOvGwXEug34TIqn6S
         xJftHkPeT2oBWGY1fbsllouLI2DaAsx1kt5SZrfhatiCyOHhp44NMpR157yzxRnLHGRp
         a52w==
X-Gm-Message-State: AOJu0YzXi6Wv2UmD3WcQfB1JZk2h8RemC1r6iM4tB9ihUW45dVf5B298
	pr4lpWB2UzPRFPqlgTOkTsYmCeW3j0tJ0R9oCWsPp8GALrQ/PKSrh+Q3zM49kw==
X-Gm-Gg: AY/fxX64fKn6tttZtUw8+a78X9j7VbN/T2Dvqfgs+0oq2JH+Ps4lzm04jK8r9Vxuv4w
	3P8ZLpteRR9VrcL/wHajKiir1m0pHv3KHvna/IQ3uLT/6AYpw+380c/ebuTByDdrC6VlLxkmMRr
	CRMXqXJhZCUV/LQpdS1e8rZPaIwx3ovJAIKeXULFK5TNqWt+sNvUcnZyFTmdsdlU+G0hcfF5sWe
	jjNrqNGnNKK7e4cMmwsKmcL3jOGO62FffaU4W/G1P4bhGVkpoKWuWNB2afP3EPKjQgs8B366tqF
	gMo9SFyB5Vz0Estr/BmDMKpb+ntikTnODuIGXbiTf9aO9T7df/Kzdu7cEdXSYmJhbdq4xmgfKOB
	RCUYyEnmTNJs68rU/Ai+yQI1n5bgPRVWvEjXNLZLGrPijIyQbTxdby5IsRvJmlJIsWEwPoHUa8V
	JNL1s8esWAZZCe4rmIJpt8TOhg
X-Google-Smtp-Source: AGHT+IFE3ZvFQL6IZnrjPmvg3fLVBRSLAfEWuB0YvUvajxMHRptPG5ACoxyJdFiK2QxlWpYLMUgd4g==
X-Received: by 2002:a05:620a:3942:b0:8be:738b:ecce with SMTP id af79cd13be357-8c08fbc0a9bmr647478485a.85.1766170459025;
        Fri, 19 Dec 2025 10:54:19 -0800 (PST)
Received: from [127.0.0.1] ([64.236.133.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783662sm253319685a.5.2025.12.19.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:54:18 -0800 (PST)
Message-Id: <31694ab9d337d68294a5710d55fc4f7e1ff6f83a.1766170456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
	<pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 18:54:15 +0000
Subject: [PATCH v2 1/2] doc: fix asciidoc markup issues in several files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

* fix incorrect use of backticks for markup in
  git-checkout.adoc, git-worktree.adoc
* switch tabs to spaces	in git-send-email.adoc list items

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-checkout.adoc   |  2 +-
 Documentation/git-send-email.adoc | 14 +++++++-------
 Documentation/git-worktree.adoc   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 6f281b298e..43ccf47cf6 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -509,7 +509,7 @@ ARGUMENT DISAMBIGUATION
 -----------------------
 
 When you run `git checkout <something>`, Git tries to guess whether
-`<something>` is intended to be a branch, a commit, or a set of file(s),
+_<something>_ is intended to be a branch, a commit, or a set of file(s),
 and then either switches to that branch or commit, or restores the
 specified files.
 
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 263b977353..caf9d693a3 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -277,7 +277,7 @@ must be used for each option.
 --smtp-ssl::
 	Legacy alias for `--smtp-encryption ssl`.
 
---smtp-ssl-cert-path::
+--smtp-ssl-cert-path <path>::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
 	by `c_rehash`, or a single file containing one or more PEM format
@@ -510,12 +510,12 @@ have been specified, in which case default to `compose`.
 	Currently, validation means the following:
 +
 --
-		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
-		*	Warn of patches that contain lines longer than
-			998 characters unless a suitable transfer encoding
-			(`auto`, `base64`, or `quoted-printable`) is used;
-			this is due to SMTP limits as described by
-			https://www.ietf.org/rfc/rfc5322.txt.
+* Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
+* Warn of patches that contain lines longer than
+  998 characters unless a suitable transfer encoding
+  (`auto`, `base64`, or `quoted-printable`) is used;
+  this is due to SMTP limits as described by
+  https://www.ietf.org/rfc/rfc5322.txt.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index f272f79783..d74ad7b0e9 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -104,7 +104,7 @@ associated with a new unborn branch named _<branch>_ (after
 passed to the command. In the event the repository has a remote and
 `--guess-remote` is used, but no remote or local branches exist, then the
 command fails with a warning reminding the user to fetch from their remote
-first (or override by using `-f/--force`).
+first (or override by using `-f`/`--force`).
 
 `list`::
 
-- 
gitgitgadget

