Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69653478E53
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566298; cv=none; b=AQeV9rvOgf1bzjVuKxCvVWVyvcSaiEAsmJ7Wt3kIKc4xCoInFSOYElnN9LHlb4lCDpWMG6JngAY+TAAC9IfkMJYxUHRFu3n/tFyhUKuvnZbzlzFFlosO8tV6f2bN0LSGQZH5DGeqc0UK9cDvZgDiSoJxpVuJ+udKW8KjlKmfagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566298; c=relaxed/simple;
	bh=CbHpGShfcW6Y60yhaCBAu7rwZIzyuHXHKzVFLgOsYDc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=o4RFNbOYrVpADJ5BUosEL3e06OODSVn6sv1KvcvarrNTdhPoQxxRz/7ebZJSM5uglrPuB96+8MbYJJ6z4RbWLlVRiSsrUjgZUEzEIFpwrG6DNEBnSbYDFB8hc62t7ZmQuJPeIJ1h4rTjgRRmzWt32c7g6CBq/pWMMatV/5qCydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFQeskY+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFQeskY+"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51306c9f2e1so51378231cf.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778566288; x=1779171088; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YLv0mKmlGUUeuIntCkjnAq+0I4G3KNInFMjgXbbHnng=;
        b=UFQeskY+9wA21VS4zlnD5Yco4Jjni+kFJq5IWyJHqZBY7qBvGFt7kYiWKVN6X954iu
         Mx8h8CDVQWsguKvm0+Yq8oQcbkQns3Vzkgp73mmbd/r7fx/vkdPNro8/E+nNF28as3/e
         LyXiEIftdL3V8wCXy8paaXhYq0/PHA0cX6mNwNMeXpgwpXarZZIBGBeiunYzBhhduaYF
         hV42ZDf5+mp1o9esSe2LbpjUbmhNLCR64pJzVF9R4ahlFukiBhrp2CvuaM27A5D/OdpQ
         8CaOFoJhzAwO7Y4BLxWwCp0UUCZPfVkR+4LJti+Q5v8hzdZQGtDB7PuSHGj9GQKal6ym
         B3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566288; x=1779171088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLv0mKmlGUUeuIntCkjnAq+0I4G3KNInFMjgXbbHnng=;
        b=dX2vXEx6lGzmDgyfm9VN29TNU0lMeMsFbPzzN8NsbtROb/CI96t5E9KqrUvS3zzxhL
         1+QbMNpz0u1VA8+vWxB715VMRwVi0qUktpcDUV6K7ZNSvhgOvOIcCaJLMpm2q2ZRdSuD
         53mjiXOqqlSC8oFoPVbzqcPQY69xJP0fjcgWiZsG+m2uCTONUthtKdZnnkZRKVzfLNdq
         Tzg5KLDdy90umGfCmgyGYH8TlJDVGeWQZmkSoBfh7J0SvNwB8jiftutr55LWYaNjnLfe
         +XkTJQOObSmBcH+UVmHJuGldzid5wuSlf46hkkKTSngSiij2bTVwJHMLlZ37ATdn9rwL
         N16w==
X-Gm-Message-State: AOJu0YwAadVA78j4Y3I8DtD4naOj7TMMu7RT3Mkl6K8/vFweIiBmtFky
	Jn8eSzVULxSlPrmd/ehDuKNbhACUhLHE+1c2JY2PTJ9sHq5AQRrw04xN9i+zNw==
X-Gm-Gg: Acq92OFIh/z74wHL8ciTqcdghrFV57YilO9KUhLE56+KnYF5aKxRFEhAeeVXO6zy/7A
	0ly4T2leOD0czbFnd8+Kbl9d2egQ4U6L8s/qzOiKDfi0RNl6rPG3ouQ8oScStrHEZooD4MG5cpm
	yOMrxqz/G006rXYz0Gaxmu0ywl8Mv3KiTdKJI0xZ+XvbrSVmDr+iKFPGpJHrt7ZhlPNEorEyVS+
	zn4PquspYKW2rOMtUEgSyS+QGcsyga91gbXuDwwOiUAHnxEMYIziRX83FSeEw18F82EW5dUCSzB
	f012Y7l/UhZWmU1F4YVvhxw8JwemisxsGKtbvv8tviS5t5Lge26+EtyJ+6xeO06djD7SY07mA2n
	K3QMidVcAIcj8sHBfN72n5mhRcWzdbat43MuxXAizIlP9hdPXaoUuumXY1eY9PQXgWyAdnPK78K
	6+GBe5wysiqIHKvaRNYiUr3Feo47V2
