From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] t4201 (shortlog): Test output format with multiple
 authors
Date: Mon, 3 May 2010 21:58:04 -0500
Message-ID: <20100504025804.GD7322@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
 <20100504015635.GA7258@progeny.tock>
 <20100504025217.GA7322@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 04:57:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O98Ka-0002xC-Gx
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab0EDC5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 22:57:51 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:52282 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316Ab0EDC5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:57:50 -0400
Received: by iwn40 with SMTP id 40so4257738iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=95CMVl1znakCCaLSnzoYC4IkFT+jMzVndBCBwkDkyW8=;
        b=PViuNOTQEWLimEoLOsjXM3t6FqWYz57K92rG8AAFOn8onIfVmGrWrt8PWKhgqAok4T
         aPrRW45KeZUSKh0N9nSWASnYel1ccP0QEE4U1qBar708Na6LAHRXJmfTIb5yNRoSuip4
         EHKScyBPKygnOCVOHd3l7itVvxTQazsKFQMGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jaYAlr44N9JBFVW8unLLT5czsd1BnJ7XzV5uv69+1ofEWoVAhjVRIr8N40zPaq6b1Y
         3YXym6XtDDoeVvuBcsuFk21sRwokSeznynbOVoQ68dj8Pvik79NgicOSMao4PiGvGIZf
         R5dLIXv1PgZuK0imYb7a3Suu/ZW5Bjk8AYiIs=
Received: by 10.231.168.85 with SMTP id t21mr1380307iby.0.1272941870070;
        Mon, 03 May 2010 19:57:50 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4891416iwn.6.2010.05.03.19.57.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 19:57:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504025217.GA7322@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146285>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

 t/t4201-shortlog.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 438a826..6bfd0c0 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -36,6 +36,10 @@ test_expect_success 'setup' '
 
 	echo 5 >a1 &&
 	git commit --quiet -m "a								12	34	56	78" a1
+
+	echo 6 >a1 &&
+	git commit --quiet -m "Commit by someone else" \
+		--author="Someone else <not!me>" a1
 '
 
 test_expect_success 'shortlog wrapping' '
@@ -51,6 +55,9 @@ A U Thor (5):
       a								12	34
          56	78
 
+Someone else (1):
+      Commit by someone else
+
 EOF
 	git shortlog -w HEAD >out &&
 	test_cmp expect out
-- 
1.6.5
