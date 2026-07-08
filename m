Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A539021C
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555175; cv=none; b=H6RJSmNAbepCr3H/BFRH1EMS0RP/oMmZKf3TUoatC1SiFBFygtqf0EspuIxWuR9Ggs9V6ALRXBXZqHnAlZQSm5XsQlHae7nXJIwnuRQykUFOewvHajgWjFS2op4CJlaDM6WLitxpkHodSZnX2ftZ7jnRHhsEI6iaMf+zTZdfnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555175; c=relaxed/simple;
	bh=Jk2E5Uw+4WBzW+eHpo+IMnp7D7ua4kPTRtZGBO4aoBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx3vyU+oLM5G1uBg5yoCsOKOSvOOnZbl3bDnI4TdcquRv5DOCuCWSjs7OvPk3pawB00WCnXnYDrMAurIipRIjwfNccqE01x2lv2s52r4rghIPRqHVb+j+fwCQ6GK5/tPlM0aXyiCRc8pwJAgzHJ/gm5cEk4vpbb4jixQ0IaHLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/VC2EMe; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/VC2EMe"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso694846fac.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555172; x=1784159972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KdMH69oD6LL6hPVV6AFUFTU0CgYi7kzlxSOOUfI/80w=;
        b=G/VC2EMeGVnJB0kKvCtd+W65VRk8aYhSpqoF2UhUj+1Ucgs0XhK9J8evEHYezGAw8R
         x7e3IR3SdAOFRPdpVHmBrsfAjzcEzYIa0YC8Xxdwpgo3JJOFGyeVRYpzvY9pS3Q+RXit
         KHi1qlE1M2QlfCWxjrujfsKAm5CDnCniJ089VI2nztInNoAauxh0uHGsaggHGn71qMni
         5RiRP5vxm0UKmeEMdE4j5TCO6sKBlmVuCbDQ+qd5U3jEuFRjXMPUykKOF7xm6wdTqHWr
         MnfcwWehR+bQHtVfn3L7pGQWYD2/4Qvxfmyl7EjkJZDP+uS8ffqUck2RYONHCYhHPm4T
         UclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555172; x=1784159972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KdMH69oD6LL6hPVV6AFUFTU0CgYi7kzlxSOOUfI/80w=;
        b=dIia9ivxEqw9/n8MHcLJiNzF5toQupdM4XaG/Q95Ql0na2452QXpnrb0l4y/lMZqhB
         oueEc2ue717G410x8JKwXaa/QJzyFI8tYwBeEzOY/VaIZ2AW2SBEovwEBQNSZSaogB7O
         bu8fMfY93QzvXLOKsD2vWJ624tkq7IYxhQFEGf8S2pbm0J6npgraAA/OAFO3OWGvmeg2
         eDYpNCrZhZo1DaBmPEI+lRgQ8do2Q/1cGdi2+l9RIm5HOMVPdWufAJv21vmNQF0YK9E+
         Id0x19C0j92/NuPFU6kPiRrVC10WjUs6L+Yfo5Xf+NgXUVpiehblzxfjmlkDYdf1SJtF
         k1ag==
X-Gm-Message-State: AOJu0Yw4gI7NAXHb8AFj0YpYdhvv01LGi8bs1p1dswHBUV8wdGVzXxUT
	d4p9jeEATw/A8W8iZvizlDtdpHHpjA/G17XbHPYwJKACWlo3HL4HHKjY5ePqqA==
X-Gm-Gg: AfdE7ck7js9qtvJwGE4jhgxJEqgx9rOq4l7WfFijFjlChD+lfAHh1fogwMvFaG3NV0y
	u5znGKttrk0ifEvSRJxlAJPtcKMXsPvV6KaIFjl76WPuMWnf+fw1JkTMp8+AxFGbt4ZFCcPFfS2
	597kCQntLyZrlUS22OsfW8u/SA1hPcj0s8oqGi9JAWU/BbNPgJSAgfH/Cbhp2Fv2ObbohvKy8ql
	U+VA7ERZwug2/WLZP/GuvXjKudqCwO+M5P1T6hm5+Z+uUjDPMaAHGxEShDRe2pYVj74b83IRHoA
	LUMa59RRSXtxx8M92cZEYUOTkgizbwc5rUmZs+FeuutolwW2eejTdBWa9Aezo1pxHh/3PbWAbTR
	hQE2xNh7C7FcH1FJKaGIXXtZttqmmAeTlmvK9F44ApXnWIr1ZzTi+TqEu0roWBcRAl7HQT9wUT5
	Y7Gj4G21rr7teQqeZ6I2eu
X-Received: by 2002:a05:6870:47a2:b0:448:b149:eb09 with SMTP id 586e51a60fabf-45163c20befmr3185568fac.21.1783555172507;
        Wed, 08 Jul 2026 16:59:32 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 02/11] object-file: rename files transaction fsync function
Date: Wed,  8 Jul 2026 18:59:16 -0500
Message-ID: <20260708235925.3992097-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing an object to a "files" ODB transaction, a full hardware
flush is not initially performed during the fsync in
`fsync_loose_object_transaction()` and instead delayed until the
transaction is later committed.

To be more consistent with other "files" ODB transaction helpers, rename
the function to `odb_transaction_files_fsync()` accordingly. The
conditional in the helper is also slightly restructured to improve
clarity to readers.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index a3eb8d71dd..d68824bb44 100644
--- a/object-file.c
+++ b/object-file.c
@@ -518,12 +518,17 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
 
-static void fsync_loose_object_transaction(struct odb_transaction *base,
-					   int fd, const char *filename)
+static void odb_transaction_files_fsync(struct odb_transaction *base,
+					int fd, const char *filename)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
 
+	if (!transaction || !transaction->objdir) {
+		fsync_or_die(fd, filename);
+		return;
+	}
+
 	/*
 	 * If we have an active ODB transaction, we issue a call that
 	 * cleans the filesystem page cache but avoids a hardware flush
@@ -531,8 +536,7 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,
 	 * before renaming the objects to their final names as part of
 	 * flush_batch_fsync.
 	 */
-	if (!transaction || !transaction->objdir ||
-	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
+	if (git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
 		if (errno == ENOSYS)
 			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
 		fsync_or_die(fd, filename);
@@ -553,7 +557,7 @@ static void flush_loose_object_transaction(struct odb_transaction_files *transac
 	/*
 	 * Issue a full hardware flush against a temporary file to ensure
 	 * that all objects are durable before any renames occur. The code in
-	 * fsync_loose_object_transaction has already issued a writeout
+	 * odb_transaction_files_fsync has already issued a writeout
 	 * request, but it has not flushed any writeback cache in the storage
 	 * hardware or any filesystem logs. This fsync call acts as a barrier
 	 * to ensure that the data in each new object file is durable before
@@ -582,7 +586,7 @@ static void close_loose_object(struct odb_source_loose *loose,
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		fsync_loose_object_transaction(loose->base.odb->transaction, fd, filename);
+		odb_transaction_files_fsync(loose->base.odb->transaction, fd, filename);
 	else if (fsync_object_files > 0)
 		fsync_or_die(fd, filename);
 	else
-- 
2.55.0.122.gf85a7e6620

