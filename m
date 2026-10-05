Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D84AD4C8
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231619; cv=none; b=LurtZCb1u2W6nqgQfk32X8EjAlBZcptr6/dguc/MYDScVk1ESKGb/azjhT/pZLima7MZTSdzGmlEpFR6non0b7exOXA9J1dqE+8cL/7p9doaBL0wSaGE5nzl5Mcby1jhxD8jM/ASIkp5s8JLxlmaxODhB95RkCp343x8ZqB7koA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231619; c=relaxed/simple;
	bh=xIam5YYthpaql0wpX8dEw61l6K5Bw17t4xctKFI/fAk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OAMLSDQDiVpuejCk3pwArpP3EmOEpfQFuUSpNyKPvVxQgQiiTMuXHFVr494doN37hMLFo4b4v5wSQwAc1lyvJEGo23zOVIEpVYkqNatdKwSYv1jcYVW7LByai+w9kWtI1wTckffjAHNtdKMpI3VPY9yYb8PYrdEBQ9RP0cOWOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghUG6DJN; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghUG6DJN"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d07so420868c88.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231617; x=1791836417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gra3gPehtwgUDKxIrPdKC+qgfC93Bf3lbkoIoIXTjbg=;
        b=ghUG6DJNP3BqjMsnTM4gTaawwcV040WxCpj+cr1yzru9XA+iiuoUfez0S+ItKktT/t
         O7eYu5vPnaM50UomXfgwnbcF6WmU/SYO04SxkzVJoegENupMgkgtbX77FlMMsX82XGKl
         ajN4ZY1acg2Vsf8b+mycqw12JHTkeaH8diDykXIkhyOxoKOpz4B3HXPogFJhkzcP5vee
         8KYVv0CDQS38+3feFoKmXY55t+I0BTzouvajeR0Xrlo9hMzAcIIrsrUXJcTKA6atMN5e
         ok3v9d41+l/AJ1m10V0t1ovAO0w9B/dzE0pdIWZzAJiDRJyzZHcKzvEgXLCsdJ5SXKqx
         zBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231617; x=1791836417;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gra3gPehtwgUDKxIrPdKC+qgfC93Bf3lbkoIoIXTjbg=;
        b=qjZ344Bva07q+0FH+ob6yCbdxP9zIM3dhZkiXdxrqjOmT0st30s/HMXQposjiaWU2l
         31Bb+hlEq+daCRjVcdV2SfMxT/p8EwnOAK9BOVhWfnhGRfhFLZ+vJFdWvWQEHN2sy9wR
         rzSMm+608Ru6z9J2o8OUSheD9XoOoZpwRZAExB2NHCkzkJrgUJ8iSIzod79YUiDQ+9jG
         gPQYgfkZY7n9rOwDiqTtoCu1uMWF5Nx/7u3q6iPXah43v8j/3yiFF/aqj5GL/aPqfyyA
         3q0hvdOotV8obc3zMPCpCtHK5fw0S4KTUNFQH3Vu9EHlPluehQLAtm1NesTDTSatCM2+
         qXBQ==
X-Gm-Message-State: AFuF++mXa8gIEa0NaB0UA09XqdRYCOyD6DXOnkH82S/CqtGtFlPN4AhB
	Uly6dX1ZJgT/e2S+WVD766KR8BRRxwZuWQXlIsOAzrEgVLAgA3MnBBwAom6VvQ==
X-Gm-Gg: AYBFou07ZsqzoEgQ4pqjA5hC2SmkL5+NFtTxoV1m2Tz0S6ip6JjuWfole0yqvfN881p
	DJZK9z4l6V+X2z/xBmgtXyIFlTLvGAQyKvK44fEyp+P6Rx2CMew83ozzDuZh9YZgE9WfKVTYVZs
	hTEj3V6bIN0cKhwHpeMjMIUEp5QuzasmQUaHVgIs38yKNia/UPR36QjwK4on/hl+yIchm4/TSOR
	Mb8bpYD67jsA1WILXI3RF6VxUVPr1uu/HxAdc+1kw2JOGyxBoT2sP+HKqgVUK/EN612TUVNId47
	ZfAkHcrPSaJyUISTrnjswtw7pCfN15E8eIblBmW/XYZRzNcOwAu7rF3UYdEQfywLwGM9EWwX4TQ
	c4Aetri+hVn/YTz/cZiMkrKNu3yiEFZISauPj7GQS1x3AB6v298mzkULy0XO6ZxrmasGNir6vSG
	4lE0B0492DlpheY0+Z1qItrSVeEO0hh/sPv8x0YI3R5bpXCgR1GnMFlML4kxFzrQL23BW5YtI=
X-Received: by 2002:a05:701b:2707:b0:15b:afce:62c2 with SMTP id a92af1059eb24-15bafce674bmr2290525c88.41.1791231616431;
        Mon, 05 Oct 2026 13:20:16 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.2.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d83d6af11sm664151c88.10.2026.10.05.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:20:15 -0700 (PDT)
Message-Id: <68867aa3fcc7f901b615f1b882612de56a0d86fc.1791231610.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Oct 2026 20:20:10 +0000
Subject: [PATCH v2 2/2] doc: remove references to gittutorial-2
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
