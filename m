From: Adam Tkac <atkac@redhat.com>
Subject: [PATCH] Fix bash completion when `egrep` is aliased to `egrep
 --color=always`
Date: Thu, 22 Nov 2012 16:41:21 +0100
Message-ID: <20121122154120.GA16835@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 19:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbbgG-0004zs-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab2KVSiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:38:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab2KVSiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:38:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAMFfME8016710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 22 Nov 2012 10:41:22 -0500
Received: from localhost (evileye.atkac.brq.redhat.com [10.34.4.30])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qAMFfLtn027681
	for <git@vger.kernel.org>; Thu, 22 Nov 2012 10:41:22 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210183>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

attached patch fixes bash completion when `egrep` is aliased to `egrep --color=always`.

Comments are welcomed.

Regards, Adam

-- 
Adam Tkac, Red Hat, Inc.

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fix-bash-completion-when-egrep-is-aliased-to-egrep-c.patch"

>From 2b62bd71af1158129492f74f0b77c9840a49507f Mon Sep 17 00:00:00 2001
From: Adam Tkac <atkac@redhat.com>
Date: Thu, 22 Nov 2012 16:34:58 +0100
Subject: [PATCH] Fix bash completion when `egrep` is aliased to `egrep
 --color=always`

Originally reported as https://bugzilla.redhat.com/show_bug.cgi?id=863780

Signed-off-by: Adam Tkac <atkac@redhat.com>
Signed-off-by: Holger Arnold <holgerar@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc0657a..47613f9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -565,7 +565,7 @@ __git_complete_strategy ()
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	for i in $(git help -a|egrep --color=never '^  [a-zA-Z0-9]')
 	do
 		case $i in
 		*--*)             : helper pattern;;
-- 
1.8.0


--ZPt4rx8FFjLCG7dd--
