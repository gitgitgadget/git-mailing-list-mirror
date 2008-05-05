From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] Pay attention to GIT_DIR when searching the git directory
Date: Mon,  5 May 2008 02:09:38 +0200
Message-ID: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jjengla@sandia.gov,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 02:12:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsoJv-0007wq-Qp
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 02:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbYEEAL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 20:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYEEAL4
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 20:11:56 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2605 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbYEEALz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 20:11:55 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 2AB92488034; Mon,  5 May 2008 02:11:54 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JsoGw-0000OG-VK; Mon, 05 May 2008 02:09:39 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JsoGw-0007eW-M0; Mon, 05 May 2008 02:09:38 +0200
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81212>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 contrib/hooks/setgitperms.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms=
=2Eperl
index dab7c8e..0b1bcf2 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -51,7 +51,7 @@ if ((@ARGV < 0) || !GetOptions(
 die $usage unless ($read_mode xor $write_mode);
=20
 my $topdir =3D `git-rev-parse --show-cdup` or die "\n"; chomp $topdir;
-my $gitdir =3D $topdir . '.git';
+my $gitdir =3D $ENV{GIT_DIR} || $topdir . '.git';
 my $gitmeta =3D $topdir . '.gitmeta';
=20
 if ($write_mode) {
--=20
1.5.5.1
