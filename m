From: Adam Tkac <atkac@redhat.com>
Subject: [PATCH] Pass "-O xhtml" param to highlight instead of "-xhtml"
Date: Wed, 26 Jan 2011 18:11:19 +0100
Message-ID: <20110126171118.GA867@traged.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 18:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi8wP-0001qf-M4
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 18:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab1AZRNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 12:13:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54856 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097Ab1AZRNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 12:13:52 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p0QHBKHA016694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 26 Jan 2011 12:11:20 -0500
Received: from localhost (dhcp-25-165.brq.redhat.com [10.34.25.165])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0QHBJhr020304;
	Wed, 26 Jan 2011 12:11:20 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165523>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

attached patch fixes the gitweb.perl script. Current highlight utility
doesn't recognize --xhtml parameter, it recognizes only "-O xhtml" parameter.

Reference: https://bugzilla.redhat.com/show_bug.cgi?id=672293

Regards, Adam

-- 
Adam Tkac, Red Hat, Inc.

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Pass-O-xhtml-parameter-instead-of-xhtml-to-hightligh.patch"

>From ec8043a730c165d8b438ccaba7c3cf5dc5fa65bc Mon Sep 17 00:00:00 2001
From: Adam Tkac <atkac@redhat.com>
Date: Wed, 26 Jan 2011 17:46:29 +0100
Subject: [PATCH] Pass "-O xhtml" parameter instead of "--xhtml" to hightlight in gitweb.

Signed-off-by: Jochen Schmitt <jochen@herr-schmitt.de>
Signed-off-by: Adam Tkac <atkac@redhat.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1025c2f..88556f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3468,7 +3468,7 @@ sub run_highlighter {
 	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
 	          quote_command($highlight_bin).
-	          " --xhtml --fragment --syntax $syntax |"
+	          " -O xhtml --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
 	return $fd;
 }
-- 
1.7.3.5


--Q68bSM7Ycu6FN28Q--
