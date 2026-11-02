Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618445;
	b=jDOijUM0BN42OIdAH59a0KM1xG/9BgrV3Ffba1Iy8dXYP624jKSnbJCGXmDb3WGLlp2+
	 KSFUIMMY7MNNdIoIYlsBViLd+gp/vZsU0IRm3nE0+34vXV/kBKIdRz+hYh9Nmk0E2ln1g
	 nFgjo1RSEStkTaCKxn10e8FE6TM1Hh7yVoQlmyc7eUlbAJeawDMrHjCQlAJNskPaN0LEF
	 WcOj+SI0GwZxWiWVYhaOc3tPLxAKMVc4RYYqxYtLb2iRGYKZrDUCm1JqgnE93DmI2gwji
	 FE4gmqMg1E6GdQLoCNwO119WG1KUIjbpvxJzMZvZ3lxJa6RfULkiDfLK4qUq5OCU1Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618445;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=cxbpzYQganXAwLPDtogXY+jEW+2l6agAI4CMO5zgk9w=;
	b=wwL2ii9Dhl5R6EqTj3sofVVWlfQpu8n3w6ENSa47Tnv3FFB+VUjvOD4lvabnH+8VB1Ks
	 k6EjTQI9Ztdsdd03hyTo7RTciDdbXkRcJWqTe9FpIA7/eyg2b4vdEmI345eQeYAybLY6G
	 NtZImk+k41/iwEccVuCzLmY2X7O00P02PR4Pb1aR3o1R/bsbIlu2TewdXrmMHTI3Hpxes
	 wzA0jTki+Z1RQN6k+//aqlLoOrlRR7WRudxB+oOXBAkIXZEMcwGGuwsyT7wixaVGX8Puo
	 OEhTM0N5t+eVi8JKAODDNGJODSRIsh6ET+HdCD/IVqh6xmN98W/ahmZjyfR/wwMD/5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hqwaWJiF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YX8PKxhL;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D606606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D606606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hqwaWJiF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YX8PKxhL
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A467A7A0165
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:20:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 06:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618444;
	 x=1793704844; bh=cxbpzYQganXAwLPDtogXY+jEW+2l6agAI4CMO5zgk9w=; b=
	hqwaWJiFmN/Kt01GfWJ17rW/12CrflwBsj5l5jUZvZo2VIWFIizFfOi9LbLt81Tb
	FIpqzrakvI2dlpQdC6SweQOp4Fi1ycK4HJUdyoK3bvp1Rl9Xx810U9BHGFf60HHR
	2V+F0kS21PIexgQP5+yPCLCoQt90Ea+dcC5ERIHSR4CQeutfwA4mINtaYZErZiFZ
	iyb+opISjTt3hUfCkfKuRMY9ZR3kWVOaCdbTROMHBAyFhNp7oD5GcH8AMd94UMhG
	w5eq2fOhNQL6hqRDLV/yQyIVady2CcZHwR5cPnll8dNtKonJaQ4BwYz5c8tFJbuh
	bBdjL24Vyj477txNV/ujFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618444; x=
	1793704844; bh=cxbpzYQganXAwLPDtogXY+jEW+2l6agAI4CMO5zgk9w=; b=Y
	X8PKxhLvO+M7I6i8wRqAEHBVQwGpA1InuPKWnu3i2xQPupyqhYU5wwLTRW5FX7mz
	nVRGdHh0IUfjlZoehzMjT9v+ElnxIKvt2CZvZo/SlzvBxRo9FlPzWX/p9NlhIXSK
	1WJD0e1IfgSbomlzpjTaQQtnbYQwO3uZftqxtw/22JG4cpzwfvSuJhunezptVvlB
	rcHIUq4F8w564dDDzntdPD0MyrywBxE7E27QL/j5OqGFEDBE7fHYStKBeYel3OG0
	VuTKPyfWculMvGglb7kHeqOGRPb/tcmfC0DMP/BhIOZhyE/d3SkMtwva93SAwDnJ
	5wHVf+Du4a9mtLAE3NL4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618444; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZAS7e2NVVLdYh4gnjh+1+Re0Z2YxhDmWnSVeGEWTDpjDxer
	atszG+1N0fUh+t//1YWQ/EVV/mzOSfwl9higL1ycFp38BSrnZWlBBrBEerkBFvWN
	Q7yMECU1ITzS6epEsEAW2dAAjhAbi8PPmggzYbzNBV9oLIsZwl9ZDxUfiYB2SD3A
	QL2egCIgJ4VKcdvXZNawIa1E3N3N43XTkfea3m49iiLELX9znhoKDt7c3ybYCaws
	j2u47nenm1f6DWWPNermy1O/5k2UD5Fz9k0fRYYjjqfyEb3H1Xs3rzZcODCKN24m
	6QvFHMaj7VbPSbp8NF/TGX3Nm3MmLY99Ffg18ZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qbHSn76hZBSozAXY03EzF0lAM52fKmJm1iWlRtTTtPI=:KAQX/7kXLhDvzAr/d+9G+Z1akaP34/wLPdg9m9D2WxU=;
X-ME-Sender: <xms:DHLoasBVmwDNDQzG6P8H4LMemeM7WbD34-KwXCErdJD-cGrRFLmLOQ>
    <xme:DHLoalcXzgTQy1TqYlVxNfC8ZvOqR1YrD1GfS67LgR_QMCnSt0jsiJocTxE40zY89
    SYBQvZgUAvBhbyKB4CFJyQQ8p5QgqeVmMKSFLivpTn7JrIKraKmxGQ>
