From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Add prefixcmp()
Date: Tue, 20 Feb 2007 01:51:22 -0800
Message-ID: <7vbqjpxilh.fsf_-_@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:51:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJReg-0007lS-UY
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbXBTJvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbXBTJvX
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:51:23 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40656 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbXBTJvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:51:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220095122.NLLI1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 04:51:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RlrN1W0021kojtg0000000; Tue, 20 Feb 2007 04:51:22 -0500
In-Reply-To: <200702200942.18654.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 09:42:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40220>

We have too many strncmp(a, b, strlen(b)).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-compat-util.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9863cf6..0a9ac56 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -279,4 +279,9 @@ static inline int sane_case(int x, int high)
 	return x;
 }
 
+static inline int prefixcmp(const char *a, const char *b)
+{
+	return strncmp(a, b, strlen(b));
+}
+
 #endif
-- 
1.5.0.1.571.ge5a1a
