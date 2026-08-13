Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C13417D99
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633016; cv=none; b=mtIV1itKFVwtgYzKyBH4kIkb0XDLHI7NooOk7yxdyHER7MEmf9wrhbfSTXtqzFsTgw6sk42AAmc9gD4wZMDCK0DS1OUgcuxaTSZQ9w4uESi4z+/mO0SV2qpt9wyEybaExQh1TcI8kFWWX0t7QD7dXJ+NhXSgGdyDC0cNhdTelpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633016; c=relaxed/simple;
	bh=UBpj5jccLzbwg5igAWFVz9c2zfLEbnPBndSArQHaxnw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=pFxtaxkoT1bZiJaLlb4qFdssClIjTr6tJBLroKPII6uKxPwMxdmqOGJhbAzWgk1zD+1/PbFmpi77RpfDTwmoKPnKcg2l3hhtpRqERxMms5k9qD6GT35FYgiRMNbLmN2Wy7SWV9pEC6pTloS+t2jcJBItqS/nGvxAEHmLPgROQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfpncgUB; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfpncgUB"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-930f618435cso41845085a.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786633011; x=1787237811; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aqNC0XhcUqmtM0H1+O/mtxxEpXamw4fsLXnqy3SYCgw=;
        b=sfpncgUB350P/U+LGlVUfIFK8DbU4MrkNPXuXFeaV1jzrWJ9+RhHpsDDTnLfsDTsKo
         KFSS5n3V5fVpW9HpZKN2ibkAFEihRZINQTv/6QeLdrXrx//Q0e63VneXbP97nCa5JGTa
         iZZGhJK+83So/FJqDFrUIIXk3wr+GcC5RJYsqq7Y1+9dJjwI0LsQZTXwvNYUrN8KaSpF
         9q8KqwNrZJ2zNwenVZTDJcQBzCzBEHiOlBF/q3Vc/RmMvW/aTk8CnzrlfUdzA9vdRI6i
         HjqKs2+TQORW+gzv3DOYxxZYAOeoFILZbY/Xtt+FnTKW6A3tQbPUwnfNYKiET9k87atb
         uAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786633011; x=1787237811;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aqNC0XhcUqmtM0H1+O/mtxxEpXamw4fsLXnqy3SYCgw=;
        b=fs82bltJtewPUGU4jtJaDw4jzJsWOBXRhQmB9iyplJoCAaIfE/62zf8k8FaHn7zaa7
         YCNaZqSiasfEJOTIshpdqoaiYiyyNt625usj7quoZVIkYVKmCSieycr8wKuRsaiX1mr7
         r8jI7dhTnTYMNpQjzbwSW3VMa+4OZI9bDREGd7tKqHQmbpueaMnZl9xATl56uecwVvpZ
         bpQdE0poXIWsGIBDSKl676XAY1dj+hDzQjPC/WIyyGz76v+79BCZJcoprkZ3gtXKoC32
         3fKyxzuoYSWUx3ZVuE8m4BZ7uPQA4nlS858J9geigWTHsYgqA+TOakkbAj1/9HZRUBek
         WzYw==
X-Gm-Message-State: AOJu0YzJ1Bpw/VLlaQ4ibipU44Nj449e9l+LAFwXFC3bwBEWQw/S44Td
	7d+3PP22vW2SowwxG9ZUIFgibj3LhkOOI/A0voueCoEVzS0/MsZGcatDY2VYrQ==
X-Gm-Gg: AR+sD11J19ufVJJ4pOAX7nVzAActtipygw9PpmyDCTHo7iHU1wLnWSZrTEZ7mzbRHip
	saYKbbxKpTYe67EfZs6/uUGFd/1sEMSxxbvdNp2HwA6747l+1F1pVFPTgOTbUS277z+aHaDrgP3
	n+lHMJyKitjmM7x7j3xkbnySBnIsFqJ3NxVg8m7J504cwNwlA2Yp2jzkq9PfB5PjG7I2HX+ugNW
	Ho8lMufsyac5crKhUIsDUKjrweFIDB6lAlhWQKxFUgevEBxznTxRH2V8LDABjs24+HNeB7BXSV6
	42RcSnvsJFOD0rerlXi4/s7bmxbLqyuK58YM/GFkTPYTG9rM8AnonYAJWzhWqViOtz0jVgoM+AB
	TCtlc9BwrtbBQM7l6dCHaOIRD5IbpgiEjVvhXlazl2X4TiOkJ/0TrLT1DkfpAt3tY5wxj7xGUGv
	4If2CVCteDheLRAh5cL1/82YCSaBvIJBi34fDQtAge3TQ4PPUoZU+Jtbky+9EbXWc=
