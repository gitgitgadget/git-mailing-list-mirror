From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] Trivial sed fix up in t/t6001
Date: Mon, 27 Jun 2005 18:43:37 -0700 (PDT)
Message-ID: <20050628014337.18986.qmail@web41205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1282928974-1119923017=:18285"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 28 03:37:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn51v-0002y9-0s
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 03:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVF1Bnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 21:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVF1Bnq
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 21:43:46 -0400
Received: from web41205.mail.yahoo.com ([66.218.93.38]:16256 "HELO
	web41205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262199AbVF1Bni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 21:43:38 -0400
Received: (qmail 18988 invoked by uid 60001); 28 Jun 2005 01:43:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qob7syOjihzJLf0WVB68Ky9+u9i1zfiaHd6YMHkAmnP16LeiuZvk2BLZmMfb+R0B2rAtoSTFWAqbbBMhFe4Xz35G9pmJ7+PUjJAKIQmbFgp6PXSa4PNWuAL4Mo5BlV8blroRGInEQOI7LHPAPRXJLExlZql/4K/OoizLUtGEy8E=  ;
Received: from [66.41.38.150] by web41205.mail.yahoo.com via HTTP; Mon, 27 Jun 2005 18:43:37 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-1282928974-1119923017=:18285
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This trivial patch fixes up the sed expression used in t/t6001. It removes the semi-colon
seperator and replaces it with white space which makes the BSD sed(1) much happier.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>


--0-1282928974-1119923017=:18285
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

--0-1282928974-1119923017=:18285--
