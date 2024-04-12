Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBC53816
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915968; cv=none; b=AXLFqqJJAGxkUqF9gbH+7tk9VZLdlPUMkLFCb7CjW0E1gdP6utZhrBpL++cD0N12jUxHYYfbvh/jzhsgPtbemeALPW+RUYcKc5ntC5DyYY6b+gmGJ/vR3Ofr6VmxQ5RgUTfEqJnTTZswrzvj6+P9dQEuCTJQzlxDIbC7dKUKtps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915968; c=relaxed/simple;
	bh=and3QQ7RfKzckgH44i41s0OGJmI4mzOAcBnlOngDSQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qr701z9vy2jS45QgcguHC6XJjuljmAlO5ORlMIwvaMhb32F3KBOYA+srx9Fq1q6fKk6vwJudb+C9mxw0K5C7mH4fOryeaeZrgjDGfz3ZffebhPyk/dEh95wAsQJqj7f+WydVnWK3G4NdlYUkRtsSvhDPKb5X+pfhNtedEh9jxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZZwe82c; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZZwe82c"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so708556a12.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915964; x=1713520764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqrkk5OOJePR2wnpQ/Lazzh/A5xC1PF+z8Cv6OPYIg8=;
        b=WZZwe82ckWWsPWXDMUJRtk/sNrAqjpw9GafuWplOVQMFud0y/WUhnWHvjxoL2O/djw
         YHV1SdesRfq9nRX5YZvQoIN6cCIddBvLFX6+xT1pnmdddZJ+sBaclkhFrjDUU2ssPAj0
         3J3KjWE0YgFVJXXDrA05rAZ9WYp55z41csUP9XVqS/DVEhQ8Kb2ey/lwXLF8wWtsKX9F
         1MFx4U708tSKW1iExJ6utcgjKv5r9nExY5emmLcsjBlnGmTsigdshrgwMZ86AkRznKv3
         H7nQBjrPYzdro+8YoU5uOj2V+rMWwBHml6P+VpLmf1MZCYxCBCc1ygx+citnwXDu3y7H
         lADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915964; x=1713520764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqrkk5OOJePR2wnpQ/Lazzh/A5xC1PF+z8Cv6OPYIg8=;
        b=wDdZUni9GJDo3fIog9aCLaXgkgyIchul62vh9BOubzwN8203+xIfakgErqgb8dXFvg
         dl3cwhNZwuTGjjR2FihguyI4EYWF27MBwXKGY1JBB2Op0LT742KVY1hPF3ah81QWr5xB
         vJug6xudAl3/jqORFHuCASP7PJuJd59ergxu0mVH+mPeUUt/9vTGXlYWPCxuzyJMvNdX
         /ttwD+uEbmgLuBsjdmgcM6ak36H/NhDZIDQO603iACJMCu6s/YYIBj6zBI7jheXDcmpm
         XkrJ99uwsbkn8c8/MhAdMzAZQPd6WwmW7DdwIl/tm/ULzxhs3CGBQnF1jTbAjN2yqe2R
         EcYA==
X-Forwarded-Encrypted: i=1; AJvYcCUOU5VzD/HRAoSik73kZ5xuDYtePkdRrmV2n4+BbZOV4hhyxSx97m72T5c11Lx2j8j3ACECBxlA9lPVMvoEfxth6xyE
X-Gm-Message-State: AOJu0YwX1TC6JvzzQLzQc3mk2RBDTyQBKQmWgP3Tes2zzZ1Gb/c9hTFj
	EFBcaUusqHXRUaH4JRUjaT3bA2qSoJ+O/OIJcbF+R0cGFN9r7jNV
X-Google-Smtp-Source: AGHT+IEmwroaT80S9f6nJb6qyIV09LdmaGpjUTPP/nlbdTmO++K8D/WEZ4p9vdDxRstkAIRAwfDZRQ==
X-Received: by 2002:a50:871a:0:b0:56e:3072:3cb4 with SMTP id i26-20020a50871a000000b0056e30723cb4mr1631507edb.22.1712915963928;
        Fri, 12 Apr 2024 02:59:23 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 4/7] files-backend: extract out `create_symref_lock`
Date: Fri, 12 Apr 2024 11:59:05 +0200
Message-ID: <20240412095908.1134387-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
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
index f74ea308b5..7c894ebe65 100644
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

