From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Documentation: squelch diff output in install-webdoc.sh
Date: Thu, 1 Oct 2015 20:06:16 +0200 (CEST)
Message-ID: <711797143.1885575.1443722776280.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 20:06:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhiFL-00065K-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 20:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587AbbJASGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 14:06:19 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:45157 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753537AbbJASGT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2015 14:06:19 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 3nRj7Y2TTqzBqnK;
	Thu,  1 Oct 2015 20:06:17 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 51AC7344D79;
	Thu,  1 Oct 2015 20:06:17 +0200 (CEST)
Received: from webmail09.arcor-online.net (webmail09.arcor-online.net [151.189.8.45])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 3nRj7Y287tzGVXK;
	Thu,  1 Oct 2015 20:06:16 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 3nRj7Y287tzGVXK
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1443722777; bh=WAMjBBcx5M/eLTD9yLzcx73ywwX8LfJiX4aNz+lZBN4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=JiRVz9R7bD/EmZXTDQaLq26cX99V7Qav7SogndxMRa8rFBTVcBTHremJmSxUsiPHf
	 D6f91HI1IPOYCTcqG8iGbuykAPlGbrCwP+eYggE3MhEdGYRxTSZUFZTgLRogddbvam
	 q8fRLDNQ7gYeBKQMh00NdWVvE0mf8AJlC01uUiEI=
Received: from [178.7.91.64] by webmail09.arcor-online.net (151.189.8.45) with HTTP (Arcor Webmail); Thu, 1 Oct 2015 20:06:16 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.91.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278897>


Diff is used in install-webdoc.sh to identify changed files
which need to be installed, but the output of diff is not
needed during the installation process. So squelch diff
output by redirecting to /dev/null.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/install-webdoc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index ed8b4ff..b3b8d19 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -12,7 +12,7 @@ do
 	then
 		: did not match
 	elif test -f "$T/$h" &&
-		$DIFF -u -I'^Last updated ' "$T/$h" "$h"
+		$DIFF -u -I'^Last updated ' "$T/$h" "$h" >/dev/null
 	then
 		:; # up to date
 	else
-- 
2.5.0.windows.1
