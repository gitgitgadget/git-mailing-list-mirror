From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] correct a few doubled-word nits in comments and documentation
Date: Wed, 28 Mar 2012 10:45:36 +0200
Message-ID: <87d37xun9r.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 10:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCoVp-0004N9-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 10:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005Ab2C1Ipp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 04:45:45 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:34684 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab2C1Ipo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 04:45:44 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5ADFDD4800D
	for <git@vger.kernel.org>; Wed, 28 Mar 2012 10:45:38 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id DFF9A60056
	for <git@vger.kernel.org>; Wed, 28 Mar 2012 10:45:36 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194112>


Found by running this command:
$ git ls-files -z|xargs -0 perl -0777 -n \
 -e 'while (/\b(then?|[iao]n|i[fst]|but|f?or|at|and|[dt]o)\s+\1\b/gims)' \
 -e '  {' \
 -e '    $n = ($` =~ tr/\n/\n/ + 1);' \
 -e '    ($v = $&) =~ s/\n/\\n/g;' \
 -e '    print "$ARGV:$n:$v\n";' \
 -e '  }'

Why not just git grep -E ...?
That wouldn't work then the doubled words are separated by a newline.
This is derived from a Makefile syntax-check rule in gnulib's maint.mk:
  http://git.sv.gnu.org/cgit/gnulib.git/tree/top/maint.mk

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/git-sh-i18n--envsubst.txt |    2 +-
 attr.h                                  |    2 +-
 gitweb/static/js/lib/cookies.js         |    2 +-
 po/README                               |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/git-sh-i18n--envsubst.txt
index 5c3ec32..2ffaf93 100644
--- a/Documentation/git-sh-i18n--envsubst.txt
+++ b/Documentation/git-sh-i18n--envsubst.txt
@@ -25,7 +25,7 @@ plumbing scripts and/or are writing new ones.
 'git sh-i18n{litdd}envsubst' is Git's stripped-down copy of the GNU
 `envsubst(1)` program that comes with the GNU gettext package. It's
 used internally by linkgit:git-sh-i18n[1] to interpolate the variables
-passed to the the `eval_gettext` function.
+passed to the `eval_gettext` function.

 No promises are made about the interface, or that this
 program won't disappear without warning in the next version
