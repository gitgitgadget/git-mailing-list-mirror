Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7781917E8
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729370396; cv=none; b=rD65PuQgwdpUvR+EPCriUT3KfjzU9K/tOb4Rb4wRaHm/Gfo/1ZMyWl2MpiiXHKQLUwF9Kf5f88pV6gkR6mRmbf2SVtCmEmv4t7UtTxOXPsxi7IY9EqimzK4ZcQ9IEGmbFSDoEolG+CZ89CNJk27n0wJOKNw38rTgFnHSypMKWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729370396; c=relaxed/simple;
	bh=JQGhNPoIxKKIiZ42x8/wDJiM6zqlSdZSXZtdmGPefBc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=a0qDg4ND+gavMvw1+Kb7YMy5CnTiLp9v5Sdl8Aq/mtbwei8JsLQMEgxe6A1IIaSVB07ieRdaX2Dw+yIN0XjgzqfehUmndFevl8gDmcs9dGMmo+/d1PqhDIIeEWvJAAA8pqZnoR7LQ4d4WXEKj7uPO7pfOPyGV1cmpa53LPh+wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmopQ/yC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmopQ/yC"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so3429057a12.0
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729370392; x=1729975192; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PR/1Yi87AGQ7C3M3c4dDhaEHekjcX2fP4S3ZwxYSSH4=;
        b=bmopQ/yCBGkJtdIMqeE7h0uqQICahdRldjUoHtfAmbFNIPSOd8jd0417357YGrfEas
         jttDhk7Qe8UGYRDnvsd58OffZ66Le4DaDFlidj/EyUdOrjHN13zln2IRRLV2pMSRPLlZ
         kWaa20q3YQ9zXOqhTTyT52QUptQS9ezsFD6ZdQ6Ve7vOZexp2QeJBCqhEHqNAZQoQcSe
         vXUqHfWCnt/W2/Hv57i496YyyUq2CUBY5WKwO36GpfsQBCyzzJ9V+AC0Ohv7a9OUASj4
         Dg/HsPeERZWZPZmLRJLjRc5oHH9RtbxBkbvLITr8SBHwy7JNK/aXSiKr045z8srkjWro
         bWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729370392; x=1729975192;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PR/1Yi87AGQ7C3M3c4dDhaEHekjcX2fP4S3ZwxYSSH4=;
        b=ZOzIyllM8IV3HBXG6oAHac49/DzMiA6xcQ8uf5Wp1H3AwgFDxbSXqIj6oSwsheV3vv
         rqSjHsG4aULQFR5KPoRPfDrzKZTHqpki1Wu0aFGz5lwaITHXw5xAJsHmLSjO4lsrMBZp
         ErTFpzwvdBwi4G1IT/J29v7LnKK2chiqAXqZ2FuF/KgF+yul3Z/jaZEcSsciY+HYETru
         sI/i0m/TImCSjbZDiRLI5eaS1CrJ/SlK4ILcSsEUv3HK6qsfB01x7DCrmXxgpEEo9TGW
         wvmbb/jHrzep2vauQONc/AY3Sens6IgDIcjVK3CFjq/gSUgSHJsGtH8MkT/O+wx7zOrI
         Uzzg==
X-Gm-Message-State: AOJu0YzEJyfa3lF5ugsUBbbrcL7Ge/ODjx32l2kbcF8wPPb9/LXo+9Oc
	M23+lCP3gWOyHd/so3v5YmDrfjKvKIGpeNfiz+omLMIz62XT+VVP0E87HA==
X-Google-Smtp-Source: AGHT+IEzEv6BLN1H5AZzXIufX2AZRTdXzLGRUBiBRQpXbOSF5nQuwIYS62KVJmvaQZcLcONkJUrEHg==
X-Received: by 2002:a05:6402:278e:b0:5c9:7cd8:7aef with SMTP id 4fb4d7f45d1cf-5ca0ac85080mr4495777a12.9.1729370391491;
        Sat, 19 Oct 2024 13:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a657bcsm138702a12.23.2024.10.19.13.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 13:39:51 -0700 (PDT)
Message-Id: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
From: "Y5 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Oct 2024 20:39:50 +0000
Subject: [PATCH] diff: setup pager only before diff contents truly ready
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
Cc: Jeff King <peff@peff.net>,
    Y5 <y5c4l3@proton.me>,
    y5c4l3 <y5c4l3@proton.me>

From: y5c4l3 <y5c4l3@proton.me>

git-diff setups pager at an early stage in cmd_diff; running diff with
invalid options like git diff --invalid will unexpectedly starts a
pager, which causes behavior inconsistency.

The pager setup routine should be moved right before the real diff
contents, in case there is any argv error.

Signed-off-by: y5c4l3 <y5c4l3@proton.me>
---
    diff: setup pager only before diff contents truly ready

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1817%2Fy5c4l3%2Fdiff-invalid-argv-remove-pager-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1817/y5c4l3/diff-invalid-argv-remove-pager-v1
Pull-Request: https://github.com/git/git/pull/1817

 builtin/diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index dca52d4221e..03340173700 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -105,6 +105,7 @@ static void builtin_diff_b_f(struct rev_info *revs,
 		     1, 0,
 		     blob[0]->path ? blob[0]->path : path,
 		     path);
+	setup_diff_pager(&revs->diffopt);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 }
@@ -129,6 +130,7 @@ static void builtin_diff_blobs(struct rev_info *revs,
 		     &blob[0]->item->oid, &blob[1]->item->oid,
 		     1, 1,
 		     blob_path(blob[0]), blob_path(blob[1]));
+	setup_diff_pager(&revs->diffopt);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 }
@@ -164,6 +166,7 @@ static void builtin_diff_index(struct rev_info *revs,
 	} else if (repo_read_index(the_repository) < 0) {
 		die_errno("repo_read_cache");
 	}
+	setup_diff_pager(&revs->diffopt);
 	run_diff_index(revs, option);
 }
 
@@ -201,6 +204,7 @@ static void builtin_diff_tree(struct rev_info *revs,
 		oid[swap] = &ent0->item->oid;
 		oid[1 - swap] = &ent1->item->oid;
 	}
+	setup_diff_pager(&revs->diffopt);
 	diff_tree_oid(oid[0], oid[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 }
@@ -227,6 +231,7 @@ static void builtin_diff_combined(struct rev_info *revs,
 		if (i != first_non_parent)
 			oid_array_append(&parents, &ent[i].item->oid);
 	}
+	setup_diff_pager(&revs->diffopt);
 	diff_tree_combined(&ent[first_non_parent].item->oid, &parents, revs);
 	oid_array_clear(&parents);
 }
@@ -283,6 +288,7 @@ static void builtin_diff_files(struct rev_info *revs, int argc, const char **arg
 				    0) < 0) {
 		die_errno("repo_read_index_preload");
 	}
+	setup_diff_pager(&revs->diffopt);
 	run_diff_files(revs, options);
 }
 
@@ -523,8 +529,6 @@ int cmd_diff(int argc,
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.rotate_to_strict = 1;
 
-	setup_diff_pager(&rev.diffopt);
-
 	/*
 	 * Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.

base-commit: 15030f9556f545b167b1879b877a5d780252dc16
-- 
gitgitgadget
