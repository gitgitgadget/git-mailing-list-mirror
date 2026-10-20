Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509662;
	b=ejtCZiHqH44Tt4+wvYt4rl54JBteZqYFlI1EiydTkLVDSUpP6N5p7vYm+4Fl/kdi41os
	 AQ9OIply52v7dSvUKMDcrkLZaMlG0hMV1FWEGUNT8YY2zufrDvGizdHyxbFtabb1uLUeY
	 QCB45BEOWQR82f8a4nLI1y07IvKvujmgStvKdxbm3SHT+m6pFDrV3UQ9FhYrTwtTaqx4s
	 Zlf9l1pIQ0LIxuHIuJAUuczK1Vraj72DeoMSXHRGB1ORbl1GLORIZpu1km7UixtcQwDvJ
	 lieWx599wL76MHYTUPYFH0TKSAFWkeMoQ7LMlIIuUh0pviMBATcRyPtE9QjF7caZ4JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X0fr6zOqrFNU1/4gCCKANeLjTcQcsgshxq8vko/FYa4=;
	b=qkVyLoyDpeCCqAqDDStMdokWLfOfb33dSsToleCcXy0o7Kv+i5DkamgUKNehPP6TkAEU
	 VnA5fK9jahEXO6pW9+QM/XfHm8V0GLWoa4cQ5CDbhuq61/D4qlC3To2v94ZCDSvTWSOOX
	 s3sk1B2/oe9e+nPGQk3O50tcYpeNWorl4zdvAtcZJxAnUOP/pGwdpbishu5bUjDZddtUd
	 ek7Lrc2mBzxpo+mPpeMzaZrIg88i/vy2y6jK7Xol2FJZzymWXYoHWxfxr/UXTlt6nvJIW
	 gid6FbmsWQyvpKE8WOmfSVb5getY6ePEZSZzcIS8sD7/vrDEOrzMRJnd4vsPziRPR7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kbv9HeLw;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2EF60A2637
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F2EF60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kbv9HeLw
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b060ec084so2417573f8f.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509661; x=1793114461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X0fr6zOqrFNU1/4gCCKANeLjTcQcsgshxq8vko/FYa4=;
        b=Kbv9HeLwkQN1G7+/O1gyDlFWulvKFzY/tXQ10KXpty7sDxgf4QKw83a1PqdpIEhve2
         PAm4rb1kMvZGel148N/cVV1PGFPV6KZv2QUjTVSKcMti8aF+s3zUCL8WwKLxSIx5Tdpn
         gxnPcS+I1a06B5IVdt1a11hNclgsvN0li/UEjCGWqVULRcKVEaD9HcAR6xn+q4F+nu7M
         xaHeDqeLSvZ5kt2hB9wBSCGO1zZ1eg+dvrfNAi3iJGqb6KaeoRQD+yGluyJrAeZEsFId
         UoN+753QqQEmU2/JaCn0biPj9z7dWarDpKW7DfVB+THs2hn6NSy//4PMVnM4xJBWHMkc
         NySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509661; x=1793114461;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0fr6zOqrFNU1/4gCCKANeLjTcQcsgshxq8vko/FYa4=;
        b=Yti4ejOamMwrm78JBOqsFt4dm+cz+kqWlIQuWXLMwAddf05XVWz2yJJIJ54P1RCKTO
         pU2PjRzC28Jnd3ZKRMAUGnhW+UmEiBwHR/d9zVMaI9Gd3dblUrAA38mzxbkyp9kz61XS
         vzbmXu2Y1gtUTBiVPU5O9ZxmbjcjlKSSbx+VwCthSsqQoivH/Nq2wWtxQs9a+/tcdj8p
         e2nFrFyiQQ0vQ9k2G/B5fKW6Y3lV0AbenSIVEACfEs/XujTc0YT0ADj0n76rAzijTV1u
         n1b2424+mzaK0I56tQ1ddWpFHI2WqHbFVoClDIfhCY5CkPTFiHDwtSJd7DdGg9cdJ5I8
         jokA==
X-Gm-Message-State: AFq9FYJuniJPABynR8Rjda88z1+CXJZVj2ipZlYlYcizkVaQyGv8kvgs
	OnZbri++HJnw/Yq3abj5jYAQE7Psaj1UYcTSF+s+RbZfs5k9coKhntjY1PRRIQ==
