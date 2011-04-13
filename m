From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] remove doubled words, e.g., s/to to/to/, and fix related typos
Date: Wed, 13 Apr 2011 17:39:40 +0200
Message-ID: <87d3kq6tz7.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 17:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA2Ad-0001PZ-1c
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 17:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab1DMPjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 11:39:49 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:56480 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754173Ab1DMPjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 11:39:48 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7F86D9403DE
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 17:39:42 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 04A90601A1; Wed, 13 Apr 2011 17:39:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171462>

I found that some doubled words had snuck back into projects from
which I'd already removed them, so now there's a "syntax-check" makefile
rule in gnulib to help prevent recurrence.  Running the command below
spotted a few in git, too:

This patch is relative to "next".

>From d21d6f61bbeeba4a754cdcded66ca86a709695ee Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 13 Apr 2011 17:34:44 +0200
Subject: [PATCH] remove doubled words, e.g., s/to to/to/, and fix related
 typos

Run this command to identify suspects:
git ls-files | xargs perl -0777 -n \
  -e 'while (/\b(then?|[iao]n|i[fst]|but|f?or|at|and|[dt])\s+\1\b/gims)' \
  -e '{$n=($` =~ tr/\n/\n/ + 1); ($v=$&)=~s/\n/\\n/g;' \
  -e 'print "$ARGV:$n:$v\n"}'
* Documentation/SubmittingPatches: Remove doubled "to".
* Documentation/git-fetch.txt: Remove doubled "or".
* Documentation/git-pack-objects.txt: Remove doubled "it".
* compat/mingw.c: Likewise.
* compat/nedmalloc/malloc.c.h: Change "an an" to "as an".
Remove doubled "is" and "or".
* gitweb/README: Change "Is is" to "This is".
* sha1_file.c: Remove doubled "at" in comment.
* vcs-svn/trp.txt: Remove doubled "if".

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/SubmittingPatches    |    3 +--
 Documentation/git-fetch.txt        |    2 +-
 Documentation/git-pack-objects.txt |    2 +-
 compat/mingw.c                     |    2 +-
 compat/nedmalloc/malloc.c.h        |   10 ++++------
 gitweb/README                      |    2 +-
 sha1_file.c                        |    2 +-
 vcs-svn/trp.txt                    |    2 +-
 8 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c3b0816..c6a5032 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -276,7 +276,7 @@ don't hide your real name.

 If you like, you can put extra tags at the end:

-1. "Reported-by:" is used to to credit someone who found the bug that
+1. "Reported-by:" is used to credit someone who found the bug that
    the patch attempts to fix.
 2. "Acked-by:" says that the person who is more familiar with the area
    the patch attempts to modify liked the patch.
@@ -608,4 +608,3 @@ following commands:
 Just make sure to disable line wrapping in the email client (GMail web
 interface will line wrap no matter what, so you need to use a real
 IMAP client).
-
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 67d2214..60ac8d2 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -34,7 +34,7 @@ pointed by remote tags that it does not yet have, then fetch
 those missing tags.  If the other end has tags that point at
 branches you are not interested in, you will not get them.

-'git fetch' can fetch from either a single named repository, or
+'git fetch' can fetch from either a single named repository,
 or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 08c89d2..20c8551 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -115,7 +115,7 @@ base-name::

 --honor-pack-keep::
 	This flag causes an object already in a local pack that
-	has a .keep file to be ignored, even if it it would have
+	has a .keep file to be ignored, even if it would have
 	otherwise been packed.

 --incremental::
diff --git a/compat/mingw.c b/compat/mingw.c
index 878b1de..4423961 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1130,7 +1130,7 @@ char **make_augmented_environ(const char *const *vars)

 /*
  * Note, this isn't a complete replacement for getaddrinfo. It assumes
- * that service contains a numerical port, or that it it is null. It
+ * that service contains a numerical port, or that it is null. It
  * does a simple search using gethostbyname, and returns one IPv4 host
  * if one was found.
  */
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 87260d2..ff7c2c4 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -100,7 +100,7 @@

        If you don't like either of these options, you can define
        CORRUPTION_ERROR_ACTION and USAGE_ERROR_ACTION to do anything
-       else. And if if you are sure that your program using malloc has
+       else. And if you are sure that your program using malloc has
        no errors or vulnerabilities, you can define INSECURE to 1,
        which might (or might not) provide a small performance improvement.

@@ -2279,12 +2279,12 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   of the same size are arranged in a circularly-linked list, with only
   the oldest chunk (the next to be used, in our FIFO ordering)
   actually in the tree.  (Tree members are distinguished by a non-null
-  parent pointer.)  If a chunk with the same size an an existing node
+  parent pointer.)  If a chunk with the same size as an existing node
   is inserted, it is linked off the existing node using pointers that
   work in the same way as fd/bk pointers of small chunks.

   Each tree contains a power of 2 sized range of chunk sizes (the
-  smallest is 0x100 <= x < 0x180), which is is divided in half at each
+  smallest is 0x100 <= x < 0x180), which is divided in half at each
   tree level, with the chunks in the smaller half of the range (0x100
   <= x < 0x140 for the top nose) in the left subtree and the larger
   half (0x140 <= x < 0x180) in the right subtree.  This is, of course,
@@ -3943,7 +3943,7 @@ static void* sys_alloc(mstate m, size_t nb) {
     least-preferred order):
     1. A call to MORECORE that can normally contiguously extend memory.
        (disabled if not MORECORE_CONTIGUOUS or not HAVE_MORECORE or
-       or main space is mmapped or a previous contiguous call failed)
+       main space is mmapped or a previous contiguous call failed)
     2. A call to MMAP new space (disabled if not HAVE_MMAP).
        Note that under the default settings, if MORECORE is unable to
        fulfill a request, and HAVE_MMAP is true, then mmap is
@@ -5748,5 +5748,3 @@ History:
 	 structure of old version,  but most details differ.)

 */
-
-
diff --git a/gitweb/README b/gitweb/README
index 4a67393..a92bde7 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -29,7 +29,7 @@ You can specify the following configuration variables when building GIT:
    The filesystem traversing limit for getting the project list; the number
    is taken as depth relative to the projectroot.  It is used when
    GITWEB_LIST is a directory (or is not set; then project root is used).
-   Is is meant to speed up project listing on large work trees by limiting
+   This is meant to speed up project listing on large work trees by limiting
    search depth.  [Default: 2007]
  * GITWEB_LIST
    Points to a directory to scan for projects (defaults to project root
diff --git a/sha1_file.c b/sha1_file.c
index df0edba..889fe71 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1534,7 +1534,7 @@ static int unpack_object_header(struct packed_git *p,
 	enum object_type type;

 	/* use_pack() assures us we have [base, base + 20) available
-	 * as a range that we can look at at.  (Its actually the hash
+	 * as a range that we can look at.  (Its actually the hash
 	 * size that is assured.)  With our object header encoding
 	 * the maximum deflated object size is 2^137, which is just
 	 * insane, so we know won't exceed what we have been given.
diff --git a/vcs-svn/trp.txt b/vcs-svn/trp.txt
index 5ca6b42..177ebca 100644
--- a/vcs-svn/trp.txt
+++ b/vcs-svn/trp.txt
@@ -96,7 +96,7 @@ node_type *foo_search(struct trp_root \*treap, node_type \*key)::

 node_type *foo_nsearch(struct trp_root \*treap, node_type \*key)::

-	Like `foo_search`, but if if the key is missing return what
+	Like `foo_search`, but if the key is missing return what
 	would be key's successor, were key in treap (NULL if no
 	successor).

--
1.7.5.rc1.228.g86d60b
