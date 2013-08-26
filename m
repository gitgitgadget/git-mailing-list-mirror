From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] git send-email: include [anything]-by: signatures
Date: Mon, 26 Aug 2013 19:57:47 +0300
Message-ID: <20130826165747.GA30788@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 18:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE056-0006sk-NX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 18:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab3HZQzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 12:55:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086Ab3HZQzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 12:55:52 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7QGtpac016096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Mon, 26 Aug 2013 12:55:51 -0400
Received: from redhat.com (vpn1-5-108.ams2.redhat.com [10.36.5.108])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r7QGtmwN003928
	for <git@vger.kernel.org>; Mon, 26 Aug 2013 12:55:48 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233003>

Consider [anything]-by: a valid signature.
This includes Tested-by: Acked-by: Reviewed-by: etc.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ecbf56f..bb9093b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1359,7 +1359,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^([A-Za-z-]*-by|Cc): (.*)$/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
-- 
MST
