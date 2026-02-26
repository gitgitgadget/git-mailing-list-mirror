Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C1478862
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140504; cv=none; b=OX9QwYAQnD8gexF6oyjmknJhlFXsO6kpbdBGctIUMvGdW8NBrEjz7WFlLXMStmr4DpYU/k3UfM0lDiaZiloE0ie1II+HFREOaVKsZztfpj9SifYYkFg6zlKUT96JDOf3H+eBTugDHqrXa9F8ELuYc02EvLWE0cSKCRzJGCn73IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140504; c=relaxed/simple;
	bh=LpkrZE9ZYUZw67HF9kFoQq6MaAkZa6q8pYU5d/t1+hY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SQVLtEE26vnJEtqsAO86KtdIIFmyIrxA8Tqt1Oc3LLJlmeAcGiv7muCT/Bt8ttopDU45plth6oW7yTBcihsklYaUU8SKA1htkSQB8Wpow4gZWywKwiZ40AJdwTtPHvlKoMpFjbXKAFHwVdfGAiDIalQNA3yJmz0979eASSmJa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhIxAxiA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhIxAxiA"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899a2f4cdddso16533146d6.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140499; x=1772745299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGMA7vPkvfPMJtiGjXbBrpxghWpD1BIOrwwz/9dAxEs=;
        b=nhIxAxiAZ1M8Y4481qUAzphCqSxGmVZmjQQvacVqMri8r4OLGTsw9JFuEsuZ5b1hla
         +bq4lxCCNJ7bcsPjFOgs92sm1S6f8W72rOBdgTVULI7ThAwRJhtxHcoOL+Vo16m7Dmfi
         am04nQmLgrizIVrExDn75PF5ijyu5uqLEqejPhi2yxcfRXOZlNBmG9TIcHXuX+AlOqIc
         SPezozMgI6vhivDE71YgwlqtPG8LVEHQzxPgaXJRt49kepQeKraDj3dyQUNjqHDEPS60
         tv0RT+KTOocOpiJ127JY0E7HtmvcZN+w00i8q4ulLTybX57Z5vIO2SLL/DSxp+1+7YpK
         n3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140499; x=1772745299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGMA7vPkvfPMJtiGjXbBrpxghWpD1BIOrwwz/9dAxEs=;
        b=dZcbH1AzWPf2FaLtktuddvbNrJS6KBZ/4KTGJPHPOekICXCU3gIfGeR68E0rl7J1pS
         aukZ3xl/9ohPDXsQDGN+6Yn0OEo+PIiUw3ysEoN1Y3cxYt1t7ZrZkxx9qcTHySCJ4N9k
         uZM0whmeSlirgheXLQulxIwHERxEwoxWoZtW+d9axS2033I12yaqgWL+gjgD/c1bN37e
         0kwX0My2py49NXl5lvcxjkGtG37Yw8dq2abjxglYREbeBF76OwdQdanFd73W/5le6Xbe
         zNZn5WUBKUimYHoTxR366S5IyF4MyeGBxB+6ptGAHNtl4Y/cEEOtLEHLf6qGaG9v4ElP
         GPOA==
X-Gm-Message-State: AOJu0YwHwXSb9n0OdBHD8CAqDaiO63TAlaurjw8USNMvT/n73XOCTEFB
	JqXJe2cXDlWLA9HlggxlFZhbzgNhT1vW7TxgtWJFJQ2W4fWdPL/rFOmCkEGuEQ==
X-Gm-Gg: ATEYQzxTooJGvkF3eJAhLyRU7W3q1/v4QSHEnvvw3b6IPqYzsoDCNPH2rm4ll8+fbay
	mRcOiK3PZ5L44SUrRdBKX9fMMMF8PRonyuV+gf3D16sjKXoRbL7BkfBiP5MZDesDGrzaNYwWH6F
	x93f1NUKA9Y8h+o39TB3l6H1Pcv9dPbTXVT09m/BLa+LLtBviPhz7niyeiFfyqBF9WMTsgZSegH
	VlH5vZKPvA2UL65xHJ79PD2BfI2eUaEX9z2/Ipvh7JORPH0GjKmTAIVHoydpaTmcXpTTMi0PZkA
	vT/7IaK95ZCNZyLOz9ZXwrMXrBQfex+dtJMLq6efklktw5jEwBbmPK/EJUZHeZpMs/ciT6o9EKU
	ouT5PsxJNeSFapUAvEBs7q74R763O5UfXmaND25PnfsFT0+aKN8dfjLbv2IOWWUOVSEgYYDPg95
	qsAK5Q6P6oa+Hbu/j1HYb/5bKkjQ==
X-Received: by 2002:a05:6214:d81:b0:895:3ec:9e6c with SMTP id 6a1803df08f44-899d1da87cfmr9022826d6.1.1772140499312;
        Thu, 26 Feb 2026 13:14:59 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7375f30sm26197906d6.27.2026.02.26.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:58 -0800 (PST)
Message-Id: <f17c0f03e5daf6b905cbdba88285ee9d8e371f3f.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:46 +0000
Subject: [PATCH v4 09/10] docs: describe repo info path keys and structure
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
Cc: eslam reda <eslam.reda.div@gmail.com>,
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

