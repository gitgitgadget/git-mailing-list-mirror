From: Adam Tkac <atkac@redhat.com>
Subject: [PATCH v2] If `egrep` is aliased, temporary disable it in
 bash.completion
Date: Thu, 29 Nov 2012 16:14:22 +0100
Message-ID: <20121129151418.GA19169@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 16:15:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te5pb-0001X9-5M
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 16:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab2K2PO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 10:14:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16975 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2K2PO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 10:14:58 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qATFEwsn032728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:14:58 -0500
Received: from localhost (evileye.atkac.brq.redhat.com [10.34.4.30])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qATFEvjn005867
	for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:14:58 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210837>

Originally reported as https://bugzilla.redhat.com/show_bug.cgi?id=863780

Signed-off-by: Adam Tkac <atkac@redhat.com>
Signed-off-by: Holger Arnold <holgerar@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0960acc..79073c2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -565,7 +565,7 @@ __git_complete_strategy ()
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	for i in $(git help -a| \egrep '^  [a-zA-Z0-9]')
 	do
 		case $i in
 		*--*)             : helper pattern;;
-- 
1.8.0


-- 
Adam Tkac, Red Hat, Inc.
