From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 2/6] t/send-email: test suppress-cc=self on cccmd
Date: Tue, 4 Jun 2013 10:56:05 +0300
Message-ID: <1370332482-12329-3-git-send-email-mst@redhat.com>
References: <1370332482-12329-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 09:55:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujm5j-0004Dk-7v
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760055Ab3FDHzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 03:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15298 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759368Ab3FDHzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 03:55:32 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r547tVGF003231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 4 Jun 2013 03:55:31 -0400
Received: from redhat.com (vpn-203-14.tlv.redhat.com [10.35.203.14])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r547tTRw019542;
	Tue, 4 Jun 2013 03:55:30 -0400
Content-Disposition: inline
In-Reply-To: <1370332482-12329-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226325>

Check that suppress-cc=self works when applied
to output of cccmd.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e1a7f3e..f81e5f5 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -204,13 +204,15 @@ test_suppress_self_unquoted () {
 
 		unquoted-$3
 
+		cccmd--$1 <$2>
+
 		Cc: $1 <$2>
 		Signed-off-by: $1 <$2>
 	EOF
 }
 
 test_expect_success $PREREQ 'self name is suppressed' "
-	test_suppress_self_unquoted 'A U Thor' 'author@redhat.com' \
+	test_suppress_self_unquoted 'A U Thor' 'author@example.com' \
 		'self_name_suppressed'
 "
 
-- 
MST
