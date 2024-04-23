Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA914388A
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907707; cv=none; b=dok34ONXzPy9J+M8dCezGoW4Vbbv4bbMZ+K7KQHJsAdpyc7j8kJOgDjYAmDqIcJpNetV+I1u6yMPnhHwxmjai+3VnrkZQ0C8wpFjgH9id8FUfc8RL8Ejw0XXoJqxe3JVGmSzrj0X8c88qBz0IHsPqH/efEB56NncCVrgFs76B5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907707; c=relaxed/simple;
	bh=orGXPgisydaJqUHfbfDCBIOnxxMoAGsrT1Ao/VkQcf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4UlQYhlPIT2wG+jkf0OFOemq0yRsQ3ZquUgzPIn8AM4vphKv3grp/Zj6iCwvy6qfIyFKWaCOhGkNLKPdN2LZAWaff/MVrnRdY/oZ7YEveS1Esruq9lr7Um49H1a+/iAnPmDm7diqDbytGWivLC+lBnHDXxUVkojFcIlfrD6ENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS+dfB9+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS+dfB9+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-417f5268b12so65373845e9.1
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907705; x=1714512505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/kSQo4mqApEZDGjq/WK5IpKtIuf94M1WAtNmj93rjQ=;
        b=OS+dfB9+8GVpAC+ZYU95GApNjD/+OzFJq5ufynQHHINZ6asl8hN+Q1h35VkG1acRqo
         1RY8Z09p9dOadEIfEgatyTPk7WZqxhqvUXlRozOJirXomWXhopudcHFlSwHVLM/loeeV
         K3sdVeeWA4zHpQgjnl+W4pWCfJCIzg5gBCqNykKbJcqErA+lHkURuSNpT4FbkDxPKEXt
         uBkDZWab3eyE+3IVs/x9aEVz6nZZIKC3z72X2CokX8f/GY9Zbz/mYvsaJ7UqxN8H2mK6
         XwkFUtiPAIB6/3r9sEsf1MdTi1P/hwZRdScbfm43aTdd76tUzp192coBLFs9QXxQfArX
         Bhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907705; x=1714512505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/kSQo4mqApEZDGjq/WK5IpKtIuf94M1WAtNmj93rjQ=;
        b=GnBjG5DHit2Yn+VcE3sg8ZO8ZaG9S4yYIoKmNltu860s2rBPp8EkH2H/w8zm5Ga0YM
         fqtFlU4xgtFV2q6rOig/hkwRsoCEVEVovdxkn7lV+fqdCJGnuLF7tTM2UbZQEimPQpiY
         o9FbUS3fZeqgTthmbALuQfy8E2f+KVQuUqxlnbaH0iLFfVCFzUu4+RvPNyiOrcroEmea
         hLFaDOB2oup13p1llxV4iRxrNVcs355gGzP9DuClHS2rPop3ofNsDGLotP/8I+9YuUuG
         gKpa9AC7EHRO5BC/kAEBhlwpRufyp2gDRZCUnKCHfTGgpjuBri16IChiwNMwAP58/qg9
         cN1A==
X-Forwarded-Encrypted: i=1; AJvYcCUc1rZ+0y3zF4E0ncjVnbzVU/howcwGGp2/3xeDn7r6atHzVTW2pPYu7JwNGWsjkXU2fntHjRnAHvieeHAU3ydi11/n
X-Gm-Message-State: AOJu0YxWuX8OOVPs+hUJIdlJ7FsdBrdUrI+vgWl2qptb9KEmuRlON0Lk
	x5cJKdzhNekzNrmuTu+bwcdH8NRwhjacyJQx4UGyLrRBKFHpYZRu
X-Google-Smtp-Source: AGHT+IFpSI3o1EkPXU47tlppbpY/XgdoHsDy6WdvdgWidQ7iRcuSifmPgMthPONfKnLZp59kdptzgQ==
X-Received: by 2002:a05:600c:19cc:b0:419:a3f:f4f6 with SMTP id u12-20020a05600c19cc00b004190a3ff4f6mr478846wmq.8.1713907704620;
        Tue, 23 Apr 2024 14:28:24 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 3/8] files-backend: extract out `create_symref_lock`
Date: Tue, 23 Apr 2024 23:28:13 +0200
Message-ID: <20240423212818.574123-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
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

