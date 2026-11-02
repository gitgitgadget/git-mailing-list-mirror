Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634432;
	b=yM1HOkq1gXUrq5g84mXfC+6szNPVXS+1p+VUijs0oWd3CMk9BbrDdv8zU+YeSbsb1EkX
	 0Bp5bOYH5rFYgLHcbi21VZIQsTj3zwGdx50BucLkc3R6GuQicCdjiL6jOmSBtzxLrZy/U
	 c/+L+rk+OdD0EPhdeuo1VWlm/92CEj0TIgOXOcj3SOAcJYUobhCDYHbQMTkkfsc4UpEL8
	 BqFnSuUqiDLlIpEuXEPJuQw1Yjw23ghhpGzz5Y/4y1TN/bHe+HAQ0uTah70ZgjYLRhSh+
	 Asb57goaTjwNv+/m8fTgApx6R/LN2g3DxkRQoylpnvmjScIevCOoaFNM2qekc7gtkQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=jThK2Ymz2zBpawwoBpSbv4iASXlAqUaFi596o0k5hiw=;
	b=sA58f9SzxuYiMpZp+TscQYhj31RWVXsB1hjc5M8NhkdcTA0GU9jdu5IIs4BiyoQYO2QC
	 1X4Yqz8H/T8j7KejXFelmJ+9jsZV3bHkIrR0gRxvIbgRN0jIhzjU/5K0ug8ZgXP0gACYL
	 Ef2HISJryLUQ/z/xcfmJBXtozG2QhZNkRnR9PMfdTKW8uIeewCgkUvY2PtHVbX9vkPBGh
	 dlKavA8PnIgC7nTZiHxlCr6Z9fqpJCQDHck7viEGVtJHS5r6BWsEqX4V6BEwzdCM82Fc6
	 8986Q12qj1JfIZgdeOcxgVEOlI+ZqBTYO2BIJqWGMR/wB6BBSX5OBDuhMahYkHshJtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uOrovgDh;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E7606B1D9
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 571E7606B1D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uOrovgDh
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a6fb4040cfso946439fac.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793634431; x=1794239231; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jThK2Ymz2zBpawwoBpSbv4iASXlAqUaFi596o0k5hiw=;
        b=uOrovgDho2XtprjWOZ1m7dzXfCDVD0KPL5/4+dxBSWlMzeMOr2kBCMXqFfQ9HC+Faw
         hV6LO4KMEg1KVfycACVNAzbZ1AJx2x4QKspK7PhviHPXiFpmCGRCCLC+iZfUzWypHEFB
         uzzwu6ib0ZQfs9tGWpenqm3pdru96mi6W5BeYAxl1SE5/gnhPKke6h/o9hatDwoKG458
         j5Nwwau/FO6I1kMFntEj/zxVN5N2pq0oxlX3K5I1iL71/IEnnMAVQY0VEgKq/GbJTQAc
         bl1jsrMQka/MQXZND9J9v97Kc3Yo2JWI9GWo7hkrnAhi6mQebqyyQ5+xT/AWt7GfuG1V
         2t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634431; x=1794239231;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jThK2Ymz2zBpawwoBpSbv4iASXlAqUaFi596o0k5hiw=;
        b=p7D3pcgM++sfDgVGtXUan2kKiur0VDBHk9jsIixIrTZ8Sg7rQlOI4sJIC3LSEV3XiS
         4gzv01HKdrR0osX81SSDMLQoqNqcV/nt6ZSPB4pAQN1kPldAixkWj+3TAkHmJYEl8J3D
         iMvcawJx4bx+v86dPbEUJh1WTpY4Yg4QEBCCx6Ei7iSOvzQl6sDu358YiwOMzxxXpG7L
         XvjjXXoe3CoBQGGz/hPSUF+01UQfcHqOya1PFx42Ifx4KUq+EywBxjmczQ77vTjcBZV6
         PYx6Gc/rXVsspMcvOvbcyl1UTy3Enuqch54yX7ZPYgSJjAp/XO5vmQ3o1Fm81mDU240M
         +VBQ==
