From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc warning
Date: Sat, 04 Dec 2010 19:12:34 +0000
Message-ID: <4CFA92A2.4030801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POytV-0000kS-7B
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab0LDUjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:39:37 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:63423 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755805Ab0LDUjg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:39:36 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1POytK-0005rW-mK; Sat, 04 Dec 2010 20:39:35 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162905>


The msvc compiler thinks that a variable could be used while
uninitialised and issues the following warning:

    ...\git\wt-status.c(152) : warning C4700: uninitialized local \
        variable 'status' used

In order to suppress the warning, we simply initialise the
variable to zero.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index d9f3d9f..9b4b5bf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -149,7 +149,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 {
 	struct wt_status_change_data *d = it->util;
 	const char *c = color(change_type, s);
-	int status = status;
+	int status = 0;
 	char *one_name;
 	char *two_name;
 	const char *one, *two;
-- 
1.7.3
