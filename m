Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6E559CA4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992445; cv=none; b=XIkmPE4BQoTJIJV+3CDHhPhZwophIHK3i0JrbX3OVvPysVt89boc6v3trlkyDai6uFrRycdbpw5azd2ZWf3q6ftKFhpPxCBp/GfL2UimnOaIxgUUebwzv15tLJZpcXjj96MbllkffTILeLgr2DxSZvg3lj7MNBAA0N1hzGC4NEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992445; c=relaxed/simple;
	bh=RG4+lLYLdWdXKLxhC2V96USoT/JPzF8QM/hT2+t5rdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pa7Nk/SNKqomD/wYkAYcbROVTLkxn0qJ/2qpiRnEUSKirTlxoObvw/6zwB6NVIJnlnhQM0JsefLSrzqayg/ZemrtJQruniGyLxgz/C4Wo7yGrRQRHq/1jjVBmlV72QHW6wsGqyj5VwcD0EeWgH10SxdYOhhbXW1wPkxw34lOiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chdSB6ND; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chdSB6ND"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso532365f8f.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992439; x=1792597239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X0fr6zOqrFNU1/4gCCKANeLjTcQcsgshxq8vko/FYa4=;
        b=chdSB6NDDrWryLGF0UzXdulcVYk4/xv73LoEIq3byWwxCMpZU5ZRKp4ZFoYM3pvtVY
         8y9fvrntM3z/pIaNKlWcD3Umpej+AXeiacH/kn63T3QLmrCrPlKuhMVMP7vM0df5PmBX
         /K+TXzHv5Gp7MwSZPh+PqbWb3AXr3VY/hsenLjuIaS6nbmiZ/a+P7Vt35FllubLwqpFV
         pIFtk4gjWDiLvld8y6Ofv2jrlHKpgb+X9tcGg73veJSU2OdMZlB8xxBJEJagGQb7hwSE
         3n34jZI38sUdA45i0zLZbDA+KY3SNKwJobHsU48KE2awSBtCzw5G/azacnPjHAXFXLjd
         vNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992439; x=1792597239;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0fr6zOqrFNU1/4gCCKANeLjTcQcsgshxq8vko/FYa4=;
        b=UpQykS+XJL7UssbZtN1cBmzLK1+yFHcdT62Hq+4/NX4bFJj16QRF6Mb+yDXVb9NaX1
         AK2Ri13m8+fIPkSXKKA/OV6Bxar4iKKF9YLmazAZ3nJCUwM2hbOpdpkvf95CmSOXEJdn
         W6rzOxXIUWeQsIpLOIEInMK29o18/0kpz4Apq6Hsi6DXsOuc15mj7wgoJ0lsYzKCcSrP
         vag71M1K5PtYRWl0gYiZYGbEKthTP65BUydOBRw77BCW3vZZHzIbeScyzS2xR8SPRGrO
         2Gy+HxuEngncZdUf2fYugur6A6vP6dZ5pT0CYSz+IsRmUnxvNfK4vIgsRdewiSlQSer8
         HKGg==
X-Gm-Message-State: AFq9FYJYVGfFjXD2PSe31fJanyd4r//X+7knDPjL1OXoJgne6ZQi/OyW
	OPwZOlrDFpDPDAnmQxiVS8svHKOLYzJUs2Ocz+9ZlWC2csQLrvv5jA/0l6euOA==
X-Gm-Gg: AYBFou0ogK1aJLMQNUPeWM2UzMi0hrY+rSeao+HUL5jB2V+4NtKl9bHB9/Co+e7C90h
	7MNzd8di+nOrImSwo7jUJXU6Zla5JKbEOMM/9rYXQR0Q1SST6alOrKbYOOxd5n4u4NHLTBVonz/
	oPVf1c2k6jFyrjjUEAaXjAQ3zJVNm8p+4EeSHMUl75lmPxZPVAWSZDtZK14CH40PArk0lVnjS9Y
	MAz66k/2Vwqfb0GF01wFY9U9m3bqCArlgNuhateiMylGbpHJtz5ajnNRuMIY5wxfOKXbCUUgyUB
	gHJB7mqC4WbYmoRKqGGjyP3P5rmmpEHlAALmhJre1r7SNjLXiVWZAV1n6fozQwgf3esDuidOF7y
	6LqXYjRsl2kb2o0TIpFIYJ8xjuFuCoNsGwOlFHxmA/8F8pulO36algUE5lgS/A7ZwK0U1Sv8ccW
	bSvkqcjEW7GXFX/Eortsnhor3C+4iy8gsmP0rNIeBGhoGm3qkfGli7gQ1OLr1oRKUz8+tACaMS8
	11Oz/C71iwc
X-Received: by 2002:a5d:5d05:0:b0:48d:ef98:1347 with SMTP id ffacd0b85a97d-48def981c24mr3045773f8f.37.1791992438439;
        Wed, 14 Oct 2026 08:40:38 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:36 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/7] stash push: remove duplicate changes detection
Date: Wed, 14 Oct 2026 16:40:15 +0100
Message-ID: <36fc0eb9130bda0ccae507433b6780c01fb28509.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1791992404.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
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

