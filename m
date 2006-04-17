From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Allow empty lines in info/grafts
Date: Mon, 17 Apr 2006 13:41:49 +0200
Message-ID: <20060417114149.28696.59020.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Apr 17 13:39:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVS4r-0006sf-RM
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 13:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDQLjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 07:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWDQLjb
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 07:39:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47778 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750782AbWDQLjb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 07:39:31 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1CF4E48A02
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 13:39:30 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FVSE9-0006Ts-Gd
	for git@vger.kernel.org; Mon, 17 Apr 2006 13:49:09 +0200
To: git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18818>


In addition to the existing comment support, that just allows the user
to use a convention that works pretty much everywhere else.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 05c4c92..2717dd8 100644
--- a/commit.c
+++ b/commit.c
@@ -160,7 +160,7 @@ struct commit_graft *read_graft_line(cha
 
 	if (buf[len-1] == '\n')
 		buf[--len] = 0;
-	if (buf[0] == '#')
+	if (buf[0] == '#' || buf[0] == '\0')
 		return NULL;
 	if ((len + 1) % 41) {
 	bad_graft_data:
