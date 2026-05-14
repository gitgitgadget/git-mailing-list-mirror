Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB840DFC3
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769252; cv=none; b=Uj+2c51Jewcm8bhigiXV/LAgHM20UCJlSTQBDOXjCNuj5SIC2Yh39kKRdUTaS1Uyi+/GDICcAsPArL2i4PpCjOHDbUQSVDiOPm39GwTGL8JF3h60uS8rG3dmGxaycAUpmMGZbfSgFJ+PXtNeBPsEC3HrM+Ecm3zNnS+Bgv/5M+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769252; c=relaxed/simple;
	bh=HOY2Wp2aAyeCt+q44WwVfcJo/DgEftKSr29j5fblzGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dINm1L4IuKPiYHigG6aINeppqJ1evBJHjsijru/4KIBSDOhZhLQI+gBo59KaE1nPyVBQQouC4Yxt+AbW8guSyqNV9GhBRTXLyCa6vBLTbNsOI7pp9x/5+nO0KGHX/uunlhcVpHf/7FEhMJA0JNXA4xDdHmJVizTZUcOuA4E0W44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPdRFBMb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPdRFBMb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so840037885a.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769249; x=1779374049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq4BPj3Eynh1uO+5cHdZlSAcOuV6d+BLce4WRHo6WeA=;
        b=NPdRFBMbO5168wZDDhPw8grUDbRJUpxeRM+pZ5DCEp0yVeQXROAAYHH0AVXsNteR7j
         tWHzw8liWpSm2jSlXcc/L19p/+NYY0SLJbxgSo+VDc+eSf98MS90S7dR7eSv6NlsZ6IT
         JCg76um0ptd/b57SE5hBzvYAlWYaV7eQE/DwWZMMmlQwgg+rosOhB+8EFrCXdABVjQb0
         DmBOzRfVeOXwvwln7EIwrU3jj7GoOQbLKcQWNAlLHfi5WPAFjnyf6LP57MGATemDEHaT
         ZppVIdFsr5wT/7gjGNpI39wxro+zDKbOls9rFmn6WM/m5v6ZZTsit93YY/48fQFLd67n
         7QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769249; x=1779374049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aq4BPj3Eynh1uO+5cHdZlSAcOuV6d+BLce4WRHo6WeA=;
        b=LmTDRCk2hHf9ZxOaQoE0AaRrrpHDHE+a59jdmP4R/IZRlIGDtsPicEehPvqa0jNUO6
         7DackkfdWgwsUDID1XT2JYbt1ctkpSnXXogqYHtAoFYIZgBtX2yXEiXv1utpLjSe2+fr
         ApTHfPOgkwchf6VDlEcJtZhm9q8avjJohJkxhasOlwxxk2I1I8qVp4BbIUvpktRB3R1D
         GiZBFVjgVvMetM5WIG+6QOEdG/mk3w4i/gRSqAtXexRtREuQ0FUpxOYwVNDfMekICuF6
         3icCEv95+g0Gen0VlGhhs6ByVj3SrQ+gvAfD60Cakp1SUb5qfBunI8UnWoNr4j5hfCAV
         aXdA==
X-Gm-Message-State: AOJu0YwC0vYTGQsHdET/CG0CafPo+hwX9Zso/Aan0cJFj+SkYBkFW8NC
	Lfo8S4Opei2Yps54vrPtqJEbnVvkoxRKGkl9WKkjeDxfw3qyKMqnD/CmzbKWKBZS
X-Gm-Gg: Acq92OEr/vTqfnD1+Q4Tp6ML7n2DsW3gQLZbgUb4saXwFTTVBkCGeRDUxWVNKwUua4w
	xPGneWHNBtLMWp3b1b4J7eLBBl3I07OR5CvbgFy3MPYmyQBj1dMO1dJH7TGNfUlMtlGZqH2MF6/
	3dPZXcynArZih7o/vRl2ZXedVVMOr7ISocX1aSMWWpxUhd636ngsi3PipVLEhOpSpTYb7FbOXn2
	XQUAFMOKSqIQYF6pQgpN1Cz0OIdyNRTE/PoxSlcEn1q8i1k8XDd/MlUeAwvq+d1NbNqXVA1AyDr
	Was8tLlzIgLaLF5BNXNG4mMipzPFblTx3ZN0gsFECMV7MOpmdbA23NmIEl2G5U0w9g4FOWsbahQ
	iTQv2ruP6VNpJeTzgUhUivqM57mx3avECA5X8uqIuWWpCPcm8QDxkmn7gXwJeYeoM7I+7sZ6iI7
	XFhYd9SMM=
X-Received: by 2002:a05:620a:1232:b0:90f:c88d:ebb9 with SMTP id af79cd13be357-90fc88deea8mr795425185a.13.1778769249188;
        Thu, 14 May 2026 07:34:09 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:08 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 07/11] git-gui: use rev-parse exclusively to find a repository
Date: Thu, 14 May 2026 10:33:18 -0400
Message-ID: <20260514143322.865587-8-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui attempts to use env(GIT_DIR) directly as the git repository,
accepting GIT_DIR if it is a directory. Only if that fails is git
rev-parse used to discover the repository.  But, this avoids all of
git-core's validity checking on a repository, thus possibly deferring an
error to a later step, possibly unexpected. Repository validation should
be part of initial setup so that later processing does not need error
trapping for configuration errors.

Let's just invoke rev-parse so all error checking is done. Stop here if
the user set GIT_DIR or GIT_WORK_TREE. Otherwise, continue the existing
behavior and show the repository picker.

Also, remove a later check on whether _gitdir is a directory: that code
cannot be reached without rev-parse having validating the repository.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 2e2ddc0..81789dd 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -374,6 +374,7 @@ set _gitdir {}
 set _gitworktree {}
 set _isbare {}
 set _githtmldir {}
+set _prefix {}
 set _reponame {}
 set _shellpath {@@SHELL_PATH@@}
 
@@ -1167,19 +1168,18 @@ proc pick_repo {} {
 	set picked 1
 }
 
+# find repository.
 if {[catch {
-		set _gitdir $env(GIT_DIR)
-		set _prefix {}
-		}]
-	&& [catch {
-		# beware that from the .git dir this sets _gitdir to .
-		# and _prefix to the empty string
-		set _gitdir [git rev-parse --absolute-git-dir]
-		set _prefix [git rev-parse --show-prefix]
-	} err]} {
+	set _gitdir [git rev-parse --absolute-git-dir]
+} err]} {
+	if {[is_gitvars_error $err]} {
+		exit 1
+	} else {
 		pick_repo
+	}
 }
 
+
 # Use object format as hash algorithm (either "sha1" or "sha256")
 set hashalgorithm [git rev-parse --show-object-format]
 if {$hashalgorithm eq "sha1"} {
@@ -1191,12 +1191,6 @@ if {$hashalgorithm eq "sha1"} {
 	exit 1
 }
 
-if {![file isdirectory $_gitdir]} {
-	catch {wm withdraw .}
-	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
-	exit 1
-}
-
 # _gitdir exists, so try loading the config
 load_config 0
 apply_config
-- 
2.54.0.99.14