X-Received: by 2002:ac8:7c53:0:b0:50d:8009:2b3d with SMTP id d75a77b69052e-514a0a43110mr198856011cf.13.1778566287753;
        Mon, 11 May 2026 23:11:27 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm110041831cf.28.2026.05.11.23.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:11:27 -0700 (PDT)
Message-Id: <pull.2110.git.1778566286543.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 06:11:26 +0000
Subject: [PATCH] merge: use repo_in_merge_bases for octopus up-to-date check
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The octopus merge path checks whether each remote head is already
an ancestor of HEAD by computing all merge-bases via
repo_get_merge_bases() and comparing the first result's OID to
the remote head.  This is more expensive than necessary:
repo_get_merge_bases() calls paint_down_to_common() with
min_generation=0, performs the full STALE drain, and may run
remove_redundant(), when all we need is a yes/no reachability
answer.

Replace this with repo_in_merge_bases(), which answers the
is-ancestor question directly.  When generation numbers are
available, repo_in_merge_bases() uses can_all_from_reach() -- a
DFS bounded by generation number that stops as soon as the target
is found or ruled out, without entering paint_down_to_common() at
all.  Without generation numbers, it still benefits from a tighter
min_generation floor.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    merge: use repo_in_merge_bases for octopus up-to-date check
    
    While reviewing callers of repo_get_merge_bases() for a different patch,
    I noticed the octopus up-to-date loop in builtin/merge.c computes full
    merge-bases only to check whether each remote head is an ancestor of
    HEAD.
    
    The existing code calls repo_get_merge_bases(), takes the first result,
    frees the list, and compares the OID to the remote head. This is
    equivalent to an is-ancestor check, which repo_in_merge_bases() answers
    directly.
    
    Using repo_in_merge_bases() simplifies the code (-14/+4 lines) and
    avoids unnecessary work: with generation numbers it uses
    can_all_from_reach() instead of paint_down_to_common(), and without
    generation numbers it still benefits from a tighter min_generation
    floor. In practice this only matters for octopus merges on repos with
    deep history, so the main value here is the simplification.
    
    The comment "Here we have to calculate the individual merge_bases again"
    dates from 2008 (1c7b76be, "Build in merge"). At the time,
    in_merge_bases() was the same cost as computing merge bases. Stolee's
    2018 generation number work (d7c1ec3e) and the later switch to
    can_all_from_reach (6cc01743) made it significantly cheaper, but this
    call site was never updated.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2110%2Fspkrka%2Fmerge-octopus-in-merge-bases-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2110/spkrka/merge-octopus-in-merge-bases-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2110

 builtin/merge.c             | 18 ++++--------------
 t/t6408-merge-up-to-date.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 2cbce56f8d..862107cf41 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1735,21 +1735,11 @@ int cmd_merge(int argc,
 		struct commit_list *j;
 
 		for (j = remoteheads; j; j = j->next) {
-			struct commit_list *common_one = NULL;
-			struct commit *common_item;
-
-			/*
-			 * Here we *have* to calculate the individual
-			 * merge_bases again, otherwise "git merge HEAD^
-			 * HEAD^^" would be missed.
-			 */
-			if (repo_get_merge_bases(the_repository, head_commit,
-						 j->item, &common_one) < 0)
+			int ret = repo_in_merge_bases(the_repository,
+						      j->item, head_commit);
+			if (ret < 0)
 				exit(128);
-
-			common_item = common_one->item;
-			commit_list_free(common_one);
-			if (!oideq(&common_item->object.oid, &j->item->object.oid)) {
+			if (!ret) {
 				up_to_date = 0;
 				break;
 			}
diff --git a/t/t6408-merge-up-to-date.sh b/t/t6408-merge-up-to-date.sh
index 7763c1ba98..be0840efb6 100755
--- a/t/t6408-merge-up-to-date.sh
+++ b/t/t6408-merge-up-to-date.sh
@@ -89,4 +89,14 @@ test_expect_success 'merge fast-forward octopus' '
 	test "$expect" = "$current"
 '
 
+test_expect_success 'merge octopus already up to date' '
+
+	git reset --hard c2 &&
+	test_tick &&
+	git merge c0 c1 &&
+	expect=$(git rev-parse c2) &&
+	current=$(git rev-parse HEAD) &&
+	test "$expect" = "$current"
+'
+
 test_done

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
