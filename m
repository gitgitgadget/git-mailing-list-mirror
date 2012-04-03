From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix a "Using plain integer as NULL pointer" sparse warning
Date: Tue, 03 Apr 2012 18:27:58 +0100
Message-ID: <4F7B331E.5080604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 19:54:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF7wN-00055K-2w
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 19:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab2DCRym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 13:54:42 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:32958 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753502Ab2DCRyl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 13:54:41 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SF7wG-00058G-Zs; Tue, 03 Apr 2012 17:54:40 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194635>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

If you need to re-roll your run-command patch [commit b0984f82,
"run-command: treat inaccessible directories as ENOENT", 30-03-2012],
could you please squash this patch into it. Thanks!

ATB,
Ramsay Jones

 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 47afb78..ae72b9b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -86,7 +86,7 @@ static char *locate_in_PATH(const char *file)
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!p || !*p)
-		return 0;
+		return NULL;
 
 	while (1) {
 		const char *end = strchrnul(p, ':');
-- 
1.7.9
