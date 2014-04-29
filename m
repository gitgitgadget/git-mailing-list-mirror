From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/8] t: remote-hg: split into setup test
Date: Tue, 29 Apr 2014 04:04:32 -0500
Message-ID: <1398762275-346-6-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48d-0000AG-R3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbaD2JPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:36 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34354 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933232AbaD2JP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:27 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so8220165obc.8
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NFsKs9fGD8Ao5C7+6uHq56i7uOvVGk51wldtrdPsJf0=;
        b=PcBjgXre/kZWvwHi2RSFqjCOEULLIfvNnNuj0/yqSgCqs5C1De3S8HjfCzrRczyue0
         PiZaJ9JR2epzfhORB+6I3vVw/Gki1sjfPx3rogs0NHJq09kLH19xcmTV9RFXdvUWAj1E
         ak4wAqZEGPVs8Ph65raG3nKk2biWjiaWUMoAITwnJPlAx4M/PeikGoRFqnSz/eBDwlBY
         IcQv52osRAtXw9SouIFhy/vcibIpC3jleDkgVFV8fcscJ5eUBQKgJ97vEWdCaedO8qjT
         +ZddsCfL0A8hfq5uK/8DmG1iuGhZ/pKl8nRyonSkrQQ5gxVygSDeN3EGCEU137qfFa4/
         +C/w==
X-Received: by 10.60.17.132 with SMTP id o4mr26672981oed.34.1398762927454;
        Tue, 29 Apr 2014 02:15:27 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j9sm42777809obh.23.2014.04.29.02.15.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247551>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5810-remote-hg.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5810-remote-hg.sh b/t/t5810-remote-hg.sh
index 594a0a1..ba8b2d8 100755
--- a/t/t5810-remote-hg.sh
+++ b/t/t5810-remote-hg.sh
@@ -105,17 +105,18 @@ setup () {
 
 setup
 
-test_expect_success 'cloning' '
-	test_when_finished "rm -rf gitrepo*" &&
-
+test_expect_success 'setup' '
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
 	echo zero >content &&
 	hg add content &&
 	hg commit -m zero
-	) &&
+	)
+'
 
+test_expect_success 'cloning' '
+	test_when_finished "rm -rf gitrepo*" &&
 	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo HEAD zero
 '
-- 
1.9.2+fc1.3.gade8541
