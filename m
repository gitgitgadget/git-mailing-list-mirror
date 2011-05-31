From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] config.c: Remove unused git_config_global() function
Date: Tue, 31 May 2011 18:23:42 +0100
Message-ID: <4DE5241E.9030000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 19:24:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRSgP-0005gL-4m
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 19:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864Ab1EaRYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 13:24:39 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:43559 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757794Ab1EaRYj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2011 13:24:39 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QRSgH-0002Dj-YW; Tue, 31 May 2011 17:24:38 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174815>


Commit 8f323c00 (drop support for GIT_CONFIG_NOGLOBAL, 15-03-2011)
removed the git_config_global() function, among other things, since
it is no longer required. Unfortunately, this function has since
been unintentionally restored; I suspect by merge commit 25b86e45
(Merge branch 'jk/maint-config-alias-fix' into next, 25-05-2011).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

A few days ago, when the next branch was @ d10669c, I noticed that
"make sparse" on next was complaining thus:

    config.c:828:5: warning: symbol 'git_config_global' was not \
        declared. Should it be static?

However, I remembered that this function had recently been removed, so
I took a quick look ...

ATB,
Ramsay Jones

 config.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index a8267e9..e0b3b80 100644
--- a/config.c
+++ b/config.c
@@ -825,11 +825,6 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-int git_config_global(void)
-{
-	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
-}
-
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
-- 
1.7.5
