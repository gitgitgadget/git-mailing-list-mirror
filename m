Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2C48820B
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133272; cv=none; b=hbMBcTEvzAp4k2sEt5x2OPWMVIl9Bi/L4IYqU4dZsW8isUeRks9C9rx7dzmm4SvqcPB/VGtDFy7Jqk/Vyji/lvM6wLzOfPgGb9wId58KpFFAhMoZLPMtPyJvkMSskfS1OX6sA0yXSi0Yd9B/fz2LoENvE/NZoRrhCXEPLhc29Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133272; c=relaxed/simple;
	bh=UZXCWHs2xCyZFFZCB8Iug1Uuwxp6PKIo6PrY1G9P8Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSYkoVJinidst92pyPjYQvEeoHglwWSI82IlOglZw1xw9UM7D0azdOAFrKZXijyML6QQxI5ZQX3fL7YqzIeYMxhoZDDrVRTZN6Q5Jdsn1TWIhlLxGiFhL/G0xlJxGSpV2PozexLr4/jZJ5K9KnGjy43W3DAt1RZw3z7c2sRbSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j+a3jOxD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cD30K84W; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j+a3jOxD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cD30K84W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D52CEC0175;
	Fri, 11 Sep 2026 09:27:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 09:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133267;
	 x=1789219667; bh=hsJyffiZwfOCAoVUwzqfY0ETZAHI8S0b6R5U5/4R9+4=; b=
	j+a3jOxDluCoobLm3gYZGqsvx/9wzQ4iw2PQvwB/tn6dvhT6ESkPaNcDfr+oCBhr
	K4/ARULXSNnROfdtktA9jL44q32rcW24pJ8DQ4js37J65w0TieBkeR/Z23ePj1VZ
	MwcMxDbUSaWG5CRHCdY+kfQfDlczRS5TmJbP2lFZ94W/e4YN6ZUeq20lOjiQSl8r
	0vAweOSYZLMklzJZAyYyZuNJ7y+ogMH5+/n6CCEyG1/cYXVp/HKjarzMDG5ZFlc+
	J/J+V6DGBJsBT3d+yBMG6G9T6pv/mkDL0uraFR21K2fh0dm8TrYZmtQQJRLgMi31
	YrMvXFB7H0tR7BG4Y3uFGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133267; x=
	1789219667; bh=hsJyffiZwfOCAoVUwzqfY0ETZAHI8S0b6R5U5/4R9+4=; b=c
	D30K84WMwrTHXySczW3BULiBeFNbU4VkBJoPlgBuJgTpYWL5dJk9wwWdtsPG5GbJ
	8NTErQIUARhy0CBwiLZB/eEgbANPM9jMGA2/7vQQvFd/xAKiEhEwQxtAs8PBeACh
	d7HgnZWmWCNw9VqM4Q9eEx9M7+pvq0ZCHoJOa68Gp0AssL4G/A429hpcW2DpEu4/
	DtcpG/idchsYc7bpRhATYFE4eV5podWXr244U+/N/Q5Zal7tDsdw09NlGhfyFz6O
	RkfJlsYiV9tWL0eegqjG+OdaqITesTweat1LFoHTVMefScAEb2cqfhv+hJ7JvJfm
	/7E57dc6zlz/nqxjzWgIg==
X-ME-Sender: <xms:0wGkao74RYEX1rpeFWAFf6qtZmdZyumx6xTFGFBx5jqpG7DRwldy-A>
    <xme:0wGkahVg1ODGq4nlqLYAHa6WC2qmtSkCuXF9y3LwkHoeBmvcZ-3clAn7viXBk2Ss3
    BkAdgeJD6rPpx6ridj_p6xEtmcgvan_gctrqyzSVFGy0IwWj9hHmrc>
