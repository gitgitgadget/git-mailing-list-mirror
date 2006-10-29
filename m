X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 2/2] Swap the porcelain and plumbing commands in the git man page
Date: Sun, 29 Oct 2006 21:09:48 +0100
Message-ID: <20061029200948.11233.27482.stgit@lathund.dewire.com>
References: <20061029200940.11233.20277.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sun, 29 Oct 2006 20:09:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at localhost.localdomain
In-Reply-To: <20061029200940.11233.20277.stgit@lathund.dewire.com>
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30450>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGyM-0000RE-5Y for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965371AbWJ2UIy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbWJ2UIx
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:08:53 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29210 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S965371AbWJ2UIu (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:08:50 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 37EC68003E1 for <git@vger.kernel.org>; Sun, 29 Oct
 2006 21:05:32 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 21223-10 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 21:05:31 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2]) by torino.dewire.com
 (Postfix) with ESMTP id 5A63B8030A5 for <git@vger.kernel.org>; Sun, 29 Oct
 2006 21:05:27 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 5B4DD28E5C for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 21:10:00 +0100 (CET)
Received: from lathund.dewire.com ([127.0.0.1]) by localhost
 (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025) with LMTP id
 LuupMt1rkeY0 for <git@vger.kernel.org>; Sun, 29 Oct 2006 21:09:49 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 71DBF28E63 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 21:09:48 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Robin Rosenberg <robin.rosenberg@dewire.com>

This makes the documentation less confusing to newcomers.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 Documentation/git.txt |  364 +++++++++++++++++++++++++------------------------
 1 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index fff07e1..0679e3c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -72,188 +72,6 @@ GIT COMMANDS
 We divide git into high level ("porcelain") commands and low level
 ("plumbing") commands.
 
