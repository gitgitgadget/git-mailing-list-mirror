From: Junio C Hamano <gitster@pobox.com>
Subject: Update install-doc-quick (Re* What's cooking in git.git (Nov 2011,
 #02; Sun, 6))
Date: Tue, 08 Nov 2011 10:17:40 -0800
Message-ID: <7vr51ixyuz.fsf_-_@alter.siamese.dyndns.org>
References: <7vehxl57lt.fsf@alter.siamese.dyndns.org>
 <4EB91D2C.6020504@atlas-elektronik.com>
 <7v8vnqzitb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 19:17:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNqF6-0004GE-US
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 19:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436Ab1KHSRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 13:17:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34767 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140Ab1KHSRr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 13:17:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 507635930;
	Tue,  8 Nov 2011 13:17:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oje0NqoySsls
	bOqVTtBIgmzeO7M=; b=l5nhb0+UpUEaDLMYs+pRklQrzx4/6B5bvBp2PvkrTgsx
	ik3H9o/0KhjE7X0I1fQdFulC1R1/6TyYqTJ7RDWENtlWaOwHGUvAQX5lMQbqSiV2
	2olP7gNNY3rk5TQ2qiQ/NkUTfKntJ/3q5crgYRkqAubIy26+RcfdESDYHKepaXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UbvaiN
	LHg/RjXntWZX2O8jX2haUXfhR/Jss93tvolYUBpsRI7VxV9jYiZ6pdQzyQKj8AUY
	7zefoM6rp1L0/7nsuvinvYS5zfJGpk+6XaOWbrRngNr10OcI9+ZgXOl2MBnWfjwt
	MfWZWSFGCqVJc553gFSiAa79rzxURc0uaUWz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4775B592F;
	Tue,  8 Nov 2011 13:17:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 911E3592E; Tue,  8 Nov 2011
 13:17:45 -0500 (EST)
In-Reply-To: <7v8vnqzitb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 08 Nov 2011 08:21:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4E58078-0A35-11E1-AA79-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185104>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:
>
>> This breaks the 'quick-install-{doc,html,man}' make targets, btw.
>
> Thanks. As the "push into kernel.org auto-rebuilds these branches"
> infrastructure is no longer available, I think we should remove these
> targets and description of them in the INSTALL file in the meantime.
>
> Anybody care to do a big removal patch?

Alternatively, we could keep it alive if people really want it, like th=
is.

Stefan, care to apply it on top of 'maint' and try it out?

 Documentation/Makefile             |   23 +++++++++++++++-----
 Documentation/install-doc-quick.sh |   40 +++++++++++++++++++++-------=
-------
 INSTALL                            |   29 ++-----------------------
 3 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6346a75..5a340fd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -46,8 +46,8 @@ MANPAGE_XSL =3D manpage-normal.xsl
 XMLTO_EXTRA =3D
 INSTALL?=3Dinstall
 RM ?=3D rm -f
-DOC_REF =3D origin/man
-HTML_REF =3D origin/html
+MAN_REPO =3D ../../git-manpages
+HTML_REPO =3D ../../git-htmldocs
=20
 infodir?=3D$(prefix)/share/info
 MAKEINFO=3Dmakeinfo
@@ -327,12 +327,23 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)):=
 %.html : %.txt
 install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
=20
+# You must have a clone of git-htmldocs and git-manpages repositories
+# next to the git repository itself for the following to work.
+
 quick-install: quick-install-man
=20
-quick-install-man:
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mand=
ir)
+require-manrepo::
+	@if test ! -d $(MAN_REPO); \
+	then echo "git-manpages repository must exist at $(MAN_REPO)"; exit 1=
; fi
+
+quick-install-man: require-manrepo
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(man=
dir)
+
+require-htmlrepo::
+	@if test ! -d $(HTML_REPO); \
+	then echo "git-htmldocs repository must exist at $(HTML_REPO)"; exit =
1; fi
=20
-quick-install-html:
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htm=
ldir)
+quick-install-html: require-htmlrepo
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(ht=
mldir)
=20
 .PHONY: FORCE
diff --git a/Documentation/install-doc-quick.sh b/Documentation/install=
-doc-quick.sh
index 35f4408..bbf0a21 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -1,29 +1,37 @@
 #!/bin/sh
-# This requires a branch named in $head
-# (usually 'man' or 'html', provided by the git.git repository)
-set -e
-head=3D"$1"
-mandir=3D"$2"
-SUBDIRECTORY_OK=3Dt
-USAGE=3D'<refname> <target directory>'
-. "$(git --exec-path)"/git-sh-setup
-cd_to_toplevel
+# This requires git-manpages and/or git-htmldocs repositories
=20
-test -z "$mandir" && usage
-if ! git rev-parse --verify "$head^0" >/dev/null; then
-	echo >&2 "head: $head does not exist in the current repository"
-	usage
+repository=3D${1?repository}
+destdir=3D${2?destination}
+
+head=3Dmaster GIT_DIR=3D
+for d in "$repository/.git" "$repository"
+do
+	if GIT_DIR=3D"$d" git rev-parse refs/heads/master >/dev/null 2>&1
+	then
+		GIT_DIR=3D"$d"
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
=20
-GIT_INDEX_FILE=3D`pwd`/.quick-doc.index
-export GIT_INDEX_FILE
+GIT_WORK_TREE=3D$(pwd)
+GIT_INDEX_FILE=3D$(pwd)/.quick-doc.$$
+export GIT_INDEX_FILE GIT_WORK_TREE
 rm -f "$GIT_INDEX_FILE"
 trap 'rm -f "$GIT_INDEX_FILE"' 0
=20
 git read-tree $head
 git checkout-index -a -f --prefix=3D"$mandir"/
=20
-if test -n "$GZ"; then
+if test -n "$GZ"
+then
 	git ls-tree -r --name-only $head |
 	xargs printf "$mandir/%s\n" |
 	xargs gzip -f
diff --git a/INSTALL b/INSTALL
index bbb9d4d..bf0d97e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,34 +139,11 @@ Issues of note:
    uses some compatibility wrappers to work on AsciiDoc 8. If you have
    AsciiDoc 7, try "make ASCIIDOC7=3DYesPlease".
=20
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
-   a cloned checkout of git.git with these two extra branches, and wil=
l
-   not work for the maintainer for obvious chicken-and-egg reasons.
+   and html documentation. To use these build targets, you need to
+   clone two separate git-htmldocs and git-manpages repositories next
+   to the clone of git itself.
=20
    It has been reported that docbook-xsl version 1.72 and 1.73 are
    buggy; 1.72 misformats manual pages for callouts, and 1.73 needs