X-ME-Received: <xmr:0wGkak3PmYZjzOV9lGgHBtPWiURMTv_ug3qzuqubQ-3HkORPORem2ONIlAAZocxXga2gZA>
X-ME-Proxy-Cause: dmFkZTFhKNTY4gaJzL8unHorI0O2mIjovbOSn/bb4FfWdQC69pOMNnSpJupj+k3b5RRAEh
    CKbErTW3WczRhRJwwrJkvaRsvQIzXEXE2C+BN/DKoL4Gbfz/Eo1tEu7eUCGtvI2UYkaIkN
    pdzF4Cl414GlPSVfplCLhQTY1vxDPnsAjpUCtDjPcnIgviIidiwFFMtURzMpzxs3Vu7cEM
    3nEkQWJ43K7d/I7qMYYZ6hxKZuNC1lSeitb76YKd6w//fOV1p7l3EElcNKMWcMdULICz/K
    NpH5skcEvh10Ou1QeaUv5hQYKlpJ4gF4a0EGGL8oCdZIc9NRujjRUNoZU+qfCLCaHmP9UI
    6YR0/GXd8Log82Yk0Kcb2eb+Z4DIP8OK1CvyxkYTarXuWUHkjDj5TwK2JdoJwb88u75jSF
    E6knwmego8jwma0e7XLKB/l34oPgfZPmfYWLvRnjaWhrn3fhN7w2b3e6aJgjEFUHaXVtKO
    rziNiNexDEB3FiRNw4MyhfGWKbzCJ7oZcbgG8q18SGGY15RVIiR5XinMKrl8cksZkIpupI
    7NAvA/f9wfX3rk1TnnGHwEOzJltdGvrWcZ6oiWjlm2+yke8V/f7liAmzmZrGbM6jyr9GyY
    fkrFMPUGuYftw2qYKZY7FEGE+boHmpWNTuEnGxV8VlhbUTOg9hRVgBjSejSA
X-ME-Proxy: <xmx:0wGkam31gkn2wPARpncwyRJ874AwaJlwQMSZLYx1q1uTYatkmIyZQw>
    <xmx:0wGkav_oHyZm8NidrU4T-O05eRdaAaAgpvbOghgkSEE20jJ5n4umrw>
    <xmx:0wGkar3PkN5K9NsR5iZh0rmjnVzk0JT8QqUgPo_davESZZh2LSQfEQ>
    <xmx:0wGkak9LW7SI0trFf62egsAVictRCduiWyomZ8Cf-S2seDkla09J8Q>
    <xmx:0wGkapUW_uz2S0ppv8SzzyqNP5QPshDVPHTuOopTO_8xHSn5q4C1ieie>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4137f02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:31 +0200
Subject: [PATCH v3 07/10] builtin/fsck: move reverse index verification
 into the packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-7-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The checks for reverse indexes live in `check_pack_rev_indexes()`, which
is hosted in "builtin/fsck.c". These checks are obviously specific to
the "packed" backend.

Move the logic into `odb_source_packed_fsck()`. As in the preceding
commit, drop the dedicated `ERROR_PACK_REV_INDEX` bit and instead use
the generic `ERROR_OBJECT` bit.

Note that this changes behaviour in two ways:

  - The checks are now skipped when "--connectivity-only" was passed.
    This is because we don't even run `odb_fsck()` at all when that
    flag has been passed by the user, and not verifying data structures
    of the object database matches the documented intent of that flag,
    which is to only check the connectivity of reachable objects.

  - The checks are now skipped for non-local sources when "--no-full"
    was passed. This is, again, in line with the documented intent of
    that flag.

Add a test to cast these semantics into stone.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c           | 37 -------------------------------------
 odb/source-packed.c      | 39 +++++++++++++++++++++++++++++++++++++++
 t/t5325-reverse-index.sh |  8 ++++++++
 3 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index e504dae904..06e72877f3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -23,7 +23,6 @@
 #include "run-command.h"
 #include "sparse-index.h"
 #include "worktree.h"
-#include "pack-revindex.h"
 #include "pack-bitmap.h"
 
 #define REACHABLE 0x0001
@@ -51,7 +50,6 @@ static timestamp_t now;
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
-#define ERROR_PACK_REV_INDEX 0100
 #define ERROR_BITMAP 0200
 
 static const char *describe_object(const struct object_id *oid)
@@ -890,40 +888,6 @@ static int mark_object_for_connectivity(const struct object_id *oid,
 	return 0;
 }
 
