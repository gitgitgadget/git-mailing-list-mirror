Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E96E61E
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061649; cv=none; b=tBy7agTZB5yqXdeBLqTd3DRNnUod1RkOTNtf9/OSAGfTebskjSyMQZ5KxCPLvesaJodFNBqyAMvcDpmKMWfyManpEFzfASgmWW9TmxbYi59LbWhI7ORfO4fglEsyGTIPifb4QNFPb67Hi40V8LkYP9Wa8DeF8Flsu53fZP7CG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061649; c=relaxed/simple;
	bh=VkRW+ZBkxA/CvtLiP78ty+3rxW9ryHbybS89zYiqGv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oM3p+9f/CcmuTCAExHPtf2Yiu7sQUDvub4G/u8dQ5bahodU/yZoN0TtGGIU8IbAkhj4jlgW1MbrB7aJ4nB0BZ01qDvlIQ59AxBynaFPwEQHuy5pPfAP3zWu777ekVjkxYZOq+1YXcHr2J1Nbl6QnEhhLPj2DjV0So2hZh6e/3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPGbUu5/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPGbUu5/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ffff16400so3792131e87.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061646; x=1715666446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgxw0fHacZoNXQLo7BaHZtOt/IT1F3iuSKCHI1fQRM0=;
        b=DPGbUu5/jy2KAJhfmWORe6/uCwDuf5Rbo2jM/VivCp9pOQIVItOSb5/EIGSiOKCQel
         H4aozabD+VrtW6mkv7Z6uRXIvon+EomH6UbpGEiVSmeYZ8OfZ62kg9I65N6ATmZEtRJD
         EzI2AtP+WWUrw975hl31caiincBnBQX05wKyZxUsIrQBu27Lvc930O2qhXN0Njd7BFjw
         xAazd0bg2wtMgc6z+LQjzYlMZJjb17f8n1GxrOw1Sq0NQWkeud2ghtQqYoUzHsj+PDxH
         t1iVTOhaav0pBOILSix5RgonRZxjpCgmy9a4tBjpMiPpkiyI7kpauh9li0VCJA/cdqGi
         WJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061646; x=1715666446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cgxw0fHacZoNXQLo7BaHZtOt/IT1F3iuSKCHI1fQRM0=;
        b=E9HRxB+9f2ODEfLGSaSbE/QdDbKPESafqLDPWGV2hBAc/xaerXLyekvZIaft/Oi7co
         jDbOQzpQC2a1ZtW+GYUgQJsIx8mVhL1DOaFZKpQuNiuW5GwOpagJTgl40/WfXhkBcxCF
         yXTzIKGP+zbLAJ9dXulu2G/hAVdPsuhm7ePKXqOGfD1P/P8zpUYZFoJTni2kvGsu/5OY
         hgOFQePdjagXwI41ZItWWgyxBq6Egov9EmRnk/eY5N0GBJZ7EIGBDUX2Lm0llZ2rED5C
         dhdFePY/JwRemnKbNgdnQb9YbuTuQx0n876+N6Qo39z6V55ywzgIM1oHBNPCH0JaSd7V
         USxw==
X-Forwarded-Encrypted: i=1; AJvYcCXGJvVCITNej5kg9b352K4dV4/m8qCK4cqg7uZ5me0KgmaQP1U5YrqN+t2d1XK5SCZWN6WGjby1+xHcZzJIkuHLSHRr
X-Gm-Message-State: AOJu0YwFVm7wzYkLaLb4nGUNNfWOZ0Yq0tnnfsc+tjDkvz+8c/olLDqj
	A6fUVu/l3LY8hiUQW8D6ZasOtH7OJeWSAUUSADWeF09rD8xedP+/
X-Google-Smtp-Source: AGHT+IFe9AndMfdvzCACSZgwvnfNMR/BysLf6Ld0A4bYKB0asf5/h+n2Zk7KtGNmnrZ3mgGYSRsTVw==
X-Received: by 2002:a05:6512:36cf:b0:51d:4c8a:bbdb with SMTP id e15-20020a05651236cf00b0051d4c8abbdbmr8844644lfs.3.1715061645625;
        Mon, 06 May 2024 23:00:45 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 2/8] files-backend: extract out `create_symref_lock()`
Date: Tue,  7 May 2024 08:00:29 +0200
Message-ID: <20240507060035.28602-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
 <20240507060035.28602-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The function `create_symref_locked()` creates a symref by creating a
'<symref>.lock' file and then committing the symref lock, which creates
the final symref.

Extract the early half of `create_symref_locked()` into a new helper
function `create_symref_lock()`. Because the name of the new function is
too similar to the original, rename the original to
`create_and_commit_symref()` to avoid confusion.

The new function `create_symref_locked()` can be used to create the
symref lock in a separate step from that of committing it. This allows
to add transactional support for symrefs, where the lock would be
created in the preparation step and the lock would be committed in the
finish step.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 51 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7e432cf026..40cc715ea7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1919,27 +1919,49 @@ static void update_symref_reflog(struct files_ref_store *refs,
 	}
 }
 
-static int create_symref_locked(struct files_ref_store *refs,
-				struct ref_lock *lock, const char *refname,
-				const char *target, const char *logmsg)
+static int create_symref_lock(struct files_ref_store *refs,
+			      struct ref_lock *lock, const char *refname,
+			      const char *target, struct strbuf *err)
 {
+	if (!fdopen_lock_file(&lock->lk, "w")) {
+		strbuf_addf(err, "unable to fdopen %s: %s",
+			     get_lock_file_path(&lock->lk), strerror(errno));
+		return -1;
+	}
+
+	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0) {
+		strbuf_addf(err, "unable to write to %s: %s",
+			     get_lock_file_path(&lock->lk), strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int create_and_commit_symref(struct files_ref_store *refs,
+				    struct ref_lock *lock, const char *refname,
+				    const char *target, const char *logmsg)
+{
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
 	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
 		update_symref_reflog(refs, lock, refname, target, logmsg);
 		return 0;
 	}
 
-	if (!fdopen_lock_file(&lock->lk, "w"))
-		return error("unable to fdopen %s: %s",
-			     get_lock_file_path(&lock->lk), strerror(errno));
+	ret = create_symref_lock(refs, lock, refname, target, &err);
+	if (!ret) {
+		update_symref_reflog(refs, lock, refname, target, logmsg);
 
-	update_symref_reflog(refs, lock, refname, target, logmsg);
+		if (commit_ref(lock) < 0)
+			return error("unable to write symref for %s: %s", refname,
+				     strerror(errno));
+	} else {
+		return error("%s", err.buf);
+	}
 
-	/* no error check; commit_ref will check ferror */
-	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
-	if (commit_ref(lock) < 0)
-		return error("unable to write symref for %s: %s", refname,
-			     strerror(errno));
-	return 0;
+	return ret;
 }
 
 static int files_create_symref(struct ref_store *ref_store,
@@ -1959,7 +1981,8 @@ static int files_create_symref(struct ref_store *ref_store,
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

