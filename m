From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/6] t5000: add test for pax extended header generation
Date: Mon, 20 May 2013 11:58:23 +0200
Message-ID: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 11:58:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeMrZ-0004MQ-Pk
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 11:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab3ETJ6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 05:58:36 -0400
Received: from india601.server4you.de ([85.25.151.105]:56477 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab3ETJ6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 05:58:35 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id 965C9FD
	for <git@vger.kernel.org>; Mon, 20 May 2013 11:58:33 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224944>

This series adds a test that exercises git archive's pax header code.
It checks for tar versions that don't support pax headers and works
around their deficiency.

The first five patches are cleanups and refactorings to centralize
tar calls into a helper function.  The last patch adds the workaround
at this central place and a file to the test archive whose name is too
long to fit into the path field of a standard tar header, making a pax
extended header necessary.

Ren=C3=A9 Scharfe (6):
  t5000: integrate export-subst tests into regular tests
  t5000, t5003: create directories for extracted files lazily
  t5000: factor out check_tar
  t5000: use check_tar for prefix test
  t5000: simplify tar-tree tests
  t5000: test long filenames

 t/t5000-tar-tree.sh    | 160 +++++++++++++++++++++++++----------------=
--------
 t/t5000/pax.tar        | Bin 0 -> 10240 bytes
 t/t5003-archive-zip.sh |   2 +-
 3 files changed, 84 insertions(+), 78 deletions(-)
 create mode 100644 t/t5000/pax.tar

--=20
1.8.2.3
