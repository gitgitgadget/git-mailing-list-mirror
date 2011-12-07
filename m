From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] test: add missing "&&" after echo command
Date: Wed, 7 Dec 2011 08:45:40 -0600
Message-ID: <20111207144540.GB30157@elie.hsd1.il.comcast.net>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
 <7vk469fm9j.fsf@alter.siamese.dyndns.org>
 <20111207144217.GA30157@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vijay Lakshminarayanan <laksvij@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYIkp-00070U-42
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 15:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab1LGOpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 09:45:46 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62225 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137Ab1LGOpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 09:45:46 -0500
Received: by qcqz2 with SMTP id z2so387548qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q82MjyFxogddDjH4HWW+msGs1aYMsChM9hcM08qYMig=;
        b=MVuC1W/HQuP53nEaNcf45qJR6xVDceKmcboyiCN2JshlewQRFCJVZv3bs+MKrlpmcr
         5rv64s0fXpACnIRDvANVPHGhEC2Ivw++HPZ4141ey97sg1eCmST6cwBB/gCmD/SF1SM2
         T2SkRyBeIDCAaikvVJSBt0xdqpFpX9u5xWIS0=
Received: by 10.50.194.229 with SMTP id hz5mr20083241igc.36.1323269145212;
        Wed, 07 Dec 2011 06:45:45 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id zs7sm4166529igb.0.2011.12.07.06.45.44
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 06:45:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111207144217.GA30157@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186458>

This test wants to modify a file and commit the change, but because of
a missing separator between commands it is parsed as a single "echo"
command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7501-commit.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 3ad04363..da75abc1 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -60,7 +60,7 @@ test_expect_success \
 
 test_expect_success \
 	"next commit" \
-	"echo 'bongo bongo bongo' >file \
+	"echo 'bongo bongo bongo' >file && \
 	 git commit -m next -a"
 
 test_expect_success \
@@ -172,11 +172,12 @@ test_expect_success \
 # easier to isolate bugs.
 
 cat >expected <<\EOF
-72c0dc9855b0c9dadcbfd5a31cab072e0cb774ca
-9b88fc14ce6b32e3d9ee021531a54f18a5cf38a2
-3536bbb352c3a1ef9a420f5b4242d48578b92aa7
-d381ac431806e53f3dd7ac2f1ae0534f36d738b9
-4fd44095ad6334f3ef72e4c5ec8ddf108174b54a
+285fcf7ec0d61b14249dfdb4c1e1fe03eaf15ee0
+0b8148b9afce917b87d71199b900466dc8ea8b6e
+43fb8826314939ce79a856face7953557fdca3d1
+eaa04bc3ae0f0b003f7f1d86bf869ec5d73eaf3e
+ee1963b250ee0f02a3fe37be0e4a02bb5af6a1ad
+b49f306003c627361a0304d151a6b4c8b26af6a1
 402702b49136e7587daa9280e91e4bb7cb2179f7
 EOF
 
-- 
1.7.8.rc3
