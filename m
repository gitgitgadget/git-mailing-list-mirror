From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH] ssh-push: Don't add '/' to pathname
Date: Fri, 17 Jun 2005 10:13:18 +0200
Message-ID: <20050617081318.GA23688@pc117b.liacs.nl>
References: <20050614103738.GA14483@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 17 10:09:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjBuQ-0006sG-Ui
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 10:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVFQIOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVFQIOR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 04:14:17 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:28121 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261908AbVFQIOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 04:14:09 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5H8DIPE000652;
	Fri, 17 Jun 2005 10:13:23 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 988366FE9; Fri, 17 Jun 2005 10:13:18 +0200 (CEST)
To: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050614103738.GA14483@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ok, I'm stupid.

This patch has actually been tested.

skimo

--
ssh-push.c: Fix handling of ssh://host/path URLs

Previous patch to fix host:path notation broke
handling of ssh://host/path notation.

Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>

---
commit 4fd62062eb2d52d32cb771feb05bf1ee29d760f9
tree 75ea11a1b6bf7ca17a274b3a8ce2191e7b815e87
parent 7875b50d1a9928e683299b283bfe94778b6c344e
author Sven Verdoolaege <skimo@liacs.nl> Fri, 17 Jun 2005 10:08:27 +0200
committer Sven Verdoolaege <skimo@liacs.nl> Fri, 17 Jun 2005 10:08:27 +0200

 rsh.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/rsh.c b/rsh.c
--- a/rsh.c
+++ b/rsh.c
@@ -41,6 +41,7 @@ int setup_connection(int *fd_in, int *fd
 	snprintf(command, COMMAND_SIZE, 
 		 "%s='%s' %s",
 		 GIT_DIR_ENVIRONMENT, path, remote_prog);
+	*path = '\0';
 	posn = command + strlen(command);
 	for (i = 0; i < rmt_argc; i++) {
 		*(posn++) = ' ';
