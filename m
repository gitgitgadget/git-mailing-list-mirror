From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] test: rebase: fix --interactive test
Date: Tue, 28 May 2013 07:54:31 -0500
Message-ID: <1369745671-22418-6-git-send-email-felipe.contreras@gmail.com>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 14:56:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJSK-0001ST-Al
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933940Ab3E1M4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:56:42 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:59721 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933913Ab3E1M4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:56:41 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so9994211oag.31
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nDVchJHCxyzE8P3vM2/dKhej7ycNbXGc5GbXR4XHh9g=;
        b=cEanoAYyaVs1S9VmhmSwQAYzODwx321/MH7V2pzE3HejgfUqOMUj34GVnbgHz0A2ug
         z3RlkaQ8NriLU/ivQUSOPvzCpZ+1jXANowgNO9W8+ENuBRbfScT38TbbMwefzFa5lvMP
         inh9YmIPzB3EPqumKKk3T6LBIDhMm9j5qkhWYFrNtsdJpz2cdAubnFLYN+0b91mDXHBs
         ccDM38orHcMum+TZcXWpgZGw0g5T09Yj1Ecy14BDosxKAqzPiL6qMwLnmRRZANkEYJ2P
         Jj6L+RZdCKQcph9VOUA4xnVGqf2hJ95LtZut5P7Qm1zaM/IrczaervALftCUBHrMC/Lb
         eLgg==
X-Received: by 10.182.108.165 with SMTP id hl5mr20528002obb.33.1369745800615;
        Tue, 28 May 2013 05:56:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm34482048obi.8.2013.05.28.05.56.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:56:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225637>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a58406d..79e8d3c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -692,7 +692,7 @@ test_expect_success 'rebase -i can copy notes' '
 	test_commit n2 &&
 	test_commit n3 &&
 	git notes add -m"a note" n3 &&
-	git rebase --onto n1 n2 &&
+	git rebase -i --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
 '
 
-- 
1.8.3.rc3.312.g47657de
