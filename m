From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/4] ZIP test fixes
Date: Sun, 06 Jan 2013 18:45:17 +0100
Message-ID: <50E9B82D.50005@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 18:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TruI0-00071L-Az
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 18:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab3AFRpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 12:45:21 -0500
Received: from india601.server4you.de ([85.25.151.105]:37101 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab3AFRpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 12:45:20 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id 0874B193;
	Sun,  6 Jan 2013 18:45:18 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212826>

=46ix a bug in two scripts that call unzip, use the opportunity for a s=
mall
cleanup, move all ZIP related tests out of t5000 and finally skip testi=
ng
symlinks if unzip doesn't support them.

The first one allows running t5000 with the unzip from pkgsrc manually =
on
NetBSD, which succeeds.  The last one -- together with the archive-zip
streaming patch I sent earlier today -- makes the ZIP tests succeed on
that platform out of the box.

Ren=E9


  t0024, t5000: clear variable UNZIP, use GIT_UNZIP instead
  t0024, t5000: use test_lazy_prereq for UNZIP
  t5000, t5002: move ZIP tests into their own script
  t5002: check if unzip supports symlinks

 t/t0024-crlf-archive.sh      |  16 +++---
 t/t5000-tar-tree.sh          |  71 -----------------------
 t/t5002-archive-zip.sh       | 131 +++++++++++++++++++++++++++++++++++=
++++++++
 t/t5002/infozip-symlinks.zip | Bin 0 -> 328 bytes
 t/test-lib.sh                |   2 +
 5 files changed, 140 insertions(+), 80 deletions(-)
 create mode 100755 t/t5002-archive-zip.sh
 create mode 100644 t/t5002/infozip-symlinks.zip

--=20
1.7.12
