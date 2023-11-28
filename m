Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pimpmybyte.de header.i=@pimpmybyte.de header.b="mIGeHEKP"
Received: from pimpmybyte.de (kalmar.hosting.pimpmybyte.de [212.227.234.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95CD0
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 22:59:17 -0800 (PST)
Received: by kalmar.hosting.pimpmybyte.de (Postfix, from userid 1000)
	id 8C7BC7E97D; Tue, 28 Nov 2023 06:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimpmybyte.de;
	s=default; t=1701154756;
	bh=f19W7xsmsWvrQNGd405ZCGJRVO7yGOsA3LzA9TW1PVE=; h=From:To:Subject;
	b=mIGeHEKPQWWe1gGfayTdItFH2kF6RWbcPaar6iHc7WGnETdXKpDitj95fYSgXVwoK
	 tFbtXlJdWDUsMpxGWh56tzNrwvtvDy9weybEXme9dnF+8MTOPfwVbCeOW1B1/0X0IV
	 KjS+NJuqI5Is0ubhUsdVqvXKevIcxwIVzCT2VXhs=
From: Marcel Krause <mk+copyleft@pimpmybyte.de>
To: git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Marcel Krause <mk+copyleft@pimpmybyte.de>
Subject: [PATCH] doc: make the gitfile syntax easier to discover
Date: Tue, 28 Nov 2023 07:55:58 +0100
Message-Id: <20231128065558.1061206-1-mk+copyleft@pimpmybyte.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <182d290a-86e5-b361-87a1-6860641fc726@pimpmybyte.de>
References: <182d290a-86e5-b361-87a1-6860641fc726@pimpmybyte.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Marcel Krause <mk+copyleft@pimpmybyte.de>
---
 Documentation/gitrepository-layout.txt | 4 +++-
 Documentation/glossary-content.txt     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 1a2ef4c150..949cd8a31e 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -23,7 +23,9 @@ A Git repository comes in two different flavours:
 
 *Note*: Also you can have a plain text file `.git` at the root of
 your working tree, containing `gitdir: <path>` to point at the real
-directory that has the repository.  This mechanism is often used for
+directory that has the repository.
+This mechanism is called a 'gitfile' and is usually managed via the
+`git submodule` and `git worktree` commands. It is often used for
 a working tree of a submodule checkout, to allow you in the
 containing superproject to `git checkout` a branch that does not
 have the submodule.  The `checkout` has to remove the entire
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5a537268e2..3f912e7bb2 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -184,6 +184,8 @@ current branch integrates with) obviously do not work, as there is no
 [[def_gitfile]]gitfile::
 	A plain file `.git` at the root of a working tree that
 	points at the directory that is the real repository.
+	For proper use see linkgit:git-worktree[1] or linkgit:git-submodule[1].
+	For syntax see linkgit:gitrepository-layout[5].
 
 [[def_grafts]]grafts::
 	Grafts enables two otherwise different lines of development to be joined
-- 
2.25.1