X-Received: by 2002:a05:620a:20c9:b0:915:a953:4b9c with SMTP id af79cd13be357-936bf87b0camr443407485a.3.1786633011147;
        Thu, 13 Aug 2026 07:56:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.195.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b1235asm161858085a.24.2026.08.13.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:50 -0700 (PDT)
Message-Id: <pull.2202.v2.git.1786633010179.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:56:49 +0000
Subject: [PATCH v2] packfile: fix perf regression with many packs
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
    Jeff King <peff@peff.net>,
    Ben Knoble <ben.knoble@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 589127caa730 (packfile: move list of packs into the packfile
store, 2025-10-30), there is a performance regression when many
packfiles need to be loaded: `packfile_store_add_pack()` now calls
`packfile_list_remove_internal()` to detect whether the packfile was
_already_ in the list, and if so, move it to the end of the list. This
function linearly scans the existing list before every insertion. Newly
loading N packs therefore has complexity O(N²).

In one reported use case (https://github.com/microsoft/git/issues/970),
N equals 37,815 and caused a slow-down of a simple `git rev-parse
--short HEAD` (which is regularly executed as part of `GIT_PS1`) from
0.4s to 4.5s.

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
    
    Changes since v1:
    
     * Fixed a typo in the commit message
     * Dropped the claim that this patch fixes the CI clone perf regression
       that's still being root-caused.
     * Renamed the is_new parameter to the more informative skip_dup_check.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2202%2Fdscho%2Ffix-perf-regression-in-v2.53-with-many-packfiles-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2202/dscho/fix-perf-regression-in-v2.53-with-many-packfiles-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2202

Range-diff vs v1:

 1:  3dfb305e58 ! 1:  b892964f7e packfile: fix perf regression with many packs
     @@ Commit message
          store, 2025-10-30), there is a performance regression when many
          packfiles need to be loaded: `packfile_store_add_pack()` now calls
          `packfile_list_remove_internal()` to detect whether the packfile was
     -    _already_ in the list, if if so, move it to the end of the list. This
     +    _already_ in the list, and if so, move it to the end of the list. This
          function linearly scans the existing list before every insertion. Newly
          loading N packs therefore has complexity O(N²).
      
          In one reported use case (https://github.com/microsoft/git/issues/970),
          N equals 37,815 and caused a slow-down of a simple `git rev-parse
          --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
     -    0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
     -    increased from under 2 minutes to over half an hour.
     +    0.4s to 4.5s.
      
          Let's fix this by establishing a fast path for known-new packfiles.
      
     @@ packfile-list.c: void packfile_list_prepend(struct packfile_list *list, struct p
       
      -void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
      +void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
     -+			  int is_new)
     ++			  int skip_dup_check)
       {
       	struct packfile_list_entry *entry;
       
      -	entry = packfile_list_remove_internal(list, pack);
     -+	entry = is_new ? NULL : packfile_list_remove_internal(list, pack);
     ++	entry = skip_dup_check ? NULL : packfile_list_remove_internal(list, pack);
       	if (!entry) {
       		entry = xmalloc(sizeof(*entry));
       		entry->pack = pack;
     @@ packfile-list.h: struct packfile_list_entry {
       void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
      -void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
      +void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
     -+			  int is_new);
     ++			  int skip_dup_check);
       
       /*
        * Find the pack within the "packs" list whose index contains the object


 packfile-list.c            | 5 +++--
 packfile-list.h            | 3 ++-
 packfile.c                 | 2 +-
 t/perf/p5303-many-packs.sh | 4 ++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/packfile-list.c b/packfile-list.c
index 01fb913abf..d6d411823c 100644
--- a/packfile-list.c
+++ b/packfile-list.c
@@ -57,11 +57,12 @@ void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack)
 		list->tail = entry;
 }
 
-void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
+			  int skip_dup_check)
 {
 	struct packfile_list_entry *entry;
 
-	entry = packfile_list_remove_internal(list, pack);
+	entry = skip_dup_check ? NULL : packfile_list_remove_internal(list, pack);
 	if (!entry) {
 		entry = xmalloc(sizeof(*entry));
 		entry->pack = pack;
diff --git a/packfile-list.h b/packfile-list.h
index 1b05e2aa36..2b4b98b226 100644
--- a/packfile-list.h
+++ b/packfile-list.h
@@ -15,7 +15,8 @@ struct packfile_list_entry {
 void packfile_list_clear(struct packfile_list *list);
 void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
 void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
-void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
+			  int skip_dup_check);
 
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
