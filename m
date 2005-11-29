From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-object-id: accept $id when .git/refs/$id exists
Date: Wed, 30 Nov 2005 00:57:32 +0100
Message-ID: <20051129235732.GA5365@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 01:00:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhFLw-0001D2-0S
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 00:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbVK2X5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 18:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVK2X5f
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 18:57:35 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:60414 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751409AbVK2X5e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 18:57:34 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id D57EC6E00B6; Wed, 30 Nov 2005 00:56:49 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E54736E00B2; Wed, 30 Nov 2005 00:56:48 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id EA84E61494; Wed, 30 Nov 2005 00:57:32 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12972>

Makes the (universal) -r argument work better with tools like bisect.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 ... until cg-object-id will use git-rev-parse.

commit c0a9b8feb79d72f7c02f37392da840dbad446dbd
tree 8a44e96d29c2171ce1915165ce84d1b1f3e27807
parent f3576824058588cf3fdeca0a8b5ae46b9d37a812
author Jonas Fonseca <fonseca@diku.dk> Mon, 28 Nov 2005 03:49:11 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Mon, 28 Nov 2005 03:49:11 +0100

 cg-object-id |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/cg-object-id b/cg-object-id
index f2cb54e..ec0362a 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -59,6 +59,9 @@ normalize_id()
 	elif [ -r "$_git/refs/heads/$id" ]; then
 		read id < "$_git/refs/heads/$id"
 
+	elif [ -r "$_git/refs/$id" ]; then
+		read id < "$_git/refs/$id"
+
 	# Short id's must be lower case and at least 4 digits.
 	elif [[ "$id" == [0-9a-f][0-9a-f][0-9a-f][0-9a-f]* ]]; then
 		idpref=${id:0:2}

-- 
Jonas Fonseca
