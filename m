Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5A27D77A
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757145129; cv=none; b=Mm5qGxsdeifLenu/2/8QcdxxCqwnfd3yJq5JxlzCwSK8zrVTC/FTdtFwq6fgleI7tOGQHZottCE8HVO188V636g3h6INzYM5IBpkuNdH852lCbsMt4JS0WAC00zxyPZOHQSxbSvgIEDEgAm0tdfG+I5EpWfY5N4Mc9YacUHMSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757145129; c=relaxed/simple;
	bh=BSlTzCdjFQBhk/JRccpJmtE8BFjz9TXaEtaXtVAvRZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gES+fQs+voTC9r2OmjFw6FkVvFaCwik8q0xht+oUcIoIq1OLiLiZyoh+Oq36/61y472UPcOnjSKlRW2fuEiiWJzr2aGzrSmdkw1zQaWNzwbh6VfKUHiDLxtSRG2nbqsP0soc6TUthe5R5d+oHw6C6vT1VijINhpBRXCYArk4IKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQpJ0EgU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQpJ0EgU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cd340377dso15425675ad.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757145126; x=1757749926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebsfKpd+g93INpNC4EHIQQlmci2lxcvxCuLOdlUPB+o=;
        b=fQpJ0EgUO7XJGO7oojjlOeVSQUDKa7CG+WsxMRPiLSlGovKEw9VGMKDLWsbJZsM9mE
         g77CDd0Pm8xo75HfhOkNOofXwDWCuojEyZ7N4v4fSFOVVgfCfv/4zdEgSkKtp74NRn40
         +450mnmg00U6ICrO4p6a9ysqqY37arApAjt924F03ToylsOoPc73CYq0bguOJO+ZYSqt
         af0MfrQ8Uy0z5MeU2ECuISId842hpILms0faT4/F7XBnEuPndhZ4JrntLfXBRecX9dSX
         Ec5NyPqFOXFjRol7zBOItOTS5I604eif7xgavV0uJuzYWZ+H5fuJFCXkNqHIW+sJQPgp
         0aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757145126; x=1757749926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebsfKpd+g93INpNC4EHIQQlmci2lxcvxCuLOdlUPB+o=;
        b=daFJV/kHcD8f8ZY5GQpLedoQuD0KF9PJYzx9on87RUYgSYrMdrjPrjgE2S74FjJboU
         XQlpevSZyOTmwVsPCvF88+PWlMKlkiHbIg9wqexyx/fWwLwGRbyYby4FPBpk7Ul+o3WL
         zhOORKeKJLDOocKmaIO6BCYUUFqk6NjC3g2R4/pyfn6+vjIBvBcw1DzxW78Phd9ZPfdj
         RzdcmWjbCPMG8m3NhavhSzJipxBNNtOQVUqacvbrRKAf6vVYzvEkRqP03yhIM5ygf93o
         iZwYVChVBV1BTPdhqDXvTaBapGxvsC+2GhMcx/OnbTPhcenxoZFIivbDI6EXe+x0vbXH
         yc3Q==
X-Gm-Message-State: AOJu0YwptWaenehoKaGqSdCE+P00C0Etctr8zYQ8FSyUOilbBaPFDW56
	TJjuB4RwLYL/9NOWoWPrG8NTFPDoqVNWAJ9RsiqfJ14484evbRXJ7JRr/G879Q==
X-Gm-Gg: ASbGncuJps6t3NXd2m0Eo3Qki/bTzeqNEiFpHEFvykpqAWcvd7WmIiyFgHRgRo3oUWc
	IpZcWTUZoRs1OUhZukUecUgNAwqYXoqIo0xHC0JDD5GcPcZ/5MU0/iriQGQHBWGr7R3K4pCfVNO
	Vw9cKioAlLLS8sUS6Ck/AxlbfAkhOXAsAc3lKF7D76+6h9MUajv2U9uM67D8Ddss9GjffBTy8GK
	WeO1MkBer4mSAyLz7x7eCwRITwGBvb6TkIKKaLzkbxG40cdSDF8R1qeMMFT/ko0VQRsSK2TBOjp
	75d8QZr+ltwddXPGJJt6zwuDfYk7K7lA6WA8XJPw1bSdYJFgBXp7uMpXo7BAYoJqrygqqYLa0lW
	5WAx2gxn4I43mRwL2W0c=
X-Google-Smtp-Source: AGHT+IEAvi+F9SP3MrZXdewWSbkt82UPtRL1jp73c0tBqZPrK1wn3tnNqlmbWc1o6c6swNa25nWbjw==
X-Received: by 2002:a17:903:2ac5:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-2516c895cc2mr17913965ad.2.1757145126219;
        Sat, 06 Sep 2025 00:52:06 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bd182256bsm3540929a91.23.2025.09.06.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 00:52:05 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 2/5] doc: factor out common option
Date: Sat,  6 Sep 2025 13:21:44 +0530
Message-Id: <20250906075147.1076656-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906075147.1076656-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
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

This change is a pure refactoring and results in no change to the
final rendered documentation for `pack-refs`.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-pack-refs.adoc     | 54 +---------------------------
 Documentation/pack-refs-options.adoc | 52 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index 42b90051e6..dac63e5e12 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -45,59 +45,7 @@ unpacked.
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
-
+include::pack-refs-options.adoc[]
 
 BUGS
 ----
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

