Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821373112A5
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561875; cv=none; b=BJ5Add1GZ6Jw/jfLEHyn3wu37lM1AuJQK4vQ+cpk/oaX/kkxQxN1FbDUugNs8vfIypp3beNbX2YUlXcU+B6Ai2xyXjJVGCBpdyxe6c56clvxQbF64XkKChgTr8jd3Qk9agX5eniaU5NC6KlZ6kS51/5LD73PBNY3vQc6ElrQOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561875; c=relaxed/simple;
	bh=bW8zUitGFp/V7thbnSYc3p4JHfsBujt7u2gbn/NuLB8=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Z+9NLtquTuyoaOjbStFi1h+EOVrOCc5pQQxQzUUZCRhnoxhSYg/TkToBPEz4uFccEOWVO0mTPq08uPQjJlFizDqS2R10ZJ8v0V+edCxJB5UkMxk1bN3IlVAayfPM3xSFfghZ/FB2lyNV3P8bYJ7tdhb/lIl2dyvbzmmS01XvKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVrkTu8a; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVrkTu8a"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-448cf99c133so186078fac.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786561872; x=1787166672; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YhhQvYHyAT+ymy2Wsmd3CN/FvvDlzENCSxxmZeak4m0=;
        b=KVrkTu8a8L2uki9XLzSc4kJR4x0EtR0c5WYwWv/vzyPrHTbF0euRmBmZ/naJUCwstr
         NHklek2LvDzjkG/CqDZWs2lInqt5RCYAvDvKuuS0SREPFHI0sTqwwz0WfeOs8eijA8J/
         4NHvqg/6ZSswtvEKhBc7e5K9CF0c5/nQ4vOReSUfoiDZcfgVY6s4EF+ZPUwh3FJoQeT7
         kSWk3Y305uLybxdLpN8CDGmxlQ2prO4lLsl6BtJbbGCRHd+oa+JYcYyW9lqXbmrGUsSD
         Ok1544ayh/nOjpexuBvBjv5482AGZTlFlAzdihprPhE4inV161sJI54PVvEdd7hM/74a
         uD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786561872; x=1787166672;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YhhQvYHyAT+ymy2Wsmd3CN/FvvDlzENCSxxmZeak4m0=;
        b=XKmPOhsYxnRdPgqt+dqCqYZLKdHqNxuwrqnKaqt0nj917XJSbHdkJd98wRNXYsZriD
         aJ218TAEkxZRm07ztlxwh5/EVVmqE/ivZDzBUWW0bSqg7PecJJ2gtTOY1cwDHCvxHZXA
         MiaO+pqD22kjmNoaxSAf/Cc0cGitvHMKD3lAksZEDw6g7Io+W5mbzevzFQoRmHH1RoJB
         jKkvAMKaQzROEL8L0QzucFrplHzvnb90GcM+XraU6UuQpgW6+0Gd5kwRGTXFm3XJuAUE
         snSAOSn0InApEcHd1YQkx3Me58C7Ygx001yuL2Mvv0A3sYQT1/vOOSypgqxVhtI/nSWK
         By2g==
X-Gm-Message-State: AOJu0Yy8ePBKpoLuHnFNjWd/xmaFdXUpFhELHO7Rskwa/IkkIY6jTWJj
	gfeqqgswJJ3ARFbyHCsjbm6R5DppBa186zBbwn2shsuaBtQronpkzpJW3vcruw==
X-Gm-Gg: AR+sD10N4l9wx6MjlT7seWjnPCY1Ia7SZFVXHQhlNdG8zUCB6+a8MxKKYUgaD+Zz8XM
	9YWgfX7J4645ogxk6v9Y3LyG5WnaygsGtCNXO4W1LSf5asiAe7kZAd4sC23ICUk56TLikjvmM3t
	UJ9VrwS87RAIBiwM00Rr30oK67/QBVhx2uaIxN92WFlBj1gKf0RcIUn3EldSdlDwe7MXlILoT03
	CCeEIPq3v9g+vTs5i9e28sxWSFZYCaXf+tUcIo6U/GmFLq2B0Hf7wPhNc8T9bgHiQG0muoGOW7u
	/CtrVMZiWG3h6jATYBXzYcll1yAWFKkAXD3OfpPI+xJcPrYQjw0kqeWYLMtqrs7TGnq5KJk20mv
	p6kmt2Gifji7knVbHwnN8yw6QTaBAQxZXD+0O1NC+bzho+t9CRkZNAzghoieyqOPPDjCst08H0E
	+06ugCcnAUJrfKhfH9yhDkHFvyNq4i+WMhbniMbrsFTEO8ks3OI1iRsIXmXuaxtQk=
