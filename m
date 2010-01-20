From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/4] msvc: Add a definition of NORETURN compatible with msvc
 compiler
Date: Wed, 20 Jan 2010 19:45:12 +0000
Message-ID: <4B575D48.9070508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	kusmabite@googlemail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:35:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhH4-0001nC-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab0ATUfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440Ab0ATUfM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:35:12 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:36018 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754491Ab0ATUfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 15:35:09 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NXhGd-0001qX-ZN; Wed, 20 Jan 2010 20:35:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137574>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

I thought that Erik had already submitted this patch along with
those that resulted in commits a4f3131c and 18660bc9. However, I
don't seem to be able to find it anywhere! (maybe I only imagined
it).

If you find Erik's patch, please apply that instead...

ATB,
Ramsay Jones

 git-compat-util.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5c59687..6efea29 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -177,6 +177,9 @@ extern char *gitbasename(char *);
 #ifdef __GNUC__
 #define NORETURN __attribute__((__noreturn__))
 #define NORETURN_PTR __attribute__((__noreturn__))
+#elif defined(_MSC_VER)
+#define NORETURN __declspec(noreturn)
+#define NORETURN_PTR
 #else
 #define NORETURN
 #define NORETURN_PTR
-- 
1.6.6
