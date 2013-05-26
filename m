From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6/6] t/send-email: test suppress-cc=self with non-ascii
Date: Sun, 26 May 2013 17:41:11 +0300
Message-ID: <1369579187-27573-7-git-send-email-mst@redhat.com>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 16:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugc80-0000qg-As
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 16:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab3EZOkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 May 2013 10:40:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26461 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab3EZOkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 10:40:51 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4QEeplL032108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:51 -0400
Received: from redhat.com (vpn-202-184.tlv.redhat.com [10.35.202.184])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4QEeluD013766
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:49 -0400
Content-Disposition: inline
In-Reply-To: <1369579187-27573-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225550>

test suppress-cc=3Dself when sender is non-acsii

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0ab4056..66ebb1e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -232,6 +232,10 @@ test_expect_success $PREREQ 'quoted self name is s=
uppressed' "
 	test_suppress_self_quoted 'A U. Thor' 'author@redhat.com' 'self_name_=
suppressed'
 "
=20
+test_expect_success $PREREQ 'non-ascii self name is suppressed' "
+	test_suppress_self_quoted 'F=FC=F1n=FD N=E2m=E9' 'odd_?=3Dmail@exampl=
e.com' 'non_ascii_self_suppressed'
+"
+
 test_expect_success $PREREQ 'Show all headers' '
 	git send-email \
 		--dry-run \
--=20
MST
