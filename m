Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448775;
	b=vcsWioXTDg1067YAiNQuo6JxQGl+HodtcIjeulqtj1PbgS8rdVM31h5ZzxmTucrPUe1s
	 EsFyevuz/bp6zH8e9JvNpXOPKt05ue2zsv/GEOPRBokxlFpvx0uxIWKQCBWCECQnX30zv
	 Bl8ABZcAtsXRtzNcSp0b5lnles7qoHs8e10N81gqyls7GTmRsPi4cVCIj7Foj57ubkyty
	 9qnilFCTIvM+k/vFzOurggmZETz6IMqDdRO1PNmQYUEeKb+78To0THrmmNpM9hB9FABFf
	 w4tE4xFXpATeqZdnEfCDCBGRoZkIXFNG7Y+gff4YScb9zTjr8QuIwCdERqQG6uTMQpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448775;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hiMDrMjHn534VdstCV3OT4YfSGNIT606KFmqgT4Dsso=;
	b=VW6mlQmtJQMPTV3zOo4XcbXY4Ez7AJsCmw1iJdsdU6jJX4QqcPrrNJka/ApvXo19PFBd
	 GSgvg/vInCUlGcKvfXSlziM+Fy4KZ+imxlP0Fc33+iechzzmJrNMrKF+TaK7tRpDlqgpJ
	 hFhYUspoI6hq8QeUiUbI43zfnqX9i/hyfwmvJSN1+zuq/IDRbI5dFkts/AGQHRD9SE4Gh
	 hSm1wPmtSZyy+Y9U0LKf4mI7NKC+nguLGGb6miUKo8Ir1eQJsoWsneq/wVrc1er8aR85d
	 0KKr6NM2ZwFbmwAnrAIC1+g+X6BuWo3Ef9T32s6SvNwfKRqwVw+Ez5Q6aCFfq5p6R+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Vt8aEbXE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C91606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C91606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Vt8aEbXE
ARC-Seal: i=1; a=rsa-sha256; t=1795448753; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DB7fOpDb0HX9CGH1AGNCD12ORFC22mhH3JrV2WdY62UcXbNCSZ/dWYBUsW9iopIWHoz4CIwsyBkGzSxTS3p3mV6UcFxFwtv25ZQZ62DxuZa+aBpNelUstb/VKrPpjM2SgYYnvzWv5H8MxesGEdQpDvFusQVMu5n+424uwiQwpsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795448753; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hiMDrMjHn534VdstCV3OT4YfSGNIT606KFmqgT4Dsso=; 
	b=McozmpYVfHR1/Cod9SwaqGreddBbSRPEWFiuGiwGXDWq/0xTinVethEerlM/8L8oTR0NBp4rUmOyLP/0e2JQWhAVEOlEXZNWMEkHIumJh0gNgSuXtSjju6hftWBPO51kFZl38A+YOyDBPnVbSiZ0/zi+0ogYWXsr2cvYOM9P6XU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Vt8aEbXEjcF69gSism0oO9lbTSi0ktBOfgakGlmOwmHMoauGEBlY3FKeNtZgF6YF/wjNU4JRONjTEjYOEQx2Uw81BHkot/fVtvB+OqSd4jOX8G57AvoYkZMzB1GMF029XEBZRYnvw1h+WZRsTFhon9xxWFi1wpy6marvrX02FpY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=hiMDrMjHn534VdstCV3OT4YfSGNIT606KFmqgT4Dsso=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179544875259395.46518140253818;
	Mon, 23 Nov 2026 07:45:52 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/5] submodule: move git dir setup out of submodule_move_head()
Date: Mon, 23 Nov 2026 17:44:58 +0200
Message-ID: <20261123154500.251056-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123154500.251056-1-adrian.ratiu@collabora.com>
References: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
 <20261123154500.251056-1-adrian.ratiu@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before running "read-tree" in a submodule, submodule_move_head()
ensures that its .git is a gitfile pointing to the right git dir.

This code is nested four levels deep, which makes it hard to read
and to extend its logic. Move it to a separate helper.

This is just cosmetic cleanup. No functional change is intended.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c | 72 +++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/submodule.c b/submodule.c
index c9dd7eae06..8aae789e98 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2119,6 +2119,41 @@ static void submodule_reset_index(const char *path, const char *super_prefix)
 		die(_("could not reset submodule index"));
 }
 
+static void setup_submodule_git_dir(const struct submodule *sub,
+				    const char *path, const char *super_prefix,
+				    const char *old_head, unsigned flags)
+{
+	if (old_head) {
+		if (!submodule_uses_gitfile(path))
+			absorb_git_dir_into_superproject(path, super_prefix);
+		else {
+			char *dotgit = xstrfmt("%s/.git", path);
+			char *git_dir = xstrdup(read_gitfile(dotgit));
+
+			free(dotgit);
+			if (validate_submodule_git_dir(git_dir, sub->name) < 0)
+				die_refusing_submodule_git_dir(the_repository,
+							       git_dir);
+			free(git_dir);
+		}
+	} else {
+		struct strbuf gitdir = STRBUF_INIT;
+		submodule_name_to_gitdir(&gitdir, the_repository, sub->name);
+		connect_work_tree_and_git_dir(path, gitdir.buf, 0);
+		strbuf_release(&gitdir);
+
+		/* make sure the index is clean as well */
+		submodule_reset_index(path, super_prefix);
+	}
+
+	if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+		struct strbuf gitdir = STRBUF_INIT;
+		submodule_name_to_gitdir(&gitdir, the_repository, sub->name);
+		connect_work_tree_and_git_dir(path, gitdir.buf, 1);
+		strbuf_release(&gitdir);
+	}
+}
+
 /**
  * Moves a submodule at a given path from a given head to another new head.
  * For edge cases (a submodule coming into existence or removing a submodule)
@@ -2160,41 +2195,8 @@ int submodule_move_head(const char *path, const char *super_prefix,
 			return error(_("submodule '%s' has dirty index"), path);
 	}
 
-	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
-		if (old_head) {
-			if (!submodule_uses_gitfile(path))
-				absorb_git_dir_into_superproject(path,
-								 super_prefix);
-			else {
-				char *dotgit = xstrfmt("%s/.git", path);
-				char *git_dir = xstrdup(read_gitfile(dotgit));
-
-				free(dotgit);
-				if (validate_submodule_git_dir(git_dir,
-							       sub->name) < 0)
-					die_refusing_submodule_git_dir(the_repository,
-								       git_dir);
-				free(git_dir);
-			}
-		} else {
-			struct strbuf gitdir = STRBUF_INIT;
-			submodule_name_to_gitdir(&gitdir, the_repository,
-						 sub->name);
-			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
-			strbuf_release(&gitdir);
-
-			/* make sure the index is clean as well */
-			submodule_reset_index(path, super_prefix);
-		}
-
-		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
-			struct strbuf gitdir = STRBUF_INIT;
-			submodule_name_to_gitdir(&gitdir, the_repository,
-						 sub->name);
-			connect_work_tree_and_git_dir(path, gitdir.buf, 1);
-			strbuf_release(&gitdir);
-		}
-	}
+	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN))
+		setup_submodule_git_dir(sub, path, super_prefix, old_head, flags);
 
 	prepare_submodule_repo_env(&cp.env);
 
-- 
2.56.1

