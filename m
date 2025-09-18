Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286D2D6412
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174441; cv=none; b=MCrXirCylpYruBYwytN7MJkHJxLSkc8qXmmDelxVSpwSAWLfVoLA2ll1O32iuboSz/qJZfEXldXNHPl98t60fxXJSYiH2VWDIeLLImm0byYmjSolbB7utO/yTJDizOs3XuGMs0ZEANBSyKqQHHeBXcQFPNjQrx0RfBeq376xK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174441; c=relaxed/simple;
	bh=QHetPRGrcuM5V+ERnqbQCLSo9TXriaJ2rguGGCQNy74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vtkvh5Qo248KdFSlXkzNNyK71SJkeKWqOSjuKGH5kxf/xwJDBUgHuvRUEZLuAbSyxcQxo+gRJiYPDqooGvldrslVJMTQP42ieJHmUckRE2UoXiAPQE29e+VynDDdWbg2f4IMpXxIzEW//LZQbybffRjRGI1ZiSbM03iVgBJ8uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkafjG5k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkafjG5k"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-251fc032d1fso6373725ad.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174439; x=1758779239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uoJq2Dr96DiMOIogUmqb9IQjGPTBbK3UF+1Bo/aC08=;
        b=BkafjG5kzYgNFnRNjafyRkfoaq5k3pKW9oiFyTqtoTX3rAb0Kwe1h9AdqDkd0q6IXO
         n9Y8iLcWyCUUrkjyPBIBi9SOFnkyqg7C9gyA3kO8iO6sVV7ToOPYqXHIAZnt7ck5gMDI
         1JNkgVzkRfNl9Y5VSxv5dVlLQorHb16bHaJ9PBsakSBC1SNC+iE1NKmK68FBouW6NZta
         u0HZbljFST9qcRcfcgVny73bIGwZCD0J5L4YK+OkcO9vilRYWH8biz/kWSYUgS6Rdxd3
         +hFGuhtfXWrxH8kBDWiZP0u1jfS7LeCq3xnhc7IfK6gPddJi8UxIgJi8OpgO62TGzY4E
         7tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174439; x=1758779239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uoJq2Dr96DiMOIogUmqb9IQjGPTBbK3UF+1Bo/aC08=;
        b=mgO8LXHJJTbHwbkARtpCYXjfZ3qa+xC0JxDZTJaL8d33nGWocgZF5x4Ru015mTsgpR
         ZGP3BD0syVS6MUISQmNVV+VUtny6lhG3/R/kH6UtrozIOqvrfoESH7KgWBbwrxiBGNnR
         50dx/bYDbRN2DrdRe9ANHyyxCfvGu49b+PVEZsoopRe+xBGfNQdHRceRWeIsFK5Medl2
         EBgIoA082yxBstyYNuEp/0sH13LWuPH2cPJwSYPIr1IZIfRHD1xQzYRz5fehlvdrCsF8
         GwLmDIl6mbXLdOq6LvnWgxxg6FrZmzwWB9lG8slDWkvrCFn1ACxmPVlrJUfa3AeHbkaq
         aScg==
X-Gm-Message-State: AOJu0Yyoa/hrMLdtj5sSzYEytBBsGIq7ksbOT2S4tmRPy9r+3f4Sdgz1
	yPAX++/OuYmADc+3HJvcHd6vOvuvESfc/geNCLeul8X+ylZI2LzEP163zFvB9w==
X-Gm-Gg: ASbGncsWXEP/FEYXlN5+cNeW4r/6kKrFwCuUzt5jzZqGSv2pdc70iIIVaRYBfyez3IU
	oQR2XpkIooSYdmvNmpeHTZ8Oi9izBDWBr22C6vTIeNSf/zxHqTG6xhJ6IqSD20znNmEn7c049ZN
	FBKucvsbUInAxP/vIU5T4uC8OUB5AEtxEPu7txa1xxriVUodORGnPYenz7S/TILOKYErkRD09j8
	UxSq5XVw73m0iCoUYhDaXeYfufuKyjRFYer37wITvdLMktReOQITwy6rcPfgULwSLfIWAzUAdGR
	ZvnF157vFgpfMIBR/BVJJXT43PAQge9tF8bXiV/rElxA9fVYKX4J2gdiWyVR7fPQPa3rhU0W4Zx
	VhXVydfRStmTrgRJJx/jk9qMZvzTApqk+TFhfqg==
X-Google-Smtp-Source: AGHT+IHEAta58mmBapPwwrXs/gyBrJxdjO6m2kfpk0lMvmngfM8CRGrobdU/Z+96KPhkQlQGHZ88VA==
X-Received: by 2002:a17:902:da83:b0:251:2d4d:bdfa with SMTP id d9443c01a7336-26812169003mr59848685ad.20.1758174439455;
        Wed, 17 Sep 2025 22:47:19 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:18 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 3/9] reftable-backend: implement 'optimize' action
Date: Thu, 18 Sep 2025 11:16:58 +0530
Message-Id: <20250918054704.544254-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make the new generic `optimize` API fully functional, provide an
implementation for the 'reftable' reference backend.

For the reftable backend, the 'optimize' action is to compact its
tables. The existing `reftable_be_pack_refs()` function already provides
this logic, so the new `reftable_be_optimize()` function simply calls
it.

Wire up the new function to the `optimize` slot in the reftable
backend's virtual table.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refs/reftable-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 570463da41..5dff1e08e5 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1721,6 +1721,12 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_optimize(struct ref_store *ref_store,
+				struct pack_refs_opts *opts)
+{
+	return reftable_be_pack_refs(ref_store, opts);
+}
+
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2702,6 +2708,7 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_abort = reftable_be_transaction_abort,
 
 	.pack_refs = reftable_be_pack_refs,
+	.optimize = reftable_be_optimize,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 
-- 
2.34.1

