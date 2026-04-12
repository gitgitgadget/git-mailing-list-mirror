Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE437B416
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775994712; cv=none; b=lw0HbI1b3ZKO7s6BznTW3hs2ucrEpLG1DyFpInBYYD8Gi2Ne3lueUakLpRFlmaaO40zluMEHk2KYMIGBDZELTqslKKUzRbjVlRtU7K6QgaK7O2Wn8+ofTjGh7gnV+fLlXgjoaJSiNOZRl/NnfeufbgX52k/Ddjd+Dnk3A2pp7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775994712; c=relaxed/simple;
	bh=wM6X1kOQ8RlWuvfEoeb3y4LRctIqntGIPQzSL9sCO5Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q2moEVofCTc9/b4ey2f8gKxBOiTGSOd3nj16Kj0yot/TPdM+mZ8lgZRVz7gGsdPsY+juaz83fOEm8xAUF0IB+X/owCQzCjozefU8nPsuj2rcG65Em1vVLXS6p1DsJqRCnM5+VQJ4K4lBhD7XP//KSpZqLn1Cldr1G6K1j39Q9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sx5+DZJy; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx5+DZJy"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2d64c756111so2891432eec.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775994710; x=1776599510; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45kNGcKZbNJJ2R6xHYB9UH7NOBs25a7xMtYNOIXh2zs=;
        b=sx5+DZJy0MaDzcdAscOx5vXoTnvHdGz4oBLyUnt/rk92ten8OySJmN+W+NOyf+BkV0
         8a8zSvUVfyFa/2vqBuzcBkPw+ZrIOmhOcUhikSWcA0kx+bJZzgb8PXjDFHLo8EJqnxjI
         suAQJmAj3zsdcC4LJDkwlJSql6JJ1SRkiq00YKAVkqRNGJYCgKUumQeGmGzDfOR7x1iF
         vJA123gG45iv8wcn/7GFzpCx6xOGJNDxXoqNGUKMzKIbwZlcnWLfkaS4Xi80fCIrRNit
         zCTyr7X6RWMaixfZngZl7UYrBPR+Hib5p25hYYMn+MDvDXZjl85OmTCypmVxcNXnN0C6
         Fyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775994710; x=1776599510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45kNGcKZbNJJ2R6xHYB9UH7NOBs25a7xMtYNOIXh2zs=;
        b=Tq0xfVNWAsX+BjEXkH9e6CWrA3LlY1T4Ch/RKjDZ3dEre7Dl8BsG6+pNGyUtIjZA0Z
         4Js8OH+SzLTPJST89F+GrHuq81vvYAQz0xW6JMzG4zeN1bpjzmXwwDMMyikUBzR5JAml
         FBUhCmWEKLeApeZ2bIZ3BM9chjkFuhWLp1Ov/xqZXl8aUAxHk9r77xJJQ2N0qkT9X+He
         V4OWwY1SfE27dRQgFlVYZHNh1T3A/2J71tVLwaY3/7GIG+ixVuR/0H8KcPUv0HK3JIvf
         Ule4c2AVq6HW40HM6ZdlhIDJxWcbxHBC+XlCi8u8itu4gXeD8u/zSTpVuVQijI3766K5
         ePtg==
X-Gm-Message-State: AOJu0YxRweEDzP4cuIllswo4XVxpTgCB8+01qYj0HKvnb4msAhbWqDOm
	VoVFyWaBgPOguksEdQQK8Oi+Ze3ELp1Y5fnVVZw30WNL1Be9FARmw4x9/PN7rg==
X-Gm-Gg: AeBDieuLJYCZ5VFosgRRkeSm8L3lOciUl1Rt3/1prrElYiVhTfEqzN3zvQ4kwwIrrrh
	rbqkF2K7deBXl9pmaqwnRRi1I6i8Vy/EYt+RgAiYuaDb+HkBdGp4tz5ga4x/Z2zePF3X+a2yvtK
	6ivmjsfuvwRhZ02XlabRMsI2qLoLEyOF+EX9ae0gj4/m2BSyqwmO+hV/DbSVt1xOoU7ZlUWraUv
	z0XSzkm/KQdSAk+9U866v3DRnPBRRTwfmsl/tHl839SAlaMxi4nZrzpVMe77A+RO1NxoS8c4B2d
	F1x1dMBy0nT468cUpkYQD4Iig3GGGTt3NzRHOWKNpV+euXYLblr9MiYT+SE2y7O2M/Ub4Nv5aSP
	zHe8GnprrWYnYKOd6LOjErzqgLh1xyzH9G3marrKQlVHHmLcVx/Fw/beL0TyD5w/cvOWb5YO08g
	F+7JOUiADBu6+T5ApL+Ms5qmkRq3wO
X-Received: by 2002:a05:7301:6706:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2d5881ad264mr5946160eec.14.1775994709654;
        Sun, 12 Apr 2026 04:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm14720046eec.18.2026.04.12.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:51:49 -0700 (PDT)
Message-Id: <8173a4eb724646e66aaf6cd8d78b1560e18c14a2.1775994705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
References: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
	<pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 12 Apr 2026 11:51:43 +0000
Subject: [PATCH v10 2/4] sequencer: allow create_autostash to run silently
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
 sequencer.c | 15 +++++++++++----
 sequencer.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..1197d7d8a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      bool silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4702,7 +4703,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4716,17 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, false);
 }
 
 void create_autostash_ref(struct repository *r, const char *refname)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, false);
+}
+
+void create_autostash_ref_silent(struct repository *r, const char *refname)
+{
+	create_autostash_internal(r, NULL, refname, true);
 }
 
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c..570f804457 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -230,6 +230,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref_silent(struct repository *r, const char *refname);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

