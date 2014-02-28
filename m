From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH] gitk: replace SHA1 entry field on keyboard paste
Date: Thu, 27 Feb 2014 22:51:37 -0800
Message-ID: <1393570297-6012-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 07:52:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHIk-0001Np-BX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbaB1GwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:52:00 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:53554 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaB1GwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:52:00 -0500
Received: by mail-pd0-f180.google.com with SMTP id y10so351364pdj.39
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 22:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Eu0M+ltr/iLAInJKCbfJKtSvYLsKY3CGxo7/RVCpez4=;
        b=KpXKUqY1uWP/ayEFPPekicatVtEuTGUCQMSUKlTo8+ZmAeIoNJn2p+UcAGTyb6abGl
         tMIP7hZWvale/JWEskjP7HwmuDzXGn9XqL9vZup0R+BIrXnSuDfgdFYPs5NLKQLdlEg0
         xr9pFLYSQbiQsA3Pr3Rgz8j/2rgmp1KjNotTSByXmNoEMahDQLXxfOblRyfU1L5yXBEL
         VtwsHGwULOb3+WZofjgbO5FtI/lTHDrELkYzAIGuNp+rFKRmTcrVb1wW5Wr/jkdyHRw1
         yP3bureZk5CEHKo/AlcC+h8cuBv3OX5mPv6mwKKwgPhqlMjU4zcVRETXDgEiEJ27RVwd
         DflQ==
X-Received: by 10.69.0.39 with SMTP id av7mr1721056pbd.4.1393570319700;
        Thu, 27 Feb 2014 22:51:59 -0800 (PST)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id n6sm2646403pbj.22.2014.02.27.22.51.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 22:51:58 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242894>

We already replace old SHA with the clipboard content for the mouse
paste event.  It seems reasonable to do the same when pasting from
keyboard.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 gitk-git/gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 90764e8..2f58bcf 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2585,6 +2585,7 @@ proc makewindow {} {
     bind $fstring <Key-Return> {dofind 1 1}
     bind $sha1entry <Key-Return> {gotocommit; break}
     bind $sha1entry <<PasteSelection>> clearsha1
+    bind $sha1entry <<Paste>> clearsha1
     bind $cflist <1> {sel_flist %W %x %y; break}
     bind $cflist <B1-Motion> {sel_flist %W %x %y; break}
     bind $cflist <ButtonRelease-1> {treeclick %W %x %y}
-- 
1.7.9
