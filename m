From: Michal Rokos <rokos@nextsoft.cz>
Subject: [PATCH] Makefile: add NO_FNMATCH_CASEFOLD to HP-UX section
Date: Mon, 7 Mar 2011 12:43:11 +0100
Message-ID: <160568F4-412B-4D50-8CA8-01BF729E4012@nextsoft.cz>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 07 12:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwYyI-00015B-5n
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 12:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab1CGLvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 06:51:23 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:45836 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab1CGLvX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 06:51:23 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Mar 2011 06:51:23 EST
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 783562526; Mon,  7 Mar 2011 12:43:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 87F7422C9
	for <git@vger.kernel.org>; Mon,  7 Mar 2011 12:43:24 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4tL+IGXoJwj for <git@vger.kernel.org>;
	Mon,  7 Mar 2011 12:43:24 +0100 (CET)
Received: from [10.20.0.58] (unknown [10.20.0.58])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTPSA id 1208D71F
	for <git@vger.kernel.org>; Mon,  7 Mar 2011 12:43:19 +0100 (CET)
X-Mailer: Apple Mail (2.1082)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168574>

fnmatch() on HP-UX does not support the GNU FNM_CASEFOLD extension, so =
set NO_FNMATCH_CASEFOLD to use the internal fnmatch implementation.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/Makefile b/Makefile
index ade7923..5c2b797 100644
--- a/Makefile
+++ b/Makefile
@@ -1042,6 +1042,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV =3D YesPlease
 	NO_HSTRERROR =3D YesPlease
 	NO_SYS_SELECT_H =3D YesPlease
+	NO_FNMATCH_CASEFOLD =3D YesPlease
 	SNPRINTF_RETURNS_BOGUS =3D YesPlease
 	NO_NSEC =3D YesPlease
 	ifeq ($(uname_R),B.11.00)

--

Michal Rokos

NextSoft spol. s r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
Czech Republic
mobile: +420 736 646 591
fax:    +420 267 224 307
e-mail: rokos@nextsoft.cz