X-Received: by 2002:a05:6808:1a22:b0:496:1111:d7a8 with SMTP id 5614622812f47-4b2243e44f2mr1377201b6e.8.1786561872016;
        Wed, 12 Aug 2026 12:11:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.186.238.84])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22376c086sm537333b6e.14.2026.08.12.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:11:11 -0700 (PDT)
Message-Id: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 19:11:09 +0000
Subject: [PATCH] packfile: fix perf regression with many packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 589127caa730 (packfile: move list of packs into the packfile
store, 2025-10-30), there is a performance regression when many
packfiles need to be loaded: `packfile_store_add_pack()` now calls
`packfile_list_remove_internal()` to detect whether the packfile was
_already_ in the list, if if so, move it to the end of the list. This
function linearly scans the existing list before every insertion. Newly
loading N packs therefore has complexity O(N²).

In one reported use case (https://github.com/microsoft/git/issues/970),
N equals 37,815 and caused a slow-down of a simple `git rev-parse
--short HEAD` (which is regularly executed as part of `GIT_PS1`) from
0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
increased from under 2 minutes to over half an hour.

Let's fix this by establishing a fast path for known-new packfiles.

The keen reader will note that there is currently only a single,
"known-new" caller of the `packfile_list_append()` function, and wonder
why not simply remove this check whether the packfile already exists in
the list? Originally, when above-mentioned commit introduced that logic,
there was a second caller in `prepare_midx()`, which would have required
that check, but that caller was removed in 6aff1f25a046 (packfile:
always add packfiles to MRU when adding a pack, 2025-10-30). Still, the
function is declared in a header file, and to avoid any problems with
in-flight or downstream callers, it is safer to extend the signature to
be explicit whether or not to skip that check.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    packfile: fix perf regression with many packs
    
    This issue was spotted by a Microsoft Git user with the massive amount
    of packfiles typical of an average, long-running monorepo checkout.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2202%2Fdscho%2Ffix-perf-regression-in-v2.53-with-many-packfiles-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2202/dscho/fix-perf-regression-in-v2.53-with-many-packfiles-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2202

 packfile-list.c            | 5 +++--
 packfile-list.h            | 3 ++-
 packfile.c                 | 2 +-
 t/perf/p5303-many-packs.sh | 4 ++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/packfile-list.c b/packfile-list.c
index 01fb913abf..1379ab3a4f 100644
--- a/packfile-list.c
+++ b/packfile-list.c
@@ -57,11 +57,12 @@ void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack)
 		list->tail = entry;
 }
 
-void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
+			  int is_new)
 {
 	struct packfile_list_entry *entry;
 
-	entry = packfile_list_remove_internal(list, pack);
+	entry = is_new ? NULL : packfile_list_remove_internal(list, pack);
 	if (!entry) {
 		entry = xmalloc(sizeof(*entry));
 		entry->pack = pack;
diff --git a/packfile-list.h b/packfile-list.h
index 1b05e2aa36..01f9fb4cc5 100644
--- a/packfile-list.h
+++ b/packfile-list.h
@@ -15,7 +15,8 @@ struct packfile_list_entry {
 void packfile_list_clear(struct packfile_list *list);
 void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
 void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
-void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
+			  int is_new);
 
 /*
  * Find the pack within the "packs" list whose index contains the object
diff --git a/packfile.c b/packfile.c
index 0eee45055f..f80f05a1fe 100644
--- a/packfile.c
+++ b/packfile.c
@@ -781,7 +781,7 @@ void packfile_store_add_pack(struct odb_source_packed *store,
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	packfile_list_append(&store->packs, pack);
+	packfile_list_append(&store->packs, pack, 1);
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
 
diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index af173a7b73..4221f9dd70 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -141,4 +141,8 @@ test_perf "load 10,000 packs" '
 	git rev-parse --verify "HEAD^{commit}"
 '
 
+test_perf "abbreviate with 10,000 packs" '
+	git rev-parse --short HEAD
+'
+
 test_done

base-commit: 11c6700f10234578d10523faf35656ca491425c9
-- 
gitgitgadget
