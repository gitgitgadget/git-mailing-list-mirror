From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Include mailmap.h in mailmap.c to catch mailmap interface changes
Date: Tue, 1 May 2007 00:31:52 +0200
Message-ID: <20070430223152.GD5000@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 00:32:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiePZ-00027J-7e
	for gcvg-git@gmane.org; Tue, 01 May 2007 00:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbXD3Wbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 18:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbXD3Wbz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 18:31:55 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:37024 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422778AbXD3Wby (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 18:31:54 -0400
Received: from tigra.home ([195.4.169.198] [195.4.169.198])
	by post.webmailer.de (klopstock mo35) (RZmta 5.8)
	with ESMTP id E014d9j3ULoFbq ; Tue, 1 May 2007 00:31:52 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C7FE1277BD;
	Tue,  1 May 2007 00:31:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9E26CD171; Tue,  1 May 2007 00:31:52 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmZRM0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45888>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

And an interface change it could use. There is only two users, and
only one needs repo_abbrev. Maybe put all mailmap data into a
structure, and pass a pointer to that structure to read_mailmap?
Not proposing it, though. Not worth the effort: mailmaps aren't very
popular (and maybe not even used, if one remembers how inconsistent
local mail configurations are).

 mailmap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 38359a2..cb567a2 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "path-list.h"
+#include "mailmap.h"
 
 int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev)
 {
-- 
1.5.2.rc0.792.g7f4bd0
