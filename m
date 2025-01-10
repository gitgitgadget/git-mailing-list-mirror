Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF21217F48
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549683; cv=none; b=U5HJ1RiNkrnvLsG7AW1UQ5IrAdLMFpfg1oDpGS/Zn5R+Wq1/AOI0tZ/aCvrU7R/yoHFC6OHrKAF80Z3wu78fqRBWpuwRCugykWpTYM1n6h7FMw6AH9H9unAU4KP5ob+Ih3QpZ2gVF7HBLZ3hhkC4qEB41TQImOmIW9vYTxLmnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549683; c=relaxed/simple;
	bh=1QGaxPFx/Gj4yMMsWVFUd4/GFk7f52d7R2g4NAHLmok=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cgtsbn4jVhn6WkKagsAKu6+BrX6FQpzqZFgSrMTgyFPvQxHIvpAGDtEqECcxw16lTjPlDyzcEcDwUJ1chEliBKyZb/d32cBkHled0l70gyluRFOx02X5dkdjthFZhLcRuFSDZFinPWAUAXWzGbXl0y+wAuSkv7NT2A6rAxTBeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgKhwy8u; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgKhwy8u"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso27229365e9.1
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 14:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736549680; x=1737154480; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3ctvZZDQgAk0pEReZtPQNrSKYnmK402AOcRUXJCeyc=;
        b=TgKhwy8u1qB3jADYEIqVsHTCIymuecixwRqM1WfGHo7pQJN3wBSNpLu+uF6LnBC9sz
         xV9AorsOfT3M5YA/7i2Vz991cZHWMp61NzaqNblhZ4XnT6m4hopDzQq9sxu4NCFJAPLU
         JDbvxR8tBqgOS6vB2dxMPElL6bRVvNLsobb7KW2vTBzXpxLUEe2fSZX8YBqVmPHcb0l/
         FIaEOAizvelAndFGKqAWp3ztSDGWZ5QYiXLj6OK1ajOUtPA/sokOw49pzmw6DgG8ez1W
         vQDYh4G6aLGPpaJnf+axIHu8Z1LLrgD4Vl19egJ+4SZ8My6E/BsSqZ/V8zGySxO9nle1
         k4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549680; x=1737154480;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3ctvZZDQgAk0pEReZtPQNrSKYnmK402AOcRUXJCeyc=;
        b=quD3n3jBBCXfVv8zuvp6eml6iDJxBP6Osa3hl21MrQEDQzCforsnjwcyrFRAkrd8V8
         sEmj+oNe6Djb4w7U1x0ieqVmiZEZHH9d60Gv3thtNAIQc5f50bA22GzD05RxDadTE4d+
         a1iruigmSvKniB3GnBoRd5TrUfsC+HSfig/bRerJB0r08dZrV2IknVebh1Ryl7pg9g2v
         IA8+sjCbHgTKlIc+oAMSM4GrA5Jj2fNbh/kSRJ4spCEDThFWHcQc7N93hB4BjhTqXS+d
         wC6vC51iqSEKPiauJcmOB4FNzf0zoQ9YbhvguPHU3MeI7KyZNF4OkpPqRo45YQiVN76e
         JfCw==
X-Gm-Message-State: AOJu0YxjZIdECbVNsc/+K1/N4YfaMHkZG413FdnCMORm9Q9X19KjhseD
	WkW6FqbjnRSNZBS5ypaDhhZ246u7gfgErB5IlLjHAwG825/67GLpTq9mpQ==
X-Gm-Gg: ASbGncvtEtWL67QDcZW6RjCqOAW6bkEoXtKiS4nWCCY2twtfR3FYWaiZVUQyQ0xBd+O
	BeSwMrT9UrjNDQyS16wR0uGxdIoiBdt+zcHrC82B0ixpBQZ7QwcGIct8AOY7b/WOMosDvHLc7y5
	Wzk2F63J9SkD8sDCbJziPr7DzKEIth8TSZE9MlG0c2QvoEnM5NskkhW+9uZlKrBWCHH1CZsZRAd
	uvoB7Fx2njbxxyYgO3mbccpLX0/ASFf6KBV28P5pMUapoOp65ZyYnk/OA==
X-Google-Smtp-Source: AGHT+IERuhWsEe0ZbYvbB0cwzQB5MJlCQBSgxCXoc30qUtzWgQBv0CyLDSa331Txk+uWHWxFx5TbMg==
X-Received: by 2002:a05:600c:a44:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-436e26f0b38mr104012265e9.27.1736549679961;
        Fri, 10 Jan 2025 14:54:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcceb374sm102222075e9.0.2025.01.10.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:54:39 -0800 (PST)
Message-Id: <097eb0e877628c0ac51a8699acaaf5e15d0e2cae.1736549677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1851.v2.git.1736549677.gitgitgadget@gmail.com>
References: <pull.1851.git.1736458019921.gitgitgadget@gmail.com>
	<pull.1851.v2.git.1736549677.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 22:54:36 +0000
Subject: [PATCH v2 1/2] docs: list popular credential helpers
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

git-credential-store saves credentials unencrypted on disk. It is the
least secure choice of credential helper. Nevertheless, it appears
several times more popular than any other credential helper [1].

Inform users about more secure alternatives.

[1] https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 Documentation/gitcredentials.txt | 41 ++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 35a7452c8fe..3337bb475de 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -66,18 +66,7 @@ storage provided by the OS or other programs. Alternatively, a
 credential-generating helper might generate credentials for certain servers via
 some API.
 
-To use a helper, you must first select one to use. Git currently
-includes the following helpers:
-
-cache::
-
-	Cache credentials in memory for a short period of time. See
-	linkgit:git-credential-cache[1] for details.
-
-store::
-
-	Store credentials indefinitely on disk. See
-	linkgit:git-credential-store[1] for details.
+To use a helper, you must first select one to use (see below for a list).
 
 You may also have third-party helpers installed; search for
 `credential-*` in the output of `git help -a`, and consult the
@@ -106,6 +95,28 @@ $ git config --global credential.helper foo
 
 === Available helpers
 
+Git currently includes the following helpers:
+
+cache::
+
+    Cache credentials in memory for a short period of time. See
+    linkgit:git-credential-cache[1] for details.
+
+store::
+
+    Store credentials indefinitely on disk. See
+    linkgit:git-credential-store[1] for details.
+
+Popular helpers with secure persistent storage include:
+
+    - git-credential-libsecret (Linux)
+
+    - git-credential-osxkeychain (macOS)
+
+    - git-credential-wincred (Windows)
+
+    - https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager] (cross platform, included in Git for Windows)
+
 The community maintains a comprehensive list of Git credential helpers at
 https://git-scm.com/doc/credential-helpers.
 
@@ -116,6 +127,12 @@ OAuth credential helper. Initial authentication opens a browser window to the
 host. Subsequent authentication happens in the background. Many popular Git
 hosts support OAuth.
 
+Popular helpers with OAuth support include:
+
+    - https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager] (cross platform, included in Git for Windows)
+
+    - https://github.com/hickford/git-credential-oauth[git-credential-oauth] (cross platform, included in many Linux distributions)
+
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
gitgitgadget

