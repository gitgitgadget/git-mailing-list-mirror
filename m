Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34F13F54AB
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001743; cv=none; b=AIh8k8eTIoV7IgKhp7Ww9ZBXCp53zqzprrO1IVkn8pJNaH+xklpMG97odT3n28YHe3SUE26QpLv7wbS8RxXhy5XbQfNtobEkCfhnUqOYd8H+7QKFchUuFUg1WIFXs+BpYHCn5f/aXGFdutG7hpSpplHiJlPU3m5c3S+pJL/zlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001743; c=relaxed/simple;
	bh=buXKdpUwnD5BMqPAUg++Kar93xWTpnEKxdoPyaAm7k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/ML0RwVGUE0Y3KzHvPS6RLbBhIUEDX38+Ar8SppemhAXN5UblQwZhYjuYU0Y1ARcyXSua6PuIVl+c2vs0GGMl2HyPBlHuSh62i7pHAHiKpdty/AAxGgZYR/885klgbWNFKojxGZKssiMUCNZHJq285KwJELGh02nodltiQEA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlRuAgMs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlRuAgMs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so25297525e9.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781001738; x=1781606538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g38CV8qawR6r6wuCUMr8K3sLUhyVgRypDN734zxQ8jg=;
        b=BlRuAgMsaUiDftc1UYPD1YSlSNMnFf6BmgOs5pI6b8bXC/KqRnzXUAK4UBecAjemT2
         aMOlBKKw2mowRyiS1v4sNrit8Gct/5j0zZtEMws5+GElXWN072Q/OOZZOel7yeGz/1sU
         dHoijMIklqdAoqPR2K3OrdQ29rm6PhuEsUXwm0wv6jVI7+JOSANb/11aVD3PX5l32K2i
         RAJAErK/9fXzhT3eKhNNqWPj6+B1oeJqjlRXLOyqnsLuqwt+V0X+LVaF+SsoQQ3Wy+Kq
         LjWzXp1F08VZ90bKtsV8DKWb90ofbQfyWfb0xQ0i8MuaUqX9iTSEmywWqsA19QI4zqJ6
         J50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001738; x=1781606538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g38CV8qawR6r6wuCUMr8K3sLUhyVgRypDN734zxQ8jg=;
        b=jyIRf4goP+1yB8VDIxs6VPRD4ZiM2TKm+4ezGNcJ+vBt6c2s4GqATtkyqqNU3X2jF1
         NOr+zYPDV8ly4+bORMzbSrKApzVEQzJE/+QXFY2jfPsFDjy4UfBu/5WKJ2gUve9ViRCx
         WqvC49ijPphZrZSqDpaKw6Vkx8dG14fnTRg5Law1JO4ZxzWhbnloQeRQMtyAruDe6ENp
         3r9NM7vGnNcGcCe+F2bNW0+5eFvLDzYvSxTvyHjC9x6bwOyhNjWVQXuLbaPh/mn1izRn
         JfA56PpZCDQyJ8o0YgkaLq1XcUdy+lkRm6IuSvAEohV1Omn0VQ0LXQUDIBgSFcqsJl/3
         nIeQ==
X-Gm-Message-State: AOJu0YzuaJv9TecABSw0YIekvyf362kwxIDprRzgnWOedMDcV3bxeQnG
	c8z01d8IX2BRgj2USDY4h65Ej3xO7lWqVrVst02gtn0cXiWFSZmfNhkSMsXHhuDF
X-Gm-Gg: Acq92OG2La+SMYh9yzME1z7p+v3DO8A6757OBxxAKGauIwSHjPef41ZG9BNfhIzjiv8
	00nJjY0Uew1IergGD1ZL0Y5jCQRFX/kte8y7A26j5w3kwwf2VS4Ri/YtHQohepFpqJUNpvxz5nx
	Jg++sNA2X3H3Sg3jyCVUIrm9qm4vmnaU5kjRLcL7vspSTrV/GnP5kXRv7Z45kJZor2vVOFyueo3
	OY8tqtKWsvLOLT6V/j5Q59hyUsTqOHGewVdTTvs40rqg8Ig62Wgu2HjnSG9BoavJVot2vBV5eaY
	TLjT40bWbcp6VVj8YOgJnY/bo5RyGu2IxRkgs4Ct5cKFI42aundGqBAw7tCBpEecMD8phqtYR/N
	k2A60noqDB26jNcFEcgUwqQzY+OwNQzlG1hGeJbsKh2C4+2LzN7dvPQe8U304OSGDfZNFyggQBK
	pIjJI8bpmugZQ5eCu4BdNhkRHWPKkeLXtkjgS4vo/PPu+hkE+2nYYRl9irN2wRGVjzAi5tOzGMB
	egYpROybFUjQFQ1ya55mz19yb+fw2B1jjdxT8EspFnRl4/Nso9dtqEf9joUxuCtUilwkO751CwA
	GnST3Sq/19wXhxG/mSmVhzSY5XKN7L07SKEIKnrbDRPxtndYJjEDOOd6acauSj97jfSGQWADJpB
	DWxa3hpx2/LDljYSDAc/tggXqsMZc5sI1
X-Received: by 2002:a05:600c:4e04:b0:490:cc1b:15c7 with SMTP id 5b1f17b1804b1-490cc1b1631mr178176955e9.30.1781001738141;
        Tue, 09 Jun 2026 03:42:18 -0700 (PDT)
Received: from localhost.localdomain (static-21-4-87-188.ipcom.comunitel.net. [188.87.4.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm499692345e9.14.2026.06.09.03.42.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 03:42:17 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: cat@malon.dev,
	ps@pks.im,
	kaartic.sivaraam@gmail.com,
	pabloosabaterr@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com
Subject: [PATCH RFC v2 1/2] builtin/history: refactor function signature
Date: Tue,  9 Jun 2026 12:42:07 +0200
Message-ID: <20260609-ps-history-reword-v2-1-a0e6028ca9b4@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

commit_tree_with_edited_message() calls commit_tree_ext() with the flag
COMMIT_TREE_EDIT_MESSAGE hardcoded and we can't set new flags on callers
like cmd_history_reword() to choose their own flags.

This refactor is needed for a subsequent commit.

Refactor commit_tree_with_edited_message() signature to accept flags
which are passed down to commit_tree_ext() instead of the hardcoded one.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/history.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 0fc06fb204..b3e2e5270d 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -160,7 +160,8 @@ static int commit_tree_ext(struct repository *repo,
 static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
-					   struct commit **out)
+					   struct commit **out,
+					   enum commit_tree_flags flags)
 {
 	struct object_id parent_tree_oid;
 	const struct object_id *tree_oid;
@@ -181,7 +182,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	}
 
 	return commit_tree_ext(repo, action, original, original->parents,
-			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
+			       &parent_tree_oid, tree_oid, out, flags);
 }
 
 enum ref_action {
@@ -692,6 +693,7 @@ static int cmd_history_reword(int argc,
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct commit *original, *rewritten;
 	struct rev_info revs = { 0 };
+	enum commit_tree_flags flags = COMMIT_TREE_EDIT_MESSAGE;
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
@@ -714,7 +716,8 @@ static int cmd_history_reword(int argc,
 	if (ret)
 		goto out;
 
-	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
+	ret = commit_tree_with_edited_message(repo, "reworded", original,
+					      &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;

-- 
2.54.0