X-Gm-Message-State: APuU4Z+vQW+OI1CsKOZ+dDT1SxvfpiU3OTBCZFbCXjmKP84aX2Ow4OPW
	VyBOEkz4LyJCMv/zZkDg50zkeg/dSZlCwAFRQWBsgmpJVkjyn2IBt8YqIqRjC/zI
X-Gm-Gg: AYBFou0Et9iLvwEOF5n6WDzC36j6tSM2H8GRSwE1T3PNHYt64HuxNPf02sN1PHUr11T
	HmtghpbDRBhSj9Epv4tpSjY6kyyBaD4ta1gEcZBNht8Rbnnkk2SAEBudPDdwLHRPyhzqy4xtw6r
	Zq/3m68dBXRZw9Qf2PqiZUEtOzGDoQAKlK3468fPy9IPoqHJjTdP3p+oA6jbmEJV7VzsHzdLh9Y
	958sRdiF2gzi3wjQosSofaOBxZJEIiBv7oW8+JDRFutXmpf6lulvT7A3WWRS7yaiANWVGXHfdS2
	8BFug0qK7rR/DtizO5JcYxnhz/1AWScK0MvKD9LXsyo4OPhe7dCoi05FTGQhdsSW5I/VCtMo8tC
	YNJYY5dyChJIjkj3B6SCBFEMrTGjWtZrOhErsFM7oHnuzPwj0xG0FFGOx8thmYQd6XZx45wvVpf
	kMUYcitrwSdr4KQgzIdk9WVg3INxNCo17JHto2+bef2oW9rDVqMEXHR3t3dJIVRnWDPBTB9bDJp
	e0N5GYlhLpjSvu7LCW/Hw8ZbDdJOEI65v+H8Sfu5DaozOdInQui12QQHPiOB2DAQcSAZgDFJm/0
	aCqqcEzATokExDg3C8hVqoNQaD3905peDko+TKatrF9A8CPNcf4e
X-Received: by 2002:a05:6870:16f1:b0:48f:e0f6:c45e with SMTP id 586e51a60fabf-4a907722e6fmr5884015fac.44.1793634431089;
        Mon, 02 Nov 2026 07:47:11 -0800 (PST)
