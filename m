Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753801EE7D5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856488; cv=none; b=EvJMX7DpkB2CLPURzwUEnLwGq9q6y2Rfyia/b53BiH1NIYSLSXLWfDeQuF51Vpc/8bZlDByss2GXx898m0Tz9ZX9y8KdYcU8BxgDDGIj8cA8+8TKTi/+7I92VAFu1qZImecZNOemjpB/Bp2PbrNhirVGtkQZYwZR4Tzbm4+xqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856488; c=relaxed/simple;
	bh=LpkrZE9ZYUZw67HF9kFoQq6MaAkZa6q8pYU5d/t1+hY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hPcgxtRBHFswADNpTu/hUuOGn5XgV/MYTaDc2Jpc/LDyNaxdS69jQhLfa5syssebBgh7AeRQXi9CQnnXOBk4ZRa+TQVqi9vQwPUIgbXD7bh9sp+JKXeyildyxHwnuJJ/87tPI7cAn1KRa5/2kr9/PvyUzeE9tIXc+BbL/xbOD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN38rEIQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN38rEIQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a1b23c05so55537531cf.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856486; x=1772461286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGMA7vPkvfPMJtiGjXbBrpxghWpD1BIOrwwz/9dAxEs=;
        b=QN38rEIQ93o1bKBp5Mb9+G/0WeucGqGX3AaZLwavXVfPX+MK/V5kfEhjz9SDVZ7DkH
         DteFKFz5FtrBm6g5fWyKRA3LnM9m8ytPlGNbB+Z+b+k07HQXNLa1OzgPRQsq7or9RZgC
         BdfDTtIaabkBmWGnJLKSDJiyuJNuxunuq0YUqujZuEzo/m75uRPZthckLwdMyvISWSIq
         uJCN6m7ZrWnk9tKJbUGmxptyRl8U4NCxrX2G9PxXm3eujxruGEb3zT4tfZYHZAYqfqKl
         MQ2MeuyDlFfHBvKUH76WWc9xBU1z/nHIcO4M23rz0cjOSxHdaffibTd/U5gl0U8mUb66
         t/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856486; x=1772461286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGMA7vPkvfPMJtiGjXbBrpxghWpD1BIOrwwz/9dAxEs=;
        b=fYOnMvyBxhc21g9DtqYnjLqiCxhH9W+ZlNO7wrLd2iRTtyQ9kimCuxlKyqQvhiqAqg
         58KOYKm/eKxEGiDbAd9CcgrLlX1Bi5xnUDHcLQB+DtyqBeaDisD6K97nWGC/1HNk8xqw
         AWJLFjX5heqXlxPocGGJH13Y9/96/6WszDSeaEbH6WT3/995BWn1JtWdQNr5oKDEHo92
         bNB/qV+sUBk3K9fmK5jhuxYZwQsWi1kg+PzEJoXPzzYI51eGLOlpSJWsV0PSITJ1sHFH
         XFiyVsRX/nSEsETC3SDcSRpk313rtiLonvE9H0f+DAXecw1xGOkIPqul3zXLCzYeAwZU
         qFqA==
X-Gm-Message-State: AOJu0YygENbYQFIauGsUQB0808lF4thx2IcNrJDmf+AMgW79+P3itU1i
	gQTuY0wyfy5dz5OcMbZV9JGDc7vYWi/zeKnG5DRKqR87Dj+WlXFK8fykaI+9W8Il
X-Gm-Gg: AZuq6aKxuGq00dV+NDto4r6HQgbx0OFp+Ii48Pyz5nEs8hWifdoUtmGAKDFEqam1s4S
	P/B1UuEX0qqkDDqQfNCvNmCrZ+bJqQHNQi8aqOwxhy6AIHxOIQqK4ALtSDzOU6xnX14LPCNbsCP
	D62HyBDm8CaSSZ0keu3Jm4SF4oAkUjPkswFYJpzh0Ka5eBIPh1ikdDJTxPTZzpeloCYZ2rcOH1d
	h27R4JqfP0vO0oqAo5AGcd2IkWVUe1w1xFsNT3Q/FmcjcEBvi+fZ899L8RdoS16ix0FcSjkLVru
	JFm7wxjKsizIktRgA1A9IIGF6OWvZDwvo43lOvXVh2YGw0bkPv3ccdUZ17x4nPk3Hzf0+aF54WP
	XRIOrSJqybNnvSFAL4u3O+DoByBNP7vU6d7hrtVtFmrf1cW6PoODtvTe5ciTbehhsnQju44vNJG
	Pj7ErcbzpHNrebb6b1F3fNo9U=
