From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] test-lib: fail if invalid options are passed
Date: Mon,  1 Jun 2009 14:14:40 +0200
Message-ID: <1243858482-6353-2-git-send-email-drizzd@aon.at>
References: <1243858482-6353-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 14:15:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB6QD-0005S5-GU
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 14:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874AbZFAMPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZFAMPK
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 08:15:10 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:39866 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094AbZFAMPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 08:15:07 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Jun 2009 14:15:06 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MB6Py-0001k7-Do; Mon, 01 Jun 2009 14:15:06 +0200
X-Mailer: git-send-email 1.6.3.1.147.g637c3
In-Reply-To: <1243858482-6353-1-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 01 Jun 2009 12:15:06.0338 (UTC) FILETIME=[99749420:01C9E2B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120464>

Previously, unknown options would be ignored, including any subsequent
valid options.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index dad1437..6e83ceb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -115,7 +115,7 @@ do
 	--tee)
 		shift ;; # was handled already
 	*)
-		break ;;
+		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
 done
 
-- 
1.6.3.1.147.g637c3