X-Gm-Gg: AYBFou2zRbyNcp58OGAh/ImlUdLstK5lzz7oAe9cbJKvNsyuoVBbrZvTph2L9ocDhR3
	oxH2nz+lIonsLXjmgg+DWASIZmqLJjwXUKBJGsrRRZmIE0P34Ro73WjJpth0H0l40opYU6PDA+Z
	SK2clLS46kuieiT9bj3jvGMqED6CUkmfblF6NTgThYDe4SBTJzLRasz1e7+mhO5oIkZWUVevRZs
	Z2KSjwYl2OlAt9zcFOCRsql6cTkY7ECL9Squ9vu+pSfA/aR7tkKJKct+NPLx2JxVf9fL5KLqDnJ
	34qIBN6wZYdEuWFGvRLBQTzAnXWy6ytYgi2vSXg0UJbU1ZXVc6yIyoTQR6MFjefRBqzc6WHhc2b
	DsxyNxQ6cisSuoUw8+WMp7e5Ib4ofhr//GfMearpMYqUNnW7DMOBVbqQYtVbBGy4/SRMpncU+n6
	TaHlUgzD0teM0S+TE/BADQlR2cZqGdYrxGKXRwGpDHFHYVP9PybvPLWUDCPAg9vh/QUjKIyF8iH
	w==
X-Received: by 2002:a05:6000:144b:b0:48c:72fc:363e with SMTP id ffacd0b85a97d-48e07fa96e2mr22403030f8f.44.1792509659396;
        Tue, 20 Oct 2026 08:20:59 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:20:58 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/7] stash push: remove duplicate changes detection
Date: Tue, 20 Oct 2026 16:20:38 +0100
Message-ID: <36fc0eb9130bda0ccae507433b6780c01fb28509.1792509606.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792509606.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792509606.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
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

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Before it creates a stash, git checks if there are any unstaged, or
uncommitted changes. If there isn't anything to stash it bails out. "git
stash push" checks for changes twice, once in do_push_stash() and then
again in do_create_stash(). While duplicating the checks for staged and
unstaged charges is fairly cheap because they stop after finding the
first changed path, if we're stashing untracked files then we visit
them all twice. Avoid that by removing the call to check_changes()
from do_push_stash() and checking the return value of do_create_stash()
to see if there were any changes to stash. If check_changes() finds
there are no changes do_create_stash() now returns CREATE_NO_CHANGES
rather than CREATE_EMPTY. This enables us to distinguish between there
being no changes and there being nothing stashed, so that "git stash
push --patch" when nothing is selected, and "git stash push --staged"
when the index matches HEAD, still exit 1 rather than 0.

As we're not calling check_changes() in do_push_stash() anymore, we do
not need to refresh the index there either because do_create_stash()
refreshes it again before calling check_changes(). Avoiding the extra
index refresh saves us two lstat() calls per changed path.

There is still one small change in behavior as, if there is nothing
to stash, we'll now try to create the reflog for stashes before we
realize that there is nothing to stash. I don't think that should
matter in practice.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index f461f002e5..aec79ed473 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1338,6 +1338,8 @@ enum create_result {
 	CREATE_SUCCESS,
 	/* No changes were stashed */
 	CREATE_EMPTY,
+	/* There were no changes to stash */
+	CREATE_NO_CHANGES,
 };
 
 static enum create_result stash_staged(struct stash_info *info,
@@ -1542,7 +1544,7 @@ static enum create_result do_create_stash(const struct pathspec *ps,
 	}
 
 	if (!check_changes(ps, include_untracked, &untracked_files)) {
-		ret = CREATE_EMPTY;
+		ret = CREATE_NO_CHANGES;
 		goto done;
 	}
 
@@ -1724,18 +1726,6 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		free(ps_matched);
 	}
 
-	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
-					 NULL, NULL, NULL)) {
-		ret = error(_("could not write index"));
-		goto done;
-	}
-
-	if (!check_changes(ps, include_untracked, &untracked_files)) {
-		if (!quiet)
-			printf_ln(_("No local changes to save"));
-		goto done;
-	}
-
 	if (!refs_reflog_exists(get_main_ref_store(the_repository), ref_stash) && do_clear_stash()) {
 		ret = -1;
 		if (!quiet)
@@ -1748,7 +1738,12 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	create_res =  do_create_stash(ps, &stash_msg_buf, include_untracked,
 				      patch_mode, interactive_opts, only_staged,
 				      &info, &patch, quiet);
-	if (create_res != CREATE_SUCCESS) {
+	if (create_res == CREATE_NO_CHANGES) {
+		if (!quiet)
+			printf_ln(_("No local changes to save"));
+		ret = 0;
+		goto done;
+	} else if (create_res != CREATE_SUCCESS) {
 		ret = -1;
 		goto done;
 	}
-- 
2.56.0.134.g299a3c16181

