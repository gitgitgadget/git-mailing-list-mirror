From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] Fix allocation of "int*" instead of "int".
Date: Tue, 31 Jul 2007 14:48:29 +0200
Message-ID: <20070731144829.ea83d43d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFr35-0004jJ-VX
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 14:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984AbXGaMl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 08:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbXGaMl6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 08:41:58 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:32948 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775AbXGaMl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 08:41:57 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 894301AB2F7;
	Tue, 31 Jul 2007 14:41:56 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 540331AB2C6;
	Tue, 31 Jul 2007 14:41:56 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54345>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

 While working on something like a "git bisect dunno", I came up with
 the patches in this series.

 Thanks in advance,
 Christian.

 builtin-rev-list.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8efd609..5bcafe4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -300,7 +300,7 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	show_list("bisection 2 sorted", 0, nr, list);
 
 	*all = nr;
-	weights = xcalloc(on_list, sizeof(int*));
+	weights = xcalloc(on_list, sizeof(int));
 	counted = 0;
 
 	for (n = 0, p = list; p; p = p->next) {
-- 
1.5.2.1.144.gabc40
