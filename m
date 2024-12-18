Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0D3FC2
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485192; cv=none; b=bBx7h+UgzGyVhpiZulbF7HSsIUuaRKnIPbP6LBr0Dy9F0FZ4a4P4DpNIhQ5W/1Ukx3ithQ8RhZ4vkz+uuM2O6cABiAqCxT0cahDq72ksWlx3FhB0C3VEDAbO58drx8QAEUN5sTy15GHxD6r3qdrW5x9sm3UXYi6YdCe1pX4ocGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485192; c=relaxed/simple;
	bh=I4MxDOYgrdNhzRHfgTWnMEqbJ5ifcbdovAn4Cs2dXmM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MXIkES69bi2JxZwabUsss6cHhexEAg0qY9u8Q8IA7Zj6TLleCDokA4gkR9oQxUhyqwP74DQERvESkXJp9mpmJT12sPA9AcOTDkaGyokuz1KNKZSjlsuFa5OjhOXRZzG8bslSsC6B9L9gdMCgeYjn+BBbWvo+VBjsx8TxDl8T7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axlR0yGl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axlR0yGl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385dece873cso2780073f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734485188; x=1735089988; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Rl7XnOUCMtt1o0ysP+M2GOigaTr4YIRmqt5+0yRp8=;
        b=axlR0yGl0/cEEFdzBjc+a0tWugfUARIguqZJ4B3U3g2vfG9aELY7xPPku9r4eXhehr
         mgYOHvwUeY0ikx78jj3Q8jsBnZbi6AYBcx6oOHhLINjMCowF2FtfXFonIstfPL1vi5vY
         dFq/ABqgJ0a1VpQjla0Dju4Zz4AFtk+ZHYJp3Ix3rXTRDM5F8LUCyitKM66etF/Kp3Af
         sYdFGNMJcGkqiUtbm5tgMhrRGcQfzazej40WO5kkJjGRmKcusftfj6Q8c4nQLfy0uuZf
         d/BAzqDtjJsE7XNfxZR7U6FjeAWwnIVV+6rTeaGr7v06cuiOhpC2c54udq4lHrqvDqEn
         fwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485188; x=1735089988;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Rl7XnOUCMtt1o0ysP+M2GOigaTr4YIRmqt5+0yRp8=;
        b=MKqZWkGuEID6fYYolZhaSakfLyLYpYMjQZAWuLryuv+B5+bGGjX/De9fe0JufEBlgg
         S+JPFJxsMw0sRqK2PTD1hRluziwl6gVdxRXY/sahOMF2iO7qht/+9mA5BdeGE9XRwRtl
         ZXe9b/lQY0c5vDIJ/lTVwXaRdEhqLT/sfVkAwXYVJ+iC0tEH74jBMBfnEuliJbg5vZfa
         CrNnTq2yCOa8pROJWQm2+NbqMDFObE5F+i1XcobkLdE84vNC0R2VATTsMHZoCE3AOMGy
         TVascGukxvw/V16GEXxtWLfur4+FH0qFbpFSrW7Waat3BEIzMHeQkKC8nAR9XLgjKu2C
         ni6Q==
X-Gm-Message-State: AOJu0Ywy8IGDdEvvohmwlcJuUX/XV+zr+yBcobMqI22K98DB/2T+gXq/
	ddRjkJS88CJJoIjGkNi0R5CTUPRvUydNGC/Fs9eMbh2hZoPjoYq3L20DfA==
X-Gm-Gg: ASbGncvRDRMOqA1YZX4A5gAX3ZEtsKm4XP1JS84gknJAx/eiFoZW8b18P+p2Ist+KAL
	mcfMtQZQcw5mLKCIPXRrfQckcrjKXrzvTntS6O9tGFCI9M/9j5jZ21zf32hY00VpXpg7lQqgD0q
	l7dUaQKTkt1F2yH+BqKbgdoNQ8u0Q0ENaRvhv9JuqaKFBtpBhGBu6HxzSxqD0lZo10pJQqLcD6a
	Ys7mESRb2u7gQLn/tc6don/4CA7o6hMvgy27G4hoC24duZO9dKvR1pAZw==
X-Google-Smtp-Source: AGHT+IFBHQT0yr2HS6d49/GfDBe06hKREafRCnQnnNXzv4jI6SoG6EeJ1wrZe1n38DDGFoT7r34EYQ==
X-Received: by 2002:a5d:64cc:0:b0:385:edd1:2245 with SMTP id ffacd0b85a97d-388e4d5b3d3mr575640f8f.30.1734485188092;
        Tue, 17 Dec 2024 17:26:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656a18a33sm3897805e9.0.2024.12.17.17.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 17:26:27 -0800 (PST)
Message-Id: <pull.1390.v10.git.git.1734485187081.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v9.git.git.1734483511642.gitgitgadget@gmail.com>
References: <pull.1390.v9.git.git.1734483511642.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 01:26:26 +0000
Subject: [PATCH v10] git: use calloc instead of malloc + memset where possible
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
Cc: "Jeff Hostetler [ ]" <git@jeffhostetler.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Bagas Sanjaya [ ]" <bagasdotme@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

Avoid calling malloc + memset by calling calloc.

Signed-off-by: Seija <doremylover123@gmail.com>
---
    git: use calloc instead of malloc where possible
    
    We can avoid having to call memset by calling calloc
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAreaZR%2Fcalloc-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AreaZR/calloc-v10
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v9:

 1:  35994dfb8af ! 1:  d7b7959be0a git: use calloc instead of malloc where possible
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    git: use calloc instead of malloc where possible
     +    git: use calloc instead of malloc + memset where possible
      
     -    Avoid having to calling malloc+memset by calling calloc.
     +    Avoid calling malloc + memset by calling calloc.
      
          Signed-off-by: Seija <doremylover123@gmail.com>
      


 remote.c    |  4 ++--
 submodule.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 10104d11e3c..462ff105273 100644
--- a/remote.c
+++ b/remote.c
@@ -2854,9 +2854,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 7ec564854d0..7707c6f48f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1489,14 +1489,13 @@ struct fetch_task {
  */
 static const struct submodule *get_non_gitmodules_submodule(const char *path)
 {
-	struct submodule *ret = NULL;
+	struct submodule *ret;
 	const char *name = default_name_or_path(path);
 
 	if (!name)
 		return NULL;
 
-	ret = xmalloc(sizeof(*ret));
-	memset(ret, 0, sizeof(*ret));
+	CALLOC_ARRAY(ret, 1);
 	ret->path = name;
 	ret->name = name;
 
@@ -1536,8 +1535,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 					    const char *path,
 					    const struct object_id *treeish_name)
 {
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
+	struct fetch_task *task;
+
+	CALLOC_ARRAY(task, 1);
 
 	if (validate_submodule_path(path) < 0)
 		exit(128);

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
