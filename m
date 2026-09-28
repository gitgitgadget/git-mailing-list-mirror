Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC44D1781
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627128; cv=none; b=HlVzXNWFPnBjMycJcr5ucmEP8ecdYrBFA3mFs81khBCJE0Pd2mOGMwX1JdQUb/p1eIzElg3irXG8UR74VZ2zHhP9XrfxbP013d0PrvhTFvQGQ1cJGUTvqUSMP8joJaUDlSUWjSt69zv/4SyDTC+UAjeqeTorJQl7aENfgDkQgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627128; c=relaxed/simple;
	bh=xIam5YYthpaql0wpX8dEw61l6K5Bw17t4xctKFI/fAk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U9Pq1nQrYl6a2f03Ongz7O5wsFdLi1533uaJ0YUEMXAv9rNBz7YXn6e89Fefntv1W/J4KBsF4lYh78aL+Rsr51um5tXBiDg7gGx0p71Kbi2WGNhZ+TazRjsWqMywioIktPWXjZaHp7qIb62qa7GobSlAAVbEd0i8a00O7W23ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTe+JbVI; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTe+JbVI"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-939922847efso313018485a.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790627126; x=1791231926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gra3gPehtwgUDKxIrPdKC+qgfC93Bf3lbkoIoIXTjbg=;
        b=lTe+JbVIdWPcrWvc7PHzjaXyKjjEYOz/2IGgULo95KhzFv8hCnKk/YZzV7YZ3rfn8O
         ArcJtBYliAcLObBF10R9wdCXOYHjp9094BmcgGyyOlokTgT1EYSjxGHe/yE2i4grO1Ei
         RYq8fH7MPyhXZAFcJf3c4WBND4T+1gVOULm5oEqetVFWPabc7gWNuYL33LHMlc/HljnC
         mhX9guUwcDnCxs0/nXTn1nqDE3e62MeV+rf4X7oBPVvNuCvtciqK2f6hcp68TsiVWV2u
         ZkWmDAJssETby8AAQyAbEIf2mfly7BKM6YykfeSvbDHje93c5/RGz0fJxiOPvoCU/99A
         fNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627126; x=1791231926;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gra3gPehtwgUDKxIrPdKC+qgfC93Bf3lbkoIoIXTjbg=;
        b=oTa0pT95uLQANhAkfmrYgC8fDR2w1+zZaWeXsxW4N57x2sN8HptliU/Ury6G4gJEN3
         31NHCCW6NqLSf/eWsF2M+9pVY4EGqK6NJu4rm+S+xZ8PPJniSKpt3/sEcnqx4uzB+TIF
         JNdaBv9q7XX0RU/VkGSj0hRNPewN2brUedK3n11Mtj+18Bp5h03JRMwepauD0F1kNGGW
         OTisYVn2sAMCnVjECA+xH571wND7Bfluv7p4HYKuxeKCrn+0P605y6Bp4n4ND/PI5fGG
         zS824RCbd6kCHZ/tLm/NHJ7WbzwL7zGbK3214G6BLEaUpcT1sGx16p3gFu3gdzSIiNO/
         V7dQ==
X-Gm-Message-State: AFuF++lnPMyxfCTNj0rRCDb2oJWMnsTfb99ApdlDTkyHqA9u3qKWsVvd
	l/rioR1Wu6AJstcB0i77Y5PDNHdXt2+O7QnP4pmhd6Gg8zeOjZNdb1hzM0jhFw==
X-Gm-Gg: AYBFou0uCsgXEMA1+k/564E6KvC8u6FXyqqDGnTXnStKZVOfXMM+o/BbVU3i2CU+4wx
	+zc+pKDHs9BXT+mClc295nO8BRMfqbnCAuJHwkIf1qVTZRISdtD9KP7oTlZiQKrRukoWKhL8ym3
	a3Z6LZU6C+FzO3cLU0wY0UsKvTd5avGEa7n3MdXaPb0BXEdZ1Da0mSRIlqFWCJxvex6DbUnPcm/
	CantKgCJdbngOuHc+gGfNfF6xxq1smDRcfl41Aohcjb42JS4RP9L8+8AktO+iukdqbO3Ua3ohsA
	qNDl/R/u8R+VOWTqm5RWKHoENznvFwjKXT5aNU8Xxy/gdUr2Ue3qqr6wqNm9KTE+C+2XEpatjPG
	jgR2ojPGxWjo8JnhR1O/6PT05JgTRdkCjviIiuM9YLuDuJIGdQnqef7ezf3Bk4Cl6mEK7R66BNI
	Xki0axyzK/PWAbcC1vemuhgFubNJa9STvNKz6t/lP1f2vqAhk2ZE8FdpXO+JRtJ+zN1N3LLuT3
