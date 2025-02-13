Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6228A2CF
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477123; cv=none; b=ET0WAOZPzNsI7MvN/ITK60BEm/TcjMx7WPhN6WMn9/vC3C88tC44U7KZ8XyY3e1Qk3EsAli+EHTTwjat72Zu3LFkfj6TaIy2GY4el1ne0MNv5r8JdV5oLEt7K6MJCF2GJda5hJmpaPpMAtnJmbadf6toNo1Bj6YyTCpBzWp8KOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477123; c=relaxed/simple;
	bh=7tJHZxNsuEnwbXylWamkyCmb/s72dkRnIu6JnkE8My8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=r8VeAXpbfkrwVfzB4KO/U4POLGrAxzQfnaHV4v5sta4qxvf1yPShoqZSfP2bprRUWwBlGmXfuTocnkYqev6sZ+0DAEW4wnu9dXDy+rmdI5kSdzK023vTyd5YQIsIQtDpddaseaFeKAUIV3uud5STvKp/Cr9zkXto5awe+Rd1Qgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYRvIVwy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYRvIVwy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43965592e1bso6991205e9.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477120; x=1740081920; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nQDUD3oWPDuAgoWKh5VaWfHbWHyLVu4X0xmOofWQWVI=;
        b=WYRvIVwy1xt9E97yNC7+hNHIJ3PqO/EnmF4ONcnGlUgm25hD8dthMMtHBeiCxTAcF+
         m6aFBHRomsMsewfzCj65sfQiHJX2MkkwQWpKxYSJfFYnm0kw5wux/1KkfjD4j5+sNk7V
         CpDtqBs+UdfWMV6i93OSwWVjXJzcxEacWKcWwF19NA+GUooBpNBNmjkykhaHaV2rhZDL
         Z+4Sdl75vJDmUAVc+jTTDvejo76FQtv4AE3+QwQS+1O4me2OmF5i+1EdbIMcNgVW51Zo
         CHligZLyHJXDDyGDNiZHSp+b2olTtwom+waaGUfqeBwFXagD2F0Gk7YEFoNpCJaLyXwD
         63rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477120; x=1740081920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQDUD3oWPDuAgoWKh5VaWfHbWHyLVu4X0xmOofWQWVI=;
        b=INII+nvh3LiWVjbn3rgqNroEmXjC8eb6+XbDzkGoLE2m+tFMLqK4faiLp0jeHsfyJM
         LB3hSJjyR9BmnGdTKIt3rCsksfWOtXOG0MoNJdmDLHx6mhLDVxm5pzqenJkz1lUGyhGt
         vAO8W44F2tLCOdbt7XUDI/iDhn6ANJPRSqAO8eA1KkpB0syMhFqkPcpEUvU+ngWBWYfd
         NHGLy39V9wK93rxji5UXEgf1OSO5OK/8VRJKKVEVqSRdys5LZ92joIO76Do2moHFPdLn
         qEpfG8glJ6rp+n9RGG47K8kO48ahQB2uVjY9uicNeyVPL+pPneP06I9X+S9hfwo+QJPf
         6CAQ==
X-Gm-Message-State: AOJu0YyK0bRMV89DZMesi+Ddc355QFfGEh519Lu5DOxE0jiAeoMFjksE
	yZr4OQryvpcLp4qbTRWg+FV14HZGweb5Zn/ftXrzHxmBl3XZ6Spx1Y1wOQ==
X-Gm-Gg: ASbGnctNzIQ7RFuyDcxRGWgsO6G0ZOcO+qSHBEdbLY4IF+94oYJiOillpfkqBq1zp0y
	DR+DMMqZrHhpBLT6fkZPfE5Czn0kDvfCFQtwAd9alOKccY2Eu4xrIE3nvlOJiTT67701M+o/FIe
	4aXofDTW4b4PC9DSEGGW2Uqz4FDn6x0OvfTR5xWTKt+n0ghoav/tTGXaIAZnxBIyNg1aLSbRcSB
	ztcGUlowVRFFV5fk/9Qi/iZCEBdGcAyfqOq7CwsfDNe1jnGQxp729NOcfjxUcNmMJ5AD0Y6y78/
	Io97xFZ5wBq5EZE0
X-Google-Smtp-Source: AGHT+IF+CTQbgRbbHEjS7kQCyR3I82x+bjIo5sX8shv/ihcFHKIYG7BtDiSMDuSjfO9soqTPeAu9ew==
X-Received: by 2002:a05:600c:c06:b0:439:6101:5440 with SMTP id 5b1f17b1804b1-43961015529mr55553025e9.8.1739477119735;
        Thu, 13 Feb 2025 12:05:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b41b5sm2778247f8f.14.2025.02.13.12.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:05:19 -0800 (PST)
Message-Id: <pull.1893.git.git.1739477118350.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Feb 2025 20:05:18 +0000
Subject: [PATCH] doc: use 'title' consistently
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

The first line of a commit message is variously called 'title' or
'subject'.

Prefer 'title' unless discussing email.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    doc: use 'title' consistently

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1893%2Fhickford%2Ftitle-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1893/hickford/title-v1
Pull-Request: https://github.com/git/git/pull/1893

 Documentation/git-commit.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 602e2f1200b..70a5e4a181c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -98,8 +98,8 @@ OPTIONS
 	replaces the log message of _<commit>_ with its own log message
 	but makes no changes to the content of _<commit>_.
 +
-The commit created by plain `--fixup=<commit>` has a subject
-composed of "fixup!" followed by the subject line from _<commit>_,
+The commit created by plain `--fixup=<commit>` has a title
+composed of "fixup!" followed by the title of _<commit>_,
 and is recognized specially by `git rebase --autosquash`. The `-m`
 option may be used to supplement the log message of the created
 commit, but the additional commentary will be thrown away once the
@@ -107,7 +107,7 @@ commit, but the additional commentary will be thrown away once the
 `git rebase --autosquash`.
 +
 The commit created by `--fixup=amend:<commit>` is similar but its
-subject is instead prefixed with "amend!". The log message of
+title is instead prefixed with "amend!". The log message of
 _<commit>_ is copied into the log message of the "amend!" commit and
 opened in an editor so it can be refined. When `git rebase
 --autosquash` squashes the "amend!" commit into _<commit>_, the
@@ -128,7 +128,7 @@ See linkgit:git-rebase[1] for details.
 
 `--squash=<commit>`::
 	Construct a commit message for use with `git rebase --autosquash`.
-	The commit message subject line is taken from the specified
+	The commit message title is taken from the specified
 	commit with a prefix of "squash! ".  Can be used with additional
 	commit message options (`-m`/`-c`/`-C`/`-F`). See
 	linkgit:git-rebase[1] for details.

base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
-- 
gitgitgadget
