Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2550E59D
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677542; cv=none; b=EqjlUpG42F9zVktlkxK1jrR5ihZmvU0buQqPKWA9qwgRbOrLFrzbXAQqOWJRbTeeHDaGk3/h0quCsTOaX1ZkiZdFoUgUBWVWFlGEEo+kP9OtqooLng4GWs3kHF7dL2doElB4yyKGLPnv2Wih7VZGvZgec8Gan4+Y/Ymy9ZrOIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677542; c=relaxed/simple;
	bh=nvX1b7Z6zpWfTz/8hO7PGdEwyfARd15FPnElUI0wvSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fggnN/IJlPS63R5kvh9ihVINJerh9XzTXMFZ1Ya8L0BZ5JdSCAhnI2eZLPyKglRNIV2MEzF9ztp0UC/o8RvQNKH3Xlzdv7zJ7lEnUdV/zSAkw5L+oTgLQbB/B2PH5ffwciIaff+dRO1j704TUzwjfHLQZW3/D7Ah4W/qnq2KVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksqcw+oJ; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksqcw+oJ"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so2301271c88.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790677527; x=1791282327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXxRghwKHq+vTiMqaQwtNNuxT2JaHCjSeffbmYLiL4E=;
        b=ksqcw+oJa0l94dMD0acR0lQNDHhYQtCepbd0xKXrrBDEMTGtYul4AvGgNFaHApMazj
         up0wx/0YTf1mJ5zZwo2V9Us6hzvbMG7fiS4hVNfhQ6ix58ankWYRPoBuiZzIivM4l7dS
         faeOSPd4eoeq2+LITFfsIY4dF6DATuLeaoqexc5NlzxA5j5pX+prwSoLfRj4fWW+KDsl
         Imw3mE5VgdQj+DwFEIGNVFaWURI6Vedj4mdwkjudfNHduLtkjCOVYOkbd0Dgo3BG34NW
         dXq3rItMv5pNS+0APqAEeUOwduLqvExhCx22mkIB9UBDRNAWW9xqYyRYl3vDqNhRSJAK
         r1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677527; x=1791282327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXxRghwKHq+vTiMqaQwtNNuxT2JaHCjSeffbmYLiL4E=;
        b=WNoLf5hChY2lkpC24QdrIfmW28VW6BYWaU5JMMCx4VRX2BSh+9jh/+7TeUBdfdcodG
         QUe5InfWdP1ApWXoFGsqprL22FDMITiNUb+3jNV59Cdjq8wz/FxQP0Vdha8ICx5pKshR
         cTd0QKpWTf6QutT8zHtrnkHVXfmkHSAgvLbIldVyWfscIC8Nt4MHkHeQPqGgoCmLFZ6c
         hNHv9gxlX1C8YjcHzVkaE369VDokgqVvafvgtepowsdM+zvhyWSSo3Eb7wULgmEjXuqS
         nSU/IL6c367Meal1W8F45RNkMc68SGeBl7T+8F6bQ71qDQZS2YUU3xWOT6k9jTX1EGsH
         HCUA==
X-Gm-Message-State: AFuF++lQMCkiPJS4j3ReoMTolFpazY9iEanLZ4b0xeO9P6ypX9AWqmW1
	SLtl0SbEtzHycCnFariD3KbRXuWvIeViNb6kOY6Fwv4Vl8kD4mbvY1zeFwkvrQ==
X-Gm-Gg: AYBFou2kW3fyUGz+hZcBVupT71hWq61f/baQoLdNHXgoE6eE387crCWD0ZguXqXFxxQ
	vTC0lQ+6yTy+iPm2YWYcdV9NmoVn94UR1kFR7kPiLPV31jejF4ws1pL3Ww+ov2KrWOL7c/t3mJ7
	MoRRBFZOJh5DGOzuon2UTMbE3qyr2drziN5s5nf3Y71DteK/RoWMnDQHyBe8jlVgGPLS0Qis0Dc
	jDxVJiIl1wxi28A2+7CzqpeCy9F6v3v+ZQD+kPm0ddREyxxLMzWWUli+shJ9cY4VGq2FVJAalnu
	4TUfYYRCCpjARgrHM+BhuupMTNe071sxwj3js8TrGlBigIikte9C/yUtBYfmuH72LLSLZRUnS4N
	MC4LkTetRGDqgWrgJyW5z9s37gisEtRRJsfCCS97IjiHdy+SfKv3YPII6YSit+CrS5W9QRepYNJ
	+dqZhFquaaZ1/CHR8id5lDv7c0/uuN1vW8l1sOQfmiv1vMbaZvcn0SWpBc0CnWKABWo0GM2/Jc5
	z0UVwzIwhWQ5P32/0G5cCUbMH/uJQ==