-static int check_pack_rev_indexes(struct repository *r, int show_progress)
-{
-	struct progress *progress = NULL;
-	struct packed_git *p;
-	uint32_t pack_count = 0;
-	int res = 0;
-
-	if (show_progress) {
-		repo_for_each_pack(r, p)
-			pack_count++;
-		progress = start_delayed_progress(r,
-						  "Verifying reverse pack-indexes", pack_count);
-		pack_count = 0;
-	}
-
-	repo_for_each_pack(r, p) {
-		int load_error = load_pack_revindex_from_disk(p);
-
-		if (load_error < 0) {
-			error(_("unable to load rev-index for pack '%s'"), p->pack_name);
-			res = ERROR_PACK_REV_INDEX;
-		} else if (!load_error &&
-			   !load_pack_revindex(r, p) &&
-			   verify_pack_revindex(p)) {
-			error(_("invalid rev-index for pack '%s'"), p->pack_name);
-			res = ERROR_PACK_REV_INDEX;
-		}
-		display_progress(progress, ++pack_count);
-	}
-	stop_progress(&progress);
-
-	return res;
-}
-
 static void fsck_refs(struct repository *r)
 {
 	struct child_process refs_verify = CHILD_PROCESS_INIT;
@@ -1104,7 +1068,6 @@ int cmd_fsck(int argc,
 		free_worktrees(worktrees);
 	}
 
-	errors_found |= check_pack_rev_indexes(repo, show_progress);
 	if (verify_bitmap_files(repo))
 		errors_found |= ERROR_BITMAP;
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0d3599f8fe..e5e69636dd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -10,6 +10,7 @@
 #include "odb/source-packed.h"
 #include "odb/streaming.h"
 #include "pack.h"
+#include "pack-revindex.h"
 #include "packfile.h"
 #include "pack-bitmap.h"
 #include "progress.h"
@@ -861,6 +862,41 @@ static int verify_packs(struct odb_source_packed *source,
 	return ret;
 }
 
+static int verify_reverse_indices(struct odb_source_packed *source,
+				  struct odb_fsck_options *opts)
+{
+	struct progress *progress = NULL;
+	struct packfile_list_entry *e;
+	uint32_t pack_count = 0;
+	int res = 0;
+
+	if (opts->flags & ODB_FSCK_PROGRESS) {
+		for (e = packfile_store_get_packs(source); e; e = e->next)
+			pack_count++;
+		progress = start_delayed_progress(source->base.odb->repo,
+						  "Verifying reverse pack-indexes", pack_count);
+		pack_count = 0;
+	}
+
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		int load_error = load_pack_revindex_from_disk(e->pack);
+
+		if (load_error < 0) {
+			error(_("unable to load rev-index for pack '%s'"), e->pack->pack_name);
+			res = -1;
+		} else if (!load_error &&
+			   !load_pack_revindex(source->base.odb->repo, e->pack) &&
+			   verify_pack_revindex(e->pack)) {
+			error(_("invalid rev-index for pack '%s'"), e->pack->pack_name);
+			res = -1;
+		}
+		display_progress(progress, ++pack_count);
+	}
+	stop_progress(&progress);
+
+	return res;
+}
+
 static int odb_source_packed_fsck(struct odb_source *source,
 				  struct odb_fsck_options *opts)
 {
@@ -870,6 +906,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
 	if ((opts->flags & ODB_FSCK_FULL) && verify_packs(packed, opts) < 0)
 		ret = -1;
 
+	if (verify_reverse_indices(packed, opts) < 0)
+		ret = -1;
+
 	return ret;
 }
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 5493791938..6b81abf663 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -204,4 +204,12 @@ test_expect_success 'fsck catches invalid header: hash function' '
 		"reverse-index file .* has unsupported hash id"
 '
 
+test_expect_success 'fsck --no-full checks rev-index, --connectivity-only does not' '
+	test_must_fail git -C corrupt fsck --no-full 2>err &&
+	test_grep "has unsupported hash id" err &&
+
+	git -C corrupt fsck --connectivity-only 2>err &&
+	test_grep ! "has unsupported hash id" err
+'
+
 test_done

-- 
2.55.0.1074.ge7621b4bad.dirty

