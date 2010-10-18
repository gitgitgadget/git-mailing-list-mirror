From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] t0003: properly quote $HOME
Date: Mon, 18 Oct 2010 11:09:54 +0200
Message-ID: <b280c19ddc25f2f3a76d1871ed79906663daa802.1287392872.git.trast@student.ethz.ch>
References: <201010172134.43983.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	Petr Onderka <gsvick@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 11:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ljN-0004SX-21
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 11:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab0JRJJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 05:09:59 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:59774 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab0JRJJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 05:09:56 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 18 Oct
 2010 11:09:56 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 18 Oct
 2010 11:09:55 +0200
X-Mailer: git-send-email 1.7.3.1.270.gbc760
In-Reply-To: <201010172134.43983.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159241>

6df42ab (Add global and system-wide gitattributes, 2010-09-01) forgot
to quote one instance of $HOME in the tests.  This would be valid
according to POSIX, but bash 4 helpfully declines to execute the
command in question with an "ambiguous redirection" error.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Changed the commit message to state the actual reason.

 t/t0003-attributes.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 25205ac..e75153b 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup' '
 	) >a/b/.gitattributes
 	(
 		echo "global test=global"
-	) >$HOME/global-gitattributes
+	) >"$HOME"/global-gitattributes
 
 '
 
-- 
1.7.3.1.270.gbc760
