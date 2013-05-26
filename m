From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5/6] t/send-email: add test with quoted sender
Date: Sun, 26 May 2013 17:41:07 +0300
Message-ID: <1369579187-27573-6-git-send-email-mst@redhat.com>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 16:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugc7v-0000mt-MK
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 16:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab3EZOkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 10:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29099 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab3EZOkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 10:40:46 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4QEekm8004053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:46 -0400
Received: from redhat.com (vpn-202-184.tlv.redhat.com [10.35.202.184])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r4QEeh6Z008762
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:44 -0400
Content-Disposition: inline
In-Reply-To: <1369579187-27573-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225548>

add test where sender address needs to be quoted.
Make sure --suppress-cc=self works well in this case.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 8aa55f8..0ab4056 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -228,6 +228,10 @@ test_expect_success $PREREQ 'self name is suppressed' "
 	test_suppress_self_unquoted 'A U Thor' 'author@redhat.com' 'self_name_suppressed'
 "
 
+test_expect_success $PREREQ 'quoted self name is suppressed' "
+	test_suppress_self_quoted 'A U. Thor' 'author@redhat.com' 'self_name_suppressed'
+"
+
 test_expect_success $PREREQ 'Show all headers' '
 	git send-email \
 		--dry-run \
-- 
MST
