Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120AA76C6A
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400284; cv=none; b=QjyJGAkt5zvKuejvxzhEdJmheHGEvifOFwwCK6LIXDYaVsJDZfErboSke1Cv4FKt9qPSZyEPOxGWtId66TeVVZWdK5e/nnuTrRFXzmzgZ3jJwmgIgFj9YYEVQ/hD+nbJpuhaRs56Ok+4I16VSICD2Zz91VTJ/jaE3uV3HLnIIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400284; c=relaxed/simple;
	bh=45ufkIQzxDtRIrHSNLkv/FGBfeRbsrOrwSHiILwjwsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaAIBOh0duJwj0dYnc9KBlkhfiosPedjMjVB3/VJIJ5dJMz8xmW1TkohlFjvWJdTq3/5WBXeDBXO0SaQYwG43VqYpSNurud4brr7yxwppKAN95krutfvEzuBY7Did/ZTo9CVfI8d504okCDMrBsj4gaocxfwROdOpB9PLqy0tOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=breguh2n; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="breguh2n"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511234430a4so3742906e87.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400278; x=1708005078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/i/lyJ+wzUg0LWI3ZUdwHbk/ESQ2s6tD9llOIvj6GY=;
        b=breguh2n3p1s/tDKAleNvacG2XeAGcWXV4aKedjzN/hnmgr4KI6lf5gIi6+zdvHnZS
         ytgX+FloJ0ulnyc/5YZe6IHnePUB6feZCZ2FznJLcJzafUAwMM4lMjX3wmWM7ISb4+xt
         Lc5OlT5GqJEPTVq9W4hE9Pe4LW9nnxoNMcsIFA/25EkHg9YUtDcs50u4WtWFsBTJOSQu
         1yjXg/YXojwGbIbiYAdKZqstmtgyuRP/bHziiumMsQ2gahBCJp6Ua4QH37cX4y7Iljd3
         zS3faQOkgl/E4JpvYKdTGzeS2dz7mI+81QL/tNlUt7hydUIpMcuADoj5gJQLN89xZsVD
         2wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400278; x=1708005078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/i/lyJ+wzUg0LWI3ZUdwHbk/ESQ2s6tD9llOIvj6GY=;
        b=sJxZ0qcDohRpCbDCFfPZiNvXOfpmjxfogUUKeiv3IfYs7yBxYftp1a4ZIlCeRnqEs2
         d1Z2fScZRi/PzR7wQmNA0hvBC5S5Pn7ohsNO3VxAcnOLxv6fCo2SMPZnqhqA/rs+TVWm
         R/rMWBRDBWJsQwebPg2d9jiVSqAKSsEaEDZw3I/DQ93zoin16n0O01BJGoUeQIQN8po+
         y4II2dj5xNl37SSX5J9ATcasHYB7peTm3HgFqMIgmeCrcoFx+URGITygvP4lKkO6E/Nr
         cz7kvbocIJ2dXPLqVofTL37jNOoi8BhGgb7/nsICLFb3qNxlQL5Oj9F+vxrNokrW8xLO
         BJFQ==
X-Gm-Message-State: AOJu0YwdVmyaMCfDBl+lsUsejuhAX0ie9d26uYDRtFxIH5SqOMHlsdL0
	3cLgbMghB6O0R8JDHlhp287UMLOMxy2eiV58+UT9Rd+jklfGHaHO4aJGTBh6
X-Google-Smtp-Source: AGHT+IGNwJnm7aMGOckC9SaXbJPfo3SLQCi13J+CVHYGHwOq9zj7bXOfLLwE3UJNvej7X5DLvL+qEA==
X-Received: by 2002:ac2:4c45:0:b0:511:2dfc:9ffc with SMTP id o5-20020ac24c45000000b005112dfc9ffcmr7494441lfk.60.1707400278531;
        Thu, 08 Feb 2024 05:51:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvUM0oFZXBMwOWBA4+jadn9RUxNEcY8MtSzuOjaCzb40TB+53uczaDONAR+ZrF/cqKaDRLDsih910fY2CNzKSXcSLwo42bolgpvKbilkrUdLtpzrNDiiGE/J/6/TUIlPJqBO6EI5amSJul1JFOdUaFGxMHb7y/ZroC/qP4NBA7iGIl1dklDDpsaE3K82Em/8n512jkg3g=
Received: from localhost.localdomain ([2001:861:3f04:7ca0:4c16:5b8b:3341:9836])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0040ebf603a89sm1698307wmq.11.2024.02.08.05.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:17 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] oidset: refactor oidset_insert_from_set()
Date: Thu,  8 Feb 2024 14:50:53 +0100
Message-ID: <20240208135055.2705260-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.565.g97b5fd12a3.dirty
In-Reply-To: <20240208135055.2705260-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
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
2.43.0.565.g97b5fd12a3.dirty