X-Received: by 2002:a05:701b:280b:b0:144:fb42:3e with SMTP id a92af1059eb24-146cfec86d0mr9611719c88.25.1790677526724;
        Tue, 29 Sep 2026 03:25:26 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2401:4900:884c:d167:a737:cb55:b3cc:523e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm30417589c88.7.2026.09.29.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:25:26 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 4/4] setup: communicate why a directory is not a valid git directory
Date: Tue, 29 Sep 2026 15:55:10 +0530
Message-ID: <20260929102513.712181-5-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment, there are a few scenarios in which the error message
surrounding an invalid Git repository is a bit blunt:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'

In this case, even though repo.git is a valid Git repository,
we get an output saying it is not since the GIT_OBJECT_DIRECTORY
does not point to a valid object directory. At the moment, the
user is on their own in figuring this out.

Instead, make it more easy for users to figure such issues
particularly in cases where they have explicitly specified
a Git directory. This intends to improve the error reporting UX
by clarifying why the specified repository is not considered valid.

We achieve this by means of using the new helper
is_git_directory_verbose() that has been introduced. With the
same, we get a more helpful error message as follows:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'
  reason: cannot access object directory '/does/not/exist' set via $GIT_OBJECT_DIRECTORY

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c                       | 10 ++++++++--
 t/t0009-git-dir-validation.sh | 10 ++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index a0fb68f7f6..a0d3c0c5bb 100644
--- a/setup.c
+++ b/setup.c
@@ -1195,6 +1195,7 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 					  int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	struct strbuf invalid_gitdir_reason = STRBUF_INIT;
 	char *gitfile;
 	int offset;
 
@@ -1207,12 +1208,16 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 		gitdirenv = gitfile;
 	}
 
-	if (!is_git_directory(gitdirenv)) {
+	if (!is_git_directory_verbose(gitdirenv, &invalid_gitdir_reason)) {
+		struct strbuf die_msg = STRBUF_INIT;
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			goto out;
 		}
-		die(_("not a git repository: '%s'"), gitdirenv);
+
+		strbuf_addf(&die_msg, _("not a git repository: '%s'\nreason: %s"),
+			    gitdirenv, invalid_gitdir_reason.buf);
+		die("%s", die_msg.buf);
 	}
 
 	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok))
@@ -1274,6 +1279,7 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 	repo_discovery_set_gitdir(discovery, gitdirenv, 0);
 
 out:
+	strbuf_release(&invalid_gitdir_reason);
 	free(gitfile);
 }
 
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index 6c40925aa4..1f8ac3fad5 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -78,7 +78,8 @@ test_expect_success 'setup: custom git directory with missing HEAD is rejected'
 	test_when_finished "rm -rf parent/empty-dir" &&
 	mkdir -p parent/empty-dir &&
 	test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
-	test_grep "not a git repository" stderr
+	test_grep "not a git repository" stderr &&
+	test_grep "reason: could not stat HEAD at" stderr
 '
 
 test_expect_success 'setup: custom git directory with HEAD as a symlink outside refs/ is rejected' '
@@ -91,7 +92,8 @@ test_expect_success 'setup: custom git directory with HEAD as a symlink outside
 		rm real-repo/HEAD &&
 		ln -s ../garbage real-repo/HEAD &&
 		test_must_fail git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
-		test_grep "not a git repository" stderr
+		test_grep "not a git repository" stderr &&
+		test_grep "reason: HEAD is a symlink .* but target lives outside refs" stderr
 	)
 '
 
@@ -103,9 +105,9 @@ test_expect_success 'setup: custom git directory with invalid GIT_OBJECT_DIRECTO
 		git init --bare real-repo &&
 		test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/does-not-exist" \
 			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
-		test_grep "not a git repository" stderr
+		test_grep "not a git repository" stderr &&
+		test_grep "reason: cannot access object directory .* set via \$GIT_OBJECT_DIRECTORY"   stderr
 	)
 '
 
-
 test_done
-- 
2.56.0.rc1.12.g2c9c8d64bb

