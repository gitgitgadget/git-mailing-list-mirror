Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594C388E7A
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269795; cv=none; b=LOkkUgLnfbcoRomyAwbD06hI8baiemojKkYtMN2YoARmxgTf+jMskHOAFL41zEwjurWa4sI9odDz/ceTcx/Od2z8Ke/a5LyUlNyaI9Z9WmdIs1Mggp+khF/G9ApoMC5mN5GvvpSoIN+PL8l+/nA2WikGYguXbuTSz7t/RgMNZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269795; c=relaxed/simple;
	bh=hp7hL9GUO92/tuyKC18WbeZrEg8SBY1JEoT/czKR/As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLubsf+qINkb0YUXTcTOtdc0u4RCfwky+DmEMPj+ia75TxGw38ZELkjk52H+brLWy6PnW7MU1sjpcY37oJ7nFunM+7/vm4Vp8EAmiigvTtjH2LnBiQ9s7iHn0ghw7yX3rYiqaFHZc8/w98w2Pl3yPJMHa4I+iF10C59H/9UDk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAFd/+mY; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAFd/+mY"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ee37dc91f5so314483a34.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269792; x=1787874592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jrten55U9ibjP+63dt73FqGe9Ka9VRkz9SFsCtTd2tw=;
        b=SAFd/+mYdyJ6SkMNm6MsnE2smYjlMJGZtnMbQlO8pD99tCJOY/fwLuG9TjJ5S35sbi
         T8olVohQ6mPbkTs9EEA/ttcVRXrIntY4KX7jgjUoLTB/sTLnqIENghVsfrJmqDPX/uWA
         sPmceDjdvOjd4dy9TM0dNpJoOpWvk9Z8U11Avxd+q4pb3lPQKb++idlcWkmoeUQ9+MCA
         sftS+Iu5U8ZME6h1TYddNb9p5NV8lxkAb9fDVsKedHTjnKNFhcIAfbr9miDQ3izm3aZG
         0BGgZUAtZ5rRBmAoF6wChNxaQQTMWxERq1JG+WAoMfu5CMT3OEi5dFzEDa3tChZ3i8Di
         96Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269792; x=1787874592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jrten55U9ibjP+63dt73FqGe9Ka9VRkz9SFsCtTd2tw=;
        b=D6UM12tc4RLDPfgkBVYyNbMLv00R++s0cYkBjYgBcD3rFpakvEmCnx+/7LS/V11E86
         B2pqTXoMTdpVqWO9A1DPkm+rLofCvGvWDvTW5XYAwTc4cRiBM67Z7MUSiFuIem5FUYUN
         oFqgEOx9nn9NQRsd8hWewdNYzR9wCtpO3T4d/qlJg2wNwRiX/tYbpMDEcWeHfG036tcR
         gY1si9beQgjluBY9/YV9Gas0Cd/4iy6peQS63HzX3MK6RSTyulsp1mXsJf2STMlVNFQN
         flDaX5OqcE1p2OK0U2Gaj2jC3T0Iu1flH/5Z4x80ZkklwieuZf8UieIhhAzlW+d6M4qK
         ofKQ==
X-Gm-Message-State: AOJu0Ywxv7dMx/pLSdN2Jd78mcU/OH9XTGq+l3SHXUXDC/6W+C+Gmz5R
	IBcCZFHfkPgdcVfirv3vA3ILRwfPK46uyZOzpp+2xCrFfwZIq+NQ30C3BnihgA==
X-Gm-Gg: AR+sD12mv5i5hkz82oavWTNT5ViHvYbsxXZOQcR/S+LL8YZERXO7K+k8hJTQ/UdDnCS
	c5myfPkckapKtFCRS0Gp4Ec7oMr/Rcpg+KK5xZWWc3hv3EFdV1ZRDrl/3ZaJdy+H1b0pku3qem4
	STb4+UgPzOSM8Vo74+bnOog/8KsZEJAK0GRRgnF6OtxftfhZj0M1eQmbJZzzc16nGQFRy1jex1t
	zygpjOPiCeZSBA7FNMqiufyVxaZUTrtNfb68O/Fn73pUnFkCezfsH7duIITPKKJilFejjR2hqNC
	uY73BHxdG7RJxgtFqx5NWTZSUfvJc5RR0L1/S8xxZ7fNu7Pr5N3ZNPnkt2+3/LRDAaopZSy3gVg
	R7BVkAVPdh3rldEmdBv68Ynil7UqjUzJHQqHZjEE/PL9vklLynUWLya91hgXUXoVELWDEaa4+G5
	FbvsOLdQeCSxmiNyO1RsVFb5Po9/Ge/ekuWe+M/yLQRqqRjoHLi5eCpLKtK2dEY9DmodVS
