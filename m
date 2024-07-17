Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7E1878
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213699; cv=none; b=MoYHLd49w4vwmXK0dvZNseUcPBUmOwJrV9A11e+hH0Q+mpGmA9e0C4Akq5+GcB4xV4MpVuWp3HTv6N17yFfgOFFlFVcxbND/y2ZVuNwffQzIIjFctXkeZ3wYCeLlBIbnFklxmF7NPtgm44vx2LAJT1eTUMrFct/YJkd80cpaGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213699; c=relaxed/simple;
	bh=tVjb3dG1j1I32QNK/whwjg9370I7gz8qttirIiLfKTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dsGDs8slw1tYDCMCXfvxqTgu6+CYPLnaCvI0kivPo8uP+1t28MBRxJxCeJVF8baqKXowvDLmqvoafpKiiH4IpQg1m0Vm08T8qC/C93xhgWMbt0KVZix65OMbQP5O6BJkFo+OqXSW6web86wpNpZGUbo65n24SRqFLkOFwa7rq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY2jnDZf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY2jnDZf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea1a69624so7082608e87.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721213695; x=1721818495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AODXixjIjv6/J2hx6hfcRojSXmh+EiFeJZ85SzjOSdE=;
        b=UY2jnDZf9q+ZPmuXGuWjOm3qcOFc7jB6abH3MAm6hwiLhfVGVFSdZ+9+2pk0afmZ5E
         Oev01hieGmqarlrFp8MIDjEiRZx8TyvtsuvwKiXoS6Mxls9MtOyFi3OzSbZqGX30Mf0C
         q/IWXRCy4ZWSvFNjfYiCmU2yXLic0Wxfm57DahC46n8Z+vSgclIdNsajbHUcMW1sgPTe
         EqNDAZjeoq1KoRnGA7m6zN5zUuMLA+03SOj08Em7897XIRw496KXjntETJzr5GpJ2le2
         MJBdxUlUowrAjcBvwNOstXvT0K297aD0o0Oiv0YSYR9Xyd29RIY0Iu9ueXr7NtpfWRbK
         zDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721213695; x=1721818495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AODXixjIjv6/J2hx6hfcRojSXmh+EiFeJZ85SzjOSdE=;
        b=NbrpMPEMvve3iYyoBDO3E6NItXKmIYkuTd69PSMJC8sAUzRRh1WOz6Vft6xRlzmYH+
         D5EJ7OZY7lE/FZse7+nFGzG2Zn7INCSrqc6tDb9nvigkHZIIwSyICMm9mGANC5RsFyz9
         dMOnsRfwlpkDfzZpE6GosPlMJYUdlX/zEFzD8eYJYiQbMcLhytmhHiR/0w9BXTnyk+vW
         m+Plrg1qjF+glKrtdXUUkGLH7w1TKH2S2lHUKkxySHw1Gyf4X+7PyLa1Kg6k56f46Lzk
         LN1vs/wFHXJT/VbH3S7zHwgRvIl4STFmLfBd40gpzXimCq9o8H4SMtwzWMWdccckl6Yq
         /kBQ==
X-Gm-Message-State: AOJu0YwVWvmfDdM2ZW7i4NVn26XYgaxwDrtQkDDoe7LagtVpG/UAblaa
	sQfq304BDBI2PIqRyqh9fW99MfEilUANKBhVZDGOjdIq7TGk6frb8lnRhg==
X-Google-Smtp-Source: AGHT+IEvbxEpRXCEJkegF88E9mVpNsEk7ODJeSSVou9lsR7KxFXjjPfqjPjG/YFIsZeDaOBJjSq67Q==
X-Received: by 2002:a05:6512:33cb:b0:52c:e556:b7e4 with SMTP id 2adb3069b0e04-52ee53bc52fmr940156e87.15.1721213694898;
        Wed, 17 Jul 2024 03:54:54 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e1d33sm1440162e87.44.2024.07.17.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:54:53 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] Documentation/gitpacking: make sample configs listing blocks
Date: Wed, 17 Jul 2024 12:54:28 +0200
Message-ID: <20240717105432.2801097-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.46.0.rc0.321.g44c27ab58a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This document contains a few sample config snippets. At least with
Asciidoctor, the section headers are rendered *more* indented than the
variables that follow:

       [bitmapPseudoMerge "all"]
    pattern = "refs/"
    ...

To address this, wrap these listings in AsciiDoc listing blocks. Remove
the indentation from the section headings. This is similar to how we
handle such sample config elsewhere, e.g., in config.txt.

While we're here, fix the nearby "wiht" typo.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 These buglets were introduced in faf558b23e (pseudo-merge: implement
 support for selecting pseudo-merge commits, 2024-05-23) as part of 
 tb/pseudo-merge-reachability-bitmap.

 Documentation/gitpacking.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
index 4a6fcba6f7..321154d4e6 100644
--- a/Documentation/gitpacking.txt
+++ b/Documentation/gitpacking.txt
@@ -143,14 +143,16 @@ include::config/bitmap-pseudo-merge.txt[]
 Suppose that you have a repository with a large number of references,
 and you want a bare-bones configuration of pseudo-merge bitmaps that
 will enhance bitmap coverage of the `refs/` namespace. You may start
-wiht a configuration like so:
+with a configuration like so:
 
-    [bitmapPseudoMerge "all"]
+----
+[bitmapPseudoMerge "all"]
 	pattern = "refs/"
 	threshold = now
 	stableThreshold = never
 	sampleRate = 100
 	maxMerges = 64
+----
 
 This will create pseudo-merge bitmaps for all references, regardless of
 their age, and group them into 64 pseudo-merge commits.
@@ -159,8 +161,10 @@ If you wanted to separate tags from branches when generating
 pseudo-merge commits, you would instead define the pattern with a
 capture group, like so:
 
-    [bitmapPseudoMerge "all"]
+----
+[bitmapPseudoMerge "all"]
 	pattern = "refs/(heads/tags)/"
+----
 
 Suppose instead that you are working in a fork-network repository, with
 each fork specified by some numeric ID, and whose refs reside in
@@ -168,12 +172,14 @@ each fork specified by some numeric ID, and whose refs reside in
 fork) in the network. In this instance, you may instead write something
 like:
 
-    [bitmapPseudoMerge "all"]
+----
+[bitmapPseudoMerge "all"]
 	pattern = "refs/virtual/([0-9]+)/(heads|tags)/"
 	threshold = now
 	stableThreshold = never
 	sampleRate = 100
 	maxMerges = 64
+----
 
 Which would generate pseudo-merge group identifiers like "1234-heads",
 and "5678-tags" (for branches in fork "1234", and tags in remote "5678",
-- 
2.46.0.rc0.321.g44c27ab58a

