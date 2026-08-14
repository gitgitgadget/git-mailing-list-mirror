Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908C388E68
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742683; cv=none; b=n0q+SQOnr3o5CrjubFXWFpQF3DRfGfZGQbd++HSNQR50+CWvTu3BTaQMyFFzUz3HRrmg7/VC8qBdVMjP/v1rx4X3Xv1gw8F3PpVHdBbOPXSEYfKw0or37q7e18+2U/eVl8ziEtumCNOqUuBgtjNBPpSv3ScQevgbD/vM2/a1so8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742683; c=relaxed/simple;
	bh=EYBpCI7YxqnVeqHTp9g8Q8EUYe7usVC8fMw1uv27+QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG45JSvmB2bSAERYhyDJgHm7FGWP98yEx1mTcI9kFgGH/BPPJHFKZXkTDEKihMY3ZzNHi4cbko9uv1fmbH6gmvAlzLm2XR2zFQXAsajI6qgRfethT/Pdb9bS/lrLwzMdsZkk77CLwrj1gX9kWrae8zz7KlrrDx1klcE80K5ijdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMWvIo69; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMWvIo69"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2029620a91.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786742681; x=1787347481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MylusCtB93l2onAStPKINfwXIZYMaPsu3U3ed+NvB8U=;
        b=iMWvIo69JBFSuL5JcGmKdfY4NUZJ0ryXi45W4Yeb70tqHFfeW0XW8r772SoiMK/49A
         8mYAQp5D7P8YXfxf/kkX4JM1c/2r/RVQcWjO8BNAFVx6iQinEMZofVqOTE91OgxdYdtc
         O1SfBk9uckpfvlS6kuBsuC/6QV5zG4W7sCh69LYDB96bBgSkscMTARZiL3fXD1vGG27S
         F1IL7vBo1N7rInNPJ33SZdlE4F5d7sq3TJYk2gokGqBTEZbe9lW0EIJx4KHJl30Tzosr
         Ts29tBUbfDWYI220LWmbHsh7lYwHSdR/HUvjt1UtBrlvTwqAbY/CCGCzbPko6DAayVGM
         H+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786742681; x=1787347481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MylusCtB93l2onAStPKINfwXIZYMaPsu3U3ed+NvB8U=;
        b=DQn34eLJ+lYaGYI3cXfBPXvbrs+FXTlV1JPjsPfdkj+zwwcQjqEperGkgACqYHwPab
         XTvQ6bc5kxZ/8HWOQrp2wXa7X1UstHzZSn34o0RXBLmm6Q6e3qOK8W/0frX0AmbdH9Ta
         pJsSks6OlDlmfRm3yvPe9HbMfMa12STldpOGwFh97FSTr4f4FKrQT/DIhFpk62uILI2B
         t+8w3Gf9b97THRqlNkz42FdqZPPv9K4/eRGfjBnVEgyvm4H/QbxsSy4jOQ+b7tip+uM8
         X1ty9o6uYrszlXyo1MfV7hL8grC43isR9smMsa7gMunJMF7O77knLWxMEGXwwDzbDMRy
         wHIA==
X-Gm-Message-State: AOJu0YwZbxNiDT/9d5+cRgYc1/VkyUHR4QBQ7ZXxNOWnBles9/+1EgbU
	ElcH7klzF12jGKPW6r+GCwSXUd9aR1ZswOZzrP7JZFWka9uoNjVyBVoPIxEZmA==
