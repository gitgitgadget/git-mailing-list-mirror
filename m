From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] cherry-pick: fix memory leaks
Date: Thu, 30 May 2013 08:34:18 -0500
Message-ID: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui32H-0007Kj-HW
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331Ab3E3Ngc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:36:32 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:41611 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab3E3NgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:36:05 -0400
Received: by mail-yh0-f47.google.com with SMTP id f73so51804yha.20
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sKtNxAuy8rvIeg5T+fd7OU0IzSjaTMjyRsOwiHRSQiY=;
        b=ihtTZRR50Y1hncKhonoi51VW9uAzlMX4rz+0ayAa8PAwLM5ZKArHEL9kW3M1YG1whE
         uVx3bHjFW+feZqxD939SgXPDrKB8aOtk8I120bPs0cE8IZ9BGIog9hBMW5MCNNsVs/UZ
         BAregIsrih1ctbAkC/k59Yfrd3131+zmF7j1sO7RhsV4vElj5IRG3MmPU/dW8KKviYta
         BrTNFUEvwxLJqg0I90cZTwF80C5GPWQlvCVc4NrAnpgWTLSFuHa1+Tnz0UenbcKbP4no
         /A4cikMasR8lPRW0eePpJFYbyvsJevaWovJrbpGK7Yn9DMnFEvtAwIGOYkUoNBE6Orz0
         tiTw==
X-Received: by 10.236.207.162 with SMTP id n22mr3805849yho.45.1369920964257;
        Thu, 30 May 2013 06:36:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l39sm9002181yhn.26.2013.05.30.06.36.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:36:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225989>

Hi,

A small change since v1; one patch is dropped and another is updated to make up
for it.

Felipe Contreras (3):
  read-cache: plug a few leaks
  unpack-trees: plug a memory leak
  unpack-trees: free created cache entries

 read-cache.c   |  4 ++++
 unpack-trees.c | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.8.3.rc3.312.g47657de
