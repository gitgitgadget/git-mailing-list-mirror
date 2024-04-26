Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAF14882E
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145098; cv=none; b=Pkr9FnPR7x8JhAwFIPftiC6ztrmS6bBFNbnjgM9fb+WrAoBFdrUg58hWwHuV1mW+xPkFN3WuSH3wKvKv91R8anC4EGx0o6rLnnw7UcDVLeaVDce7ovBwoevVpDIwV9VpTM0m/WQz7OE9/uuOrCXuoB+OetB5mMWgLQE6c+vWKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145098; c=relaxed/simple;
	bh=orGXPgisydaJqUHfbfDCBIOnxxMoAGsrT1Ao/VkQcf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvKlKpSPoxeQxFm9lOGRbf73gpamLkbm1szVfGxEIXmm9w+99SVSEe52YmUiaY01Mg2sZNxYEQx8em0Bw9RBtDqHyUGUKU9gUQNqgD1kkxOM88vRYHlfiZH01ZZXAOr0utodmafQDwTVJxhlXpbABNd2HV4Az2VujCkhpjwQvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK5tY19Z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK5tY19Z"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57225322312so3273282a12.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145095; x=1714749895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/kSQo4mqApEZDGjq/WK5IpKtIuf94M1WAtNmj93rjQ=;
        b=GK5tY19Zz8INunVsUnHDSb8UGrqXJVCFvS6+6SjMH6ankvxoJ0AN5abj0CzXGChlmw
         vFL+ugho+lp41YwjBNW4XIaP/asKI0CgrZhYTOz1SCbOwvB8NjmNNnZUFUi5PTtRwy8t
         LK8PjXdjHc23i65xF39LVG0QbATsZMslt88mgFpYWdOkaOucLv2QmO0wQdYkFIhebFre
         rY66DKQwKAUWrx//k4n9JBlO56WBE6eFfSL9WjoqsgEG69MVQUSOB4KIVnk5zleoFpa7
         4QshqirwGThiyblpuI8xQRJq8ZWUbQ0HxAqmSaPJCkXKBoPNyqCn98MB6Gc1ero+Gi+J
         bb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145095; x=1714749895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/kSQo4mqApEZDGjq/WK5IpKtIuf94M1WAtNmj93rjQ=;
        b=GGb2u6DhF+yLdiWEx6xdwmlvRpE75jEy8rz0v/VHbfrNodFRqbIAj5F6WCd2/rGUEy
         RKjAxoIsUdWT9sukKIzmDpfR6K7+mQZZoHmHTyOgK6t1z/LsDizGDxW1PtD3vhE/ND5J
         WM9U5oIo/QioCl4HS7kQkoegM5EBh1H8GMcFEFsODmfUAb4zTo5Pxh/zSBWp+LZh1drF
         I0SABN4Ngt5ESWKZsyeNlyVcR0oP269h0paiyQWB1WzF6IhuPfP0xmz0nJhXPZsNJigV
         HAXMHGlJYAIa9H3Ea/GDp5AUiiAsJnckyaK6Nn+9gXUOs1Q/KMU33yFmFSh6EytrDD/l
         l2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUkLws/lYKDX22q34gBvxZbfY46PN+KTWihRnP/IbgDeyFz6O/jFa5koFiOeYfTLHk9Gn3nI2S1PWL9qN88Ss2gniJM
X-Gm-Message-State: AOJu0YxSMTS9ALOvM7nQR6KODzeC26gwXNt+K8NdWWaKH6iBbp6Q9sOG
	iB+bzBJPfW3itND/gn0uXBeOgEnoW+UsgoVMMfeZDql0oBD8bynw
X-Google-Smtp-Source: AGHT+IEuAC0qWi6haLNvAb7HMim1Afk3XxW1yBkifkdwKJmLTmJhiihZqfaZ/0sSF6UgDM27DfiBPA==
X-Received: by 2002:a17:906:5617:b0:a52:56e8:2294 with SMTP id f23-20020a170906561700b00a5256e82294mr2205130ejq.52.1714145095405;
        Fri, 26 Apr 2024 08:24:55 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 2/7] files-backend: extract out `create_symref_lock`
Date: Fri, 26 Apr 2024 17:24:44 +0200
Message-ID: <20240426152449.228860-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426152449.228860-1-knayak@gitlab.com>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The function `create_symref_locked` creates a symref by creating a
'<symref>.lock' file and then committing the symref lock, which creates
the final symref.

Split this into two individual functions `create_and_commit_symref` and
`create_symref_locked`. This way we can create the symref lock and
commit it at different times. This will be used to provide symref
support in `git-update-ref(1)`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e4d0aa3d41..2420dac2aa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1920,26 +1920,39 @@ static void update_symref_reflog(struct files_ref_store *refs,
 	}
 }
 
-static int create_symref_locked(struct files_ref_store *refs,
-				struct ref_lock *lock, const char *refname,
-				const char *target, const char *logmsg)
+static int create_symref_lock(struct files_ref_store *refs,
+			      struct ref_lock *lock, const char *refname,
+			      const char *target)
 {
+	if (!fdopen_lock_file(&lock->lk, "w"))
+		return error("unable to fdopen %s: %s",
+			     get_lock_file_path(&lock->lk), strerror(errno));
+
+	/* no error check; commit_ref will check ferror */
+	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
+	return 0;
+}
+
+static int create_and_commit_symref(struct files_ref_store *refs,
+				    struct ref_lock *lock, const char *refname,
+				    const char *target, const char *logmsg)
+{
+	int ret;
+
 	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
 		update_symref_reflog(refs, lock, refname, target, logmsg);
 		return 0;
 	}
 
-	if (!fdopen_lock_file(&lock->lk, "w"))
-		return error("unable to fdopen %s: %s",
-			     get_lock_file_path(&lock->lk), strerror(errno));
+	ret = create_symref_lock(refs, lock, refname, target);
+	if (!ret) {
+		update_symref_reflog(refs, lock, refname, target, logmsg);
 
-	update_symref_reflog(refs, lock, refname, target, logmsg);
+		if (commit_ref(lock) < 0)
+			return error("unable to write symref for %s: %s", refname,
+				     strerror(errno));
+	}
 
-	/* no error check; commit_ref will check ferror */
-	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
-	if (commit_ref(lock) < 0)
-		return error("unable to write symref for %s: %s", refname,
-			     strerror(errno));
 	return 0;
 }
 
@@ -1960,7 +1973,8 @@ static int files_create_symref(struct ref_store *ref_store,
 		return -1;
 	}
 
-	ret = create_symref_locked(refs, lock, refname, target, logmsg);
+	ret = create_and_commit_symref(refs, lock, refname, target, logmsg);
+
 	unlock_ref(lock);
 	return ret;
 }
-- 
2.43.GIT