X-Received: by 2002:a05:620a:1a09:b0:93b:fb3c:2d09 with SMTP id af79cd13be357-93c43d7a705mr2174701685a.66.1790627125763;
        Mon, 28 Sep 2026 13:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.79.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c814353dbsm231707785a.30.2026.09.28.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:25:25 -0700 (PDT)
Message-Id: <a76819e3aff80b587156ba805fc6e93bb54cc41b.1790627122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 20:25:21 +0000
Subject: [PATCH 2/3] [doc] Remove references to gittutorial-2
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Redirect folks to `gitdatamodel` instead, since every time it's
referenced the intent is to explain objects, references, blobs, etc.

The update to `gittutorial` isn't very carefully thought through since
we're planning to delete that entire document anyway. It's just there to
maintain some internal consistency.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/MyFirstObjectWalk.adoc |  2 +-
 Documentation/git.adoc               |  2 +-
 Documentation/gitcore-tutorial.adoc  |  1 -
 Documentation/gitcvs-migration.adoc  |  2 +-
 Documentation/gitglossary.adoc       |  1 -
 Documentation/gittutorial.adoc       | 23 +++++------------------
 6 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index 413a9fdb05..76e635b93a 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -145,7 +145,7 @@ used to track the allocated size of the list.
 Per entry, we find:
 
 `item` is the object provided upon which to base the object walk. Items in Git
-can be blobs, trees, commits, or tags. (See `Documentation/gittutorial-2.adoc`.)
+can be blobs, trees, commits, or tags. (See `Documentation/gitdatamodel.adoc`.)
 
 `name` is the object ID (OID) of the object - a hex string you may be familiar
 with from using Git to organize your source in the past. Check the tutorial
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 6f0075f918..1f0cbaee7a 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -1200,7 +1200,7 @@ the Git Security mailing list <git-security@googlegroups.com>.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
+linkgit:gittutorial[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitdatamodel[7],
 linkgit:gitcore-tutorial[7], linkgit:gitcli[7],
diff --git a/Documentation/gitcore-tutorial.adoc b/Documentation/gitcore-tutorial.adoc
index 2122aeb976..abbe193056 100644
--- a/Documentation/gitcore-tutorial.adoc
+++ b/Documentation/gitcore-tutorial.adoc
@@ -1649,7 +1649,6 @@ to follow, not easier.
 SEE ALSO
 --------
 linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:git-help[1],
 linkgit:giteveryday[7],
diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitcvs-migration.adoc
index 905d08cd5f..66a5c3ed6d 100644
--- a/Documentation/gitcvs-migration.adoc
+++ b/Documentation/gitcvs-migration.adoc
@@ -194,7 +194,7 @@ repositories without the need for a central maintainer.
 SEE ALSO
 --------
 linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
+linkgit:gitdatamodel[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:giteveryday[7],
diff --git a/Documentation/gitglossary.adoc b/Documentation/gitglossary.adoc
index b046d9cb29..6051f494d3 100644
--- a/Documentation/gitglossary.adoc
+++ b/Documentation/gitglossary.adoc
@@ -18,7 +18,6 @@ SEE ALSO
 --------
 linkgit:gitdatamodel[7],
 linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.adoc
index 519b8d8be2..006e534778 100644
--- a/Documentation/gittutorial.adoc
+++ b/Documentation/gittutorial.adoc
@@ -622,24 +622,12 @@ Next Steps
 ----------
 
 This tutorial should be enough to perform basic distributed revision
-control for your projects.  However, to fully understand the depth
-and power of Git you need to understand two simple ideas on which it
-is based:
+control for your projects.  However, to fully understand the Git
+documentation, it's useful to learn how Git stores the history of
+your project in its database. See linkgit:gitdatamodel[7] for an
+explanation.
 
-  * The object database is the rather elegant system used to
-    store the history of your project--files, directories, and
-    commits.
-
-  * The index file is a cache of the state of a directory tree,
-    used to create commits, check out working directories, and
-    hold the various trees involved in a merge.
-
-Part two of this tutorial explains the object
-database, the index file, and a few other odds and ends that you'll
-need to make the most of Git. You can find it at linkgit:gittutorial-2[7].
-
-If you don't want to continue with that right away, a few other
-digressions that may be interesting at this point are:
+A few other commands that may be interesting:
 
   * linkgit:git-format-patch[1], linkgit:git-am[1]: These convert
     series of git commits into emailed patches, and vice versa,
@@ -662,7 +650,6 @@ digressions that may be interesting at this point are:
 
 SEE ALSO
 --------
-linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
-- 
gitgitgadget

