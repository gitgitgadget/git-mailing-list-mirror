Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022747;
	b=bz1R+G/Si0EqHHJeRVhgXqvzBkTigs0LNYshfWizB3wdhpj5og6B9ZWZG1UblRAtHNa4
	 pv2yETYUfAiy8zAGPmxXyXVJa68QTin59PIj8C24GyhQzhNk5ZviQl9uJqOqLYiwjF4vS
	 mnOvJA0/S7dFFib+K8f0q4MnUDFov8LD/0tFuD6/Fycsn7W/IYaK2kC+5OGESxwB/ZcvS
	 gCDSbzb0RfqbF+9jVKp/R6UkpeQgfTYjjDqSVJgqCIVtU91M8c17LlCsQE24+/JuVqyRb
	 AQ7nFflGJ7HkFBnJvTvZbRU8NQuWbv1yWsHth9J1D5o3rvnQE1KM6ylgpBCP3b4Bkyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=VNC2xdkoaj/GTbTPDmoHkxfJSbmF7ycCbjfHQexbEnY=;
	b=WMnx0QeanofOF3zEMZ1M2lQQ9OV5GJ72ewIqX1uIXsrMAMoNypTu4uIF/V6+KeitR4+o
	 vBomSpE+HhsoZh4ng4qIwXOCt++cYi954QGJKVdw9MeEJnYrrprDBkgxiCUaezH4W/ZHH
	 jVS3sgtfrX86UwWb3CcZaLvtNm+AspUa6Fo0s+yzXYJyRZxybsHXwOJsBjZ0K5Dzcd/w1
	 J0Uuyw4IE+FjK/cQtHqsjuayXrGIvRVn7lmaSDdxIRPphG1d/hi/FgtJTr2yHqehJe9JM
	 mbgfNpkNHS4qnNQCTSNINulhehIygzzU/+nPUnUzOvHYPweVQ82rHNiOlgdQ+6B6OJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FS2Hgdie;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E916606A321
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E916606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FS2Hgdie
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1846bc43c28so3036787c88.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022747; x=1793627547; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VNC2xdkoaj/GTbTPDmoHkxfJSbmF7ycCbjfHQexbEnY=;
        b=FS2Hgdie6WCaAu++nnlQ8mMOwRJ4LYsWL4Mj9bicf6D0s1t6NdvheQM7KV7ZAdx92L
         vkgWwBITLg/ixZ18RbZ4Kf8oZJI02+M4JgW8KfWVingP8PloHnSLdumQQys/II9oKaoT
         qh+b4T8MMDuDSYqGSd0rId+GjuPaPQqjQI3ye5E8vCvb5XcXLu0FULv6Dm+dxM7ilI23
         BdHgU1qt+vfwnAN3wSIXTCKY6mCnudJfgl0LF34Iu5gOmJGpAXf5RXsu8rDtIzmCkuMZ
         olvyvGsoK/nm+CU8W/iqDoQMuGN8IuShEjrl49MsKNog1ebM+0yyEYMA3hxK1M91EpZY
         AEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022747; x=1793627547;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VNC2xdkoaj/GTbTPDmoHkxfJSbmF7ycCbjfHQexbEnY=;
        b=fBLJf6In/Dly7Yokk7Su64wzx89KpGRloSiA1077QzCkIRTrhOSmkgw+bEeSKseeoH
         MfqnHRqj7RjfaqALcfoN5rlrF0bnn7l6adgJs/Medg+uHbH/vZygc1B3kPxcsatNIN44
         9u/0btgjxMCHVtvx1dU7eYJFuhBYDzNXvZ0A3eyHPdM+f9d7HyDOFPJ0Z1ZwBm5ttz6Z
         LHBzeS252rD9wvDD2Csk+lzhlGZBBXZ435NDzKkC/Alcapy+ATPEKThgA0Lj08hZB/5C
         MUJJ2pMmAq14ramStd6Vh0t0usoTof1PIQ6WvENSPLJ+ztDRXafw8AemwdW6ZfBpu3Y5
         sK9w==
X-Gm-Message-State: AFq9FYJIM6vEjNgsfm/mVuHyF2Wq/ls1Pds9uKh8CPHdUHBeZ2+73Kuh
	MgROe3OfPF3M8+r9i5JPJv4LY9TfZ1OWCSXC3bd4HC9NZwbK/hvQA55t8V5VVJi+
X-Gm-Gg: AYBFou2gXamNQPd5V650NWmF4Qn3O3pcOdrI1Bvd93HUUt2yI4bCEkBSZGPJzGPNGz3
	mf1wzSI/+5fHFrS4m+yLEGsN29aj9wX7TS+8AqN+KejTGhXqzpCnIx+E1DvJgW3+J5X5asS3wJE
	6EfBq9gVMbzvKok1U6ytBrFpu6MmiE7H1KfCwOm4wlUhWBN5CuExy/gtRPRv33ajSOtVkptZWiU
	mBbklzWz/6kGo+zMKKBm4RfAzzuATIFbm24263+5EMpdtNw5bYR8lNXMuAeihck5PGe2LqV4p78
	kKYYXQFASOXORs3xN3wUSVIrr6plOZ0VSufCt/NS4pVYBjghQKiVhxmMdMvkLd7uP5eMUQCjQKP
	xRh8dCye5fNpWBjideeXqcC1ojQKVynoODaA3SIlkqhWdmfIZXx+oi/FqKaeKn2Dy3pROYAnu3t
	3IZDHvX2CIgmPikgVmCY5sKK/z8/27tbaq4Ha8/bMcXeuY+0193SKBi2yqq0HJXWFbEbQ0SwwEt
	RyTTz1RMas8F9U54YwaZcGR2Upq9rri8BFG0QCIC4auxUAsCVywZ0hZnD1m/Cle4Gec+46ss0Cr
	s26Gcw==
X-Received: by 2002:a05:7023:d02:b0:189:d6bf:7eaa with SMTP id a92af1059eb24-19934e71e01mr11425290c88.16.1793022746126;
        Mon, 26 Oct 2026 06:52:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.158.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm22749674c88.21.2026.10.26.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:52:25 -0700 (PDT)
Message-Id: <0a42345cecec10bd32ae3db1a699452b164a2f25.1793022742.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2241.v3.git.1793022742.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v3.git.1793022742.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 13:52:22 +0000
Subject: [PATCH v3 2/2] doc: remove references to gittutorial-2
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
Cc: Tuomas Ahola <taahol@utu.fi>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
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
 command-list.txt                     |  1 -
 7 files changed, 8 insertions(+), 24 deletions(-)

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
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..5c649c882e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -244,7 +244,6 @@ gitrepository-layout                    userinterfaces
 gitrevisions                            userinterfaces
 gitsubmodules                           guide
 gittutorial                             guide
-gittutorial-2                           guide
 gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
 scalar                                  mainporcelain
-- 
gitgitgadget
