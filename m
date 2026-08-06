Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DD44C4E5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015353; cv=none; b=VoEEUrUn1Z/mbXLhXtgXf3+L4LbkMR2IzS+k5AbU8UmmkvwVAFDnfMMVNNR3VWMswlHzmDwpHDflA15KFIXGkIJqBYc93IQyy8vMop1GxiB/t4YQ2OxZyEYEZiBXeG7JvYxNme8zQy8PR1s4s4ehr7431G76/zRPnazhUXxlC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015353; c=relaxed/simple;
	bh=WHxLgisO5U5Pj3dqkHmuDaIfkATa6gpIRERY/ttBCa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgpNBIhHK92QOhN3UatBshlqShyohgD6ZwDbZtfu0tmFuelJi/71w9A1JE42gBRt2pgNWd2mEraKNxmt2PdTkZe8gFHW8g/OJ43x5WIMdi9q6KnM00Z1xjZBVfNQsNseyl/uxVSGYDmaFoG9UzhK5jpx4VCIhlRb4Jpuis3ZQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ5gRKTl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ5gRKTl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1826270a91.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015351; x=1786620151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5M3EgrbEi7lZ3MMmlC7q9ZfEWvkfbTAg6dgOfBkK7UU=;
        b=aZ5gRKTlsLtrEDFkbXrOnZqF17Y636/xun6zgwGMhajghBCHT5/ugOkVGTcWJx4ulG
         5NemWqQU5m8KKq5NjNRtBvH6bIOzvhsMouzMKHjz/L1YW5qTABFO91hdpnUFsKadrcNz
         LiCK6RM/kSxH9Uqx7WYxW2Um4A3+755VpNsKEIX7IYMEKmclZN9oe9yZE1TB5/BZVdjM
         iehxZYsmLC9kDzJZlfyKyLA5WMtkCEPEPaJTENISCLDASVCqph+HQ8wHOCVPqIwOKSkx
         ZHqUz/w33RB2TwZs2zyynL/wj8sAP6VHwa+qNGvvPncU21C/rSmrOtqnTVDJaqEe7zlD
         Ek9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015351; x=1786620151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5M3EgrbEi7lZ3MMmlC7q9ZfEWvkfbTAg6dgOfBkK7UU=;
        b=o0HORQ6SiUe6k9dqs+1XfghabX+ebRoBuQYnXOFBi/9glJRkt+vN2XMDtciAQM3sX4
         ZRQOdezrVmO0VhtN716QjBX0zff+7bjFHbnu3CC0YLhyr//i1v+CHrHo5fTXBBoh7t+D
         OjgNdkDIOG0kRWZim55Fm5fD2ie2NPvXZP3GcJvsai/5t05msnWtwUU3ro6M1I4sM0wv
         Uyqs3LCI5m6G4vXaxJ9hWUC+I5q9Hkjf/1IVE2e/GKEQmOUh1h4JMiJ2BamwMv+V6mhD
         RW7+PXy4Yqbplnv6FBccusQz+4Sz9sj/QVcfIK4iy0QLn3nKkQhJZ8YiPusPSdIUG3tP
         uISg==
X-Gm-Message-State: AOJu0YyjINHAmMf+xeSZ37WyszHYQsR6tgv7ndRmAMveQl6kvH1T+zY2
	UROSdo8/LU9CiVbwHinGToFtI0LK+9I6nokSWr27v38WItxD0cug1H7PGbC82x3C
