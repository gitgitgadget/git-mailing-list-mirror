From: Peter Foley <pefoley2@verizon.net>
Subject: [PATCH/RFC] Move contents of libgit.a to lib subdirectory
Date: Sun, 19 Jun 2011 20:50:58 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 02:53:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYSja-00079y-GT
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 02:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980Ab1FTAwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 20:52:51 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:41000 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1FTAwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 20:52:50 -0400
Received: from linux ([unknown] [108.28.47.43]) by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LN2000YXD3BBP02@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 19 Jun 2011 19:52:29 -0500 (CDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176042>

This patch tries to organize the git source tree by moving the files which 
make up libgit.a to a lib subdirectory.
Before this patch the toplevel source directory contained 285 files. 
After this patch the root directory will contain 167 files and 
the lib subdirectory will contain 119 files

Signed-off-by: Peter Foley <pefoley2@verizon.net>
---
 Makefile                                     |  258 +++++++++++++-------------
 abspath.c => lib/abspath.c                   |    0
 advice.c => lib/advice.c                     |    0
 alias.c => lib/alias.c                       |    0
 alloc.c => lib/alloc.c                       |    0
 archive-tar.c => lib/archive-tar.c           |    0
 archive-zip.c => lib/archive-zip.c           |    0
 archive.c => lib/archive.c                   |    0
 attr.c => lib/attr.c                         |    0
 base85.c => lib/base85.c                     |    0
 bisect.c => lib/bisect.c                     |    0
 blob.c => lib/blob.c                         |    0
 branch.c => lib/branch.c                     |    0
 bundle.c => lib/bundle.c                     |    0
 cache-tree.c => lib/cache-tree.c             |    0
 color.c => lib/color.c                       |    0
 combine-diff.c => lib/combine-diff.c         |    0
 commit.c => lib/commit.c                     |    0
 config.c => lib/config.c                     |    0
 connect.c => lib/connect.c                   |    0
 convert.c => lib/convert.c                   |    0
 copy.c => lib/copy.c                         |    0
 csum-file.c => lib/csum-file.c               |    0
 ctype.c => lib/ctype.c                       |    0
 date.c => lib/date.c                         |    0
 decorate.c => lib/decorate.c                 |    0
 diff-delta.c => lib/diff-delta.c             |    0
 diff-lib.c => lib/diff-lib.c                 |    0
 diff-no-index.c => lib/diff-no-index.c       |    0
 diff.c => lib/diff.c                         |    0
 diffcore-break.c => lib/diffcore-break.c     |    0
 diffcore-delta.c => lib/diffcore-delta.c     |    0
 diffcore-order.c => lib/diffcore-order.c     |    0
 diffcore-pickaxe.c => lib/diffcore-pickaxe.c |    0
 diffcore-rename.c => lib/diffcore-rename.c   |    0
 dir.c => lib/dir.c                           |    0
 editor.c => lib/editor.c                     |    0
 entry.c => lib/entry.c                       |    0
 environment.c => lib/environment.c           |    0
 exec_cmd.c => lib/exec_cmd.c                 |    0
 fsck.c => lib/fsck.c                         |    0
 gettext.c => lib/gettext.c                   |    0
 graph.c => lib/graph.c                       |    0
 grep.c => lib/grep.c                         |    0
 hash.c => lib/hash.c                         |    0
 help.c => lib/help.c                         |    0
 hex.c => lib/hex.c                           |    0
 ident.c => lib/ident.c                       |    0
 levenshtein.c => lib/levenshtein.c           |    0
 list-objects.c => lib/list-objects.c         |    0
 ll-merge.c => lib/ll-merge.c                 |    0
 lockfile.c => lib/lockfile.c                 |    0
 log-tree.c => lib/log-tree.c                 |    0
 mailmap.c => lib/mailmap.c                   |    0
 match-trees.c => lib/match-trees.c           |    0
 merge-file.c => lib/merge-file.c             |    0
 merge-recursive.c => lib/merge-recursive.c   |    0
 name-hash.c => lib/name-hash.c               |    0
 notes-cache.c => lib/notes-cache.c           |    0
 notes-merge.c => lib/notes-merge.c           |    0
 notes.c => lib/notes.c                       |    0
 object.c => lib/object.c                     |    0
 pack-check.c => lib/pack-check.c             |    0
 pack-refs.c => lib/pack-refs.c               |    0
 pack-revindex.c => lib/pack-revindex.c       |    0
 pack-write.c => lib/pack-write.c             |    0
 pager.c => lib/pager.c                       |    0
 parse-options.c => lib/parse-options.c       |    0
 patch-delta.c => lib/patch-delta.c           |    0
 patch-ids.c => lib/patch-ids.c               |    0
 path.c => lib/path.c                         |    0
 pkt-line.c => lib/pkt-line.c                 |    0
 preload-index.c => lib/preload-index.c       |    0
 pretty.c => lib/pretty.c                     |    0
 progress.c => lib/progress.c                 |    0
 quote.c => lib/quote.c                       |    0
 reachable.c => lib/reachable.c               |    0
 read-cache.c => lib/read-cache.c             |    0
 reflog-walk.c => lib/reflog-walk.c           |    0
 refs.c => lib/refs.c                         |    0
 remote.c => lib/remote.c                     |    0
 replace_object.c => lib/replace_object.c     |    0
 rerere.c => lib/rerere.c                     |    0
 resolve-undo.c => lib/resolve-undo.c         |    0
 revision.c => lib/revision.c                 |    0
 run-command.c => lib/run-command.c           |    0
 server-info.c => lib/server-info.c           |    0
 setup.c => lib/setup.c                       |    0
 sha1-array.c => lib/sha1-array.c             |    0
 sha1-lookup.c => lib/sha1-lookup.c           |    0
 sha1_file.c => lib/sha1_file.c               |    0
 sha1_name.c => lib/sha1_name.c               |    0
 shallow.c => lib/shallow.c                   |    0
 sideband.c => lib/sideband.c                 |    0
 sigchain.c => lib/sigchain.c                 |    0
 strbuf.c => lib/strbuf.c                     |    0
 string-list.c => lib/string-list.c           |    0
 submodule.c => lib/submodule.c               |    0
 symlinks.c => lib/symlinks.c                 |    0
 tag.c => lib/tag.c                           |    0
 thread-utils.c => lib/thread-utils.c         |    0
 trace.c => lib/trace.c                       |    0
 transport-helper.c => lib/transport-helper.c |    0
 transport.c => lib/transport.c               |    0
 tree-diff.c => lib/tree-diff.c               |    0
 tree-walk.c => lib/tree-walk.c               |    0
 tree.c => lib/tree.c                         |    0
 unpack-trees.c => lib/unpack-trees.c         |    0
 url.c => lib/url.c                           |    0
 usage.c => lib/usage.c                       |    0
 userdiff.c => lib/userdiff.c                 |    0
 utf8.c => lib/utf8.c                         |    0
 walker.c => lib/walker.c                     |    0
 wrapper.c => lib/wrapper.c                   |    0
 write_or_die.c => lib/write_or_die.c         |    0
 ws.c => lib/ws.c                             |    0
 wt-status.c => lib/wt-status.c               |    0
 xdiff-interface.c => lib/xdiff-interface.c   |    0
 zlib.c => lib/zlib.c                         |    0
 119 files changed, 129 insertions(+), 129 deletions(-)
 rename abspath.c => lib/abspath.c (100%)
 rename advice.c => lib/advice.c (100%)
 rename alias.c => lib/alias.c (100%)
 rename alloc.c => lib/alloc.c (100%)
 rename archive-tar.c => lib/archive-tar.c (100%)
 rename archive-zip.c => lib/archive-zip.c (100%)
 rename archive.c => lib/archive.c (100%)
 rename attr.c => lib/attr.c (100%)
 rename base85.c => lib/base85.c (100%)
 rename bisect.c => lib/bisect.c (100%)
 rename blob.c => lib/blob.c (100%)
 rename branch.c => lib/branch.c (100%)
 rename bundle.c => lib/bundle.c (100%)
 rename cache-tree.c => lib/cache-tree.c (100%)
 rename color.c => lib/color.c (100%)
 rename combine-diff.c => lib/combine-diff.c (100%)
 rename commit.c => lib/commit.c (100%)
 rename config.c => lib/config.c (100%)
 rename connect.c => lib/connect.c (100%)
 rename convert.c => lib/convert.c (100%)
 rename copy.c => lib/copy.c (100%)
 rename csum-file.c => lib/csum-file.c (100%)
 rename ctype.c => lib/ctype.c (100%)
 rename date.c => lib/date.c (100%)
 rename decorate.c => lib/decorate.c (100%)
 rename diff-delta.c => lib/diff-delta.c (100%)
 rename diff-lib.c => lib/diff-lib.c (100%)
 rename diff-no-index.c => lib/diff-no-index.c (100%)
 rename diff.c => lib/diff.c (100%)
 rename diffcore-break.c => lib/diffcore-break.c (100%)
 rename diffcore-delta.c => lib/diffcore-delta.c (100%)
 rename diffcore-order.c => lib/diffcore-order.c (100%)
 rename diffcore-pickaxe.c => lib/diffcore-pickaxe.c (100%)
 rename diffcore-rename.c => lib/diffcore-rename.c (100%)
 rename dir.c => lib/dir.c (100%)
 rename editor.c => lib/editor.c (100%)
 rename entry.c => lib/entry.c (100%)
 rename environment.c => lib/environment.c (100%)
 rename exec_cmd.c => lib/exec_cmd.c (100%)
 rename fsck.c => lib/fsck.c (100%)
 rename gettext.c => lib/gettext.c (100%)
 rename graph.c => lib/graph.c (100%)
 rename grep.c => lib/grep.c (100%)
 rename hash.c => lib/hash.c (100%)
 rename help.c => lib/help.c (100%)
 rename hex.c => lib/hex.c (100%)
 rename ident.c => lib/ident.c (100%)
 rename levenshtein.c => lib/levenshtein.c (100%)
 rename list-objects.c => lib/list-objects.c (100%)
 rename ll-merge.c => lib/ll-merge.c (100%)
 rename lockfile.c => lib/lockfile.c (100%)
 rename log-tree.c => lib/log-tree.c (100%)
 rename mailmap.c => lib/mailmap.c (100%)
 rename match-trees.c => lib/match-trees.c (100%)
 rename merge-file.c => lib/merge-file.c (100%)
 rename merge-recursive.c => lib/merge-recursive.c (100%)
 rename name-hash.c => lib/name-hash.c (100%)
 rename notes-cache.c => lib/notes-cache.c (100%)
 rename notes-merge.c => lib/notes-merge.c (100%)
 rename notes.c => lib/notes.c (100%)
 rename object.c => lib/object.c (100%)
 rename pack-check.c => lib/pack-check.c (100%)
 rename pack-refs.c => lib/pack-refs.c (100%)
 rename pack-revindex.c => lib/pack-revindex.c (100%)
 rename pack-write.c => lib/pack-write.c (100%)
 rename pager.c => lib/pager.c (100%)
 rename parse-options.c => lib/parse-options.c (100%)
 rename patch-delta.c => lib/patch-delta.c (100%)
 rename patch-ids.c => lib/patch-ids.c (100%)
 rename path.c => lib/path.c (100%)
 rename pkt-line.c => lib/pkt-line.c (100%)
 rename preload-index.c => lib/preload-index.c (100%)
 rename pretty.c => lib/pretty.c (100%)
 rename progress.c => lib/progress.c (100%)
 rename quote.c => lib/quote.c (100%)
 rename reachable.c => lib/reachable.c (100%)
 rename read-cache.c => lib/read-cache.c (100%)
 rename reflog-walk.c => lib/reflog-walk.c (100%)
 rename refs.c => lib/refs.c (100%)
 rename remote.c => lib/remote.c (100%)
 rename replace_object.c => lib/replace_object.c (100%)
 rename rerere.c => lib/rerere.c (100%)
 rename resolve-undo.c => lib/resolve-undo.c (100%)
 rename revision.c => lib/revision.c (100%)
 rename run-command.c => lib/run-command.c (100%)
 rename server-info.c => lib/server-info.c (100%)
 rename setup.c => lib/setup.c (100%)
 rename sha1-array.c => lib/sha1-array.c (100%)
 rename sha1-lookup.c => lib/sha1-lookup.c (100%)
 rename sha1_file.c => lib/sha1_file.c (100%)
 rename sha1_name.c => lib/sha1_name.c (100%)
 rename shallow.c => lib/shallow.c (100%)
 rename sideband.c => lib/sideband.c (100%)
 rename sigchain.c => lib/sigchain.c (100%)
 rename strbuf.c => lib/strbuf.c (100%)
 rename string-list.c => lib/string-list.c (100%)
 rename submodule.c => lib/submodule.c (100%)
 rename symlinks.c => lib/symlinks.c (100%)
 rename tag.c => lib/tag.c (100%)
 rename thread-utils.c => lib/thread-utils.c (100%)
 rename trace.c => lib/trace.c (100%)
 rename transport-helper.c => lib/transport-helper.c (100%)
 rename transport.c => lib/transport.c (100%)
 rename tree-diff.c => lib/tree-diff.c (100%)
 rename tree-walk.c => lib/tree-walk.c (100%)
 rename tree.c => lib/tree.c (100%)
 rename unpack-trees.c => lib/unpack-trees.c (100%)
 rename url.c => lib/url.c (100%)
 rename usage.c => lib/usage.c (100%)
 rename userdiff.c => lib/userdiff.c (100%)
 rename utf8.c => lib/utf8.c (100%)
 rename walker.c => lib/walker.c (100%)
 rename wrapper.c => lib/wrapper.c (100%)
 rename write_or_die.c => lib/write_or_die.c (100%)
 rename ws.c => lib/ws.c (100%)
 rename wt-status.c => lib/wt-status.c (100%)
 rename xdiff-interface.c => lib/xdiff-interface.c (100%)
 rename zlib.c => lib/zlib.c (100%)

diff --git a/Makefile b/Makefile
index e40ac0c..9982d2d 100644
--- a/Makefile
+++ b/Makefile
@@ -568,122 +568,122 @@ LIB_H += utf8.h
 LIB_H += xdiff-interface.h
 LIB_H += xdiff/xdiff.h
 
-LIB_OBJS += abspath.o
-LIB_OBJS += advice.o
-LIB_OBJS += alias.o
-LIB_OBJS += alloc.o
-LIB_OBJS += archive.o
-LIB_OBJS += archive-tar.o
-LIB_OBJS += archive-zip.o
-LIB_OBJS += attr.o
-LIB_OBJS += base85.o
-LIB_OBJS += bisect.o
-LIB_OBJS += blob.o
-LIB_OBJS += branch.o
-LIB_OBJS += bundle.o
-LIB_OBJS += cache-tree.o
-LIB_OBJS += color.o
-LIB_OBJS += combine-diff.o
-LIB_OBJS += commit.o
-LIB_OBJS += config.o
-LIB_OBJS += connect.o
-LIB_OBJS += convert.o
-LIB_OBJS += copy.o
-LIB_OBJS += csum-file.o
-LIB_OBJS += ctype.o
-LIB_OBJS += date.o
-LIB_OBJS += decorate.o
-LIB_OBJS += diffcore-break.o
-LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-order.o
-LIB_OBJS += diffcore-pickaxe.o
-LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += dir.o
-LIB_OBJS += editor.o
-LIB_OBJS += entry.o
-LIB_OBJS += environment.o
-LIB_OBJS += exec_cmd.o
-LIB_OBJS += fsck.o
-LIB_OBJS += graph.o
-LIB_OBJS += grep.o
-LIB_OBJS += hash.o
-LIB_OBJS += help.o
-LIB_OBJS += hex.o
-LIB_OBJS += ident.o
-LIB_OBJS += levenshtein.o
-LIB_OBJS += list-objects.o
-LIB_OBJS += ll-merge.o
-LIB_OBJS += lockfile.o
-LIB_OBJS += log-tree.o
-LIB_OBJS += mailmap.o
-LIB_OBJS += match-trees.o
-LIB_OBJS += merge-file.o
-LIB_OBJS += merge-recursive.o
-LIB_OBJS += name-hash.o
-LIB_OBJS += notes.o
-LIB_OBJS += notes-cache.o
-LIB_OBJS += notes-merge.o
-LIB_OBJS += object.o
-LIB_OBJS += pack-check.o
-LIB_OBJS += pack-refs.o
-LIB_OBJS += pack-revindex.o
-LIB_OBJS += pack-write.o
-LIB_OBJS += pager.o
-LIB_OBJS += parse-options.o
-LIB_OBJS += patch-delta.o
-LIB_OBJS += patch-ids.o
-LIB_OBJS += path.o
-LIB_OBJS += pkt-line.o
-LIB_OBJS += preload-index.o
-LIB_OBJS += pretty.o
-LIB_OBJS += progress.o
-LIB_OBJS += quote.o
-LIB_OBJS += reachable.o
-LIB_OBJS += read-cache.o
-LIB_OBJS += reflog-walk.o
-LIB_OBJS += refs.o
-LIB_OBJS += remote.o
-LIB_OBJS += replace_object.o
-LIB_OBJS += rerere.o
-LIB_OBJS += resolve-undo.o
-LIB_OBJS += revision.o
-LIB_OBJS += run-command.o
-LIB_OBJS += server-info.o
-LIB_OBJS += setup.o
-LIB_OBJS += sha1-array.o
-LIB_OBJS += sha1-lookup.o
-LIB_OBJS += sha1_file.o
-LIB_OBJS += sha1_name.o
-LIB_OBJS += shallow.o
-LIB_OBJS += sideband.o
-LIB_OBJS += sigchain.o
-LIB_OBJS += strbuf.o
-LIB_OBJS += string-list.o
-LIB_OBJS += submodule.o
-LIB_OBJS += symlinks.o
-LIB_OBJS += tag.o
-LIB_OBJS += trace.o
-LIB_OBJS += transport.o
-LIB_OBJS += transport-helper.o
-LIB_OBJS += tree-diff.o
-LIB_OBJS += tree.o
-LIB_OBJS += tree-walk.o
-LIB_OBJS += unpack-trees.o
-LIB_OBJS += url.o
-LIB_OBJS += usage.o
-LIB_OBJS += userdiff.o
-LIB_OBJS += utf8.o
-LIB_OBJS += walker.o
-LIB_OBJS += wrapper.o
-LIB_OBJS += write_or_die.o
-LIB_OBJS += ws.o
-LIB_OBJS += wt-status.o
-LIB_OBJS += xdiff-interface.o
-LIB_OBJS += zlib.o
+LIB_OBJS += lib/abspath.o
+LIB_OBJS += lib/advice.o
+LIB_OBJS += lib/alias.o
+LIB_OBJS += lib/alloc.o
+LIB_OBJS += lib/archive.o
+LIB_OBJS += lib/archive-tar.o
+LIB_OBJS += lib/archive-zip.o
+LIB_OBJS += lib/attr.o
+LIB_OBJS += lib/base85.o
+LIB_OBJS += lib/bisect.o
+LIB_OBJS += lib/blob.o
+LIB_OBJS += lib/branch.o
+LIB_OBJS += lib/bundle.o
+LIB_OBJS += lib/cache-tree.o
+LIB_OBJS += lib/color.o
+LIB_OBJS += lib/combine-diff.o
+LIB_OBJS += lib/commit.o
+LIB_OBJS += lib/config.o
+LIB_OBJS += lib/connect.o
+LIB_OBJS += lib/convert.o
+LIB_OBJS += lib/copy.o
+LIB_OBJS += lib/csum-file.o
+LIB_OBJS += lib/ctype.o
+LIB_OBJS += lib/date.o
+LIB_OBJS += lib/decorate.o
+LIB_OBJS += lib/diffcore-break.o
+LIB_OBJS += lib/diffcore-delta.o
+LIB_OBJS += lib/diffcore-order.o
+LIB_OBJS += lib/diffcore-pickaxe.o
+LIB_OBJS += lib/diffcore-rename.o
+LIB_OBJS += lib/diff-delta.o
+LIB_OBJS += lib/diff-lib.o
+LIB_OBJS += lib/diff-no-index.o
+LIB_OBJS += lib/diff.o
+LIB_OBJS += lib/dir.o
+LIB_OBJS += lib/editor.o
+LIB_OBJS += lib/entry.o
+LIB_OBJS += lib/environment.o
+LIB_OBJS += lib/exec_cmd.o
+LIB_OBJS += lib/fsck.o
+LIB_OBJS += lib/graph.o
+LIB_OBJS += lib/grep.o
+LIB_OBJS += lib/hash.o
+LIB_OBJS += lib/help.o
+LIB_OBJS += lib/hex.o
+LIB_OBJS += lib/ident.o
+LIB_OBJS += lib/levenshtein.o
+LIB_OBJS += lib/list-objects.o
+LIB_OBJS += lib/ll-merge.o
+LIB_OBJS += lib/lockfile.o
+LIB_OBJS += lib/log-tree.o
+LIB_OBJS += lib/mailmap.o
+LIB_OBJS += lib/match-trees.o
+LIB_OBJS += lib/merge-file.o
+LIB_OBJS += lib/merge-recursive.o
+LIB_OBJS += lib/name-hash.o
+LIB_OBJS += lib/notes.o
+LIB_OBJS += lib/notes-cache.o
+LIB_OBJS += lib/notes-merge.o
+LIB_OBJS += lib/object.o
+LIB_OBJS += lib/pack-check.o
+LIB_OBJS += lib/pack-refs.o
+LIB_OBJS += lib/pack-revindex.o
+LIB_OBJS += lib/pack-write.o
+LIB_OBJS += lib/pager.o
+LIB_OBJS += lib/parse-options.o
+LIB_OBJS += lib/patch-delta.o
+LIB_OBJS += lib/patch-ids.o
+LIB_OBJS += lib/path.o
+LIB_OBJS += lib/pkt-line.o
+LIB_OBJS += lib/preload-index.o
+LIB_OBJS += lib/pretty.o
+LIB_OBJS += lib/progress.o
+LIB_OBJS += lib/quote.o
+LIB_OBJS += lib/reachable.o
+LIB_OBJS += lib/read-cache.o
+LIB_OBJS += lib/reflog-walk.o
+LIB_OBJS += lib/refs.o
+LIB_OBJS += lib/remote.o
+LIB_OBJS += lib/replace_object.o
+LIB_OBJS += lib/rerere.o
+LIB_OBJS += lib/resolve-undo.o
+LIB_OBJS += lib/revision.o
+LIB_OBJS += lib/run-command.o
+LIB_OBJS += lib/server-info.o
+LIB_OBJS += lib/setup.o
+LIB_OBJS += lib/sha1-array.o
+LIB_OBJS += lib/sha1-lookup.o
+LIB_OBJS += lib/sha1_file.o
+LIB_OBJS += lib/sha1_name.o
+LIB_OBJS += lib/shallow.o
+LIB_OBJS += lib/sideband.o
+LIB_OBJS += lib/sigchain.o
+LIB_OBJS += lib/strbuf.o
+LIB_OBJS += lib/string-list.o
+LIB_OBJS += lib/submodule.o
+LIB_OBJS += lib/symlinks.o
+LIB_OBJS += lib/tag.o
+LIB_OBJS += lib/trace.o
+LIB_OBJS += lib/transport.o
+LIB_OBJS += lib/transport-helper.o
+LIB_OBJS += lib/tree-diff.o
+LIB_OBJS += lib/tree.o
+LIB_OBJS += lib/tree-walk.o
+LIB_OBJS += lib/unpack-trees.o
+LIB_OBJS += lib/url.o
+LIB_OBJS += lib/usage.o
+LIB_OBJS += lib/userdiff.o
+LIB_OBJS += lib/utf8.o
+LIB_OBJS += lib/walker.o
+LIB_OBJS += lib/wrapper.o
+LIB_OBJS += lib/write_or_die.o
+LIB_OBJS += lib/ws.o
+LIB_OBJS += lib/wt-status.o
+LIB_OBJS += lib/xdiff-interface.o
+LIB_OBJS += lib/zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/annotate.o
@@ -1389,7 +1389,7 @@ ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
 ifdef GETTEXT_POISON
-	LIB_OBJS += gettext.o
+	LIB_OBJS += lib/gettext.o
 	BASIC_CFLAGS += -DGETTEXT_POISON
 endif
 ifdef NO_STRCASESTR
@@ -1547,7 +1547,7 @@ ifdef NO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
-	LIB_OBJS += thread-utils.o
+	LIB_OBJS += lib/thread-utils.o
 endif
 
 ifdef HAVE_PATHS_H
@@ -1710,7 +1710,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.sp help.o: common-cmds.h
+lib/help.sp lib/help.o: common-cmds.h
 
 builtin/help.sp builtin/help.o: common-cmds.h
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
@@ -1973,7 +1973,7 @@ $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 test-svn-fe.o: vcs-svn/svndump.h
 endif
 
-exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
+lib/exec_cmd.sp lib/exec_cmd.s lib/exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
@@ -1981,10 +1981,10 @@ exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.sp config.s config.o: EXTRA_CPPFLAGS = \
+lib/config.sp lib/config.s lib/config.o: EXTRA_CPPFLAGS = \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
+lib/attr.sp lib/attr.s lib/attr.o: EXTRA_CPPFLAGS = \
 	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
 http.sp http.s http.o: EXTRA_CPPFLAGS = \
@@ -2011,10 +2011,10 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
+git-http-fetch$X: lib/revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
-git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
+git-http-push$X: lib/revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2149,15 +2149,15 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
-test-ctype$X: ctype.o
+test-ctype$X: lib/ctype.o
 
-test-date$X: date.o ctype.o
+test-date$X: lib/date.o lib/ctype.o
 
-test-delta$X: diff-delta.o patch-delta.o
+test-delta$X: lib/diff-delta.o lib/patch-delta.o
 
 test-line-buffer$X: vcs-svn/lib.a
 
-test-parse-options$X: parse-options.o
+test-parse-options$X: lib/parse-options.o
 
 test-string-pool$X: vcs-svn/lib.a
 
@@ -2350,7 +2350,7 @@ distclean: clean
 
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
-		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+		builtin/*.o lib/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
diff --git a/abspath.c b/lib/abspath.c
similarity index 100%
rename from abspath.c
rename to lib/abspath.c
diff --git a/advice.c b/lib/advice.c
similarity index 100%
rename from advice.c
rename to lib/advice.c
diff --git a/alias.c b/lib/alias.c
similarity index 100%
rename from alias.c
rename to lib/alias.c
diff --git a/alloc.c b/lib/alloc.c
similarity index 100%
rename from alloc.c
rename to lib/alloc.c
diff --git a/archive-tar.c b/lib/archive-tar.c
similarity index 100%
rename from archive-tar.c
rename to lib/archive-tar.c
diff --git a/archive-zip.c b/lib/archive-zip.c
similarity index 100%
rename from archive-zip.c
rename to lib/archive-zip.c
diff --git a/archive.c b/lib/archive.c
similarity index 100%
rename from archive.c
rename to lib/archive.c
diff --git a/attr.c b/lib/attr.c
similarity index 100%
rename from attr.c
rename to lib/attr.c
diff --git a/base85.c b/lib/base85.c
similarity index 100%
rename from base85.c
rename to lib/base85.c
diff --git a/bisect.c b/lib/bisect.c
similarity index 100%
rename from bisect.c
rename to lib/bisect.c
diff --git a/blob.c b/lib/blob.c
similarity index 100%
rename from blob.c
rename to lib/blob.c
diff --git a/branch.c b/lib/branch.c
similarity index 100%
rename from branch.c
rename to lib/branch.c
diff --git a/bundle.c b/lib/bundle.c
similarity index 100%
rename from bundle.c
rename to lib/bundle.c
diff --git a/cache-tree.c b/lib/cache-tree.c
similarity index 100%
rename from cache-tree.c
rename to lib/cache-tree.c
diff --git a/color.c b/lib/color.c
similarity index 100%
rename from color.c
rename to lib/color.c
diff --git a/combine-diff.c b/lib/combine-diff.c
similarity index 100%
rename from combine-diff.c
rename to lib/combine-diff.c
diff --git a/commit.c b/lib/commit.c
similarity index 100%
rename from commit.c
rename to lib/commit.c
diff --git a/config.c b/lib/config.c
similarity index 100%
rename from config.c
rename to lib/config.c
diff --git a/connect.c b/lib/connect.c
similarity index 100%
rename from connect.c
rename to lib/connect.c
diff --git a/convert.c b/lib/convert.c
similarity index 100%
rename from convert.c
rename to lib/convert.c
diff --git a/copy.c b/lib/copy.c
similarity index 100%
rename from copy.c
rename to lib/copy.c
diff --git a/csum-file.c b/lib/csum-file.c
similarity index 100%
rename from csum-file.c
rename to lib/csum-file.c
diff --git a/ctype.c b/lib/ctype.c
similarity index 100%
rename from ctype.c
rename to lib/ctype.c
diff --git a/date.c b/lib/date.c
similarity index 100%
rename from date.c
rename to lib/date.c
diff --git a/decorate.c b/lib/decorate.c
similarity index 100%
rename from decorate.c
rename to lib/decorate.c
diff --git a/diff-delta.c b/lib/diff-delta.c
similarity index 100%
rename from diff-delta.c
rename to lib/diff-delta.c
diff --git a/diff-lib.c b/lib/diff-lib.c
similarity index 100%
rename from diff-lib.c
rename to lib/diff-lib.c
diff --git a/diff-no-index.c b/lib/diff-no-index.c
similarity index 100%
rename from diff-no-index.c
rename to lib/diff-no-index.c
diff --git a/diff.c b/lib/diff.c
similarity index 100%
rename from diff.c
rename to lib/diff.c
diff --git a/diffcore-break.c b/lib/diffcore-break.c
similarity index 100%
rename from diffcore-break.c
rename to lib/diffcore-break.c
diff --git a/diffcore-delta.c b/lib/diffcore-delta.c
similarity index 100%
rename from diffcore-delta.c
rename to lib/diffcore-delta.c
diff --git a/diffcore-order.c b/lib/diffcore-order.c
similarity index 100%
rename from diffcore-order.c
rename to lib/diffcore-order.c
diff --git a/diffcore-pickaxe.c b/lib/diffcore-pickaxe.c
similarity index 100%
rename from diffcore-pickaxe.c
rename to lib/diffcore-pickaxe.c
diff --git a/diffcore-rename.c b/lib/diffcore-rename.c
similarity index 100%
rename from diffcore-rename.c
rename to lib/diffcore-rename.c
diff --git a/dir.c b/lib/dir.c
similarity index 100%
rename from dir.c
rename to lib/dir.c
diff --git a/editor.c b/lib/editor.c
similarity index 100%
rename from editor.c
rename to lib/editor.c
diff --git a/entry.c b/lib/entry.c
similarity index 100%
rename from entry.c
rename to lib/entry.c
diff --git a/environment.c b/lib/environment.c
similarity index 100%
rename from environment.c
rename to lib/environment.c
diff --git a/exec_cmd.c b/lib/exec_cmd.c
similarity index 100%
rename from exec_cmd.c
rename to lib/exec_cmd.c
diff --git a/fsck.c b/lib/fsck.c
similarity index 100%
rename from fsck.c
rename to lib/fsck.c
diff --git a/gettext.c b/lib/gettext.c
similarity index 100%
rename from gettext.c
rename to lib/gettext.c
diff --git a/graph.c b/lib/graph.c
similarity index 100%
rename from graph.c
rename to lib/graph.c
diff --git a/grep.c b/lib/grep.c
similarity index 100%
rename from grep.c
rename to lib/grep.c
diff --git a/hash.c b/lib/hash.c
similarity index 100%
rename from hash.c
rename to lib/hash.c
diff --git a/help.c b/lib/help.c
similarity index 100%
rename from help.c
rename to lib/help.c
diff --git a/hex.c b/lib/hex.c
similarity index 100%
rename from hex.c
rename to lib/hex.c
diff --git a/ident.c b/lib/ident.c
similarity index 100%
rename from ident.c
rename to lib/ident.c
diff --git a/levenshtein.c b/lib/levenshtein.c
similarity index 100%
rename from levenshtein.c
rename to lib/levenshtein.c
diff --git a/list-objects.c b/lib/list-objects.c
similarity index 100%
rename from list-objects.c
rename to lib/list-objects.c
diff --git a/ll-merge.c b/lib/ll-merge.c
similarity index 100%
rename from ll-merge.c
rename to lib/ll-merge.c
diff --git a/lockfile.c b/lib/lockfile.c
similarity index 100%
rename from lockfile.c
rename to lib/lockfile.c
diff --git a/log-tree.c b/lib/log-tree.c
similarity index 100%
rename from log-tree.c
rename to lib/log-tree.c
diff --git a/mailmap.c b/lib/mailmap.c
similarity index 100%
rename from mailmap.c
rename to lib/mailmap.c
diff --git a/match-trees.c b/lib/match-trees.c
similarity index 100%
rename from match-trees.c
rename to lib/match-trees.c
diff --git a/merge-file.c b/lib/merge-file.c
similarity index 100%
rename from merge-file.c
rename to lib/merge-file.c
diff --git a/merge-recursive.c b/lib/merge-recursive.c
similarity index 100%
rename from merge-recursive.c
rename to lib/merge-recursive.c
diff --git a/name-hash.c b/lib/name-hash.c
similarity index 100%
rename from name-hash.c
rename to lib/name-hash.c
diff --git a/notes-cache.c b/lib/notes-cache.c
similarity index 100%
rename from notes-cache.c
rename to lib/notes-cache.c
diff --git a/notes-merge.c b/lib/notes-merge.c
similarity index 100%
rename from notes-merge.c
rename to lib/notes-merge.c
diff --git a/notes.c b/lib/notes.c
similarity index 100%
rename from notes.c
rename to lib/notes.c
diff --git a/object.c b/lib/object.c
similarity index 100%
rename from object.c
rename to lib/object.c
diff --git a/pack-check.c b/lib/pack-check.c
similarity index 100%
rename from pack-check.c
rename to lib/pack-check.c
diff --git a/pack-refs.c b/lib/pack-refs.c
similarity index 100%
rename from pack-refs.c
rename to lib/pack-refs.c
diff --git a/pack-revindex.c b/lib/pack-revindex.c
similarity index 100%
rename from pack-revindex.c
rename to lib/pack-revindex.c
diff --git a/pack-write.c b/lib/pack-write.c
similarity index 100%
rename from pack-write.c
rename to lib/pack-write.c
diff --git a/pager.c b/lib/pager.c
similarity index 100%
rename from pager.c
rename to lib/pager.c
diff --git a/parse-options.c b/lib/parse-options.c
similarity index 100%
rename from parse-options.c
rename to lib/parse-options.c
diff --git a/patch-delta.c b/lib/patch-delta.c
similarity index 100%
rename from patch-delta.c
rename to lib/patch-delta.c
diff --git a/patch-ids.c b/lib/patch-ids.c
similarity index 100%
rename from patch-ids.c
rename to lib/patch-ids.c
diff --git a/path.c b/lib/path.c
similarity index 100%
rename from path.c
rename to lib/path.c
diff --git a/pkt-line.c b/lib/pkt-line.c
similarity index 100%
rename from pkt-line.c
rename to lib/pkt-line.c
diff --git a/preload-index.c b/lib/preload-index.c
similarity index 100%
rename from preload-index.c
rename to lib/preload-index.c
diff --git a/pretty.c b/lib/pretty.c
similarity index 100%
rename from pretty.c
rename to lib/pretty.c
diff --git a/progress.c b/lib/progress.c
similarity index 100%
rename from progress.c
rename to lib/progress.c
diff --git a/quote.c b/lib/quote.c
similarity index 100%
rename from quote.c
rename to lib/quote.c
diff --git a/reachable.c b/lib/reachable.c
similarity index 100%
rename from reachable.c
rename to lib/reachable.c
diff --git a/read-cache.c b/lib/read-cache.c
similarity index 100%
rename from read-cache.c
rename to lib/read-cache.c
diff --git a/reflog-walk.c b/lib/reflog-walk.c
similarity index 100%
rename from reflog-walk.c
rename to lib/reflog-walk.c
diff --git a/refs.c b/lib/refs.c
similarity index 100%
rename from refs.c
rename to lib/refs.c
diff --git a/remote.c b/lib/remote.c
similarity index 100%
rename from remote.c
rename to lib/remote.c
diff --git a/replace_object.c b/lib/replace_object.c
similarity index 100%
rename from replace_object.c
rename to lib/replace_object.c
diff --git a/rerere.c b/lib/rerere.c
similarity index 100%
rename from rerere.c
rename to lib/rerere.c
diff --git a/resolve-undo.c b/lib/resolve-undo.c
similarity index 100%
rename from resolve-undo.c
rename to lib/resolve-undo.c
diff --git a/revision.c b/lib/revision.c
similarity index 100%
rename from revision.c
rename to lib/revision.c
diff --git a/run-command.c b/lib/run-command.c
similarity index 100%
rename from run-command.c
rename to lib/run-command.c
diff --git a/server-info.c b/lib/server-info.c
similarity index 100%
rename from server-info.c
rename to lib/server-info.c
diff --git a/setup.c b/lib/setup.c
similarity index 100%
rename from setup.c
rename to lib/setup.c
diff --git a/sha1-array.c b/lib/sha1-array.c
similarity index 100%
rename from sha1-array.c
rename to lib/sha1-array.c
diff --git a/sha1-lookup.c b/lib/sha1-lookup.c
similarity index 100%
rename from sha1-lookup.c
rename to lib/sha1-lookup.c
diff --git a/sha1_file.c b/lib/sha1_file.c
similarity index 100%
rename from sha1_file.c
rename to lib/sha1_file.c
diff --git a/sha1_name.c b/lib/sha1_name.c
similarity index 100%
rename from sha1_name.c
rename to lib/sha1_name.c
diff --git a/shallow.c b/lib/shallow.c
similarity index 100%
rename from shallow.c
rename to lib/shallow.c
diff --git a/sideband.c b/lib/sideband.c
similarity index 100%
rename from sideband.c
rename to lib/sideband.c
diff --git a/sigchain.c b/lib/sigchain.c
similarity index 100%
rename from sigchain.c
rename to lib/sigchain.c
diff --git a/strbuf.c b/lib/strbuf.c
similarity index 100%
rename from strbuf.c
rename to lib/strbuf.c
diff --git a/string-list.c b/lib/string-list.c
similarity index 100%
rename from string-list.c
rename to lib/string-list.c
diff --git a/submodule.c b/lib/submodule.c
similarity index 100%
rename from submodule.c
rename to lib/submodule.c
diff --git a/symlinks.c b/lib/symlinks.c
similarity index 100%
rename from symlinks.c
rename to lib/symlinks.c
diff --git a/tag.c b/lib/tag.c
similarity index 100%
rename from tag.c
rename to lib/tag.c
diff --git a/thread-utils.c b/lib/thread-utils.c
similarity index 100%
rename from thread-utils.c
rename to lib/thread-utils.c
diff --git a/trace.c b/lib/trace.c
similarity index 100%
rename from trace.c
rename to lib/trace.c
diff --git a/transport-helper.c b/lib/transport-helper.c
similarity index 100%
rename from transport-helper.c
rename to lib/transport-helper.c
diff --git a/transport.c b/lib/transport.c
similarity index 100%
rename from transport.c
rename to lib/transport.c
diff --git a/tree-diff.c b/lib/tree-diff.c
similarity index 100%
rename from tree-diff.c
rename to lib/tree-diff.c
diff --git a/tree-walk.c b/lib/tree-walk.c
similarity index 100%
rename from tree-walk.c
rename to lib/tree-walk.c
diff --git a/tree.c b/lib/tree.c
similarity index 100%
rename from tree.c
rename to lib/tree.c
diff --git a/unpack-trees.c b/lib/unpack-trees.c
similarity index 100%
rename from unpack-trees.c
rename to lib/unpack-trees.c
diff --git a/url.c b/lib/url.c
similarity index 100%
rename from url.c
rename to lib/url.c
diff --git a/usage.c b/lib/usage.c
similarity index 100%
rename from usage.c
rename to lib/usage.c
diff --git a/userdiff.c b/lib/userdiff.c
similarity index 100%
rename from userdiff.c
rename to lib/userdiff.c
diff --git a/utf8.c b/lib/utf8.c
similarity index 100%
rename from utf8.c
rename to lib/utf8.c
diff --git a/walker.c b/lib/walker.c
similarity index 100%
rename from walker.c
rename to lib/walker.c
diff --git a/wrapper.c b/lib/wrapper.c
similarity index 100%
rename from wrapper.c
rename to lib/wrapper.c
diff --git a/write_or_die.c b/lib/write_or_die.c
similarity index 100%
rename from write_or_die.c
rename to lib/write_or_die.c
diff --git a/ws.c b/lib/ws.c
similarity index 100%
rename from ws.c
rename to lib/ws.c
diff --git a/wt-status.c b/lib/wt-status.c
similarity index 100%
rename from wt-status.c
rename to lib/wt-status.c
diff --git a/xdiff-interface.c b/lib/xdiff-interface.c
similarity index 100%
rename from xdiff-interface.c
rename to lib/xdiff-interface.c
diff --git a/zlib.c b/lib/zlib.c
similarity index 100%
rename from zlib.c
rename to lib/zlib.c
-- 
1.7.5.3
