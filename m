From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] Trivial sed fix up in t/t6001
Date: Fri, 1 Jul 2005 06:55:16 -0700 (PDT)
Message-ID: <20050701135516.87892.qmail@web41208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-478121560-1120226116=:83634"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 15:50:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoLtn-0001kM-FG
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 15:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbVGAN4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 09:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbVGANze
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 09:55:34 -0400
Received: from web41208.mail.yahoo.com ([66.218.93.41]:12881 "HELO
	web41208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263348AbVGANzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 09:55:19 -0400
Received: (qmail 87894 invoked by uid 60001); 1 Jul 2005 13:55:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TMCPI2V0Y6Ti5dZHg042Vs/DETa+Nel+C92WPmX/MxKAnvw5H8MKlCDM9BKjptuIUvSOoLcAAEsKMfwEN0+kAu4AfaaJ3SJW9TmRRu0Qw6/h2/A6ORszEQnUYdK6Be7rzzMtPGUkvhK0YYo1WIPQ3mDsU1KKnTibBrz+v6e9PPY=  ;
Received: from [66.41.38.150] by web41208.mail.yahoo.com via HTTP; Fri, 01 Jul 2005 06:55:16 PDT
To: jon.seymour@gmail.com, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-478121560-1120226116=:83634
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Change the sed seperator in t/t6001.

This trivial patch removes the semicolon as the sed seperator in the t/t6001 test script
and replaces it with white space.  This makes BSD sed(1) much happier.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>

===

Jon,

If you could ack this patch or incorporate it into your tree, I'd be very obliged.

Thanks,

--Mark


--0-478121560-1120226116=:83634
Content-Type: text/plain; name="t6001-sed-fixup.patch.txt"
Content-Description: 1890562984-t6001-sed-fixup.patch.txt
Content-Disposition: inline; filename="t6001-sed-fixup.patch.txt"

diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -40,7 +40,8 @@ save_tag()
 	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
 	shift 1
     	"$@" >.git/refs/tags/$_tag
-    	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
+    	sed_script="s/$(tag $_tag)/$_tag/g
+$sed_script"
 }
 
 # Replace unhelpful sha1 hashses with their symbolic equivalents 

--0-478121560-1120226116=:83634--
