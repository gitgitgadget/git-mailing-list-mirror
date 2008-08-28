From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Remove useless memset of static command name lists in
	builtin-merge.c
Date: Thu, 28 Aug 2008 19:17:13 +0200
Message-ID: <20080828171713.GB6024@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 19:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlGb-0007aw-6P
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbYH1RZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYH1RZT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:25:19 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:42160 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbYH1RZK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:25:10 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf4EvTSQ==
Received: from tigra.home (Faec3.f.strato-dslnet.de [195.4.174.195])
	by post.webmailer.de (fruni mo51) (RZmta 16.47)
	with ESMTP id a00d07k7SH1FbE ; Thu, 28 Aug 2008 19:25:07 +0200 (MEST)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 22FC9277C8;
	Thu, 28 Aug 2008 19:25:07 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id C736436D1E; Thu, 28 Aug 2008 19:17:13 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94093>

The statics are always initialized with 0

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

...and we already depend on it.

 builtin-merge.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index dcd08f7..9ad9791 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -93,8 +93,6 @@ static struct strategy *get_strategy(const char *name)
 		struct cmdnames not_strategies;
 		loaded = 1;
 
-		memset(&main_cmds, 0, sizeof(struct cmdnames));
-		memset(&other_cmds, 0, sizeof(struct cmdnames));
 		memset(&not_strategies, 0, sizeof(struct cmdnames));
 		load_command_list("git-merge-", &main_cmds, &other_cmds);
 		for (i = 0; i < main_cmds.cnt; i++) {
-- 
1.6.0.1.150.g5966
