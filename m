From: Roger Leigh <rleigh@debian.org>
Subject: [PATCH 2/2] builtin-mailinfo.c: Free regular expression after use
Date: Mon, 29 Jun 2009 22:34:29 +0100
Message-ID: <1246311269-18120-1-git-send-email-rleigh@debian.org>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
Cc: Roger Leigh <rleigh@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 23:34:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOV7-0003x1-W5
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbZF2Ves (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbZF2Ver
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:34:47 -0400
Received: from nagini.codelibre.net ([80.68.93.164]:58625 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZF2Ver (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:34:47 -0400
Received: by nagini.codelibre.net (Postfix, from userid 107)
	id ED98818223; Mon, 29 Jun 2009 22:34:47 +0100 (BST)
Received: from hardknott (unknown [78.148.79.113])
	by nagini.codelibre.net (Postfix) with ESMTPSA id 994F3181C0;
	Mon, 29 Jun 2009 22:34:47 +0100 (BST)
Received: by hardknott (Postfix, from userid 1000)
	id DC99D120C1; Mon, 29 Jun 2009 22:34:47 +0100 (BST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122462>

Signed-off-by: Roger Leigh <rleigh@debian.org>
---
 builtin-mailinfo.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 6d19046..6559c37 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -254,6 +254,8 @@ static void cleanup_subject(struct strbuf *subject)
 		strbuf_trim(subject);
 	}
 
+	regfree(&regex);
+
 	return;
 }
 
-- 
1.6.3.3
