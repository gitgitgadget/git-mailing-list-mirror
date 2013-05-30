From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 6/6] t/send-email: test suppress-cc=self with non-ascii
Date: Thu, 30 May 2013 10:11:26 +0300
Message-ID: <1369897638-27299-7-git-send-email-mst@redhat.com>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 09:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhx0y-0003LS-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 09:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967773Ab3E3HLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 03:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37880 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967768Ab3E3HK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 03:10:59 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4U7AwN3031702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 30 May 2013 03:10:58 -0400
Received: from redhat.com (vpn-203-5.tlv.redhat.com [10.35.203.5])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4U7Aumf006832;
	Thu, 30 May 2013 03:10:56 -0400
Content-Disposition: inline
In-Reply-To: <1369897638-27299-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225941>

test suppress-cc=3Dself when sender is non-acsii

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 42fb809..430e8de 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -236,6 +236,11 @@ test_expect_success $PREREQ 'quoted self name is s=
uppressed' "
 		'self_name_suppressed'
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
