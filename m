From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] format-patch: add test for dashdash
Date: Thu, 26 Nov 2009 21:12:00 +0200
Message-ID: <1259262720-24077-3-git-send-email-felipe.contreras@gmail.com>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 20:12:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDjlX-0007dq-2E
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbZKZTMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbZKZTMM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:12:12 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58454 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZKZTMK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:12:10 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so755484bwz.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WEnHxqTuKU8uOjTk7vKq05bvcSzbfBKDmZ5Fk/iOEQQ=;
        b=qZzrcHNrszsFGLHRn2PUzchntKu3huiD700eZHQqeObKLW+TyK/tXru2Xqp85BNAq7
         qN8gbRMgGWj0YKSqWp7ETGMwT4vHtJ15iQvNCT7ZdbFEi35zw926wDRMv+m4tm3Lwdmd
         rgSeHcftgoKdxW2HQ5Yabn356Pry/5T9eXQho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VJFZC2esXXIF+ENtathxrJ/8KkiF2KIldqrib0izgVGn266a/bZPaPVfXxsBJC6GFX
         qNIDe98NmOtu7JV2XWi8P+D4dvhcTCG73HiV2q0AjhRdctVxRPTPuERgnpwk0iuJvBRl
         9A+VJR2aWW6e3b8j5I3Ndsd834F9K3/ffbw1Q=
Received: by 10.204.25.150 with SMTP id z22mr109094bkb.138.1259262736533;
        Thu, 26 Nov 2009 11:12:16 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 13sm244515bwz.14.2009.11.26.11.12.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 11:12:15 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
In-Reply-To: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133824>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4014-format-patch.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7f267f9..d5b002d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -536,6 +536,10 @@ test_expect_success 'format-patch --signoff' '
 	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 '
 
+test_expect_success 'format-patch -- <path>' '
+	git format-patch master..side -- file
+'
+
 echo "fatal: --name-only does not make sense" > expect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
-- 
1.6.6.rc0.61.geeb75
