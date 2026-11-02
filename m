Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618437;
	b=aquaygmisLmCPLp8kuiSvsl+UAA9goi2sgVWvKtkjHEZDzmNGh8xxQmSartj+1ryLdPi
	 CUhSnL0jfR1K3HdosgUqAUfZlWLk9+0BmCQoKOC7H7leKcCg7IsYBBZV201bA8mdmZ55N
	 CMAtzCF0CTSjnmp4gc+634Z3QABYVBRxwQ+WfGK5Fy7vbZ02/CVIwngWx5IExYIqi6SaJ
	 Z9nFelpAFv1igJcmczbCMnqKbWBZBgmTErIdNjYzUGLgqWXUF6xRJRUfyzFlBunxWNkqz
	 Y5/HJaXla5tDTkIfdaQyHQCnWVWnkg5cn01m2bX6VFAB/eSQV1/cqPEEDtVWgRSBdJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618437;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=3Ji1EOySIKDFCVgmOe8cnphOYATq2te1Ovr8vQVmstU=;
	b=amNhonGFG59vozuSnfmsPpx3bAXrfb8zSQRGbPQOBRSOjmFykMft8MN1ikJYNRZAA0JG
	 RM4TDF2q+ZTZV5ii1TpaWkowZLSvoQS0chesXE4tv29iADkE2H+fwbaUyGp6IQognORVN
	 EPQjk1+32pAQ03KzIEfUXg5DGphBCzEiAPy5qK1O7PAcXm8G1iPs78XJc8t9H+7qIUfeS
	 7tpe60hz6dI0eI50hxXkHQ+2buk+ZQ8E4bujjmUzV7fbpr1uFgtQzRooWdc7K7gcxzokP
	 qEfdr8zpmnCSehul2AUyuo1YcWMbhtOQEcPOXeKhADlvg2r8y/EaGi8hyCAZ5CLwKSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=B0oiSKwa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EzaaEtY5;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5C606A332
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C5C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=B0oiSKwa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EzaaEtY5
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D90231D000B4
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:20:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Nov 2026 06:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618435;
	 x=1793704835; bh=3Ji1EOySIKDFCVgmOe8cnphOYATq2te1Ovr8vQVmstU=; b=
	B0oiSKwaCBBr15tQChfsvoBEfdQ/jwg9+2eaNjbgO2L3VnaCrDt4RbJQcPFAkahE
	8gh9K7GSDBZLKIuSM8M6X0dsoeAZ+Lq8x0maLYvZ+kJSswLnYV6aBZ4OJUkzyVc3
	CWhzzLM9PXCVVUlVNIfRHEokA4sTvZqRfKksqJC4FgqOHgCMa3tBlmr9QlT87r/F
	zlLTiR9u/jxXPCD63vb7GtrlLZndOwE8tELJpdQRPtEeJtSO6n9ptuJYZ+9bwfLk
	vUz5CA/tZrBVro+v/umBnDnx6ZCXVX80Ywr6Z/AI63V4fuaMGVGxoMJQnvBTrDZ3
	3IPsMT/gKVJI4OICR+8uvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618435; x=
	1793704835; bh=3Ji1EOySIKDFCVgmOe8cnphOYATq2te1Ovr8vQVmstU=; b=E
	zaaEtY5Ik7eA0oG76F8LuYX98D3AKCEYi0/LQExQdOuTycB+SzEPKujTvumHBwml
	dhd73JGCIEZ7uTStm52zGJUDqGfRiMxrW5EaBnbVWhaVStIxC5uPnMUH1lHKFeoe
	VNg4t4ZCvAICjFI8mWBfSU5OKTptxtVhIB3X5CGg+XNUncX0z+9KbfWUAlNFLYkd
	MNFKx6zr23xoSZN1ndfjNdT4rMrviLQtlSxtq5rAfNx/XbPT6sMuIEEU0VUfWmDo
	LzQWPY/SRb0sxmxKL6iyg6IxT3vxDAMnr4ZCtVIXreKXcspRHRGL+GYJ5iEhUrEv
	95wwYq9jKQ/cvk85Fn+3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618435; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IlyaBeJHX1jDeOJtNkCiqG165A9d/8WnuDn88kBja2Apg14
	G/CBIfqxGRygDqdLgvwkLRpH8Xk5jmByAIkpPIjIIwSVZUS5YjDpVkXokN0ioLup
	VXK1yi02+MR0g+Nt6m1jp9cgqRVoL31sFU0xa+rDdvDmzNU2TKm0Lg4huJEeUYHo
	vT9++ueh3uJNdixBqXikx2hzE4aHibgT+dGUpAXelTPIHy64J49KshbX2Tn9Qq0e
	K15+RZYAhabh8mAWDAe/LdT+dEXaoQT+ktl8ZVcIwDTa4Oed9LoEvgM+ccjUCY18
	BydmXjAALKf1Jg7cOfvf8UrmT/5pERJze0iWdPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sjd6kMY2WJm5yCnIlzsMlzkQUP59UOPHS9xsRs/7cGY=:zEbUEGlohuU4ahVmxzQw3+sJHY/WU4uvwB1Tbjc7/9A=;