X-Gm-Gg: AR+sD13qNIFgSsxPo5FgV3GWhDOKHUyMiN9QxC9Dv0ZqrlR3Rq2MufY9wxuFR9dtg7M
	Dg7fxmUQB4FftmgfUgVRU0YJaSO09XqEdCL2jY2ivnzIiKWIGMVTzIic97lUlIW8/1X0bGmtad6
	/tt3ZUKlzoWUo2IGGpbSGENP2NzVkROReaePPIZgr7jNxM+Dr99vpXl57cvVfJPVrspSQCkKs0B
	p57Ce2gskoTlBw65/Pd2xVhGLaIhbkDPqE5npuVjd8lGEH10IGUF1WN1WellG/8jbtmjwZadBOJ
	/TM/EmYsosSmWpBxJ49oOEBq1NtSpEV+VMP7oauxAw8aFYW0bTlvEU2TGBRGU7b3rQFYO9ik/kE
	xdaZDgLd1N0oXZYFECmyt3SmR+WW0NOwvDUIe27tWWZx3BtSvSfjJ/uNmcfUDYQldz7DmLPU8Le
	banURbumcQx49AalPnW5/5UM3nMhVHE+2Tl17GVirNNKOZbhvsCvC/Kyn+EjeaIwYyxC1OeZXPK
	C//f0XPlKfP0cW3fGJhcAclu3s30DNrslQpMVNi/zWQg4tjH/TiYTqYouArKpy5K94x8W4HfFpm
	bSBy6GKO3AqHg0F1IyvFJPUC
X-Received: by 2002:a17:90b:2248:b0:38d:adae:4866 with SMTP id 98e67ed59e1d1-3903c63c51dmr11597289a91.21.1786015350848;
        Thu, 06 Aug 2026 04:22:30 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:30 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 3/7] repack-promisor: allow excluding objects from the rebuilt promisor pack
Date: Thu,  6 Aug 2026 16:51:58 +0530
Message-ID: <20260806112202.75067-4-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a to_drop oidset parameter to repack_promisor_objects(). When it is
non-NULL, write_oid() omits those objects from the rebuilt promisor
pack. This is the mechanism --drop-filtered will use to remove promisor
blobs, i.e. rebuild the promisor pack without them.

All existing callers pass NULL, so behavior is unchanged.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c  |  2 +-
 repack-promisor.c | 15 ++++++++++++++-
 repack.h          |  4 +++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2e8b7ea45c..0a4dadb896 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -429,7 +429,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp);
+		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..fabfdc168a 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -6,10 +6,12 @@
 #include "path.h"
 #include "repository.h"
 #include "run-command.h"
+#include "oidset.h"
 
 struct write_oid_context {
 	struct child_process *cmd;
 	const struct git_hash_algo *algop;
+	const struct oidset *to_drop;
 };
 
 /*
@@ -23,6 +25,15 @@ static int write_oid(const struct object_id *oid,
 	struct write_oid_context *ctx = data;
 	struct child_process *cmd = ctx->cmd;
 
+	/*
+	 * Objects in to_drop are being removed from the repository, so
+	 * omit them from the rebuilt promisor pack. Each such object is a
+	 * promisor object and therefore remains recoverable from the
+	 * promisor remote.
+	 */
+	if (ctx->to_drop && oidset_contains(ctx->to_drop, oid))
+		return 0;
+
 	if (cmd->in == -1) {
 		if (start_command(cmd))
 			die(_("could not start pack-objects to repack promisor objects"));
@@ -81,7 +92,8 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
 void repack_promisor_objects(struct repository *repo,
 			     const struct pack_objects_args *args,
-			     struct string_list *names, const char *packtmp)
+			     struct string_list *names, const char *packtmp,
+			     const struct oidset *to_drop)
 {
 	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -98,6 +110,7 @@ void repack_promisor_objects(struct repository *repo,
 	 */
 	ctx.cmd = &cmd;
 	ctx.algop = repo->hash_algo;
+	ctx.to_drop = to_drop;
 	odb_for_each_object(repo->objects, NULL, write_oid, &ctx,
 			    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
diff --git a/repack.h b/repack.h
index f9fbc895f0..a5a3f7c6ba 100644
--- a/repack.h
+++ b/repack.h
@@ -3,6 +3,7 @@
 
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "oidset.h"
 
 struct pack_objects_args {
 	char *window;
@@ -100,7 +101,8 @@ void generated_pack_install(struct generated_pack *pack, const char *name,
 
 void repack_promisor_objects(struct repository *repo,
 			     const struct pack_objects_args *args,
-			     struct string_list *names, const char *packtmp);
+			     struct string_list *names, const char *packtmp,
+			     const struct oidset *to_drop);
 
 struct pack_geometry {
 	struct packed_git **pack;
-- 
2.54.0