X-Received: by 2002:a05:6820:4917:b0:6ae:8ee4:e01f with SMTP id 006d021491bc7-6b1591d5588mr1987356eaf.4.1787269792525;
        Thu, 20 Aug 2026 16:49:52 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:52 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 8/9] odb: return temporary ODB source when set
Date: Thu, 20 Aug 2026 18:49:39 -0500
Message-ID: <20260820234940.894624-9-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When invoked, `odb_set_temporary_primary_source()` installs a temporary
object directory as the new primary ODB source. A caller that wants to
operate on the ODB source of the open transaction must assume that it is
the first entry in the ODB source list which is a bit awkward and
fragile.

Instead, return the newly installed source directly and report the
previous primary source via a new `prev_source` out parameter. Propagate
the installed source through `tmp_objdir_replace_primary_odb()` and
start storing it in the "files" ODB transaction so a subsequent commit
can easily access it without relying on the ODB source list ordering.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 3 ++-
 odb.c         | 9 +++++++--
 odb.h         | 6 ++++--
 tmp-objdir.c  | 8 +++++---
 tmp-objdir.h  | 6 ++++--
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 4d03c167d5..db63587f6d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -485,6 +485,7 @@ struct odb_transaction_files {
 	struct odb_transaction base;
 
 	struct tmp_objdir *objdir;
+	struct odb_source *quarantine;
 	struct transaction_packfile packfile;
 	const char *prefix;
 };
@@ -507,7 +508,7 @@ int odb_transaction_files_prepare(struct odb_transaction *base)
 	if (!transaction->objdir)
 		return error(_("unable to create temporary object directory"));
 
-	tmp_objdir_replace_primary_odb(transaction->objdir, 0);
+	transaction->quarantine = tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 
 	return 0;
 }
diff --git a/odb.c b/odb.c
index caf1d0f542..8afcb6b637 100644
--- a/odb.c
+++ b/odb.c
@@ -226,7 +226,8 @@ struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy)
+						    const char *dir, int will_destroy,
+						    struct odb_source **prev_source)
 {
 	struct odb_source *source;
 
@@ -250,7 +251,11 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	source->will_destroy = will_destroy;
 	source->next = odb->sources;
 	odb->sources = source;
-	return source->next;
+
+	if (prev_source)
+		*prev_source = source->next;
+
+	return source;
 }
 
 void odb_restore_primary_source(struct object_database *odb,
diff --git a/odb.h b/odb.h
index fca67e8253..bdfcb9509a 100644
--- a/odb.h
+++ b/odb.h
@@ -199,10 +199,12 @@ struct odb_source *odb_find_source_or_die(struct object_database *odb, const cha
 
 /*
  * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary source.
+ * object directory and return the newly installed primary source. The former
+ * primary source is reported via `prev_source` when non-NULL.
  */
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy);
+						    const char *dir, int will_destroy,
+						    struct odb_source **prev_source);
 
 /*
  * Restore the primary source that was previously replaced by
diff --git a/tmp-objdir.c b/tmp-objdir.c
index d199d39e7c..e633d97e0e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -327,11 +327,13 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 	odb_add_to_alternates_memory(t->repo->objects, t->path.buf);
 }
 
-void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
+struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
+						  int will_destroy)
 {
 	if (t->prev_source)
 		BUG("the primary object database is already replaced");
-	t->prev_source = odb_set_temporary_primary_source(t->repo->objects,
-							  t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
+
+	return odb_set_temporary_primary_source(t->repo->objects, t->path.buf,
+						will_destroy, &t->prev_source);
 }
diff --git a/tmp-objdir.h b/tmp-objdir.h
index ccf800faa7..81eb927413 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -64,8 +64,10 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
 /*
  * Replaces the writable object store in the current process with the temporary
  * object directory and makes the former main object store an alternate.
- * If will_destroy is nonzero, the object directory may not be migrated.
+ * If will_destroy is nonzero, the object directory may not be migrated. Returns
+ * the newly installed primary source.
  */
-void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
+struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *,
+						  int will_destroy);
 
 #endif /* TMP_OBJDIR_H */
-- 
2.55.0.424.g13c7afec21