X-ME-Sender: <xms:A3LoagjPoZM28otgxiVvYMczzxCddo2hNT4ie-xd5-vk7kEpInfWPQ>
    <xme:A3Loav9q5q2BRa33KUN2VRyquKpFZMHc_6S_VoNBPO_7aIdVnK57WyhH_2wexpJMY
    61Np8yy7Tkm3OQ0jbnUrlnX6LFcBwz1tlCGHkUUSOx7FNrbZlHB7oY>
X-ME-Received: <xmr:A3LoatsTc1BthGXSQX1HzZunVxtBN4XelHltSF7BBUgKzKwACyZh-yjsXx32hQKUV3mUdQ>
X-ME-Proxy-Cause: dmFkZTEWnSUxfpS/kEGGbDYmyltFkkmaTeyhGDOrpTvM5SV6z0pSUCwWg28N3N54QmR8zn
    EgAMbbXhC/6APutHcIMZaDoLE5FxRn39xAJrjJ0q+z8FnYttm/5Z/P+eQJQK+dXzTmDh8Y
    zAqtbt3KP9tul+qE39EMNdqe0OJkse1fks+Vc5LwqpPb28y6ukQ6UoV4Q0kjXw9OQMSR1C
    GKScovgGttSHRY3BdFvpP+Tg/R0UYIeLOTVkT39trDUzrLUVB2lwh8jQz7soyL9G5uppOW
    mL+OeKrLNWmrO/XU/NmJ5TLvF3bWpDaovGukNKamVebS1OCgL/DPatSqxcvBbVd7a3wlTU
    N86yvIry4LdBRs6cJv9gFXv1EQwTMqQ4uWhFJmO4UsmFIneAmpXgWQd4SG1EfsYCSLv9rX
    mZuyxvVdU0YqTpc4EGVuQHxq1jvckW4fqxjjad+OMefiEAJc2GDssQ2F3h+j2k9vSOgeKA
    Sbqgdot3jettL55mIlwVE+Fr1aL3DyR44fyCfjCwmUakO2jnOjUcy4UECUyAfzjdj45Bf1
    DX2/5v/cxYuNcs0fMZj35SKnYEoYJak1YNBz7X3YsWGst+AuSapeiVgxIIiDpFQ2nHCbXI
    GiAVxo7b5bqplV6VhYxmWxMKjNW+HGRRUpmsW21zO7Jw7U0gkYnrjkMA0qsw
X-ME-Proxy: <xmx:A3Loama3L0WJ6ha05y_Xu_4VC7nEC2n6SYTevyvY2gPx7JJ-W56aYw>
    <xmx:A3LoatqvQ3vvuqYMR33KunWLvKFLLDo-nSQNxEyxCvs-lhoDRkf8Ug>
    <xmx:A3Loar-ocjYg7NnFALaHkv_HDTVl6X31H4B0ZFsCrKkxb1gDNNCr2w>
    <xmx:A3Loas98gHNptbrGmzw3bYmAaPYuQcOloaKMH4EWfhGd04Q-CkuICQ>
    <xmx:A3LoalisuKyDiDJTdmOXVdoEeB-D6CO2qU0OP75jNf3HVgNuMYVNghE_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Nov 2026 06:20:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17e91b9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Nov 2026 11:20:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:20:18 +0100
