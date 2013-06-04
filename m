From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 5/6] t/send-email: test suppress-cc=self with non-ascii
Date: Tue, 4 Jun 2013 10:56:15 +0300
Message-ID: <1370332482-12329-6-git-send-email-mst@redhat.com>
References: <1370332482-12329-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 09:56:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujm65-0004bK-JT
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760092Ab3FDHz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 03:55:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21260 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760082Ab3FDHzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 03:55:50 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r547thSF004319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 4 Jun 2013 03:55:43 -0400
Received: from redhat.com (vpn-203-14.tlv.redhat.com [10.35.203.14])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r547te5t011086;
	Tue, 4 Jun 2013 03:55:42 -0400
Content-Disposition: inline
In-Reply-To: <1370332482-12329-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226330>

test suppress-cc=3Dself when sender is non-acsii

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6c0f715..0d50fa7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -236,6 +236,11 @@ test_expect_success $PREREQ 'self name with dot is=
 suppressed' "
 		'self_name_dot_suppressed'
 "
=20
+test_expect_success $PREREQ 'non-ascii self name is suppressed' "
+	test_suppress_self_quoted 'F=FC=F1n=FD N=E2m=E9' 'odd_?=3Dmail@exampl=
e.com' \
+		'non_ascii_self_suppressed'
+"
+
 test_expect_success $PREREQ 'Show all headers' '
 	git send-email \
 		--dry-run \
--=20
MST
