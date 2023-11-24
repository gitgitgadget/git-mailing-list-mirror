Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pimpmybyte.de header.i=@pimpmybyte.de header.b="nZmZlQfY"
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 13:29:04 PST
Received: from pimpmybyte.de (kalmar.hosting.pimpmybyte.de [212.227.234.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA919A7
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 13:29:03 -0800 (PST)
Received: by kalmar.hosting.pimpmybyte.de (Postfix, from userid 0)
	id 8A7077E728; Fri, 24 Nov 2023 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimpmybyte.de;
	s=default; t=1700860880;
	bh=FtqYTnAjkvdYCO5IEfdsIzvF1BGSOhvyQfatxFylht4=; h=From:To:Subject;
	b=nZmZlQfY6686wBvFcsjPC4hPR+PqabPhOSAwDWqUjPlNmBx5Bv+L/OpgybHxLGaeN
	 IcY62n22V3SDfmB+u8ccYafEmt+4xHUJYjLkQlLuHgTgqzEdL3UTkKqyEICr+CDOgj
	 uMpyXtErth+3ddxnSgwkpbH3nuW7bAdvQVuM1V1k=
From: Marcel Krause <mk+copyleft@pimpmybyte.de>
To: git mailing list <git@vger.kernel.org>
Cc: Marcel Krause <mk+copyleft@pimpmybyte.de>
Subject: [PATCH] doc: make the gitfile syntax easier to discover
Date: Fri, 24 Nov 2023 20:47:12 +0100
Message-Id: <20231124194711.563720-1-mk+copyleft@pimpmybyte.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It took way too long for me to find the syntax expected for a gitfile.
My search engine found the gitglossary manpage which defined the term
but had no hints about syntax.
Thus here I add a mention of gitrepository-layout.

Once I somehow found gitrepository-layout, I searched for "gitfile" in
there, but had no matches. It took a moment of discouragement and a
minute or so of actually reading to find the info I was looking for.
Thus here I add the part "[This mechanism is] called a 'gitfile'" in
hopes that future readers will find it in mere seconds and without
discouragement. Maybe it even helps search engines find it.

Ideally, someone else may add a mention of gitrepository-layout in the
"fatal: invalid gitfile format:" error message, which is what sent me
on my journey initially, or even add a stub man page named "gitfile".

Based on the maint branch for maximum compatibility.

Signed-off-by: Marcel Krause <mk+copyleft@pimpmybyte.de>
---
 Documentation/gitrepository-layout.txt | 8 ++++----
 Documentation/glossary-content.txt     | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 1a2ef4c150..c52b8564e3 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -23,10 +23,10 @@ A Git repository comes in two different flavours:
 
 *Note*: Also you can have a plain text file `.git` at the root of
 your working tree, containing `gitdir: <path>` to point at the real
-directory that has the repository.  This mechanism is often used for
-a working tree of a submodule checkout, to allow you in the
-containing superproject to `git checkout` a branch that does not
-have the submodule.  The `checkout` has to remove the entire
+directory that has the repository.  This mechanism is called a 'gitfile'
+and is often used for a working tree of a submodule checkout, to allow
+you in the containing superproject to `git checkout` a branch that
+does not have the submodule.  The `checkout` has to remove the entire
 submodule working tree, without losing the submodule repository.
 
 These things may exist in a Git repository.
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5a537268e2..e5f55bf670 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -184,6 +184,7 @@ current branch integrates with) obviously do not work, as there is no
 [[def_gitfile]]gitfile::
 	A plain file `.git` at the root of a working tree that
 	points at the directory that is the real repository.
+	See linkgit:gitrepository-layout for the syntax.
 
 [[def_grafts]]grafts::
 	Grafts enables two otherwise different lines of development to be joined
-- 
2.25.1