X-Received: by 2002:a05:622a:292:b0:506:9ad2:8d4a with SMTP id d75a77b69052e-5070bcf84b2mr119788311cf.75.1771856486013;
        Mon, 23 Feb 2026 06:21:26 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6c9de8sm68076331cf.26.2026.02.23.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:24 -0800 (PST)
Message-Id: <f17c0f03e5daf6b905cbdba88285ee9d8e371f3f.1771856469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
	<pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:09 +0000
Subject: [PATCH v2 9/9] docs: describe repo info path keys and structure
 metrics
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Document the newly added repo info capabilities, including
category keys and path-oriented key definitions.

Also describe --path-format behavior for path outputs.

Update git repo structure documentation to cover newly reported
maxima and aggregate keyvalue/nul fields.

This keeps command behavior and output keys fully specified for
users and scripts.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 Documentation/git-repo.adoc | 67 ++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..b575977a4b 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
+git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
 git repo structure [--format=(table|keyvalue|nul) | -z]
 
 DESCRIPTION
@@ -44,6 +44,11 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`--path-format=(absolute|relative)`:::
+	Controls formatting for keys in the `path` category. The default is
+	`absolute`. This option may be specified multiple times; the last one
+	specified takes effect.
+
 `structure [--format=(table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
@@ -52,6 +57,12 @@ supported:
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
 * Total disk size of reachable objects by type
+* Largest inflated reachable object size by type
+* Largest disk size of a reachable object by type
+* Largest parent count among reachable commits
+* Largest entry count among reachable trees
+* Longest and deepest path among reachable blobs
+* Deepest annotated tag chain
 +
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
@@ -64,6 +75,7 @@ supported:
 `keyvalue`:::
 	Each line of output contains a key-value pair for a repository stat.
 	The '=' character is used to delimit between the key and the value.
+	Both aggregate metrics and per-type metrics are included.
 	Values containing "unusual" characters are quoted as explained for the
 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
@@ -78,9 +90,11 @@ supported:
 
 INFO KEYS
 ---------
-In order to obtain a set of values from `git repo info`, you should provide
-the keys that identify them. Here's a list of the available keys and the
-values that they return:
+In order to obtain values from `git repo info`, provide either individual keys
+or category names. A category returns all keys within that category. For
+example, `layout` returns both `layout.bare` and `layout.shallow`.
+
+Here's a list of the available keys and the values that they return:
 
 `layout.bare`::
 	`true` if this is a bare repository, otherwise `false`.
@@ -91,6 +105,51 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.common-dir`::
+	The path to the common git directory.
+
+`path.config-file`::
+	The path to the `config` file in the git directory.
+
+`path.git-dir`::
+	The path to the git directory.
+
+`path.git-prefix`::
+	The path of the current working directory relative to the top-level
+	directory.
+
+`path.grafts-file`::
+	The path to the `info/grafts` file.
+
+`path.hooks-directory`::
+	The path to the `hooks` directory.
+
+`path.index-file`::
+	The path to the index file.
+
+`path.logs-directory`::
+	The path to the `logs` directory.
+
+`path.objects-directory`::
+	The path to the objects directory.
+
+`path.packed-refs-file`::
+	The path to the `packed-refs` file.
+
+`path.refs-directory`::
+	The path to the `refs` directory.
+
+`path.shallow-file`::
+	The path to the `shallow` file.
+
+`path.superproject-working-tree`::
+	The path to the superproject's working tree root, or an empty string
+	when the repository is not used as a submodule.
+
+`path.toplevel`::
+	The path to the top-level working tree directory, or an empty string
+	for bare repositories.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
-- 
gitgitgadget