X-ME-Received: <xmr:DHLoalOFDqd1TjkFFLiFoEgm3VCncl-FAmkd9-ZWaJgAZzo9yNGdWgRQjFXixz6CEGWGfg>
X-ME-Proxy-Cause: dmFkZTEWnSUxfpS/kEGGbDYmyltFkkmaTeyhGDOrpTvM5SV6z0pSUCwWg28N3N54QmR8zn
    EgAMbbXhC/6APutHcIMZaDoLE5FxRn39xAJrjJ0q+z8FnYttm/5Z/P+eQJQK+dXzTmDh8Y
    zAqtbt3KP9tul+qE39EMNdqe0OJkse1fks+Vc5LwqpPb28y6ukQ6UoV4Q0kjXw9OQMSR1C
    GKScovgGttSHRY3BdFvpP+Tg/R0UYIeLOTVkT39trDUzrLUVB2lwh8jQz7soyL9G5uppOW
    mL+OeKrLNWmrO/XU/NmJ5TLvF3bWpDaovGukNKamVebS1OCgL/DPatSqxcvBbVd7a3wlf6
    NTPnJaTe61Qmv8zEKxEkInJWdCuWiLdvBY+SefecsecBUry5720MzXramY0e9RL5IwezbG
    dZp+6gMEGzhsVFqE+tQRLQFtOtOPljJPN1tJwcvoLUa3NhaN22ZbkhhvZeuJ15PW2kOgtV
    us3XNe6/X3fxA3dwFQ4KDpucu7Sv08n7mf4XelsbKVpkYNz5jmpvH8QHiaz1sNdcmIsqcA
    DVY/AWHAp/g3aTVmC4sRnsoEg1FBo2Y4VxeGAJSQZ9OUu6kMZC71PsCWrTInBQUTc1Mg+i
    vd1YL+NhLiun6Am90xf1vDLro0UbN0gFVS3GScMsZBrukyrXsjlj4RrdzIeQ
X-ME-Proxy: <xmx:DHLoan7X8HdBxfCIGlqv9Y28B2IMGB5Vn_MqNNGw_9RFPVfGKyzwXA>
    <xmx:DHLoahLqcwCx_uVPCJF-2rCR6L8QsB5YoCRicWZmUe5r07wsEzxjAw>
    <xmx:DHLoapfC6XsYzkVCosrL7-FMmwOIrSfWyvBbZNhHcF-IWcgMEmzM3g>
    <xmx:DHLoaseNjivoZnukKcswBFdTj0TMUnEOuGsgZysX4C_xCKLvBVHfJQ>
    <xmx:DHLoanAC4pxomftaVPNhpJeEd1EW_jClZ5mcd_6_hUyvOTkhgE8fGzLh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Nov 2026 06:20:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b9a37ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Nov 2026 11:20:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:20:21 +0100
Subject: [PATCH 5/6] object-file: stop including "odb/source-loose.h"
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
Message-Id: <20261102-pks-odb-loose-cleanups-v1-5-fbbc86c29693@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have now moved all functionality that relate to the loose backend
from "object-file.c" into the backend itself. Wrap up these refactorings
by not including "odb/source-loose.h" anymore and instead include the
file explicitly in all compilation units that require access to it.

Like this we can trivially identify exactly those files that still
depend on details of the loose backend itself and that thus require
further work to become truly backend-agnostic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 1 +
 http-walker.c          | 1 +
 http.c                 | 1 +
 loose.c                | 1 +
 object-file.c          | 1 +
 object-file.h          | 2 +-
 setup.c                | 1 +
 7 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfbc..e53c69af31f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -34,6 +34,7 @@
 #include "object-file.h"
 #include "object-file-convert.h"
 #include "odb.h"
+#include "odb/source-loose.h"
 #include "odb/streaming.h"
 #include "replace-object.h"
 #include "dir.h"
diff --git a/http-walker.c b/http-walker.c
index 4f50dd9b8d0..13730a27847 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -11,6 +11,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/source-loose.h"
 
 struct alt_base {
 	char *base;
diff --git a/http.c b/http.c
index d79678d01f0..25b5fc3b3b7 100644
--- a/http.c
+++ b/http.c
@@ -21,6 +21,7 @@
 #include "string-list.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/source-loose.h"
 #include "tempfile.h"
 #include "date.h"
 #include "trace2.h"
diff --git a/loose.c b/loose.c
index d6a2bb5ba3c..64cd6f1c3c1 100644
--- a/loose.c
+++ b/loose.c
@@ -4,6 +4,7 @@
 #include "object-file.h"
 #include "odb.h"
 #include "odb/source-files.h"
+#include "odb/source-loose.h"
 #include "hex.h"
 #include "repository.h"
 #include "wrapper.h"
diff --git a/object-file.c b/object-file.c
index d3ddcbf309c..917a65d5b33 100644
--- a/object-file.c
+++ b/object-file.c
@@ -20,6 +20,7 @@
 #include "object-file-convert.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "odb/streaming.h"
 #include "odb/transaction.h"
 #include "pack.h"
diff --git a/object-file.h b/object-file.h
index 83d3f38a540..746356ceb51 100644
--- a/object-file.h
+++ b/object-file.h
@@ -4,7 +4,7 @@
 #include "git-zlib.h"
 #include "object.h"
 #include "odb.h"
-#include "odb/source-loose.h"
+#include "odb/streaming.h"
 #include "odb/transaction.h"
 
 /* The maximum size for an object header. */
diff --git a/setup.c b/setup.c
index 61bcdafe82a..bc94463a239 100644
--- a/setup.c
+++ b/setup.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
+#include "odb/source.h"
 #include "refs.h"
 #include "repository.h"
 #include "config.h"

-- 
2.56.0.500.g5d06dc02cd.dirty

