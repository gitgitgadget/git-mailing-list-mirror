From: Kristof Provost <Kristof@provost-engineering.be>
Subject: [PATCH] makefile: Add a cscope target
Date: Sat, 6 Oct 2007 00:33:36 +0200
Message-ID: <20071005223336.GA4556@luggage>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 00:40:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idvqh-0002LM-ME
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 00:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761792AbXJEWkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762921AbXJEWkY
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 18:40:24 -0400
Received: from rhineheart.priorweb.be ([213.193.229.215]:44460 "HELO
	rhineheart.priorweb.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761792AbXJEWkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 18:40:23 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2007 18:40:23 EDT
Received: (qmail 26884 invoked by uid 1010); 5 Oct 2007 22:33:40 -0000
Received: from unknown (HELO rhineheart.priorweb.be) (127.0.0.1)
  by rhineheart.priorweb.be with SMTP; 5 Oct 2007 22:33:40 -0000
Received: from luggage (dD5767E05.access.telenet.be [213.118.126.5])
	by rhineheart.priorweb.be (Postfix) with SMTP
	for <git@vger.kernel.org>; Sat,  6 Oct 2007 00:33:37 +0200 (CEST)
Received: by luggage (sSMTP sendmail emulation); Sat, 06 Oct 2007 00:33:36 +0200
Content-Disposition: inline
X-PGP-Fingerprint: 6B6E 5EED 8ECF FAE7 1F61  7458 5046 7D0E 11B0 0EE8
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Virus-Scanned: Passed
X-Spam-Scanned: 2.0
X-Spam-Status: NO
X-Scanned-By: PriorWeb mailfilter
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60135>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current makefile supports ctags but not cscope. Some people prefer
cscope (I do), so this patch adds a cscope target.

Signed-off-by: Kristof Provost <Kristof@provost-engineering.be>

---
diff --git a/Makefile b/Makefile
index 8db4dbe..42c9e94 100644
--- a/Makefile
+++ b/Makefile
@@ -947,6 +947,10 @@ tags:
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
=20
+cscope:
+	$(RM) cscope*
+	$(FIND) . -name '*.hcS]' -print | xargs cscope -b
+
 ### Detect prefix changes
 TRACK_CFLAGS =3D $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
@@ -1093,7 +1097,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
-	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
+	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) configure config.log config.mak.autogen config.mak.append config.st=
atus config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
@@ -1111,7 +1115,7 @@ endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS
=20
 .PHONY: all install clean strip
-.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags .FORCE-GIT-CFLAGS
+.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS=20
=20
 ### Check documentation
 #


--
Kristof

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBrvAUEZ9DhGwDugRAt6mAJ4go3urIiIvRR1FgMjptbKiBsJTngCfXpM9
VTIcfx5J0novBVrqCaFQq3Q=
=4VWy
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
