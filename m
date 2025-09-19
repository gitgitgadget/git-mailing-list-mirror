Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012F3064B3
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270431; cv=none; b=C4BBuvKhr09ze0sG8ZWMlX6v7Q2ynwwTTKjXzzc3o4JujiwEakXqNyUlpoparEi0VU3/gX7SRPfl2TOBLuoiJKY0NVkmwg/gvPRFUmp9hE2BzKK2yWAvSQ8sy3wwiIY7iw6VJLKqUN+R2f4F7T/xhTewyLW4X72GkJrQf6weSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270431; c=relaxed/simple;
	bh=hGWZxsKzkmtmH30N8+0hZ/G8mstFgYq7npIutgHHw34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSE/7oFIfq+77A1lirV2GJlx2gp7vD22dFJjMYiLTD+KLmDj3dZrNocRWwsY+bNdih8ho3rrynr70vtL/KxCMbeCO6tu+bNKpKS9K5Wku2QboHgNaBzBmCgfK1UnfuUCtuL701dldQIZKxpvpQ1GNft7/JQ6bHy3PHxzz3+4ljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUfMyeNl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUfMyeNl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2680cf68265so14154155ad.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270429; x=1758875229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdzzTYsiGPhndDTqj3xVX++QuVdtr8GdDaWjj2gX2nU=;
        b=NUfMyeNlpMtayZNMrvvprTvPk6CImk/pa7zmnlsr7W4LJYfW/qc1x75b7hN2tB0N9z
         MZaKMsfmKtRZBSNKjlz/z+7n74ceAHHbfxJBINhd4L+v0rgotRgz9b/m4szXjagrcyVn
         hu9WLWnqXjSfUg4zJ/WNhpcAStpZmqBXSknU+ttihl+iDHglv/KMZpyqQkhGfkhfVsLg
         Szgis2a4GqCK5WHeJheazK4cUo4tBt6YBRePWCbuiZ4095/oAFuvPnV9IoWcJJwkjonc
         0bqnUTApetj9whZNwssbYOcv9PfZe7ySNYSUptiPGXOPpt7N51Qnei8aMqVq33GXiFt8
         RzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270429; x=1758875229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdzzTYsiGPhndDTqj3xVX++QuVdtr8GdDaWjj2gX2nU=;
        b=LL1PuhqLHoNzSZC3J8SWY+IExhQ+8iMpFLVMyTweFhPpdt6ukflqo7FbfN6SXB28nl
         hOYADrpfEmRgiHGlgsg8mnCgFuN8SysFJsbzzxRfxC3sR7c/8ymGaIUp16cowJrvmtnf
         vuUaJ01ebusVc9AMllo1r4L4oywVy3hvNhQpcm3H66xHNEAbhKOuPTcIuIjRWhoZvOxA
         OyoC4A11FLcEwudX4Y5OuPNITXSudTWSrgNWz3f7ir9lXHkMMnwlyV39uLmDSORvPb36
         7PZ7hUI3WhqRGc4X4D5LamiLZxumovxOjypRghwZBZpITUg+ze4o5s05D+aKkIeN3Goi
         8Enw==
X-Gm-Message-State: AOJu0Yy3gX40yOl7+0gTRZfuGR533I14GF4hn98cNLHoeER+wjeG1ztO
	eDfcv39cHYzNAxSBb0QxOj8l4J66jljGMdrnIwdDy0r5A2RENObSwaqzD+Upag==
X-Gm-Gg: ASbGncsU+g+5RYv8pNo6/uOhUkEnG03np6RDIvch0TxwA4awfD4V5hjjFdmPzLjGaXR
	wYbF5f53mCivE/c+bVMsKXxWWfzoqYnwu1ei4gkqwSAilHqClzry7XFsBrIb1NWFArhUVfvXcZb
	HtlqN9MQEICC7Q2vnHot8cgOcCe6nShA6vspDnA4m+bcD+rHh6H+p2EzCd3YKdd+ZPRSjemYW9u
	4MYoEsA0PXWLc3SB08HROK/QZZjmWdwe4cmuArZ+FF34UQKRUvcTgKSa1xc7uzzRL27+kY5vbgZ
	tmt9Ipk3/HppQctjayCKU1aQDb0/mx2968/bMU/NHJCyNIXhvXV5Ve7AMgKCsblRi5HfDwz1KK5
	cObhCTiMTdpjoecJdOV0=
X-Google-Smtp-Source: AGHT+IF/yd0m6gNhvNBF6Pk2Whicx/sJG3m8V4BU9+eakPYeAC1B5XY+EVsOhd8Z/VXlqPy3Z0CqMw==
X-Received: by 2002:a17:903:3847:b0:24c:ea1c:1176 with SMTP id d9443c01a7336-269ba507c2emr36108235ad.38.1758270428772;
        Fri, 19 Sep 2025 01:27:08 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:27:08 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 6/9] doc: pack-refs: factor out common options
