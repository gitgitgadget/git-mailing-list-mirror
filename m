From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/19] Untracked cache to speed up "git status"
Date: Mon, 27 Oct 2014 19:10:27 +0700
Message-ID: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:10:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8N-0002PF-15
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbaJ0MKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 08:10:46 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:51341 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaJ0MKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:10:46 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so2282336pdb.13
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=g8ALptAvg4Mox+imWaxHLi8baN+vNF5Iliw0QoO98hI=;
        b=C6rMSIz8v2aNBlaeMlePdLRD0RYBk5a3bielQpHp/upyTLUHu6aGl5o13s1ZVCV/ra
         LCFqfTBKSwWCaPToPr9IVmtMtNZ2bPK2JBwQN+8yfLv+Qx35sjDPe+a3bQXFxV3/HbcG
         zV+p98l83qzRCaEDLjDWBd4BhrmNI6638VTLeVCLohcpgqkiZYY4G39mCTAFvqnBE8qh
         IFtzeOH4/vG2KMLm/WanKvGdXUBSOXpTnrJ8omupJAiKKkizCtSKoDNpdHmrmYLdMA/c
         xFL5Vp7ICRFvcB31VmknqohX3EvsCTkOECOzHzz7vZYr5NnoA2YrCMCUpMQga8lRNg99
         8GQA==
X-Received: by 10.70.45.110 with SMTP id l14mr1470165pdm.157.1414411845572;
        Mon, 27 Oct 2014 05:10:45 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id te2sm3570886pbc.51.2014.10.27.05.10.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:10:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:10:48 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last post was five months ago [1]. It's probably time for a resend
in case I'm hit by a bus. Numbers are in 17/19, saving about 40% time
on "git status". Details are in 02/19 and 06/19. Still on the table:

 - index-helper series [2] probably helps save about 10-15% in total
 - watchman support to lower the numbers even more, but not for Windows

I still need to see how watchman can be made on top of this.

[1] http://thread.gmane.org/gmane.comp.version-control.git/248306
[2] http://thread.gmane.org/gmane.comp.version-control.git/254314/focus=254318
-- 
2.1.0.rc0.78.gc0d8480