diff --git a/attr.h b/attr.h
index eb8ca0d..dea590a 100644
--- a/attr.h
+++ b/attr.h
@@ -40,7 +40,7 @@ int git_check_attr(const char *path, int, struct git_attr_check *);

 /*
  * Retrieve all attributes that apply to the specified path.  *num
- * will be set the the number of attributes on the path; **check will
+ * will be set the number of attributes on the path; **check will
  * be set to point at a newly-allocated array of git_attr_check
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
diff --git a/gitweb/static/js/lib/cookies.js b/gitweb/static/js/lib/cookies.js
index 72b51cd..66b9a07 100644
--- a/gitweb/static/js/lib/cookies.js
+++ b/gitweb/static/js/lib/cookies.js
@@ -30,7 +30,7 @@
  *                            If a negative value is specified or a date in the past),
  *                            the cookie will be deleted.
  *                            If set to null or omitted, the cookie will be a session cookie
- *                            and will not be retained when the the browser exits.
+ *                            and will not be retained when the browser exits.
  * @param {String} [options.path] Restrict access of a cookie to particular directory
  *                               (default: path of page that created the cookie).
  * @param {String} [options.domain] Override what web sites are allowed to access cookie
diff --git a/po/README b/po/README
index 188ea2c..c1520e8 100644
--- a/po/README
+++ b/po/README
@@ -178,7 +178,7 @@ used:

 C:

- - Include builtin.h at the top, it'll pull in in gettext.h, which
+ - Include builtin.h at the top, it'll pull in gettext.h, which
    defines the gettext interface. Consult with the list if you need to
    use gettext.h directly.

--
1.7.9.3


>From e887bda34232bd3cfb63f6a65e534fa14cfa42ca Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 28 Mar 2012 10:34:28 +0200
Subject: [PATCH 2/2] correct spelling: an URL -> a URL


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/git-submodule.txt             |    2 +-
 Documentation/gitmodules.txt                |    4 ++--
 Documentation/howto/using-merge-subtree.txt |    2 +-
 contrib/svn-fe/svn-fe.txt                   |    2 +-
 http.c                                      |    2 +-
 http.h                                      |    2 +-
 perl/Git.pm                                 |    2 +-
 transport.c                                 |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b729649..c243ee5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -190,7 +190,7 @@ commit for each submodule.
 sync::
 	Synchronizes submodules' remote URL configuration setting
 	to the value specified in .gitmodules. It will only affect those
-	submodules which already have an url entry in .git/config (that is the
+	submodules which already have a URL entry in .git/config (that is the
 	case when they are initialized or freshly added). This is useful when
 	submodule URLs change upstream and you need to update your local
 	repositories accordingly.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 4040941..4e1fd52 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -28,7 +28,7 @@ submodule.<name>.path::
 	be unique within the .gitmodules file.

 submodule.<name>.url::
-	Defines an url from where the submodule repository can be cloned.
+	Defines a URL from which the submodule repository can be cloned.
 	This may be either an absolute URL ready to be passed to
 	linkgit:git-clone[1] or (if it begins with ./ or ../) a location
 	relative to the superproject's origin repository.
@@ -84,7 +84,7 @@ Consider the following .gitmodules file:

 This defines two submodules, `libfoo` and `libbar`. These are expected to
 be checked out in the paths 'include/foo' and 'include/bar', and for both
-submodules an url is specified which can be used for cloning the submodules.
+submodules a URL is specified which can be used for cloning the submodules.

 SEE ALSO
 --------
diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentation/howto/using-merge-subtree.txt
index 2933056..1ae8d12 100644
--- a/Documentation/howto/using-merge-subtree.txt
+++ b/Documentation/howto/using-merge-subtree.txt
@@ -25,7 +25,7 @@ What you want is the 'subtree' merge strategy, which helps you in such a
 situation.

 In this example, let's say you have the repository at `/path/to/B` (but
-it can be an URL as well, if you want). You want to merge the 'master'
+it can be a URL as well, if you want). You want to merge the 'master'
 branch of that repository to the `dir-B` subdirectory in your current
 branch.

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 2dd27ce..1128ab2 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -51,7 +51,7 @@ as committer, where 'user' is the value of the `svn:author` property
 and 'UUID' the repository's identifier.

 To support incremental imports, 'svn-fe' puts a `git-svn-id` line at
-the end of each commit log message if passed an url on the command
+the end of each commit log message if passed a URL on the command
 line.  This line has the form `git-svn-id: URL@REVNO UUID`.

 The resulting repository will generally require further processing
diff --git a/http.c b/http.c
index 8ac8eb6..f3f83d7 100644
--- a/http.c
+++ b/http.c
@@ -829,7 +829,7 @@ int http_get_strbuf(const char *url, struct strbuf *result, int options)
 }

 /*
- * Downloads an url and stores the result in the given file.
+ * Downloads a URL and stores the result in the given file.
  *
  * If a previous interrupted download is detected (i.e. a previous temporary
  * file is still around) the download is resumed.
diff --git a/http.h b/http.h
index 0b61653..915c286 100644
--- a/http.h
+++ b/http.h
@@ -127,7 +127,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 #define HTTP_NOAUTH	5

 /*
- * Requests an url and stores the result in a strbuf.
+ * Requests a URL and stores the result in a strbuf.
  *
  * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
  */
diff --git a/perl/Git.pm b/perl/Git.pm
index f7ce511..497f420 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -691,7 +691,7 @@ The hash is in the format C<refname =\> hash>. For tags, the C<refname> entry
 contains the tag object while a C<refname^{}> entry gives the tagged objects.

 C<REPOSITORY> has the same meaning as the appropriate C<git-ls-remote>
-argument; either an URL or a remote name (if called on a repository instance).
+argument; either a URL or a remote name (if called on a repository instance).
 C<GROUPS> is an optional arrayref that can contain 'tags' to return all the
 tags and/or 'heads' to return all the heads. C<REFGLOB> is an optional array
 of strings containing a shell-like glob to further limit the refs returned in
diff --git a/transport.c b/transport.c
index 181f8f2..ea9dcb6 100644
--- a/transport.c
+++ b/transport.c
@@ -1154,7 +1154,7 @@ int transport_disconnect(struct transport *transport)
 }

 /*
- * Strip username (and password) from an url and return
+ * Strip username (and password) from a URL and return
  * it in a newly allocated string.
  */
 char *transport_anonymize_url(const char *url)
--
1.7.9.3
