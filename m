Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254C38DD1
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843147; cv=none; b=nJupgAlFrv2qJz7UNNfzRH7GmDzWk4T1zdISj9r5BA1AV07YB8IVzWuIDNwzpaXmXyDzCfJuGd62+sKCdsHY47P7mYszBHAnT5koqWPKeccgGoxyxEWmux6r3b3DZN3e05Xq5tBqq+RlmwF05N7/2S53mohd8ECY+MwbIgtZcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843147; c=relaxed/simple;
	bh=O4Kz2l4lIdgl2Ol3XtFU2WmORudjiZmMj4vqINx0pIw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pdff/WEmBCNPQCto34G3JYtHUpST8fF7h9UQlhWVWrh1hFQiv1HjMmDenX74u9HLjkXW1bgNE7V+3I5n3moYFjjhCoK1pXs+dPl1MO/MHjUD5HJNeZ6JDx+6f8pNe18pg7XC8PvwjXl9RSiqR/zFT829VDKLKwhaMf0HKSehpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z35lKh7O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z35lKh7O"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5096158dcso2190130f8f.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749843143; x=1750447943; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Te5jkEK+ZBCCqL2T8ftBHONLn4OI0/oogAca1Va7w0A=;
        b=Z35lKh7Oj0LklkHwe7n2hN/Dfuq7RMJw+Wl2qLWU/Lj1bSvD/3A3WZl2kMZwwAijIJ
         5XqFFAlG4ghihn24BbMwpNVDtC6X9F8N26tJKt5DPkozz6V8wZrV31y8T1XN5YixpALI
         GVnQVULPwRN6yyfjlBEUteBoK/vmy5lGmh+jCHtIdocOM2QGusHfZhU0PTW3Xl4MmxBD
         KdROl7lee8YM6SxjM2KKk1M/010BL4Vvy9jmSrzEPa64pS7OF9+A2oJD4qcI91MwNkzf
         dvQ5JgR39QRj37IotXUGE1c3XgDGm6QELh71t3SkaaQ1fAwVu5wyP3fik9oZEErOfo3t
         2vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749843143; x=1750447943;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te5jkEK+ZBCCqL2T8ftBHONLn4OI0/oogAca1Va7w0A=;
        b=f7eTNa5pcvykN6t7AS3xaldstBlKNhjBvcF/VUdfGhDecMq5tMrHpZfXn5aUIWo0HD
         8hTQknk4SMJuDj0aD+t8SowfDRmMyIRpJgKaIBx47dFMTdUiAjPYTGKGklCPUvLmdleT
         MMkDXY1PdLYRiZOf9owPYp45nRIaY77t9qdLW16wmEvGF63D+1oE4cVegqLbh6BuoiOl
         H94/mK6KpqkXC4B8yNSIkFINKVDi+105t21546ZIhxQNrs0e+FWTPCbm36F2VrHrBv54
         7I8hIDIv0xis6ywyi1JQ9Dh0odQSpaAPI1ZcoFGDsreXNM5mC/NnR9tSN30T9/MkdSCW
         fl1w==
X-Gm-Message-State: AOJu0Yx+uENdMRSBNsy1N879i7ePi09OE/zMBktKq0T++7nVk/dAvyJv
	cJ4Gr3yc2QXyxVmlO0Rv734BQgxFUluRVn1Mj9IOdPxws/3TEEXMb0CAhSgS3g==
X-Gm-Gg: ASbGncsnuxIdv3IB8DoUOhS9wHqXtl9a3p8pDXSiVvhN8hSW9BQKMDfeeBoxGLPTLrF
	maXwDB4A7C5uUioGXLWWcRYIB+jpRpIvRpd8CCuIgMXrqhLL+Lt8fdfXoUCzH3YNyTMCM8dPp4E
	Ih2HO/XCAEPnPDkhr2cxXzHrDTpl6yT6RB5DsZOeo+l/X6rqKoa63AUOJA+qS41n3RLZILEIWDI
	++TdvNMd11STtEeuu/ZWVQnUxlSmaP8GwElYIfGge1Uzo01qeABUyYENHuzaxVLz9xdrd6gZcjC
	+jB/rq0yDwm1Wiq+Ad1XHopHlZdYeEZjvh1VHrh/G7qZhkxJLD+K5VPPaaWFAio=
X-Google-Smtp-Source: AGHT+IE4Tc/vFWpxD5ARZVs2u1gqa8b5rWpscHeQiFh+kxP3/FNCybx1Ey9Y+fTltMESoQ04vek0tA==
X-Received: by 2002:a05:6000:2dc3:b0:3a5:1471:d885 with SMTP id ffacd0b85a97d-3a572e58cb3mr896658f8f.56.1749843143117;
        Fri, 13 Jun 2025 12:32:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13c19esm61032565e9.25.2025.06.13.12.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 12:32:22 -0700 (PDT)
Message-Id: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
From: "Alex via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Jun 2025 19:32:21 +0000
Subject: [PATCH] Allocate msg only after fatal checks to avoid leaks
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
Cc: Alex <alexguo1023@gmail.com>,
    jinyaoguo <guo846@purdue.edu>

From: jinyaoguo <guo846@purdue.edu>

In parse_reuse_arg, we previously called xmalloc and strbuf_init
before resolving the ref and reading the object, leading to a
leaked msg on die() paths. This change moves the allocation of
struct note_msg until after repo_get_oid and
repo_read_object_file succeed, ensuring no heap memory is held
when a fatal error is triggered.

Signed-off-by: jinyaoguo <guo846@purdue.edu>
---
    Allocate msg only after fatal checks to avoid leaks

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1998%2Fmugitya03%2Fmlk-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1998/mugitya03/mlk-3-v1
Pull-Request: https://github.com/git/git/pull/1998

 builtin/notes.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index a3f433ca4c0..6df8a7998fb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -308,7 +308,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
-	struct note_msg *msg = xmalloc(sizeof(*msg));
+	struct note_msg *msg;
 	char *value;
 	struct object_id object;
 	enum object_type type;
@@ -316,17 +316,17 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	BUG_ON_OPT_NEG(unset);
 
-	strbuf_init(&msg->buf, 0);
 	if (repo_get_oid(the_repository, arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
 	if (!(value = repo_read_object_file(the_repository, &object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
-	if (type != OBJ_BLOB) {
-		strbuf_release(&msg->buf);
-		free(value);
-		free(msg);
-		die(_("cannot read note data from non-blob object '%s'."), arg);
-	}
+    if (type != OBJ_BLOB) {
+        free(value);
+        die(_("cannot read note data from non-blob object '%s'."), arg);
+    }
+
+    msg = xmalloc(sizeof(*msg));
+    strbuf_init(&msg->buf, 0);
 
 	strbuf_add(&msg->buf, value, len);
 	free(value);

base-commit: 9edff09aec9b5aaa3d5528129bb279a4d34cf5b3
-- 
gitgitgadget