-Low-level commands (plumbing)
------------------------------
-
-Although git includes its
-own porcelain layer, its low-level commands are sufficient to support
-development of alternative porcelains.  Developers of such porcelains
-might start by reading about gitlink:git-update-index[1] and
-gitlink:git-read-tree[1].
-
-We divide the low-level commands into commands that manipulate objects (in
-the repository, index, and working tree), commands that interrogate and
-compare objects, and commands that move objects and references between
-repositories.
-
-Manipulation commands
-~~~~~~~~~~~~~~~~~~~~~
-gitlink:git-apply[1]::
-	Reads a "diff -up1" or git generated patch file and
-	applies it to the working tree.
-
-gitlink:git-checkout-index[1]::
-	Copy files from the index to the working tree.
-
-gitlink:git-commit-tree[1]::
-	Creates a new commit object.
-
-gitlink:git-hash-object[1]::
-	Computes the object ID from a file.
-
-gitlink:git-index-pack[1]::
-	Build pack idx file for an existing packed archive.
-
-gitlink:git-init-db[1]::
-	Creates an empty git object database, or reinitialize an
-	existing one.
-
-gitlink:git-merge-index[1]::
-	Runs a merge for files needing merging.
-
-gitlink:git-mktag[1]::
-	Creates a tag object.
-
-gitlink:git-mktree[1]::
-	Build a tree-object from ls-tree formatted text.
-
-gitlink:git-pack-objects[1]::
-	Creates a packed archive of objects.
-
-gitlink:git-prune-packed[1]::
-	Remove extra objects that are already in pack files.
-
-gitlink:git-read-tree[1]::
-	Reads tree information into the index.
-
-gitlink:git-repo-config[1]::
-	Get and set options in .git/config.
-
-gitlink:git-unpack-objects[1]::
-	Unpacks objects out of a packed archive.
-
-gitlink:git-update-index[1]::
-	Registers files in the working tree to the index.
-
-gitlink:git-write-tree[1]::
-	Creates a tree from the index.
-
-
-Interrogation commands
-~~~~~~~~~~~~~~~~~~~~~~
-
-gitlink:git-cat-file[1]::
-	Provide content or type/size information for repository objects.
-
-gitlink:git-describe[1]::
-	Show the most recent tag that is reachable from a commit.
-
-gitlink:git-diff-index[1]::
-	Compares content and mode of blobs between the index and repository.
-
-gitlink:git-diff-files[1]::
-	Compares files in the working tree and the index.
-
-gitlink:git-diff-stages[1]::
-	Compares two "merge stages" in the index.
-
-gitlink:git-diff-tree[1]::
-	Compares the content and mode of blobs found via two tree objects.
-
-gitlink:git-for-each-ref[1]::
-	Output information on each ref.
-
-gitlink:git-fsck-objects[1]::
-	Verifies the connectivity and validity of the objects in the database.
-
-gitlink:git-ls-files[1]::
-	Information about files in the index and the working tree.
-
-gitlink:git-ls-tree[1]::
-	Displays a tree object in human readable form.
-
-gitlink:git-merge-base[1]::
-	Finds as good common ancestors as possible for a merge.
-
-gitlink:git-name-rev[1]::
-	Find symbolic names for given revs.
-
-gitlink:git-pack-redundant[1]::
-	Find redundant pack files.
-
-gitlink:git-rev-list[1]::
-	Lists commit objects in reverse chronological order.
-
-gitlink:git-show-index[1]::
-	Displays contents of a pack idx file.
-
-gitlink:git-tar-tree[1]::
-	Creates a tar archive of the files in the named tree object.
-
-gitlink:git-unpack-file[1]::
-	Creates a temporary file with a blob's contents.
-
-gitlink:git-var[1]::
-	Displays a git logical variable.
-
-gitlink:git-verify-pack[1]::
-	Validates packed git archive files.
-
-In general, the interrogate commands do not touch the files in
-the working tree.
-
-
-Synching repositories
-~~~~~~~~~~~~~~~~~~~~~
-
-gitlink:git-fetch-pack[1]::
-	Updates from a remote repository (engine for ssh and
-	local transport).
-
-gitlink:git-http-fetch[1]::
-	Downloads a remote git repository via HTTP by walking
-	commit chain.
-
-gitlink:git-local-fetch[1]::
-	Duplicates another git repository on a local system by
-	walking commit chain.
-
-gitlink:git-peek-remote[1]::
-	Lists references on a remote repository using
-	upload-pack protocol (engine for ssh and local
-	transport).
-
-gitlink:git-receive-pack[1]::
-	Invoked by 'git-send-pack' to receive what is pushed to it.
-
-gitlink:git-send-pack[1]::
-	Pushes to a remote repository, intelligently.
-
-gitlink:git-http-push[1]::
-	Push missing objects using HTTP/DAV.
-
-gitlink:git-shell[1]::
-	Restricted shell for GIT-only SSH access.
-
-gitlink:git-ssh-fetch[1]::
-	Pulls from a remote repository over ssh connection by
-	walking commit chain.
-
-gitlink:git-ssh-upload[1]::
-	Helper "server-side" program used by git-ssh-fetch.
-
-gitlink:git-update-server-info[1]::
-	Updates auxiliary information on a dumb server to help
-	clients discover references and packs on it.
-
-gitlink:git-upload-archive[1]::
-	Invoked by 'git-archive' to send a generated archive.
-
-gitlink:git-upload-pack[1]::
-	Invoked by 'git-fetch-pack' to push
-	what are asked for.
-
-
 High-level commands (porcelain)
 -------------------------------
 
@@ -491,6 +309,188 @@ gitlink:git-stripspace[1]::
 	Filter out empty lines.
 
 
