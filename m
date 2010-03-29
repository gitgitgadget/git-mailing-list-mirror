From: Holger =?utf-8?B?V2Vpw58=?= <holger@zedat.fu-berlin.de>
Subject: [PATCH] Link against libiconv on IRIX
Date: Mon, 29 Mar 2010 12:57:48 +0200
Organization: Freie =?utf-8?Q?Universit=C3=A4t?= Berlin
Message-ID: <20100329105748.GD14869@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 12:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwCfM-0000zv-Fw
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 12:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab0C2K5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 06:57:50 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:43709 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755295Ab0C2K5t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 06:57:49 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwCfF-0001YL-08>; Mon, 29 Mar 2010 12:57:49 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwCfE-0008U5-Sc>; Mon, 29 Mar 2010 12:57:48 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          for git@vger.kernel.org with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwCfE-00APHH-QY>; Mon, 29 Mar 2010 12:57:48 +0200
Mail-Followup-To: Git List <git@vger.kernel.org>
Content-Disposition: inline
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143454>

On IRIX, "-liconv" must be added to the linker command line in order to
get iconv(3) support; set the according Makefile variable appropriately=
=2E

Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 3a6c6ea..8a0f5c4 100644
--- a/Makefile
+++ b/Makefile
@@ -919,6 +919,7 @@ ifeq ($(uname_S),IRIX)
 	SNPRINTF_RETURNS_BOGUS =3D YesPlease
 	SHELL_PATH =3D /usr/gnu/bin/bash
 	NEEDS_LIBGEN =3D YesPlease
+	NEEDS_LIBICONV =3D YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
 	NO_SETENV=3DYesPlease
@@ -937,6 +938,7 @@ ifeq ($(uname_S),IRIX64)
 	SNPRINTF_RETURNS_BOGUS =3D YesPlease
 	SHELL_PATH=3D/usr/gnu/bin/bash
 	NEEDS_LIBGEN =3D YesPlease
+	NEEDS_LIBICONV =3D YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
 	NO_IPV6=3DYesPlease
--=20
1.7.0.3
