From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Add a makefile rule to regenerate .gitignore from the make variables.
Date: Tue, 11 Dec 2007 10:24:29 +0100
Message-ID: <20071211092429.GE30948@artemis.madism.org>
References: <20071211092101.GD30948@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8vCeF2GUdMpe9ZbK";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 10:25:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J21MC-00013C-Si
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 10:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXLKJYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 04:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbXLKJYc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 04:24:32 -0500
Received: from pan.madism.org ([88.191.52.104]:34731 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbXLKJYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 04:24:31 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 45A812F4D5
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 10:24:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A96D57088; Tue, 11 Dec 2007 10:24:29 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071211092101.GD30948@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67830>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  This allow that the commands that moved away, were renamed, or the new
commands gets added in a simple fashion.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    This is an alternative patch that aims at solving the problem at once,
    running "make ignore" or "make .gitignore" will regenerate the list of
    commands and test programs and add it in a sorted way at the end.

 .gitignore |   60 +++++++++++++++++++++++++++-----------------------------=
----
 Makefile   |    7 +++++++
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5eaba41..52cb353 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,28 @@
 GIT-CFLAGS
 GIT-GUI-VARS
 GIT-VERSION-FILE
+git-core-*/?*
+gitk-wish
+common-cmds.h
+*.tar.gz
+*.dsc
+*.deb
+git.spec
+*.exe
+*.[aos]
+*.py[co]
+config.mak
+autom4te.cache
+config.cache
+config.log
+config.status
+config.mak.autogen
+config.mak.append
+configure
+tags
+TAGS
+cscope*
+### Automatic ignore list
 git
 git-add
 git-add--interactive
@@ -31,18 +53,17 @@ git-cvsexportcommit
 git-cvsimport
 git-cvsserver
 git-daemon
+git-describe
 git-diff
 git-diff-files
 git-diff-index
 git-diff-tree
-git-describe
 git-fast-export
 git-fast-import
 git-fetch
 git-fetch--tool
 git-fetch-pack
 git-filter-branch
-git-findtags
 git-fmt-merge-msg
 git-for-each-ref
 git-format-patch
@@ -59,7 +80,6 @@ git-index-pack
 git-init
 git-init-db
 git-instaweb
-git-local-fetch
 git-log
 git-lost-found
 git-ls-files
@@ -69,9 +89,8 @@ git-mailinfo
 git-mailsplit
 git-merge
 git-merge-base
-git-merge-index
 git-merge-file
-git-merge-tree
+git-merge-index
 git-merge-octopus
 git-merge-one-file
 git-merge-ours
@@ -79,13 +98,14 @@ git-merge-recursive
 git-merge-resolve
 git-merge-stupid
 git-merge-subtree
+git-merge-tree
 git-mergetool
 git-mktag
 git-mktree
-git-name-rev
 git-mv
-git-pack-redundant
+git-name-rev
 git-pack-objects
+git-pack-redundant
 git-pack-refs
 git-parse-remote
 git-patch-id
@@ -120,10 +140,6 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
-git-ssh-fetch
-git-ssh-pull
-git-ssh-push
-git-ssh-upload
 git-stash
 git-status
 git-stripspace
@@ -144,34 +160,12 @@ git-verify-pack
 git-verify-tag
 git-whatchanged
 git-write-tree
-git-core-*/?*
-gitk-wish
 gitweb/gitweb.cgi
 test-absolute-path
 test-chmtime
 test-date
 test-delta
-test-dump-cache-tree
 test-genrandom
 test-match-trees
 test-parse-options
 test-sha1
-common-cmds.h
-*.tar.gz
-*.dsc
-*.deb
-git.spec
-*.exe
-*.[aos]
-*.py[co]
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
diff --git a/Makefile b/Makefile
index ccc9f3c..50c8b9a 100644
--- a/Makefile
+++ b/Makefile
@@ -946,6 +946,13 @@ $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/=
xdiff.h xdiff/xtypes.h \
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
=20
+.gitignore: Makefile
+	$(QUIET_GEN)$(RM) $@+ && ( \
+	    sed -e '/^### Automatic ignore list$$/q' $@ \
+	    $(foreach p,$(sort $(OTHER_PROGRAMS) $(ALL_PROGRAMS) $(BUILT_INS)),&&=
 echo $p) \
+	    $(foreach t,$(sort $(TEST_PROGRAMS)),&& echo $t) \
+	) > $@+ && mv $@+ $@
+ignore: .gitignore
=20
 doc:
 	$(MAKE) -C Documentation all
--=20
1.5.3.7.2224.gb695b


--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXldNvGr7W6HudhwRAqg4AKCa9dB3BUovaO/hJkSIlGGZ9aP6bwCcDqoE
w+ldAHVcPFEpWlRsgh10XTI=
=9Na2
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