+Low-level commands (plumbing)
+-----------------------------
+
+Although git includes its
+own porcelain layer, its low-level commands are sufficient to support
+development of alternative porcelains.  Developers of such porcelains
+might start by reading about gitlink:git-update-index[1] and
+gitlink:git-read-tree[1].
+
+We divide the low-level commands into commands that manipulate objects (in
+the repository, index, and working tree), commands that interrogate and
+compare objects, and commands that move objects and references between
+repositories.
+
+Manipulation commands
+~~~~~~~~~~~~~~~~~~~~~
+gitlink:git-apply[1]::
+	Reads a "diff -up1" or git generated patch file and
+	applies it to the working tree.
+
+gitlink:git-checkout-index[1]::
+	Copy files from the index to the working tree.
+
+gitlink:git-commit-tree[1]::
+	Creates a new commit object.
+
+gitlink:git-hash-object[1]::
+	Computes the object ID from a file.
+
+gitlink:git-index-pack[1]::
+	Build pack idx file for an existing packed archive.
+
+gitlink:git-init-db[1]::
+	Creates an empty git object database, or reinitialize an
+	existing one.
+
+gitlink:git-merge-index[1]::
+	Runs a merge for files needing merging.
+
+gitlink:git-mktag[1]::
+	Creates a tag object.
+
+gitlink:git-mktree[1]::
+	Build a tree-object from ls-tree formatted text.
+
+gitlink:git-pack-objects[1]::
+	Creates a packed archive of objects.
+
+gitlink:git-prune-packed[1]::
+	Remove extra objects that are already in pack files.
+
+gitlink:git-read-tree[1]::
+	Reads tree information into the index.
+
+gitlink:git-repo-config[1]::
+	Get and set options in .git/config.
+
+gitlink:git-unpack-objects[1]::
+	Unpacks objects out of a packed archive.
+
+gitlink:git-update-index[1]::
+	Registers files in the working tree to the index.
+
+gitlink:git-write-tree[1]::
+	Creates a tree from the index.
+
+
+Interrogation commands
+~~~~~~~~~~~~~~~~~~~~~~
+
+gitlink:git-cat-file[1]::
+	Provide content or type/size information for repository objects.
+
+gitlink:git-describe[1]::
+	Show the most recent tag that is reachable from a commit.
+
+gitlink:git-diff-index[1]::
+	Compares content and mode of blobs between the index and repository.
+
+gitlink:git-diff-files[1]::
+	Compares files in the working tree and the index.
+
+gitlink:git-diff-stages[1]::
+	Compares two "merge stages" in the index.
+
+gitlink:git-diff-tree[1]::
+	Compares the content and mode of blobs found via two tree objects.
+
+gitlink:git-for-each-ref[1]::
+	Output information on each ref.
+
+gitlink:git-fsck-objects[1]::
+	Verifies the connectivity and validity of the objects in the database.
+
+gitlink:git-ls-files[1]::
+	Information about files in the index and the working tree.
+
+gitlink:git-ls-tree[1]::
+	Displays a tree object in human readable form.
+
+gitlink:git-merge-base[1]::
+	Finds as good common ancestors as possible for a merge.
+
+gitlink:git-name-rev[1]::
+	Find symbolic names for given revs.
+
+gitlink:git-pack-redundant[1]::
+	Find redundant pack files.
+
+gitlink:git-rev-list[1]::
+	Lists commit objects in reverse chronological order.
+
+gitlink:git-show-index[1]::
+	Displays contents of a pack idx file.
+
+gitlink:git-tar-tree[1]::
+	Creates a tar archive of the files in the named tree object.
+
+gitlink:git-unpack-file[1]::
+	Creates a temporary file with a blob's contents.
+
+gitlink:git-var[1]::
+	Displays a git logical variable.
+
+gitlink:git-verify-pack[1]::
+	Validates packed git archive files.
+
+In general, the interrogate commands do not touch the files in
+the working tree.
+
+
+Synching repositories
+~~~~~~~~~~~~~~~~~~~~~
+
+gitlink:git-fetch-pack[1]::
+	Updates from a remote repository (engine for ssh and
+	local transport).
+
+gitlink:git-http-fetch[1]::
+	Downloads a remote git repository via HTTP by walking
+	commit chain.
+
+gitlink:git-local-fetch[1]::
+	Duplicates another git repository on a local system by
+	walking commit chain.
+
+gitlink:git-peek-remote[1]::
+	Lists references on a remote repository using
+	upload-pack protocol (engine for ssh and local
+	transport).
+
+gitlink:git-receive-pack[1]::
+	Invoked by 'git-send-pack' to receive what is pushed to it.
+
+gitlink:git-send-pack[1]::
+	Pushes to a remote repository, intelligently.
+
+gitlink:git-http-push[1]::
+	Push missing objects using HTTP/DAV.
+
+gitlink:git-shell[1]::
+	Restricted shell for GIT-only SSH access.
+
+gitlink:git-ssh-fetch[1]::
+	Pulls from a remote repository over ssh connection by
+	walking commit chain.
+
+gitlink:git-ssh-upload[1]::
+	Helper "server-side" program used by git-ssh-fetch.
+
+gitlink:git-update-server-info[1]::
+	Updates auxiliary information on a dumb server to help
+	clients discover references and packs on it.
+
+gitlink:git-upload-archive[1]::
+	Invoked by 'git-archive' to send a generated archive.
+
+gitlink:git-upload-pack[1]::
+	Invoked by 'git-fetch-pack' to push
+	what are asked for.
+
+
 Configuration Mechanism
 -----------------------
