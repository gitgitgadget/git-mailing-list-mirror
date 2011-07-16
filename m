From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFD/PATCH v3 22/23] t5800: document inability to push new branch with old content
Date: Sat, 16 Jul 2011 15:03:42 +0200
Message-ID: <1310821424-4750-23-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4YZ-0005RE-Lz
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab1GPNFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:05:12 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab1GPNFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:05:07 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996059ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4RFMXTBANGpzqKTghgXtnTBZfU94vI1zjvKHal0PUFo=;
        b=kWBHCzArj5TWXAP8IPd5BhH7/ffebRNUwD+S4d05smYR8utKRRsWJ29LexE+i1taHK
         u8pYPuBupEds/X5fCPNuEBijVKBGTxIA446lDxwAYjSZ33okqu8KUlgdaB6vBO9FNP41
         JRLpF5+uBZAhkUR+Ny7oDSl5Mr9hS44KPjWm8=
Received: by 10.213.8.206 with SMTP id i14mr579101ebi.6.1310821506550;
        Sat, 16 Jul 2011 06:05:06 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.05.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:05:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177266>


Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  So, I'm not sure what's going on here. It just says:
  "Everything up to date" when you try to do a push like this.

 t/t5800-remote-helpers.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1c62001..68f8418 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -125,6 +125,14 @@ test_expect_success 'push new branch by name' '
 	compare_refs clone HEAD server refs/heads/new-name
 '
 
+test_expect_failure 'push new branch with old content' '
+	(cd clone &&
+	 git checkout -b existing &&
+	 git push origin existing
+	) &&
+	compare_refs clone refs/heads/existing server refs/heads/existing
+'
+
 test_expect_failure 'push new branch with old:new refspec' '
 	(cd clone &&
 	 git push origin new-name:new-refspec
-- 
1.7.5.1.292.g728120
