Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490E15E7E4
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086752; cv=none; b=B8E/4d+wRwPHeaK6imGcSNO5cdT+bjdd1rT2MWBfdiUSKATnC8pADFWcstPccBBu11D8HTuexHwAQ+JRsFNrarXjaUNm7nWtLcC/T3TE533Q6fv2Z3f6Xp/tGpVQDFSvmJCud1Kb5EItAer5iJY5QVWq5XJCiYSZ1qPqcBaPK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086752; c=relaxed/simple;
	bh=/z+GjUanz0VJg8cfRSx5x7luD4TqFaFjagpMOYcgiek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLqWqQfkcAoS4lYKaBZKheTCEZLAXbjocpjaPVhUbPw+wZQJ+ExhjNzlMoEErqEVz5TBYK/K2LAFg+IWjDN0gtwm1ok0yp9a+DQVmtNMF6BpiQXi1QuplRmAbAGTRA1/aldUPxWqAr7sdOUcNBZ3XrPSeLJj1BCccFRlz/NPWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQHyAD68; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQHyAD68"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34d8d11a523so1448787f8f.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086749; x=1715691549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FERSfw3Ff4dZG+nIeAH/tJSTfDrXGZVZI6a+PJbbfNA=;
        b=lQHyAD68oqL9maJgM4EkbwQ79SxrhehlYix6iUZBKNJ+1cy+SnJgT/XIe9bwSGbDM3
         N/+NMeLbSSGS2QOHnHLBokVII9wqruezjdQ4Qliq3wwrnXNm+cDJLmPLlqS+IyXYZJ1B
         qcWz2ORKn+whyI3dFAt1ZxgZg1ki2FCpXA48xhUKXHAlxwbnVjf7gZsjaaDWfC3PJA31
         +z4wJhmTvHzNFhbdXUAymTrtBN8edNXYUYo/LK97x+tzcL+wYkeNRf4LuIpaG63ZvEDL
         h2qQqC22mC0TMh3LZomioAnxnOylbcOHwGhu6sEHcD9X8n7nBSLsNoRvac3JGht7j7PA
         UNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086749; x=1715691549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FERSfw3Ff4dZG+nIeAH/tJSTfDrXGZVZI6a+PJbbfNA=;
        b=f/RJAXIspOtNX/dkxkQhx6QQJ4F8LzdHa2mgkjz7lGAbC9gCs30So5AIpvWKLmnhYj
         8i9FA07VtKRd37ghNV6gsdGVtup6Fg1xjPtLVADGir3uhW3q4GdRNAPwcxoAN0cfg8Lg
         QibOx1sX259NeYysQVIAv57ZMXZSvCYecRrkbPMLf5n72ZK+wUqRI4ztD6m9GMof1TsA
         MEnprpn381OX0fDsINM8KMrGWipP1tmlx9cvYOg86tu7tzsefOyX7yJ3kr67UtcYahRd
         kqeES7TUHW7r1pCALpeMUT2n3MBzULB2Hxzgb8M+ZO8jcW3C6N6cX6b1OvPrwogo462D
         36QA==
X-Gm-Message-State: AOJu0YynuUam+tLwCINPSaBQKeJDeOfJofnIXN/pZeZv/grY67EgKjOc
	QK2D6G9ukK9uRyDdkXuJuEWa/LuY6/zI8tp5jhxPjPOz3IbpFUGf
X-Google-Smtp-Source: AGHT+IEMiqUCsWLzUyhoRPqE4jG2sbXVB2bGXmREmDFAaUi2kn6YsdmNwn5xUF+fWWkpFj9Tg1ljVA==
X-Received: by 2002:adf:a41c:0:b0:33e:c307:a00a with SMTP id d28-20020adfa41c000000b0033ec307a00amr8887396wra.43.1715086749508;
        Tue, 07 May 2024 05:59:09 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:08 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 2/8] files-backend: extract out `create_symref_lock()`
Date: Tue,  7 May 2024 14:58:53 +0200
Message-ID: <20240507125859.132116-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com>
References: <20240507060035.28602-1-knayak@gitlab.com>
 <20240507125859.132116-1-knayak@gitlab.com>
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
index e4d0aa3d41..74a713090c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1920,27 +1920,49 @@ static void update_symref_reflog(struct files_ref_store *refs,
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
@@ -1960,7 +1982,8 @@ static int files_create_symref(struct ref_store *ref_store,
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

