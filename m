Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCF2D480F
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531684; cv=none; b=Mrw7dhCDVwQgBuiB1PVE1PbO2Ojm7O77DYxHE2MwhElyAbIgyceM2LO3law26oGsUP6/kKPPqZKihshKokDWzEkl7tC8gkbm4b7HAkS2Be5ozx/NgM49j7VWOCf6Rvyqb7qqyR5qxcBfnpaSKbdb2IWcKkCT8FtMAJPxuTsCHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531684; c=relaxed/simple;
	bh=qC9Y7ABq/M75GI0FmMohTXXUpRz+/nY/k9KI3sbsWVk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pcK3CcZDOPDLynnjJOt74TF6xUC6DbDWYUfY8EwBTbXbaucxzMMaPbzp7mOe1Y5vDRDY68YuvaifHaRcBHXZ2mvADtYarLc3ueTxBTs2HUCTHs+dtMfcbYoAJ4ggd+qU+LDiT1FYylSicwzxp6LiobBFGmjyAc07NGOgqIl20GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZTZWEdb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZTZWEdb"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32d3e17d925so4439349a91.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531681; x=1758136481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6tFnhDLB0benNtw754Bk783fMG4tjg2RUJPPMVT2Yw=;
        b=JZTZWEdbwtFvDpHCXzrPETTUjKd1G28ekjuIHJnrUjd51fuSO7GLUIquRUrFKi6VWb
         06gT9qTfil85LFvH+Z9/bKzK6sdmQGv+Kmw51GrFJLPq/ulHsk8bTC8toEWXkBc8FDgf
         rOskRair4z9b782SSDU3LfXn1CG3XmT+h+nZs+WfxMLdpQfw2cVC/+HzPQKhNJQLbsqk
         7LAsbgQHCBrA4x9+YVtI1xd6cBu3Q35emC3S6dxv0mPjyVT3YU3cTd9hgLIGsbreD7fg
         mGIOrvamgvVWyfVpWf6YXuA2KH2Nx0fmksd/IW56sOrHNncZfooIs9ISBzfYY3ybV+Y0
         +sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531681; x=1758136481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6tFnhDLB0benNtw754Bk783fMG4tjg2RUJPPMVT2Yw=;
        b=HjVfg4h3kV9OSmOOjTgKad6BYsvW3LBxE4/9m8nQ4bSJoXRkcSbYDzQDcJKNK4fgzP
         TVg1gBb5n3MPxMrn7RGoBA1RwXv2HJ7jGz71esnpbIP+Si12Kn9dIvu4paEVSFoczLOb
         QRUKFDk0x4X0bWL/a41oqcWNRs11BGON1W8IGugULJ9qocaSWo1pqOYwZPdFkpYxE8oW
         wnNPwgxB0fvZgRMcyzwW0+c+awQp3lZxpcRDDOG0KzGLpupbligY0i65lRjEPqktDRz0
         T7coUB/lYldeHDituP99pvTyav8c0QrmFWmKNqa22lisjBIiIn5BRoP4yPRWRaiaRPZS
         ZsrQ==
X-Gm-Message-State: AOJu0YzIVhnX85NMGN3juUF7ZuzfHpPaX4HivI0+JuApC9UNIMJnLJ1k
	6/RwEmfM1KEpWgEuN6a7CxzSoSSzg4WEIFmgd6L1OkQvWhYBmSP/sSFix5asbQ==
X-Gm-Gg: ASbGncswQhGRcjYpzH5JdSBVtLkc3TOrT9/XwL1/O70G+mbuZy7TRNKH/zzDodw50X9
	eTo+jnr2eu0ceub5QmPrnxMeiYyuACqQgyTTQNi8kp1L4WwcTwRWbdrMJdcMcYDFg7X8gPCSSJt
	HcuNe8JYU3uW8ji52NZHn+KuixtNUqqwu5OT39/91UgTLWbLsUOAsdLsXgRNPcnQw4dq8zDffMj
	BaN/guPrW9hvnb9oTAd49iRjgfXXJD9rZ1wDGavnNOoMerrU/2rrftEAta5QWnOj4olCAng+h8c
	paAiPxZUrpomQfhYbA8D60KgUrYWMT9Dz8LLFQ50BDCOEe5qJLPY6vklsXBJi6WirYZMGuntc6m
	SRIX16xdXZ06d8oA6yFYZ7F7lml+8jIqjZnLKHA==
X-Google-Smtp-Source: AGHT+IF4mpQnWYwnqmEq9n8zHIhZtusM6JMCsu/6Yfu5XAFAWRuUv6Ia/UL/j0ENSKtl1Dw/xPIMWw==
X-Received: by 2002:a17:90b:1d8f:b0:32b:bc2c:fa1e with SMTP id 98e67ed59e1d1-32d43fb48f7mr19860314a91.36.1757531681402;
        Wed, 10 Sep 2025 12:14:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32da8823c8esm2894683a91.0.2025.09.10.12.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:40 -0700 (PDT)
Message-Id: <db603b1e5f833556430150f31fde0a24214c680f.1757531669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:29 +0000
Subject: [PATCH v4 7/7] doc: git-checkout: clarify restoring files section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback on this section: 3 users don't know what "tree-ish"
means and 3 users don't know what "pathspec" means. One user also says
that the section is very confusing and that they don't understand what
the "index" is.

From conversations on Mastodon, several users said that their impression
is that "the index" means the same thing as "HEAD". It would be good to
give those users (and other users who do not know what "index" means) a
hint as to its meaning.

Make this section more accessible to users who don't know what the terms
"pathspec", "tree-ish", and "index" mean by using more familiar language,
adding examples, and using simpler sentence structures.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 1e19e13a0e..d8e8bcf549 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -75,22 +75,29 @@ Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 `git checkout <tree-ish> [--] <pathspec>...`::
 `git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite both the index and the working tree with the
-	contents at the _<tree-ish>_ for the files that match the pathspec.
+	Replace the specified files and/or directories with the version from
+	the given commit or tree and add them to the index
+	(also known as "staging area").
++
+For example, `git checkout main file.txt` will replace `file.txt`
+with the version from `main`.
 
 `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...`::
 `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite working tree with the contents in the index for the files
-	that match the pathspec.
+	Replace the specified files and/or directories with the version from
+	the index.
++
+For example, if you check out a commit, edit `file.txt`, and then
+decide those changes were a mistake, `git checkout file.txt` will
+discard any unstaged changes to `file.txt`.
 +
-The index may contain unmerged entries because of a previous failed merge.
-By default, if you try to check out such an entry from the index, the
-checkout operation will fail and nothing will be checked out.
-Using `-f` will ignore these unmerged entries.  The contents from a
-specific side of the merge can be checked out of the index by
-using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
-file can be discarded to re-create the original conflicted merge result.
+This will fail if the file has a merge conflict and you haven't yet run
+`git add file.txt` (or something equivalent) to mark it as resolved.
+You can use `-f` to ignore the unmerged files instead of failing, use
+`--ours` or `--theirs` to replace them with the version from a specific
+side of the merge, or use `-m` to replace them with the original
+conflicted merge result.
 
 `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
 	This is similar to the previous two modes, but lets you use the
-- 
gitgitgadget
