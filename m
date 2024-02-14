Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8845813F
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920741; cv=none; b=mUMrhyDrxzLx4n7ijyy4pcE71jAmdPvi7GJy1l+2/2oqghjr1PZDQDPS11N5wNoKjpxN+zNoCNGvGpmRWC83LLwyjOSdcGdXI22oRdsBArYhoo9dRcxCP8ulVxjBjdDPcfqDEKiniG3gKRqVsnS3kSRrem4I1vLC0Pt8YY6Zy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920741; c=relaxed/simple;
	bh=5nN7PCkMnOl6irnT2/UCukUhG295v3VwjpAuyBWB3jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=folr0Q6D32MFLFzFujssgpo0hCGcLx+HMc+797lJ8Xol2qDq6Mn4ClXUVT36JLspi4hvx5H/gG8cn0jTUzFwEIjzr2anQD8Itzes5Sz9a3cB90B90wfVKbv3cSnteZbzW5Ml/I0TgDCb0i8iCFjrJmPia+yXn3M6I8AZojV9krY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvLIT+MD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvLIT+MD"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51167e470f7so6800731e87.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920737; x=1708525537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQMITNF0upK+7gZ4ZuIZ67TW7nc5tOPXMcQcm2qM/vA=;
        b=kvLIT+MDTzkOLMYNVe1gUGJ5xeC+C/OmLqmgY8y+RO3jw4eb8F/57n6QX7HJV6k2a5
         cqw89LS5qInvcfcoiLH9GzzYzqdpaybdXI+NR+GOkobJ+b/dd5+XRwtyU/UbJhgG2woe
         OaJn34sNI+P5N4MOZWG3umH4fgTqDoPLZKYXTpB76b6REw85OobJZ0fXgmE9bpZlW5KA
         M6kTnQibX99Hj9x6viavMHhm/mSHsbvTwekUPjq4A8j3kfevIOi09BqQvBhoBAycXX67
         AbYvg8qquOVx6NX9B6ZU+n32MTNfr3siUASUOe1qIy9Q/hGhBdMB+kx3uIM0MB3yes5Z
         0JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920737; x=1708525537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQMITNF0upK+7gZ4ZuIZ67TW7nc5tOPXMcQcm2qM/vA=;
        b=SVS6UkvPBhEZTvnG4XXx2c7W6Ehl6dkzIDqn9OtXyVgCuUHYoPUP91ItnTg92x4+lS
         Zuyz15/U2ioJQ7zwGual8/c/eol/YsOSGW8wto6MeKP/t8nMrlEfVe7aKdk6d5DtpWqh
         OLzpG2a+MK0lAt8rsBZo89iqLC9KGlTgKQC54nVV3HH+LK7xZrrufKakhGB8kndtn919
         f6HKAAeUORcjeLmfLDH9U1tvlgu6s+ky4LhgE2SfOFsdU88iKJXQ6IOwZhnJFk+e3hcL
         pJlrr1foNTVlHf9tbzg2T3wCxQODBXZ284UPvCyyZgeLuzXGeUMI0Qq4eZd0n7zM5A4a
         YqFA==
X-Gm-Message-State: AOJu0YyUh7flVscJ3iHrZI7vY/yfyjDzG3palXnGXtXwRXDmUAA1y1Ew
	8+stS7TzSpEIKPFDzv1odfjpxqnkc7glyxaumY0yewyKXweuuOqTYLNoXIj/
X-Google-Smtp-Source: AGHT+IFg1L0qRJVGJ4aGt9aC/lIBCbCCptBbWs04gJczIBPuhBl4qfKdBwKf9DksQftXvdo+9SL9Tg==
X-Received: by 2002:a05:6512:239e:b0:511:ac65:4e68 with SMTP id c30-20020a056512239e00b00511ac654e68mr1209142lfv.15.1707920735989;
        Wed, 14 Feb 2024 06:25:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0D3H5Fh6OCprmLVUJqG9lWTgs9TyeTmpxdJEnh/ORO/nJbyLRPjfnC8w4855+luYJd8xDNnX0TMNUXjUUATbUEUSBXj9LHk5CrQX6xZFbNbyNaI9S5xm9Pw43bK2sQlGK/lvGB8UNbQ2XwYQcI2P8xeFCXawDoRLXYMsMSx8fiYijgx5hfi8sJvZrEAABW5lshgha8vg7neMPmxZOaL+XB4xIDFFK3fH8H07gwNo1
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:4d2b:b120:8137:3062])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b00411ce6def3fsm2146871wmp.38.2024.02.14.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:25:33 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/5] oidset: refactor oidset_insert_from_set()
Date: Wed, 14 Feb 2024 15:25:11 +0100
Message-ID: <20240214142513.4002639-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.51.gda36843b44
In-Reply-To: <20240214142513.4002639-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240214142513.4002639-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will need to add all the oids from a set into
another set. In "list-objects-filter.c", there is already a static
function called add_all() to do that.

Let's rename this function oidset_insert_from_set() and move it into
oidset.{c,h} to make it generally available.

While at it, let's remove a useless `!= NULL`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 list-objects-filter.c | 11 +----------
 oidset.c              | 10 ++++++++++
 oidset.h              |  6 ++++++
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index da287cc8e0..4346f8da45 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -711,15 +711,6 @@ static void filter_combine__free(void *filter_data)
 	free(d);
 }
 
-static void add_all(struct oidset *dest, struct oidset *src) {
-	struct oidset_iter iter;
-	struct object_id *src_oid;
-
-	oidset_iter_init(src, &iter);
-	while ((src_oid = oidset_iter_next(&iter)) != NULL)
-		oidset_insert(dest, src_oid);
-}
-
 static void filter_combine__finalize_omits(
 	struct oidset *omits,
 	void *filter_data)
@@ -728,7 +719,7 @@ static void filter_combine__finalize_omits(
 	size_t sub;
 
 	for (sub = 0; sub < d->nr; sub++) {
-		add_all(omits, &d->sub[sub].omits);
+		oidset_insert_from_set(omits, &d->sub[sub].omits);
 		oidset_clear(&d->sub[sub].omits);
 	}
 }
diff --git a/oidset.c b/oidset.c
index d1e5376316..91d1385910 100644
--- a/oidset.c
+++ b/oidset.c
@@ -23,6 +23,16 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
 	return !added;
 }
 
+void oidset_insert_from_set(struct oidset *dest, struct oidset *src)
+{
+	struct oidset_iter iter;
+	struct object_id *src_oid;
+
+	oidset_iter_init(src, &iter);
+	while ((src_oid = oidset_iter_next(&iter)))
+		oidset_insert(dest, src_oid);
+}
+
 int oidset_remove(struct oidset *set, const struct object_id *oid)
 {
 	khiter_t pos = kh_get_oid_set(&set->set, *oid);
diff --git a/oidset.h b/oidset.h
index ba4a5a2cd3..262f4256d6 100644
--- a/oidset.h
+++ b/oidset.h
@@ -47,6 +47,12 @@ int oidset_contains(const struct oidset *set, const struct object_id *oid);
  */
 int oidset_insert(struct oidset *set, const struct object_id *oid);
 
+/**
+ * Insert all the oids that are in set 'src' into set 'dest'; a copy
+ * is made of each oid inserted into set 'dest'.
+ */
+void oidset_insert_from_set(struct oidset *dest, struct oidset *src);
+
 /**
  * Remove the oid from the set.
  *
-- 
2.44.0.rc0.51.gda36843b44

