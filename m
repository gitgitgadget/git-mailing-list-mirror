Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B532586C1
	for <git@vger.kernel.org>; Sat, 10 May 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880495; cv=none; b=h7c9rY1g3wVrp8T2CZKs2rPJd2RecmP7699gevyrtOwv60vlytn2XruUt99/qPFwc2uxHEGkvIfzs00FW4OF5db7btRWhDArZvrX32e5kcLVyXDQve64WVhWHYld2Wklb6rew0hlqXFqHhoapp6piBHBXGkABzdCbc6zELMZNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880495; c=relaxed/simple;
	bh=RgkZaD0JQevaf/+zqmuJhVjE6J7QyIZAIUfvLTEORaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNZhhRqsTqy3FOGW4z/HZdd08iqelc5jrb++pTZpVa7Wu3OIl6toATwu2Sk7odqa0Rra7usgDQcxpglE+szQ9Jy4zTwWP4XjaLWo1n57fGdDgDbeEtaY8EdonQ2JBDzUS+xbuouRw+WOUNmF86XSkbFJ4cpRgeNr+93pWeqBOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5704313F8CE;
	Sat, 10 May 2025 14:34:49 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 4/4] git-var doc: fix usage of $ENV_VAR vs ENV_VAR
Date: Sat, 10 May 2025 14:33:17 +0200
Message-ID: <20250510123346.20927-5-jn.avila@free.fr>
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

When refering to environment variables in the documentation, use the
ENV_VARIABLE format instead of $ENV_VARIABLE. The latter is used in the
documentation to refer to the actual value of the variable, not the name
of the variable.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-var.adoc | 40 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 909963b1c2..b606c2d649 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -32,58 +32,56 @@ EXAMPLES
 
 VARIABLES
 ---------
-GIT_AUTHOR_IDENT::
+`GIT_AUTHOR_IDENT`::
     The author of a piece of code.
 
-GIT_COMMITTER_IDENT::
+`GIT_COMMITTER_IDENT`::
     The person who put a piece of code into Git.
 
-GIT_EDITOR::
+`GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
     interpreted by the shell when it is used.  Examples: `~/bin/vi`,
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
-    --nofork`.  The order of preference is the `$GIT_EDITOR`
-    environment variable, then `core.editor` configuration, then
-    `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
+    --nofork`.  The order of preference is `$GIT_EDITOR`, then
+    `core.editor` configuration value, then `$VISUAL`, then
+    `$EDITOR`, and then the default chosen at compile
     time, which is usually 'vi'.
 ifdef::git-default-editor[]
     The build you are using chose '{git-default-editor}' as the default.
 endif::git-default-editor[]
 
-GIT_SEQUENCE_EDITOR::
+`GIT_SEQUENCE_EDITOR`::
     Text editor used to edit the 'todo' file while running `git rebase
     -i`. Like `GIT_EDITOR`, the value is meant to be interpreted by
-    the shell when it is used. The order of preference is the
-    `$GIT_SEQUENCE_EDITOR` environment variable, then
-    `sequence.editor` configuration, and then the value of `git var
-    GIT_EDITOR`.
+    the shell when it is used. The order of preference is
+    `$GIT_SEQUENCE_EDITOR`, then `sequence.editor` configuration value,
+    and then the value of `git var GIT_EDITOR`.
 
-GIT_PAGER::
+`GIT_PAGER`::
     Text viewer for use by Git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
-    is the `$GIT_PAGER` environment variable, then `core.pager`
-    configuration, then `$PAGER`, and then the default chosen at
-    compile time (usually 'less').
+    is `$GIT_PAGER`, then the value of `core.pager` configuration, then
+    `$PAGER`, and then the default chosen at compile time (usually `less`).
 ifdef::git-default-pager[]
     The build you are using chose '{git-default-pager}' as the default.
 endif::git-default-pager[]
 
-GIT_DEFAULT_BRANCH::
+`GIT_DEFAULT_BRANCH`::
     The name of the first branch created in newly initialized repositories.
 
-GIT_SHELL_PATH::
+`GIT_SHELL_PATH`::
     The path of the binary providing the POSIX shell for commands which use the shell.
 
-GIT_ATTR_SYSTEM::
+`GIT_ATTR_SYSTEM`::
     The path to the system linkgit:gitattributes[5] file, if one is enabled.
 
-GIT_ATTR_GLOBAL::
+`GIT_ATTR_GLOBAL`::
     The path to the global (per-user) linkgit:gitattributes[5] file.
 
-GIT_CONFIG_SYSTEM::
+`GIT_CONFIG_SYSTEM`::
     The path to the system configuration file, if one is enabled.
 
-GIT_CONFIG_GLOBAL::
+`GIT_CONFIG_GLOBAL`::
     The path to the global (per-user) configuration files, if any.
 
 Most path values contain only one value. However, some can contain multiple
-- 
2.48.0

