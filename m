From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: [PATCH 2/2] gitk-git: have make uninstall also remove empty
 directories
Date: Tue, 08 Dec 2009 16:23:54 +0100
Organization: www.AvatarAcademy.nl
Message-ID: <1260285834.1856.53.camel@vuurvlieg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 16:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1v0-0000Km-0R
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 16:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbZLHPXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 10:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbZLHPXv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 10:23:51 -0500
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:59967 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbZLHPXt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 10:23:49 -0500
Received: from vuurvlieg (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id 9891E67AC0;
	Tue,  8 Dec 2009 16:23:55 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vuurvlieg (Postfix) with ESMTP id CD0C611C61F;
	Tue,  8 Dec 2009 16:23:54 +0100 (CET)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134888>

The default Git install performs a multi-rooted install in $HOME,
which makes manual removal somewhat cumbersome.

The directories created by the installation should be removed if
they are empty.

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 gitk-git/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..d68f19a 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -47,6 +47,8 @@ install:: all
 uninstall::
 	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(not=
dir $p) &&) true
 	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	-rmdir -p '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	-rmdir -p '$(DESTDIR_SQ)$(msgsdir_SQ)'
=20
 clean::
 	$(RM) gitk-wish po/*.msg
--=20
1.6.5.2.182.g1a756



--=20
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesett=
er
Avatar=C2=AE: http://AvatarAcademy.nl    | http://lilypond.org
