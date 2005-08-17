From: Marco Costalba <mcostalba@yahoo.it>
Subject: [PATCH] Let git-format-patch-script write on stdout
Date: Wed, 17 Aug 2005 05:17:27 -0700 (PDT)
Message-ID: <20050817121727.39967.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Aug 17 14:17:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Mrf-00010C-1j
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 14:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVHQMRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 08:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVHQMRf
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 08:17:35 -0400
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:124 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751108AbVHQMRe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 08:17:34 -0400
Received: (qmail 39969 invoked by uid 60001); 17 Aug 2005 12:17:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5CSyBEu2AHcXqqR/bGQUzvg5Y7oq9ocQ8PcHPylaXSDqgGU7Ufw1DJ4OQR1XRaHy1unbx32kLJfoGZPw3v9te9+6v47QvG1TPtukk6EvRbFiV8Nj2qVG1qIE4GQoUXAo86kYT+CMQbP8oLJAdAGWIQRV/s3Z1rINxsw+MTSN0U0=  ;
Received: from [151.42.53.158] by web26309.mail.ukl.yahoo.com via HTTP; Wed, 17 Aug 2005 05:17:27 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Avoid that git-format-patch writes out patch series
information on stderr when there are no errors

Signed-off-by: Marco Costalba <mcostalba@yahoo.it>
---

 git-format-patch-script |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

47238497f48d19a0bf44eb9b23875bbb8e8a12aa
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -146,7 +146,7 @@ do
 
     file=`printf '%04d-%stxt' $i "$title"`
     i=`expr "$i" - 1`
-    echo >&2 "* $file"
+    echo >&1 "* $file"
     {
 	mailScript='
 	/./d



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
