Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E36C2FD
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658309; cv=none; b=BcVl2fLY7V8O9ZYquFzGZ+0e1/qkHE/YRY9DBPIC6YhzW/oUYBgpsm/GwZODrQMDgBenaBK8okwqYqGwjax/Dv1CGmU+YGloGrU5gEPZFGCh9cv2j02NAzS7I7bp5OmGWZIYNjWm/O4Ctmq3WQ+4nq7seV8ZYdaeV8QbmubdAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658309; c=relaxed/simple;
	bh=X7z8wM+7z4Wo03bBfMBc+EcBTjaJj/HA91HRxeVfVXg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jpD+3mhgBzvDagpUF7JHiJtpX1dZzo44oZhXTCPT+pIxgRjOdk+Sa7Kqa1JOB0iLkw3RWxgfuvOtFqQLYAVky98Yfch7t4E5awkThNMJqg3+3lkdOJBDgAevv4XhpVnhzyFsNWNZe4uJDKbU9D3fYhTWa4WFzlUQ/a92DiYfZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZsHnSOb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZsHnSOb"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d228a132acso6345491fa.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658303; x=1709263103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Mj+I5jSFetbDnyRBkw1H3MLII/QvfFpIXksGvxGp74=;
        b=NZsHnSObnUowfGMSdpB7/OUCw0CRxXQxT/NGAMZfPrbZ0xy0rXgyM7CngcABB0yebq
         P9w0jAD7mlz8e/k287VZtV6PoAxliskNx3CoLJuTSC1IuYoXVT0N1JCmw70iS+Ve83Rk
         gRFHEKp6Ba51lgzoFNKhP3d2GYxZ430wkc37BNhXzXaSwCzRiCMOcUljaJWSUw/3kI8d
         7C16gY8bQ55SDMk/LQ6H1C714ihNTWYh4G0/asVJAwpKxdrE1mvf1SsR4ctL5cPwe/OM
         af5DTC7OX1PxbsKNNx38x/+3D3p8H8dgIXXH11q9dfPIEKSbTkFd9KZsyW0gUIHG3o8i
         f46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658303; x=1709263103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Mj+I5jSFetbDnyRBkw1H3MLII/QvfFpIXksGvxGp74=;
        b=luTlWlGc6RVc5rPUMlS+tLdGf4c3u7LivwzHULH5cU7f+1u4612A/UfNJTy0s7v4UQ
         LGFVrNBOxj4N52tX865AhnAIwbeZ8QHb61D3R08wI8OoRShBKB7OwgzdPPYeki0PUpvM
         3/Q+R3JizlypVP0LWrD3r1+64W5NGNx/YV1DyqE/4x6FP2VA9A+pL8dblJpBljL0pEsx
         zmGrIRlhET0vRUCM+80CeatZhOUfVdA3j4Hii7nbxiRqdp4QAMA4Y49KJA5xlUX3G1G7
         Psn5tkuif1ET2/dnSsD+xRtExe1Wsd19HCsw0oQHGFxPzGwJ27dPn73+IhDIxp4oPLCv
         XvdA==
X-Gm-Message-State: AOJu0YyFeHlutFvwADSHfKz6+vb6VP882rkcd+0dpVCswaMkkOU4yW8c
	1ZnDEQRDq/hBzj2Exye1qInoT7JG4qR583MiEAc+Z2/JaTY6PnIZiVrtVcgC
X-Google-Smtp-Source: AGHT+IGHBautectAYohF85KfJm9cMIMD0TGlXWRCz84fLVls03g3m6dH5zlZolXZpUOxRrXkVYmPPw==
X-Received: by 2002:a05:651c:211:b0:2d2:3f09:ca3e with SMTP id y17-20020a05651c021100b002d23f09ca3emr407765ljn.50.1708658303063;
        Thu, 22 Feb 2024 19:18:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b004128812dcb6sm583597wmo.28.2024.02.22.19.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:22 -0800 (PST)
Message-ID: <03b07d9c25edb951db4de518212f8a3e9e184e49.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:05 +0000
Subject: [PATCH v2 01/16] name-hash: add index_dir_find()
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Replace the index_dir_exists() function with index_dir_find() and
change the API to take an optional strbuf to return the canonical
spelling of the matched directory prefix.

Create an index_dir_exists() wrapper macro for existing callers.

The existing index_dir_exists() returns a boolean to indicate if
there is a case-insensitive match in the directory name-hash, but
it doesn't tell the caller the exact spelling of that match.

The new version also copies the matched spelling to a provided strbuf.
This lets the caller, for example, then call index_name_pos() with the
correct case to search the cache-entry array for the real insertion
position.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 name-hash.c | 9 ++++++++-
 name-hash.h | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 251f036eef6..3a58ce03d9c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -685,13 +685,20 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	return slow_same_name(name, namelen, ce->name, len);
 }
 
-int index_dir_exists(struct index_state *istate, const char *name, int namelen)
+int index_dir_find(struct index_state *istate, const char *name, int namelen,
+		   struct strbuf *canonical_path)
 {
 	struct dir_entry *dir;
 
 	lazy_init_name_hash(istate);
 	expand_to_path(istate, name, namelen, 0);
 	dir = find_dir_entry(istate, name, namelen);
+
+	if (canonical_path && dir && dir->nr) {
+		strbuf_reset(canonical_path);
+		strbuf_add(canonical_path, dir->name, dir->namelen);
+	}
+
 	return dir && dir->nr;
 }
 
diff --git a/name-hash.h b/name-hash.h
index b1b4b0fb337..0cbfc428631 100644
--- a/name-hash.h
+++ b/name-hash.h
@@ -4,7 +4,12 @@
 struct cache_entry;
 struct index_state;
 
-int index_dir_exists(struct index_state *istate, const char *name, int namelen);
+
+int index_dir_find(struct index_state *istate, const char *name, int namelen,
+		   struct strbuf *canonical_path);
+
+#define index_dir_exists(i, n, l) index_dir_find((i), (n), (l), NULL)
+
 void adjust_dirname_case(struct index_state *istate, char *name);
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 
-- 
gitgitgadget

