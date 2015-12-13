From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Sun, 13 Dec 2015 20:07:12 +0000
Message-ID: <1450037234-15344-1-git-send-email-luke@diamand.org>
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 21:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8CvW-0006zO-PC
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 21:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbbLMUHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 15:07:20 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35363 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbbLMUHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 15:07:19 -0500
Received: by mail-wm0-f43.google.com with SMTP id p66so18897369wmp.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w0cvRaUp/rD8BPnY/uXzFlPe08tAsyJUfpZfo/BK/PY=;
        b=NxVSEQ3FCI04dgrfCWZN7LiMDNwKNzU7A0bUJRKL4Ej+hn6o534wrHdZ9wiKy5pJxh
         sVYuezZ531Y+ThfDUyetI6Mz57XdDjjsgeaUrIeWARcQpmjGWMybr6VA74zosAZXf3DH
         FDL8Kg72Qmq2x7We+10TMBFFk090cRJNCAEUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w0cvRaUp/rD8BPnY/uXzFlPe08tAsyJUfpZfo/BK/PY=;
        b=ia/lMdiZI4geB1r4CThkXPXvPuuDx8mh4roIEAM0/LCVzNgRlAket93dZb2I0YsBuA
         Yuu8HoISCLz89vZizpdbYPHvAru4RxZaGtCDN/C1Nj6hOPJ6KB2vvtgH2HcvR3mp41rf
         PlqUXV+sdwGCers5PGWpIQjjRh3evxi30nj8Y1/0AKiyDPjed5k5pb+J9U/lpOqo3gGM
         VP19he3nJlSbCaFGZbLaJ6UUDCbzAGKPdFPMo0cZB5sAUzFm3KDsJaG8S2HwFb6LQwQr
         KHhmVzMlNs1VnQC/XoGpr6++QTtHn+TNCiXLodmax/XZRQat1FlwdPyl+ay+vDljEXHS
         mTTg==
X-Gm-Message-State: ALoCoQmEhVWurlaAfwFOSnz3JZeoKXk+4UIiaL84tiexQTI2knMifFI07HLor72ZrWpRUcp0QZQ1R0iEDNnKiwm9R3jthpu9QQ==
X-Received: by 10.28.19.20 with SMTP id 20mr20390433wmt.49.1450037237504;
        Sun, 13 Dec 2015 12:07:17 -0800 (PST)
Received: from ethel.local.diamand.org (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id e136sm7404804wma.23.2015.12.13.12.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Dec 2015 12:07:16 -0800 (PST)
X-Mailer: git-send-email 2.6.2.474.g3eb3291
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282348>

James Farwell reported a bug I introduced into git-p4 with
handling of multiple depot paths:

http://article.gmane.org/gmane.comp.version-control.git/282297

This patch series adds a failing test case, and a fix for this
problem.

Luke

Luke Diamand (2):
  git-p4: failing test case for skipping changes with multiple depots
  git-p4: fix handling of multiple depot paths

 git-p4.py               |  8 +++++---
 t/t9818-git-p4-block.sh | 28 +++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.6.2.474.g3eb3291