Subject: [PATCH 2/6] object-file: move logic to derive loose object paths
 into backend
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pks-odb-loose-cleanups-v1-2-fbbc86c29693@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The logic to derive the filesystem path of a loose object is contained
in "object-file.c" even though it's an implementation detail of the
"loose" backend. Move the logic into the "loose" backend accordingly.
While at it, inline the call to `fill_loose_path()`.

Ideally, we'd be able to remove the externally-visible declaration. But
unfortunately, we still require access to that function for use in the
dumb transport so that it can derive the target path for downloaded
objects. This will need to get abstracted eventually, but for now we
simply continue to expose the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 25 -------------------------
 object-file.h      |  8 --------
 odb/source-loose.c | 21 +++++++++++++++++++++
 odb/source-loose.h |  8 ++++++++
 4 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/object-file.c b/object-file.c
index c1b78a25c9f..ab919f03fef 100644
--- a/object-file.c
+++ b/object-file.c
@@ -43,31 +43,6 @@ static int get_conv_flags(unsigned flags)
 		return 0;
 }
 
-static void fill_loose_path(struct strbuf *buf,
-			    const struct object_id *oid,
-			    const struct git_hash_algo *algop)
-{
-	for (size_t i = 0; i < algop->rawsz; i++) {
-		static char hex[] = "0123456789abcdef";
-		unsigned int val = oid->hash[i];
-		strbuf_addch(buf, hex[val >> 4]);
-		strbuf_addch(buf, hex[val & 0xf]);
-		if (!i)
-			strbuf_addch(buf, '/');
-	}
-}
-
-const char *odb_loose_path(struct odb_source_loose *loose,
-			   struct strbuf *buf,
-			   const struct object_id *oid)
-{
-	strbuf_reset(buf);
-	strbuf_addstr(buf, loose->base.path);
-	strbuf_addch(buf, '/');
-	fill_loose_path(buf, oid, loose->base.odb->repo->hash_algo);
-	return buf->buf;
-}
-
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn, const time_t *mtime)
 {
diff --git a/object-file.h b/object-file.h
index 65ab44542b0..3cfcaefa420 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,14 +23,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 
 struct odb_source;
 
-/*
- * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified oid.
- */
-const char *odb_loose_path(struct odb_source_loose *source,
-			   struct strbuf *buf,
-			   const struct object_id *oid);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 96fc2ed213f..0f29162d752 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -18,6 +18,27 @@
 #include "tempfile.h"
 #include "write-or-die.h"
 
+const char *odb_loose_path(struct odb_source_loose *loose,
+			   struct strbuf *buf,
+			   const struct object_id *oid)
+{
+	static const char hex[] = "0123456789abcdef";
+
+	strbuf_reset(buf);
+	strbuf_addstr(buf, loose->base.path);
+	strbuf_addch(buf, '/');
+
+	for (size_t i = 0; i < loose->base.odb->repo->hash_algo->rawsz; i++) {
+		unsigned int val = oid->hash[i];
+		strbuf_addch(buf, hex[val >> 4]);
+		strbuf_addch(buf, hex[val & 0xf]);
+		if (!i)
+			strbuf_addch(buf, '/');
+	}
+
+	return buf->buf;
+}
+
 static int append_loose_object(const struct object_id *oid,
 			       const char *path UNUSED,
 			       void *data)
diff --git a/odb/source-loose.h b/odb/source-loose.h
index a6ae808662b..8d4cdac0d50 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -49,4 +49,12 @@ static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_sour
 	return container_of(source, struct odb_source_loose, base);
 }
 
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified oid.
+ */
+const char *odb_loose_path(struct odb_source_loose *source,
+			   struct strbuf *buf,
+			   const struct object_id *oid);
+
 #endif

-- 
2.56.0.500.g5d06dc02cd.dirty

