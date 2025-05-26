Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E921F5437
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255624; cv=none; b=Vdr18jyyYxZqa5jhoQ8PwTn+Zn255/6iuPmwQyHCS9vbYLcBROJKD5nJ8Fq+G9Ta7eps8Sqs0gNoceO1HwoxYwVeYjDbTzpupsER4Z0N+4x8ryk6fsh78gRGm6MnDVEweyGObd4W7SjyFh9dEPkIYeV5jMsIBQ5fc4V1s8dM8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255624; c=relaxed/simple;
	bh=IoTUHU+x0vMnfXQXi/2jjUPQ0vAIJtILQcuvsGsQS9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvp07s7wTjcRF9fMXT3WAOOXNc9c9Hwzc6LOqvbp8082VNTMWcE99ccnePJ5q3BoxjUvi/JbPJ8UopKJCInmY6ssua0ZBtx5O2ieK2diR1kbwrCkA/IDFaFxrAuOmS8AVQmx3xsR8WmfG6mRcnvAW/nz8zW0L8TgMjwxX50V6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fThWHj/f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fThWHj/f"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe574976so15607645e9.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255620; x=1748860420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLvbYEHj1q4sNnYaaxN4Zn9FrKMZMu98NMgWjQPcxuo=;
        b=fThWHj/fLuo245EWettwBf5LAodiPmDQPGK7F8PDQmFMT3qMufx3LgqCWaWTOZdyyw
         yYSFNI+SkfwI17j75Ss9db5njArSci6rdguBwVaseWjTsavH96kkKMXnnOl2Q7lbrZdt
         /kS0z/u64aZQgvyDJWf+2tDVNVCzEKm0ZvrJEABpjq8l/93OpcH+BNJYTYaTXfZe856c
         2VWMuZyCMPjet+NFnxaFBo7hPdm5CiXGOAh5b22C6UBJSq64tPfEf2r22tQCfW9kfSA1
         mltEoXUlJvjUkw0acO25BZ9nXdsWHnvnUJY5EePE0gwmhjQX0qxWEKm7sP6ZSbEjFlPK
         +5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255620; x=1748860420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLvbYEHj1q4sNnYaaxN4Zn9FrKMZMu98NMgWjQPcxuo=;
        b=DRwBfUHpnhMxwT5AVWoeMP9eiPsy1fiEIBHRyOevYOzyAYYbCJH13mwwScJ8g0w633
         w6O/AbvM3QJPdMuz+ahJvdonCKab+T104sqsIb9WGxAtdn6NPD7Ap+RJKn70etYCWlFF
         3DxdeU1ypgQ10HEUj0dlQquXUIaqyAbAqFSXWfDjZDZWXkwmD6dTH1IlGk5YZ52FS3me
         /Y0tmdSD2IfgOzcaflv1wADFjRDJz8EpeSnzZqxO8JW0xtW2og6ZD13MyZzJAiobC70Z
         1trkJkSmB8p4fL63rt4atOHw4aOMoLKmuXZ2xvId3ddelONE4+ACA+AQVohImH/7QyQ4
         InWA==
X-Gm-Message-State: AOJu0YxfjaYXnpYwwlCWNp7DR1eJnTIU+S61rmki8lZSTAlMJLtVwMgo
	c4SSSSOxGCSx29bn2lL5rHwxgnsz17fivyWxz5e08g602A8Ombll7RTAJsmQ6RQB
X-Gm-Gg: ASbGncu0DglNaVPyQdg0HdOFtj88oPoxQ1JYgtCfAe7SH7EF1WgARiD14ZdGYtBe1b6
	pl+gMNihSjFmqoSfQl55+KIw2dqLuWNq6kQgVp8vf/UanY5/9ZzIjxCYnVFgavOk82h1t80wWKZ
	TClR0a8CCQ7YBYha9y7i8nSMH9QXg82s2v8pee0U8yVMP4N7uS/CnkDdNMzmLhFs5O/Y7w1yOQG
	i9tK8mGpEQ7KSBfif+4PxJ7PVEBvgpq08ieAl0vTG/LNP1mg0a9TyYX3ARnXyC9F4KSP4cFANBY
	Zo45amJP9sFsj1UGoP9olz1oFsqjnRoqs+XxKnwQBhnKWtOF4TQ6Ip0kqsjwRW5yTUjTLQ/7xTA
	vpTDjGZqwPxZ5ucBPUU1dN6yqjsQiRh35WX9Z
X-Google-Smtp-Source: AGHT+IEJFcjx2oFAT4+iXrGFjK83nBOxKrzrSkzQYb3/BKcOlZK+cmZEeyVd99Se6puFnPF4ZbFZWA==
X-Received: by 2002:a05:6000:288e:b0:3a3:55e6:eaaf with SMTP id ffacd0b85a97d-3a4cb44eccbmr5950002f8f.24.1748255620176;
        Mon, 26 May 2025 03:33:40 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d26caf92sm5071512f8f.66.2025.05.26.03.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:33:39 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/6] doc/verify-commit: update and improve the whole doc
Date: Mon, 26 May 2025 12:33:11 +0200
Message-ID: <20250526103314.1542316-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.614.g649fb04ae6
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation of the `git verify-commit` commands currently looks
very outdated and minimal. Especially it has the following issues:

  - It only talks about verifying GPG signatures while the command
    actually supports verifying other signatures like SSH ones.

  - It's not clear what the exit code of the command is.

  - It talks about the `<commit>...` arguments only as "SHA-1
    identifiers" while SHA-256 as well as any committish is actually
    supported.

Let's fix all those issues by updating and improving the whole
documentation.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-verify-commit.adoc | 36 ++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-verify-commit.adoc b/Documentation/git-verify-commit.adoc
index aee4c40eac..6a208a0c2a 100644
--- a/Documentation/git-verify-commit.adoc
+++ b/Documentation/git-verify-commit.adoc
@@ -3,7 +3,7 @@ git-verify-commit(1)
 
 NAME
 ----
-git-verify-commit - Check the GPG signature of commits
+git-verify-commit - Check the signature of commits
 
 SYNOPSIS
 --------
@@ -12,20 +12,46 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Validates the GPG signature created by 'git commit -S'.
+Validates the cryptographic signature of commits. This is typically
+a GPG signature created by 'git commit -S', but other signature
+formats like SSH may also be verified depending on Git configuration
+(see linkgit:git-config[1] and the `gpg.format` option).
+
+By default, the command prints human-readable verification results to
+standard error.
+
+EXIT STATUS
+-----------
+If all the specified commits are successfully verified and their
+signatures are good and trusted according to the configured trust
+requirements, the command exits with 0.
+
+If any commit fails verification (e.g., due to a bad signature, a
+missing or untrusted key), if a specified object cannot be found or is
+not a commit object, or if another error occurs during verification,
+the command exits with a non-zero status.
 
 OPTIONS
 -------
 --raw::
-	Print the raw gpg status output to standard error instead of the normal
-	human-readable output.
+	Print the raw signature verification status output to standard
+	error instead of the normal human-readable output. The format
+	of this output is specific to the signature format being used.
 
 -v::
 --verbose::
 	Print the contents of the commit object before validating it.
 
 <commit>...::
-	SHA-1 identifiers of Git commit objects.
+	Commit objects to verify. Can be specified using any format
+	accepted by linkgit:git-rev-parse[1].
+
+SEE ALSO
+--------
+linkgit:git-commit[1],
+linkgit:git-config[1],
+linkgit:git-verify-tag[1],
+linkgit:git-log[1]
 
 GIT
 ---
-- 
2.49.0.609.g63c55177e5

