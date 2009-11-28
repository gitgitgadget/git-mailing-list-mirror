From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/3] format-patch: add test for dashdash
Date: Sat, 28 Nov 2009 13:40:29 +0200
Message-ID: <1259408429-5685-4-git-send-email-felipe.contreras@gmail.com>
References: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 12:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELfc-0006w7-IV
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbZK1Lkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbZK1Lkq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:40:46 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38892 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZK1Lkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:40:45 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1602122bwz.21
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=15xR+3h4RGZRE1qd6+h8nuQ+nAzv0ZRpiFZInQJfLYA=;
        b=kJMDurUDpedEgSj+uNOMu4hMekf//DSADtcSiFxC5Zrsii+QZk/KgKWgbeBecSQRnF
         i0KDcnzUxZMFb07P4G4MOs7QVp2PqYnfYazjngv4hPSfp+moJvIK4B60RteBi38zPe+O
         J7KOOPjd4hdzCRkcGCQ5jHSKKTVEQudKftXlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bYr8Ya9muEf28HbX0v2OryuW5Wx7QeSFSRgijy8RAItj/PXcqH14urIGTvBJIny5J6
         eihjOcdpm9uxvaZsmTZ3ZOA4lfebkIZ2ZLvhCliCb1Qtv+aPZkYR3Mpc6wWVBJVTDw/S
         nDlCay45E1O4S0xmxN4n285T3r0J2xpIjJZGM=
Received: by 10.204.34.20 with SMTP id j20mr2195667bkd.57.1259408451874;
        Sat, 28 Nov 2009 03:40:51 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 14sm615469bwz.1.2009.11.28.03.40.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:40:51 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
In-Reply-To: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133959>

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
1.6.6.rc0.59.g5117f7.dirty
