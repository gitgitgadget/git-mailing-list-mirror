Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CC44DB65
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220658; cv=none; b=cWHxroqltzdmsL7QuVGOvROJe1gHaoDhPkzvzMNYsIz51in7zKFjpsjCZxXaggIZmmrzzBpTnXWuaSFcioAeHLPGG67AQDr0XpX7a4H9ZbI5LcZQVGPdtByHyki4KRsDRmtIvinPv0nhgEJptl3RF3DKGbnPMobQ05UE1Y6b0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220658; c=relaxed/simple;
	bh=LpkrZE9ZYUZw67HF9kFoQq6MaAkZa6q8pYU5d/t1+hY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kegng86dMrEhSemMv0Eqh1FAOKklN9GQRgonhvMdOnDJMLZkdR+e6vEXuObl92K1+ss6p0bAsiJMm1iHScTabS8T2eTXzSgno+h4POj+ROZMVd0mIMrVaGpZAtudkjIIiAnphbrcnYQD55IZRx3a1fQhUf8Jnw7Ziptg8vLw2w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYUSmwcG; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYUSmwcG"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdecd00ebdso1228888eec.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220656; x=1772825456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGMA7vPkvfPMJtiGjXbBrpxghWpD1BIOrwwz/9dAxEs=;
        b=eYUSmwcGP3dE/B5Okd3OOX0KS3v/QHrJposTvL4d1/Kf8jxL7Fp3+uyMIUHTgZuun9
         hOBaKp+FEPpWI2XgX9qSbJDgZ6N/6shUg+ZL+JBa2AJueT2ZiywWmYEMLYKKMijIMajW
         CruhwO2mCWEFpbLn+jKLsTr7eSsouW392mSenP5DH2WVv1VJjofQleKVxCPSoq/W4cdd
         4GZxQxI6NxpyPYhZat9IcBiqY/AlM5DxyHiJIaomuMZRGZ0G7J+uLGRGtY+AsSEfdm0y
         IGdP7kpzspOyZ1y+XIKb17LrpKZbrIYu1AH51LgF9Rv1GDaO96J0ayL10ZIBfbIlpyWr
         mqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220656; x=1772825456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGMA7vPkvfPMJtiGjXbBrpxghWpD1BIOrwwz/9dAxEs=;
        b=MnIkaAprTURu9lBHRozBckD0Kz/nb57la8yg9TNoIkNwxKCbFHyy3HLr+dL04ToqrJ
         DRAO1M/ltcxxidruJ/zu8K0f+nPgBd0vzCB9bazu/wJLzSGmS58fQxsGW33oNK2K7mIc
         +F6GAmkmmlquVp80e+wYTz0eDKW+oL2MUidJkllLISfvSePqRp8U/1eAGiUcUX/hJp2v
         9qFfvvxxEYh9HbZ3B64zI2SGaOsy2H+C4pKHkFf+MfwxydQQ++nRpU4wSi3hDqdOL7JH
         J5CQxf5zD9DS6Y6yPAjZpg3OGLZZsizx0OeyBIo+xdF7Hv4LYTfk2vlQguNnS+dmPwYt
         ewnQ==
X-Gm-Message-State: AOJu0YyspwfHRV5+Pu8baFsPT1wbV0dBuY+EDAHJLE2+OS0ickEWRDZj
	IIumyVa5Z6g4PKvi1Mtg0i/OuPqm/3NDQhp8b7QHgHzDndeYZSpVKXtGNscoYQ==
X-Gm-Gg: ATEYQzz4XZCDcp9zUZrX0nVvesZ9T3dbgGoVdYEa/xb1rfIMzB+89eFNKx+2g1qntMQ
	mNTFtoBOqJQ7LqKCCtzF+eS+z3Aq8jmDfim4eUyTpeyFvP74A/Sj7F1qUs4YjNMSj8s9dkJ10fV
	QFFjDHHIHNJpo6HBdQAoKhBqWFrsidUo0YoDm9QZgpJsc9Ys0Fm4rWhbwEfRzw3LHYPhcVeW+TX
	Vi+lySjYLsKbOiVqVhj+Cwd5oxCtDOrdSD/tqCN89WrUHWvJ6EeICk+p6IaykiJyDSc91bma0H0
	lMlcKWadSf1DnorVfkfs8WpmoaTH3aybHyFFXAOTupoqV2/gCD4Nh3+fINW/81hNvLwdEz1DYx7
	lbCW367tOsUy2jY1qspZM+PivAYm6Y1S+FMBLWfWT4iQFzHkiMi90A4NUW5qMT8BGMzSILhlFen
	92kb9hwkmufkVLv49bekCQQrGPGs7Zd0Bl8rv59A==
X-Received: by 2002:a05:7301:6084:b0:2ba:6d87:cf6e with SMTP id 5a478bee46e88-2bde1c0f4bfmr1933629eec.4.1772220655292;
        Fri, 27 Feb 2026 11:30:55 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1e04361sm4899887eec.14.2026.02.27.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:54 -0800 (PST)
Message-Id: <f17c0f03e5daf6b905cbdba88285ee9d8e371f3f.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:38 +0000
Subject: [PATCH v5 09/11] docs: describe repo info path keys and structure
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
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

