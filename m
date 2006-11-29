X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add --bool and --int to the OPTIONS section
Date: Wed, 29 Nov 2006 08:25:40 +0000
Message-ID: <200611290825.40953.andyparkins@gmail.com>
References: <7vd5772unw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 08:26:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vd5772unw.fsf@assigned-by-dhcp.cox.net>
X-TUID: eac74226b448e87f
X-UID: 175
X-Length: 979
Content-Disposition: inline
X-OriginalArrivalTime: 29 Nov 2006 08:27:22.0241 (UTC) FILETIME=[310B9710:01C71390]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32623>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpKlJ-0004LY-Oi for gcvg-git@gmane.org; Wed, 29 Nov
 2006 09:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966284AbWK2IZq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 03:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966330AbWK2IZq
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 03:25:46 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:35434 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S966284AbWK2IZp
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 03:25:45 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 29 Nov 2006 08:27:22 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GpKlC-0001Tb-00 for <git@vger.kernel.org>; Wed, 29 Nov
 2006 08:25:42 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I did look for just such an option, but didn't find it because it wasn't in 
the OPTIONS list of the git-repo-config man page.  If there is an OPTIONS 
section it should include all options, otherwise it's no use as a quick 
reference.

Your template commit message is an excellent idea, but I don't like the idea 
of simply hard coding sign off line into it; it means that there are then two 
locations in the .git tree that I'd have to edit to change my name.  
Therefore any template would have to support token expansion so that "S-o-B: 
$REPOSITORY_EMAIL" would be possible.  Even better would be support 
for "$GIT_STATUS_OUTPUT" and "$GIT_DIFF_OUTPUT" so that the commit message is 
completely templated.

 Documentation/git-repo-config.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-repo-config.txt 
b/Documentation/git-repo-config.txt
index 8199615..5bede9a 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -77,6 +77,12 @@ OPTIONS
 -l, --list::
 	List all variables set in config file.
 
+--bool::
+	git-repo-config will ensure that the output is "true" or "false"
+
+--int::
+	git-repo-config will ensure that the output is a simple decimal number
+
 
 ENVIRONMENT
 -----------
-- 
1.4.3.GIT-dirty
