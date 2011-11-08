From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Update install-doc-quick (Re* What's cooking in git.git (Nov
 2011, #02; Sun, 6))
Date: Tue, 08 Nov 2011 13:34:46 -0800
Message-ID: <7vbosmxpqh.fsf@alter.siamese.dyndns.org>
References: <7vehxl57lt.fsf@alter.siamese.dyndns.org>
 <4EB91D2C.6020504@atlas-elektronik.com>
 <7v8vnqzitb.fsf@alter.siamese.dyndns.org>
 <7vr51ixyuz.fsf_-_@alter.siamese.dyndns.org>
 <loom.20111108T215341-107@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 22:34:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNtJn-00085i-Ao
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 22:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab1KHVeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 16:34:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab1KHVeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 16:34:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 158345A77;
	Tue,  8 Nov 2011 16:34:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=muMTgsfgzTba33cOG9aPKR2Lkt8=; b=KsLQBY
	seMUqLROzJUgLxES3dtM84lE6VRwvj8/wz3m2Rs4cCJcFbdPgunaLUAtQFq99r86
	dGlykIFpXEuswgeIzOzAwVb5DPECvH/Tg5qZvlSCSiZ0WaGdWxWgkLkeIc/J3BKW
	n69WlIM5cmFAP5jDNx7fHDfmy0c+w+3L0aDbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dBZdpkiCyU1hat5rX79fmhPtehk8Qn0Y
	by0E6YR/5RrlZ/U4ZqDWMuXuD9DKm4KuCYugiIO88nKR2oQNA9/g6JlpZid/Rf76
	MUI8Jw+9qUjwn7Z2Ld3MTStqvJwQYjcj79nD5Kz+pmg+c/kTJ2s4isDTu6+kRlVd
	HkEYu9c8Cok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CF1F5A75;
	Tue,  8 Nov 2011 16:34:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 323725A74; Tue,  8 Nov 2011
 16:34:48 -0500 (EST)
In-Reply-To: <loom.20111108T215341-107@post.gmane.org> (Stefan Naewe's
 message of "Tue, 8 Nov 2011 20:59:30 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BB8C432-0A51-11E1-8E0F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185113>

Thanks.

-- >8 --
Subject: [PATCH] docs: Update install-doc-quick

The preformatted documentation pages live in their own repositories
these days. Adjust the installation procedure to the updated layout.

Tested-by: Stefan Naewe <stefan.naewe@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile             |   23 ++++++++++++++-----
 Documentation/install-doc-quick.sh |   44 +++++++++++++++++++++--------------
 INSTALL                            |   29 ++---------------------
 3 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6346a75..5a340fd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -46,8 +46,8 @@ MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
 INSTALL?=install
 RM ?= rm -f
-DOC_REF = origin/man
-HTML_REF = origin/html
+MAN_REPO = ../../git-manpages
+HTML_REPO = ../../git-htmldocs
 
 infodir?=$(prefix)/share/info
 MAKEINFO=makeinfo
@@ -327,12 +327,23 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
 
+# You must have a clone of git-htmldocs and git-manpages repositories
+# next to the git repository itself for the following to work.
+
 quick-install: quick-install-man
 
-quick-install-man:
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)
+require-manrepo::
+	@if test ! -d $(MAN_REPO); \
+	then echo "git-manpages repository must exist at $(MAN_REPO)"; exit 1; fi
+
+quick-install-man: require-manrepo
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir)
+
+require-htmlrepo::
+	@if test ! -d $(HTML_REPO); \
+	then echo "git-htmldocs repository must exist at $(HTML_REPO)"; exit 1; fi
 
-quick-install-html:
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
+quick-install-html: require-htmlrepo
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir)
 
 .PHONY: FORCE
diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index 35f4408..327f69b 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -1,31 +1,39 @@
 #!/bin/sh
-# This requires a branch named in $head
-# (usually 'man' or 'html', provided by the git.git repository)
-set -e
-head="$1"
-mandir="$2"
-SUBDIRECTORY_OK=t
-USAGE='<refname> <target directory>'
-. "$(git --exec-path)"/git-sh-setup
-cd_to_toplevel
+# This requires git-manpages and/or git-htmldocs repositories
 
-test -z "$mandir" && usage
-if ! git rev-parse --verify "$head^0" >/dev/null; then
-	echo >&2 "head: $head does not exist in the current repository"
-	usage
+repository=${1?repository}
+destdir=${2?destination}
+
+head=master GIT_DIR=
+for d in "$repository/.git" "$repository"
+do
+	if GIT_DIR="$d" git rev-parse refs/heads/master >/dev/null 2>&1
+	then
+		GIT_DIR="$d"
+		export GIT_DIR
+		break
+	fi
+done
+
+if test -z "$GIT_DIR"
+then
+	echo >&2 "Neither $repository nor $repository/.git is a repository"
+	exit 1
 fi
 
-GIT_INDEX_FILE=`pwd`/.quick-doc.index
-export GIT_INDEX_FILE
+GIT_WORK_TREE=$(pwd)
+GIT_INDEX_FILE=$(pwd)/.quick-doc.$$
+export GIT_INDEX_FILE GIT_WORK_TREE
 rm -f "$GIT_INDEX_FILE"
 trap 'rm -f "$GIT_INDEX_FILE"' 0
 
 git read-tree $head
-git checkout-index -a -f --prefix="$mandir"/
+git checkout-index -a -f --prefix="$destdir"/
 
-if test -n "$GZ"; then
+if test -n "$GZ"
+then
 	git ls-tree -r --name-only $head |
-	xargs printf "$mandir/%s\n" |
+	xargs printf "$destdir/%s\n" |
 	xargs gzip -f
 fi
 rm -f "$GIT_INDEX_FILE"
diff --git a/INSTALL b/INSTALL
index bbb9d4d..bf0d97e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,34 +139,11 @@ Issues of note:
    uses some compatibility wrappers to work on AsciiDoc 8. If you have
    AsciiDoc 7, try "make ASCIIDOC7=YesPlease".
 
-   Alternatively, pre-formatted documentation is available in
-   "html" and "man" branches of the git repository itself.  For
-   example, you could:
-
-	$ mkdir manual && cd manual
-	$ git init
-	$ git fetch-pack git://git.kernel.org/pub/scm/git/git.git man html |
-	  while read a b
-	  do
-	    echo $a >.git/$b
-	  done
-	$ cp .git/refs/heads/man .git/refs/heads/master
-	$ git checkout
-
-   to checkout the pre-built man pages.  Also in this repository:
-
-	$ git checkout html
-
-   would instead give you a copy of what you see at:
-
-	http://www.kernel.org/pub/software/scm/git/docs/
-
    There are also "make quick-install-doc", "make quick-install-man"
    and "make quick-install-html" which install preformatted man pages
-   and html documentation.
-   This does not require asciidoc/xmlto, but it only works from within
-   a cloned checkout of git.git with these two extra branches, and will
-   not work for the maintainer for obvious chicken-and-egg reasons.
+   and html documentation. To use these build targets, you need to
+   clone two separate git-htmldocs and git-manpages repositories next
+   to the clone of git itself.
 
    It has been reported that docbook-xsl version 1.72 and 1.73 are
    buggy; 1.72 misformats manual pages for callouts, and 1.73 needs
-- 
1.7.8.rc1.82.g90e080