Received: from [127.0.0.1] ([20.118.38.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a92167b03csm6858589fac.2.2026.11.02.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:47:10 -0800 (PST)
Message-Id: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 15:47:09 +0000
Subject: [PATCH] rev-list: ignore replacements in the connectivity check
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The connectivity check follows replace refs, but other operations
that depend on the repository being complete, such as fsck, prune,
pack-objects and upload-pack, do not. They were taught to ignore
replacements in dae556bdb1 (environment: add global variable to
disable replacement, 2009-01-23), as they must work with the
original objects, and check_connected() came later without doing
the same.

Teach the connectivity check to ignore replacements as well, so
that it verifies the same objects that the commands relying on its
result will read. This is not a problem seen in practice, but the
two can disagree. If a replace ref names an object that is not yet
present locally, the check follows the replacement instead of that
object when it arrives, and accepts an incoming pack that lacks
objects below it. fsck and repack then fail. Such a replace ref can
be the result of fetching refs/replace/* without the branch that
contains the replaced commit, which fsck does not complain about,
but it still takes a sender that sends an incomplete pack.

check_connected() passes --connectivity-check to its rev-list
subprocess, so make rev-list disable replacements when that option
is given, for both the full and the incremental check. Also drop
OBJECT_INFO_LOOKUP_REPLACE from the object reads in tree-verify.c,
used by the incremental check, to match. Disabling replacements
already overrides the flag, but it suggests the opposite intent.

The t5413 test that expected the check to accept a commit whose
original tree is incomplete because a replacement is complete now
expects a rejection, and the test that disabled replacements
explicitly to get one is redundant.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    rev-list: ignore replacements in the connectivity check
    
    I noticed this while working on the incremental connectivity check [1].
    I could not find any discussion of why check_connected() follows replace
    refs when fsck, prune, pack-objects and upload-pack do not, and the
    history suggests that it was never a deliberate choice.
    
    This is meant both as a question and a proposed patch: should the
    connectivity check ignore replacements like those commands do, or is
    there a reason for it to respect them? If there is a good reason to keep
    the current behavior, I don't have any issue with dropping the patch
    directly -- you would not even have to look at the code :) If not, I
    think aligning them is a reasonable thing to do.
    
    The case described in the commit message, where the two disagree, is
    tricky to trigger in practice, so I do not expect it to be a common
    problem. The main benefit is logical consistency.
    
    Shallow boundaries are not affected, since they use the graft mechanism
    internally, not replace refs.
    
    [1]
    https://lore.kernel.org/git/pull.2211.v4.git.1792581744.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2279%2Fspkrka%2Freplace-connectivity-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2279/spkrka/replace-connectivity-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2279

 Documentation/rev-list-options.adoc |  1 +
 builtin/rev-list.c                  |  3 +++
 t/t5413-connectivity-check.sh       | 11 +----------
 tree-verify.c                       |  2 --
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 285fb3809f..b2c0d394ab 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1107,6 +1107,7 @@ It is an error to use `--missing-only` without `--missing=print` or
 	(For internal use only.)  Used by `check_connected()` to
 	select the connectivity check algorithm; see
 	`transfer.connectivityCheck` in linkgit:git-config[1].
+	Replacement objects are ignored, as with `--no-replace-objects`.
 endif::git-rev-list[]
 
 `--no-walk[=(sorted|unsorted)]`::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 071a0e3cb5..bf66d2c9ae 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -30,6 +30,7 @@
 #include "strbuf.h"
 #include "tree-verify.h"
 #include "parse.h"
+#include "replace-object.h"
 
 #define INCREMENTAL_MAX_COMMITS 1000
 
@@ -807,6 +808,8 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--connectivity-check=", &arg)) {
 			parse_connectivity_check(arg, &connectivity_check);
+			/* Check the original objects, like fsck and pack-objects do. */
+			disable_replace_refs();
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
 		} else if (!strcmp(arg, "--missing-only")) {
diff --git a/t/t5413-connectivity-check.sh b/t/t5413-connectivity-check.sh
index 60edf99b63..341638a433 100755
--- a/t/t5413-connectivity-check.sh
+++ b/t/t5413-connectivity-check.sh
@@ -427,18 +427,9 @@ test_expect_success "$mode: handles directory-to-file transition" '
 
 # Replacement objects.
 
-test_expect_success "$mode: accepts with replacement objects" '
+test_expect_success "$mode: ignores replacement objects" '
 	(
 		cd replace-test &&
-		check_connected "$original_oid"
-	)
-'
-
-test_expect_success "$mode: rejects without replacement objects" '
-	(
-		cd replace-test &&
-		GIT_NO_REPLACE_OBJECTS=1 &&
-		export GIT_NO_REPLACE_OBJECTS &&
 		test_expect_code 128 check_connected \
 			"$original_oid" 2>err &&
 		test_grep "missing blob object.*$orig_blob_oid" err
diff --git a/tree-verify.c b/tree-verify.c
index 25db76d30b..c228235150 100644
--- a/tree-verify.c
+++ b/tree-verify.c
@@ -133,7 +133,6 @@ static int verify_blob(struct repository *repo,
 	vs->blobs_checked++;
 	oi.typep = &type;
 	if (odb_read_object_info_extended(repo->objects, oid, &oi,
-					  OBJECT_INFO_LOOKUP_REPLACE |
 					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 		if (vs->exclude_promisor_objects &&
 		    is_promisor_object(repo, oid))
@@ -163,7 +162,6 @@ static int read_tree_object(struct object_database *odb,
 	oi.sizep = sizep;
 	oi.contentp = bufp;
 	if (odb_read_object_info_extended(odb, oid, &oi,
-					  OBJECT_INFO_LOOKUP_REPLACE |
 					  OBJECT_INFO_SKIP_FETCH_OBJECT))
 		*bufp = NULL;
 	if (*bufp && type != OBJ_TREE) {

base-commit: ebdc087dc99d68bb340c282b2ba5f722def28d19
-- 
gitgitgadget