Date: Fri, 19 Sep 2025 13:56:44 +0530
Message-Id: <20250919082647.535213-7-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding documentation for `git refs optimize`, factor
out the common options from the `git-pack-refs` man page into a
shareable file `pack-refs-options.adoc` and update `git-pack-refs.adoc`
to use an `include::` macro.

This change is a pure refactoring and results in no change to the final
rendered documentation for `pack-refs`.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-pack-refs.adoc     | 53 +---------------------------
 Documentation/pack-refs-options.adoc | 52 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index 42b90051e6..fde9f2f294 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -45,58 +45,7 @@ unpacked.
 OPTIONS
 -------
 
---all::
-
-The command by default packs all tags and refs that are already
-packed, and leaves other refs
-alone.  This is because branches are expected to be actively
-developed and packing their tips does not help performance.
-This option causes all refs to be packed as well, with the exception
-of hidden refs, broken refs, and symbolic refs. Useful for a repository
-with many branches of historical interests.
-
---no-prune::
-
-The command usually removes loose refs under `$GIT_DIR/refs`
-hierarchy after packing them.  This option tells it not to.
-
---auto::
-
-Pack refs as needed depending on the current state of the ref database. The
-behavior depends on the ref format used by the repository and may change in the
-future.
-+
-	- "files": Loose references are packed into the `packed-refs` file
-	  based on the ratio of loose references to the size of the
-	  `packed-refs` file. The bigger the `packed-refs` file, the more loose
-	  references need to exist before we repack.
-+
-	- "reftable": Tables are compacted such that they form a geometric
-	  sequence. For two tables N and N+1, where N+1 is newer, this
-	  maintains the property that N is at least twice as big as N+1. Only
-	  tables that violate this property are compacted.
-
---include <pattern>::
-
-Pack refs based on a `glob(7)` pattern. Repetitions of this option
-accumulate inclusion patterns. If a ref is both included in `--include` and
-`--exclude`, `--exclude` takes precedence. Using `--include` will preclude all
-tags from being included by default. Symbolic refs and broken refs will never
-be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
-and reset the list of patterns.
-
---exclude <pattern>::
-
-Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
-accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
-patterns. If a ref is already packed, including it with `--exclude` will not
-unpack it.
-+
-When used with `--all`, pack only loose refs which do not match any of
-the provided `--exclude` patterns.
-+
-When used with `--include`, refs provided to `--include`, minus refs that are
-provided to `--exclude` will be packed.
+include::pack-refs-options.adoc[]
 
 
 BUGS
diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
new file mode 100644
index 0000000000..0b11282941
--- /dev/null
+++ b/Documentation/pack-refs-options.adoc
@@ -0,0 +1,52 @@
+--all::
+
+The command by default packs all tags and refs that are already
+packed, and leaves other refs
+alone.  This is because branches are expected to be actively
+developed and packing their tips does not help performance.
+This option causes all refs to be packed as well, with the exception
+of hidden refs, broken refs, and symbolic refs. Useful for a repository
+with many branches of historical interests.
+
+--no-prune::
+
+The command usually removes loose refs under `$GIT_DIR/refs`
+hierarchy after packing them.  This option tells it not to.
+
+--auto::
+
+Pack refs as needed depending on the current state of the ref database. The
+behavior depends on the ref format used by the repository and may change in the
+future.
++
+	- "files": Loose references are packed into the `packed-refs` file
+	  based on the ratio of loose references to the size of the
+	  `packed-refs` file. The bigger the `packed-refs` file, the more loose
+	  references need to exist before we repack.
++
+	- "reftable": Tables are compacted such that they form a geometric
+	  sequence. For two tables N and N+1, where N+1 is newer, this
+	  maintains the property that N is at least twice as big as N+1. Only
+	  tables that violate this property are compacted.
+
+--include <pattern>::
+
+Pack refs based on a `glob(7)` pattern. Repetitions of this option
+accumulate inclusion patterns. If a ref is both included in `--include` and
+`--exclude`, `--exclude` takes precedence. Using `--include` will preclude all
+tags from being included by default. Symbolic refs and broken refs will never
+be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
+and reset the list of patterns.
+
+--exclude <pattern>::
+
+Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
+accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
+patterns. If a ref is already packed, including it with `--exclude` will not
+unpack it.
++
+When used with `--all`, pack only loose refs which do not match any of
+the provided `--exclude` patterns.
++
+When used with `--include`, refs provided to `--include`, minus refs that are
+provided to `--exclude` will be packed.
-- 
2.34.1

