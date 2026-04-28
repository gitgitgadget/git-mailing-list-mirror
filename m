Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAB47B431
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401561; cv=none; b=iKXU0mYwTLqeG2VHSvBOX6xtCtFCaKhTjfrpFdLySCEX7NsJPA8W7HBAoyP6i85qb11gkO9QtMnuVsqQfzoE1WMYrxJYbrN+jPXS/GJBpiX9Blnzeykmlx4/Y/MvUsAtr8F7nIZjfpzbpzuH9LHa4+J/EPDCN38/u8XLlYtLE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401561; c=relaxed/simple;
	bh=hqnWLxNzUpLTOR1qBC52imCK7DQ8jdrTvGVSLkRVcTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Kmm/dw+u0eaJgv75Fl2wtNbOpfxSgOE8Lvm9SJHsbk8FBYvzKRWHPu897PzxL0GmHCfVJNRFGUXdcYRxNpZROH6GDs2G1y4FMFv2sBRQh9xbux2sPlH6iCLkyLWEgeOdabFydhDJCKhvFCksJQjwj13Cd0heyDWxKx953qG3E8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qL4zUSO8; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL4zUSO8"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c565dd3a7so3871029c88.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777401559; x=1778006359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=qL4zUSO8geEotkT/TOshiC0bJVO3sCFbwP9HlEmhijXjJxLY6ucXMXC+y4ku4NuMzS
         5w53cSm74BpCZMfZ1cNFw/tBau19jDuvZ9wVWwoXnYK3SAIoIHoUh62aU63i5Dz+s+p3
         YVYlVEIcxO1L9D9zZsoKz9tny2toNujPZTi+B+NQerfY/s5OrPFxYg3DW6p4VEzXBh3R
         kpI22C5MPnUMOCaIUshMLtTI4xAn7oKAVgHG3hIxaPOF3EdANM4LtpcPs65UKjWCmP3L
         +tCtmmYsO+VgRQT4d91nneDg365syZsr9dvErWxmtkV3pJxowQVDwX3jzdfWcPv5bSRc
         Gt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401559; x=1778006359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=oXezDIGytrPh9tq47iAq16j6OPfRqEQJEkVi2IuaY3ajbvjRMt6tEs7ZYdXlfrUAx5
         +4dkZDZnbK7CSRPKE/UbAzRWTAEJ3TmEQYRbyoRZlMlTYyy8XVxfBVg6T197bML6s9LU
         91NX+m12XnLvWtrEBKXv2+JLbFS4vx6CKm4k4VP+41ZstVezA6SB0pFlWKZKeAi5uS7u
         hSY0VEJNaq12wmBiXouhDt3CVm3WhBPKTJbHTt5DwYo0aEUD1tTrEr0o3SUXyjWKSTP9
         zI10LL5SY9739Vmidn2Whydcn2OCx7WKJIQKW1ogHEcNr+7KsFq/RD77kMdPyf7sJMdi
         +SLw==
X-Gm-Message-State: AOJu0YyFDRyDNEP/57NYkBn83XfVK0UI8D8UaLzoVjNlsOCWKO63ZSMU
	zpfv2YWXwEOXmh0Xa9quAbA+pUZcdikmpJSbgbUzwVd+xTJcLfNUxXpal7Z8yQ==
X-Gm-Gg: AeBDiev+HpDbVXV9hQf6Ff5oMYEOqGHXN0Y3oGJbkpgohsXP+LJfL0CdPi34Gf0/UOa
	nuC7LZCYDE3STaF60nfImqlf4+Vpe36R78PB6nWkaoBHo5qeqif92kgJ0d+K6ywjX7TSyHX3Mlh
	6uIPSGuNA52Qeem6rcbXecc6sMMsA6KwZW+fKLn13ouczpjeUR4D1MRMvB9UznWTS9BLOj/gQU8
	ZJRcbkFwJZx0vn5E/hrIzClipvSFP2sGl5PyhJq9b0DMTZEfG6hYnz6wPrIvjI8Uwh1pUbAZBgY
	TBUZYbUfxFLc8zvttcG9kdtlJvqI19TR8tDRzLdwRbIFWBMCxi81oQh14pFHQxabhgzsWOMzqPy
	Rxpx/hg0QHLtoN3geH/T0EiR8MJq9LJMMD2Zp8sSz0beC808LzrT0IVh3NT9Fmk3tmmkbLcJESF
	iSyJZhkBjroprAea3Tryi3bPbKoxx4xt5EBV1P
X-Received: by 2002:a05:7022:6281:b0:124:abaa:7ff2 with SMTP id a92af1059eb24-12de2a53f79mr226263c88.24.1777401558393;
        Tue, 28 Apr 2026 11:39:18 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.83.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9b1e3bsm2565337c88.13.2026.04.28.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:39:17 -0700 (PDT)
Message-Id: <89e0bfa80326d20d11355ed2e73de0907e5c9e41.1777401552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
	<pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 18:39:09 +0000
Subject: [PATCH v16 2/5] sequencer: allow create_autostash to run silently
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a silent parameter to create_autostash_internal and introduce
create_autostash_ref_silent so that callers can create an autostash
without printing the "Created autostash" message.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/merge.c |  6 ++++--
 sequencer.c     | 17 +++++++++++------
 sequencer.h     |  3 ++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 2cbce56f8d..3ebe190ef1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1672,7 +1672,8 @@ int cmd_merge(int argc,
 		}
 
 		if (autostash)
-			create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+			create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+					     NULL, false);
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
@@ -1764,7 +1765,8 @@ int cmd_merge(int argc,
 		die_ff_impossible();
 
 	if (autostash)
-		create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+		create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+				     NULL, false);
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..ff5258f481 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,9 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      const char *message,
+				      bool silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4679,7 +4681,8 @@ static void create_autostash_internal(struct repository *r,
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
-			     "stash", "create", "autostash", NULL);
+			     "stash", "create",
+			     message ? message : "autostash", NULL);
 		stash.git_cmd = 1;
 		stash.no_stdin = 1;
 		strbuf_reset(&buf);
@@ -4702,7 +4705,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4718,13 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, NULL, false);
 }
 
-void create_autostash_ref(struct repository *r, const char *refname)
+void create_autostash_ref(struct repository *r, const char *refname,
+			  const char *message, bool silent)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, message, silent);
 }
 
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c..02d2d9db06 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -229,7 +229,8 @@ void commit_post_rewrite(struct repository *r,
 			 const struct object_id *new_head);
 
 void create_autostash(struct repository *r, const char *path);
-void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref(struct repository *r, const char *refname,
+			  const char *message, bool silent);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

