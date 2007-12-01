From: Mark Drago <markdrago@gmail.com>
Subject: [PATCH] hg-to-git: do not include the branch name as the first line
 of commit msg
Date: Sat, 01 Dec 2007 12:56:06 -0500
Message-ID: <4751A036.1080209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: stelian@popies.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 01 18:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyWZe-0007pi-FA
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 18:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbXLARz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbXLARz7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 12:55:59 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:38392 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbXLARz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 12:55:58 -0500
Received: by py-out-1112.google.com with SMTP id u77so5131115pyb
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=4RTFz2UrNfXrhgiKCCDcgs2PDnSqvBHMNpwBa0RNlzo=;
        b=cAN+4Z7AHkW00loUsorPGBcCMNv2m/OWEudzMGT8O3oxNRhBhczwhFNIYf0QRXXmXioNPc8IbHklwH9Tg3qz5KAGodVIACwkM+nxMMGKOQhWriixVcn76EtLQjaZ8pq/uqgN05OuLVa8fAD77ZW+m/8jQ8JHlfPX/JqMoA0jzX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=PYvS1xPXoZkvIQQsVmfXsOnxa7jmOOywcpbYeKYNbwQ2MBsvXDT/+9AUP2Q7kLms7MxU+lqBrIK4ZP6TMW1Uee9mixTDED/Cmp0fVBbhQOBXE/z7HRpCCDFg0cfWFtcFuOD2RW7yJye/ZNM8yD2pNl0J9Dyw5T4KgkY2iWVH7WQ=
Received: by 10.65.203.3 with SMTP id f3mr21327670qbq.1196531757571;
        Sat, 01 Dec 2007 09:55:57 -0800 (PST)
Received: from ?192.168.1.5? ( [24.189.168.60])
        by mx.google.com with ESMTPS id e14sm5533797qbe.2007.12.01.09.55.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Dec 2007 09:55:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66729>

Signed-off-by: Mark Drago <markdrago@gmail.com>
---
 contrib/hg-to-git/hg-to-git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 7a1c3e4..6bff49b 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -158,7 +158,7 @@ for cset in range(int(tip) + 1):
         mparent = None
 
     (fdcomment, filecomment) = tempfile.mkstemp()
-    csetcomment = os.popen('hg log -r %d -v | grep -v ^changeset: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v ^description: | grep -v ^tag:' % cset).read().strip()
+    csetcomment = os.popen('hg log -r %d -v | grep -v ^changeset: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v ^description: | grep -v ^tag: | grep -v ^branch:' % cset).read().strip()
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
 
-- 
1.5.2.4
