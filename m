Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7E4EB38
	for <git@vger.kernel.org>; Sat, 10 May 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880489; cv=none; b=D+EbYee5uKY9GLErCLyHL8GvlXvDz/flW7gCJmgvcLIz/BS07RitswDnCANE+xmDijeqUdgCj3Hopuoyhbca65e+JXNNpXALrlYhPNdDb8k6gB6O9iFwXwh/7qvCiHxpJyfOJC3w1kUhLeXE4rGjGo2crXJ/HNu5DCKHxPid+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880489; c=relaxed/simple;
	bh=1LOUtjaOY/NqQDpISpuFRLkJxMFwMHmXMKFhk8uTPZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfb8Ju9srsFZbFOX+X1Q1dZfqgOcP9JMh6vaQc5dYnPEbyL3QjWtC++aNGizBStN6SInPPI4/yvTX+A0bTVP52JRqzsa2GVeom8Dj6yQ8FzISXW3DueVc1I1JYIDUorOaMAUUbBsTEWw0ovqegZ0p6XACC/fhzbpueV9wLIMBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E3D2F13F861;
	Sat, 10 May 2025 14:34:42 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 2/4] git-{var,write-tree} docs: update mark-up of synopsis option descriptions
Date: Sat, 10 May 2025 14:33:15 +0200
Message-ID: <20250510123346.20927-3-jn.avila@free.fr>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250510123346.20927-1-jn.avila@free.fr>
References: <20250501213414.370514-1-gitster@pobox.com>
 <20250510123346.20927-1-jn.avila@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

To unify mark-up used in our documentation to a newer convention,
started by 22293895 (doc: apply synopsis simplification on git-clone
and git-init, 2024-09-24), update the documentation for 'git var' and
'git write-tree' to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-var.adoc        |  6 +++---
 Documentation/git-write-tree.adoc | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 0680568dfd..909963b1c2 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -8,8 +8,8 @@ git-var - Show a Git logical variable
 
 SYNOPSIS
 --------
-[verse]
-'git var' (-l | <variable>)
+[synopsis]
+git var (-l | <variable>)
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ no value.
 
 OPTIONS
 -------
--l::
+`-l`::
 	Display the logical variables. In addition, all the
 	variables of the Git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
diff --git a/Documentation/git-write-tree.adoc b/Documentation/git-write-tree.adoc
index f22041a9dc..4c7100ea1e 100644
--- a/Documentation/git-write-tree.adoc
+++ b/Documentation/git-write-tree.adoc
@@ -8,8 +8,8 @@ git-write-tree - Create a tree object from the current index
 
 SYNOPSIS
 --------
-[verse]
-'git write-tree' [--missing-ok] [--prefix=<prefix>/]
+[synopsis]
+git write-tree [--missing-ok] [--prefix=<prefix>/]
 
 DESCRIPTION
 -----------
@@ -18,23 +18,23 @@ tree object is printed to standard output.
 
 The index must be in a fully merged state.
 
-Conceptually, 'git write-tree' sync()s the current index contents
+Conceptually, `git write-tree` sync()s the current index contents
 into a set of tree files.
 In order to have that match what is actually in your directory right
-now, you need to have done a 'git update-index' phase before you did the
-'git write-tree'.
+now, you need to have done a `git update-index` phase before you did the
+`git write-tree`.
 
 
 OPTIONS
 -------
---missing-ok::
-	Normally 'git write-tree' ensures that the objects referenced by the
+`--missing-ok`::
+	Normally `git write-tree` ensures that the objects referenced by the
 	directory exist in the object database.  This option disables this
 	check.
 
---prefix=<prefix>/::
+`--prefix=<prefix>/`::
 	Writes a tree object that represents a subdirectory
-	`<prefix>`.  This can be used to write the tree object
+	_<prefix>_.  This can be used to write the tree object
 	for a subproject that is in the named subdirectory.
 
 GIT
-- 
2.48.0

