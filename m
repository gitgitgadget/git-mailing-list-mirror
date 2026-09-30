Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8A435534
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797190; cv=none; b=KVSmn1notxkgUtLfsVCvclH7N+hEfcZqEBKbH3OBYOKx7DHjPHYnD8/X1KbbCOEfpGa1itSocc50UR8S7v76CaoMjGhg3q+GjFO8HRnC01gTso/OTPfrbeDDhPrXSLzcYUG7Bfqb16j4/ARL7moyKDTUBWPob1DEgeM9I+1XGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797190; c=relaxed/simple;
	bh=HO7Mp2/bnFItRVa9flzyfwbOTimOSk/pqqawTWlC5X8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Lbb9LeEoI65Wvqhs5MIUBqCZAjwlQFlquOL9s1xNkzHW0TTdNBXx1HJRsrWf3U9U4sCz9c5epsDRTjxY60ezzM9URPBtteInUHzEdhSJw88KNQHod5rrIWP6jeUBib+sloQ+dwIDh39lChR5ILFLdJqRvvo/HDi2aVnwhIzP3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUvNGFDK; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUvNGFDK"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bffc8105eso1802555eec.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797188; x=1791401988; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HbPI9jber5z6c6oblpRKC4RDpZn5Q2oMCW+NdYH+818=;
        b=GUvNGFDKjj4hbRgstyunM1aYFUlxRpWhr/ROW/8Cg6xzIGVSMfFq1rYKDZadjZYclS
         tlcWb1LeCBcUn+KJ/+GZn9tolTCZcdFkiCmzprAslz/TVAQB3dbi+LDq9+ZnscX85j3y
         mUMDEsaW2UHFINTqaFPDepu5aX84JNQEhkGbINd2AlouedvgEdyvIUhGQKiUNVSh9DZd
         1NL4Hl8fiElmwDmZKIRndfKyYU3duDw0IGr8ObM6mNFPAfp4R3IAdmkDCbc7jqzJcbNR
         vIVJAehGP9SVEDoNDSBmVaUOYvC+3JrHqvJsNX3Daolc/c2BBI30jt1HAIOIRotHJHb2
         OIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797188; x=1791401988;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HbPI9jber5z6c6oblpRKC4RDpZn5Q2oMCW+NdYH+818=;
        b=bGkhJVcnxOVgV4ChMS/ZILlDCmxq7Czotexb/gx3wZnA7R15c9UuR8T2yQBqxbYhHp
         ORJWVfgD74W7EbpR9suNespP+ZuwpxmUUosT1tkuiFjNsk0GB2s5WYB6xCNdz5M1KyX/
         rYoarAgafN6jMRUN1pgcNVpUbG7J3awpby4XGBcb1jprsER3Yx2zOQsJuHJoja98ktwK
         3s0u9AyX1LIzQ4XuOuzyFDsr5+PA6UwFd78jHVtoNqV4YpnJnuGbsoFdMP69niaJMRjG
         iLCnS+4GE+b4Zaps4pxtHk5wEUkxIoEaUxySZPezRx3x4mpwBjQ0i5yEgtx57/i4lRAi
         pGAA==
X-Gm-Message-State: AFuF++mFxa6F9p/5MUTYJ0oJo+27i7Ak+WsEiTXN38CwXDX/5IlpvuHo
	iKOXR74/Y6vJMkLdG2zTvY1NEOiM5smWI1SDqb3gUbG3pnhtZauzT95kUhRd5Q==
X-Gm-Gg: AYBFou0WLfV30oahCwh+gphFvAzjJa5WBcV/tZHGUNT4OLwqEXceVsWcHE4Qf13rD2Q
	ChhcLJytovqColhdnq9RmTXdHgH823baxIrl+kWsBM8pQoe/05ikE6MUFWbb+kV9m3x6V1HpPSa
	9Vt1YPUxsFiDg9/vvKN5cQxdmIp/50SRpQ1X1ohqwbxG6UhMZJgs9brMnKdPtn0bseWY6bZWasa
	XJbmdVsccSup7Z74sgID2Zmut+KCR3psMyQZjZV+aVgD/7FZXaM+pYiAwnrCuiMCIAfnjdrDQWy
	L8oiEPrBFlPThnRu9aITP5tx8bx1pdFUTKLzTJK7vZ97dqEcNwnMVQUfUH5Tt/TraiDgJ4+ie0h
	X9Dkyw6oMXKMjrcgAMOr0+ZbSRiUYq+n+YKoZj0uWNcBB5zUU5bZDQpSOGmgA3uguNPZlyYfjsT
	LUASzsO7k6os8lN+8vLsqMNihHehfefrs0pD+bD6axQIRYrs+5NcGK46Cfx2y/EVUoZ8tx2mTL
X-Received: by 2002:a05:7301:6196:20b0:34b:7e89:9a7 with SMTP id 5a478bee46e88-34ce0156f04mr2636115eec.20.1790797188197;
        Wed, 30 Sep 2026 12:39:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.109.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4d1d560sm959021eec.29.2026.09.30.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:39:47 -0700 (PDT)
Message-Id: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 19:39:46 +0000
Subject: [PATCH] object-name: accept @{p} as short for @{push}
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Typing "git log @{p}.." fails with "unknown revision", even though
"@{u}" works as the short form of "@{upstream}". Users who reach for
the one letter spelling of the push destination by analogy get an
error.

Accept "@{p}" wherever "@{push}" is accepted, in any case, just like
"@{u}".

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    object-name: accept @{p} as short for @{push}
    
    @{u} works as the short form of @{upstream}, but @{p} fails with
    "unknown revision". This makes @{p} resolve to the same branch as
    @{push}, in any case, and documents it next to @{u}.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2431%2FHaraldNordgren%2Fpush-shorthand-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2431/HaraldNordgren/push-shorthand-v1
Pull-Request: https://github.com/git/git/pull/2431

 Documentation/revisions.adoc | 2 +-
 object-name.c                | 2 +-
 t/t1514-rev-parse-push.sh    | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 3fbfbd3d5f..68ce6f3dc2 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -122,7 +122,7 @@ some output processing may assume ref names in UTF-8.
   `branch.<name>.remote`). B@{u} refers to the remote-tracking branch for
   the branch X taken from remote R, typically found at `refs/remotes/R/X`.
 
-'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
+'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{p\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
diff --git a/object-name.c b/object-name.c
index 4eda8c8eac..6546685760 100644
--- a/object-name.c
+++ b/object-name.c
@@ -657,7 +657,7 @@ static inline int upstream_mark(const char *string, int len)
 
 static inline int push_mark(const char *string, int len)
 {
-	const char *suffix[] = { "@{push}" };
+	const char *suffix[] = { "@{push}", "@{p}" };
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index d868a08110..5a4f16867a 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -60,6 +60,13 @@ test_expect_success '@{push} with pushremote defined' '
 	resolve topic@{push} refs/remotes/other/topic
 '
 
+test_expect_success '@{p} is short for @{push}' '
+	test_config push.default current &&
+	test_config branch.topic.pushremote other &&
+	resolve topic@{p} refs/remotes/other/topic &&
+	resolve topic@{P} refs/remotes/other/topic
+'
+
 test_expect_success '@{push} with push refspecs' '
 	test_config push.default nothing &&
 	test_config remote.origin.push refs/heads/*:refs/heads/magic/* &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
