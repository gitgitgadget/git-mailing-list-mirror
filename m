From: Jeff King <peff@peff.net>
Subject: [PATCH] gitignore: root most patterns at the top-level directory
Date: Mon, 26 Oct 2009 21:10:24 -0400
Message-ID: <20091027011024.GA29361@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:06:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2aWT-0004I0-LR
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 02:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbZJ0BGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbZJ0BGm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 21:06:42 -0400
Received: from peff.net ([208.65.91.99]:37128 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755085AbZJ0BGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 21:06:42 -0400
Received: (qmail 29371 invoked by uid 1000); 27 Oct 2009 01:10:24 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131298>

Our gitignore doesn't use a preceding "/" to root its
patterns in the top of the repository. This means that if
you add a file or directory called "git" (for example)
inside a subdirectory, it will be erroneously ignored.

This patch was done mechanically with "s/^[^*]/\/&/" with
one exception: instead of ignoring gitk-wish, we should
gitk-git/gitk-wish (arguably, this should be done in
gitk-git/.gitignore, but because that is a subtree merge
from elsewhere, this is easier).

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---

This bit Sverre while I was looking over his shoulder. I doubt it comes
up very often, but we should probably be modeling good gitignore
behavior. I have to admit it looks a lot uglier, though.

 .gitignore |  354 ++++++++++++++++++++++++++++++------------------------------
 1 files changed, 177 insertions(+), 177 deletions(-)

diff --git a/.gitignore b/.gitignore
index 51a37b1..289c3d0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,184 +1,184 @@
-GIT-BUILD-OPTIONS
-GIT-CFLAGS
-GIT-GUI-VARS
-GIT-VERSION-FILE
-git
-git-add
-git-add--interactive
-git-am
-git-annotate
-git-apply
-git-archimport
-git-archive
-git-bisect
-git-bisect--helper
-git-blame
-git-branch
-git-bundle
-git-cat-file
-git-check-attr
-git-check-ref-format
-git-checkout
-git-checkout-index
-git-cherry
-git-cherry-pick
-git-clean
-git-clone
-git-commit
-git-commit-tree
-git-config
-git-count-objects
-git-cvsexportcommit
-git-cvsimport
-git-cvsserver
-git-daemon
-git-diff
-git-diff-files
-git-diff-index
-git-diff-tree
-git-difftool
-git-difftool--helper
-git-describe
-git-fast-export
-git-fast-import
-git-fetch
-git-fetch--tool
-git-fetch-pack
-git-filter-branch
-git-fmt-merge-msg
-git-for-each-ref
-git-format-patch
-git-fsck
-git-fsck-objects
-git-gc
-git-get-tar-commit-id
-git-grep
-git-hash-object
-git-help
-git-http-fetch
-git-http-push
-git-imap-send
-git-index-pack
-git-init
-git-init-db
-git-instaweb
-git-log
-git-lost-found
-git-ls-files
-git-ls-remote
-git-ls-tree
-git-mailinfo
-git-mailsplit
-git-merge
-git-merge-base
-git-merge-index
-git-merge-file
-git-merge-tree
-git-merge-octopus
-git-merge-one-file
-git-merge-ours
-git-merge-recursive
-git-merge-resolve
-git-merge-subtree
-git-mergetool
-git-mergetool--lib
-git-mktag
-git-mktree
-git-name-rev
-git-mv
-git-pack-redundant
-git-pack-objects
-git-pack-refs
-git-parse-remote
-git-patch-id
-git-peek-remote
-git-prune
-git-prune-packed
-git-pull
-git-push
-git-quiltimport
-git-read-tree
-git-rebase
-git-rebase--interactive
-git-receive-pack
-git-reflog
-git-relink
-git-remote
-git-remote-curl
-git-repack
-git-replace
-git-repo-config
-git-request-pull
-git-rerere
-git-reset
-git-rev-list
-git-rev-parse
-git-revert
-git-rm
-git-send-email
-git-send-pack
-git-sh-setup
-git-shell
-git-shortlog
-git-show
-git-show-branch
-git-show-index
-git-show-ref
-git-stage
-git-stash
-git-status
-git-stripspace
-git-submodule
-git-svn
-git-symbolic-ref
-git-tag
-git-tar-tree
-git-unpack-file
-git-unpack-objects
-git-update-index
-git-update-ref
-git-update-server-info
-git-upload-archive
-git-upload-pack
-git-var
-git-verify-pack
-git-verify-tag
-git-web--browse
-git-whatchanged
-git-write-tree
-git-core-*/?*
-gitk-wish
-gitweb/gitweb.cgi
-test-chmtime
-test-ctype
-test-date
-test-delta
-test-dump-cache-tree
-test-genrandom
-test-match-trees
-test-parse-options
-test-path-utils
-test-sha1
-test-sigchain
-common-cmds.h
+/GIT-BUILD-OPTIONS
+/GIT-CFLAGS
+/GIT-GUI-VARS
+/GIT-VERSION-FILE
+/git
+/git-add
+/git-add--interactive
+/git-am
+/git-annotate
+/git-apply
+/git-archimport
+/git-archive
+/git-bisect
+/git-bisect--helper
+/git-blame
+/git-branch
+/git-bundle
+/git-cat-file
+/git-check-attr
+/git-check-ref-format
+/git-checkout
+/git-checkout-index
+/git-cherry
+/git-cherry-pick
+/git-clean
+/git-clone
+/git-commit
+/git-commit-tree
+/git-config
+/git-count-objects
+/git-cvsexportcommit
+/git-cvsimport
+/git-cvsserver
+/git-daemon
+/git-diff
+/git-diff-files
+/git-diff-index
+/git-diff-tree
+/git-difftool
+/git-difftool--helper
+/git-describe
+/git-fast-export
+/git-fast-import
+/git-fetch
+/git-fetch--tool
+/git-fetch-pack
+/git-filter-branch
+/git-fmt-merge-msg
+/git-for-each-ref
+/git-format-patch
+/git-fsck
+/git-fsck-objects
+/git-gc
+/git-get-tar-commit-id
+/git-grep
+/git-hash-object
+/git-help
+/git-http-fetch
+/git-http-push
+/git-imap-send
+/git-index-pack
+/git-init
+/git-init-db
+/git-instaweb
+/git-log
+/git-lost-found
+/git-ls-files
+/git-ls-remote
+/git-ls-tree
+/git-mailinfo
+/git-mailsplit
+/git-merge
+/git-merge-base
+/git-merge-index
+/git-merge-file
+/git-merge-tree
+/git-merge-octopus
+/git-merge-one-file
+/git-merge-ours
+/git-merge-recursive
+/git-merge-resolve
+/git-merge-subtree
+/git-mergetool
+/git-mergetool--lib
+/git-mktag
+/git-mktree
+/git-name-rev
+/git-mv
+/git-pack-redundant
+/git-pack-objects
+/git-pack-refs
+/git-parse-remote
+/git-patch-id
+/git-peek-remote
+/git-prune
+/git-prune-packed
+/git-pull
+/git-push
+/git-quiltimport
+/git-read-tree
+/git-rebase
+/git-rebase--interactive
+/git-receive-pack
+/git-reflog
+/git-relink
+/git-remote
+/git-remote-curl
+/git-repack
+/git-replace
+/git-repo-config
+/git-request-pull
+/git-rerere
+/git-reset
+/git-rev-list
+/git-rev-parse
+/git-revert
+/git-rm
+/git-send-email
+/git-send-pack
+/git-sh-setup
+/git-shell
+/git-shortlog
+/git-show
+/git-show-branch
+/git-show-index
+/git-show-ref
+/git-stage
+/git-stash
+/git-status
+/git-stripspace
+/git-submodule
+/git-svn
+/git-symbolic-ref
+/git-tag
+/git-tar-tree
+/git-unpack-file
+/git-unpack-objects
+/git-update-index
+/git-update-ref
+/git-update-server-info
+/git-upload-archive
+/git-upload-pack
+/git-var
+/git-verify-pack
+/git-verify-tag
+/git-web--browse
+/git-whatchanged
+/git-write-tree
+/git-core-*/?*
+/gitk-git/gitk-wish
+/gitweb/gitweb.cgi
+/test-chmtime
+/test-ctype
+/test-date
+/test-delta
+/test-dump-cache-tree
+/test-genrandom
+/test-match-trees
+/test-parse-options
+/test-path-utils
+/test-sha1
+/test-sigchain
+/common-cmds.h
 *.tar.gz
 *.dsc
 *.deb
-git.spec
+/git.spec
 *.exe
 *.[aos]
 *.py[co]
-config.mak
-autom4te.cache
-config.cache
-config.log
-config.status
-config.mak.autogen
-config.mak.append
-configure
-tags
-TAGS
-cscope*
+/config.mak
+/autom4te.cache
+/config.cache
+/config.log
+/config.status
+/config.mak.autogen
+/config.mak.append
+/configure
+/tags
+/TAGS
+/cscope*
 *.obj
 *.lib
 *.sln
@@ -188,5 +188,5 @@ cscope*
 *.user
 *.idb
 *.pdb
-Debug/
-Release/
+/Debug/
+/Release/
-- 
1.6.5.1.203.g342e8
