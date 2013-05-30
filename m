From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 3/6] t/send-email: test suppress-cc=self on cccmd
Date: Thu, 30 May 2013 10:11:18 +0300
Message-ID: <1369897638-27299-4-git-send-email-mst@redhat.com>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 09:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhx0k-000399-J9
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 09:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967763Ab3E3HKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 03:10:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967740Ab3E3HKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 03:10:50 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4U7AnTU024401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 30 May 2013 03:10:50 -0400
Received: from redhat.com (vpn-203-5.tlv.redhat.com [10.35.203.5])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4U7AlT3002588;
	Thu, 30 May 2013 03:10:48 -0400
Content-Disposition: inline
In-Reply-To: <1369897638-27299-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225938>

Check that suppress-cc=self works when applied
to output of cccmd.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e1a7f3e..452b362 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -204,6 +204,8 @@ test_suppress_self_unquoted () {
 
 		unquoted-$3
 
+		cccmd--$1 <$2>
+
 		Cc: $1 <$2>
 		Signed-off-by: $1 <$2>
 	EOF
-- 
MST