X-Gm-Gg: AR+sD11PEuikoSXBxasMDmKITzwK0YkURXsJV3cQ/JA7AfuBRL4G4pLHNowPhkgEsPW
	iorm4ec4xZoXqk5KJFmwKR/BWe3dcpj3xPLZ7+Po6qMegv5u+WH+NXUlVI2aLdhmb05aFkTRm6z
	5N4D4zUuu67r+R6mUN6jzyeJKL7yxCc3AKmnW4iw1DhSMd82S9pvBCdSeFpVxWg6jgDAB8U3Tma
	pwvrLVb9Q8psUOBTDBro8972+S3JqCsTHFa9Qh6X2Hwpe8+r6pj/T2Z7ztswyvCPfutUT5b4q1/
	yIPhyfPIG8wOUH+ceFC5Mn9aoOWj+ozTReMyr7l6erajlrAP+/6ke0NBCRlL9wpfiOOZ8VGuGdU
	N3bKsonk8kWTe4hgW866Qf+lY0RuvJo7ZU/NxYa+x2ovNxLhrmqHBk/SBygfIJCyphXr1GlDf61
	FxpbUKoVfF8+dafGPz9GbcH50fkAB/4FbCsUlnYcNk2MqmrF0tZFT6SG2PPtLA10UOqVKo2gWZT
	h5ilV6lI6QYInWwquNNQOqmH/Bq5A==
X-Received: by 2002:a05:6a20:d48c:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3cc71b8a6f7mr11472071637.13.1786742680926;
        Fri, 14 Aug 2026 14:24:40 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:3130:d601:284f:52df:cf2b:6eed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd918fsm7953749eec.2.2026.08.14.14.24.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 14:24:40 -0700 (PDT)
From: tilak-raaz <raaztilak07@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	wy@wyuan.org,
	ben.knoble@gmail.com,
	tilak-raaz <raaztilak07@gmail.com>
Subject: [GSoC PATCH v2] submodule: warn on valueless active config
Date: Sat, 15 Aug 2026 02:54:30 +0530
Message-ID: <20260814212431.43626-1-raaztilak07@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
References: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config parser previously threw a hard error if 'submodule.active'
was provided without a value, causing commands to abort.

Swap repo_config_get_string_multi() to repo_config_get_value_multi()
to parse valueless keys safely. Use the standard config_error_nonbool()
helper to emit a warning to the user rather than crashing.

This resolves a NEEDSWORK comment in submodule.c.

Signed-off-by: tilak-raaz <raaztilak07@gmail.com>
---

Thank you Ben and Weijie for the guidance on git-send-email. I have 
properly configured my terminal to prevent the whitespace damage caused 
by the Gmail web client.

Junio, thank you for pointing me to the correct helper function. 

Changes in v2:
- Use config_error_nonbool() to report valueless submodule.active.
- Add a regression test for the valueless configuration.
- Fix whitespace/indentation issues from v1.
 submodule.c                | 12 ++++++------
 t/t7400-submodule-basic.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5c92575888..07d1fc63e9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -231,11 +231,7 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
-/*
- * NEEDSWORK: Emit a warning if submodule.active exists, but is valueless,
- * ie, the config looks like: "[submodule] active\n".
- * Since that is an invalid pathspec, we should inform the user.
- */
+
 int is_tree_submodule_active(struct repository *repo,
 			     const struct object_id *treeish_name,
 			     const char *path)
@@ -261,12 +257,16 @@ int is_tree_submodule_active(struct repository *repo,
 	free(key);
 
 	/* submodule.active is set */
-	if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
+	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
 		struct pathspec ps;
 		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
 
 		for_each_string_list_item(item, sl) {
+			 if (!item->string) {
+				config_error_nonbool("submodule.active");
+				continue;
+			}
 			strvec_push(&args, item->string);
 		}
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eefdecb0bd..74c26f6630 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1549,4 +1549,15 @@ test_expect_success 'submodule add fails when name is reused' '
 	)
 '
 
+
+test_expect_success 'warn on valueless submodule.active' '
+test_when_finished "rm -rf empty-active" &&
+git init empty-active &&
+test_commit -C empty-active initial &&
+git -c protocol.file.allow=always -C empty-active submodule add ../empty-active sub &&
+git -C empty-active config --unset submodule.sub.active &&
+printf "[submodule]\n\tactive\n" >>empty-active/.git/config &&
+git -C empty-active submodule status 2>err &&
+grep "missing value for .submodule.active." err
+'
 test_done
-- 
2.50.1 (Apple Git-155)

