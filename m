From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] git-clean: implement partial matching for selection
Date: Wed, 24 Jul 2013 10:22:03 +0800
Message-ID: <cover.1374632255.git.worldhello.net@gmail.com>
References: <d099b22989d6e7c023e160a6a9b232bc58e6349c.1374631307.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 04:23:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1ok3-0001Mz-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 04:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3GXCXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 22:23:47 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60817 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3GXCXq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 22:23:46 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so8857973pdj.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 19:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DLbM0Vbxdcut7kkaPYtDeozWahYtaxKbKvus3LeR21I=;
        b=V2Qtp5ESW7aiIkQsj3rb/X7BX0tlkbLchBCmYi6eMgw5drSFjDRcjcmSEmDUtzs7mC
         BEgvu6eBLB4CrWci8VtTdBwvtA6m0lZ7nTjX0BA3cGaGRENaO8d7YaxsWz1+BHC6CpAV
         X0dlSFH8v/ZJ11jIF9cOI4AxwV3WqYntWeA49i24Mwf2QIacyW99WHmylNPUiKoiAYPV
         xvOq36z231nyuHbH5ij8Kujl2iPCpF8o3sGEMjub8iAK58pf3vdB9kVxsRy3LyPIL36w
         nqDXvqu3a5UXDU9085EQqdKbWFizzGaWNPFgq2xO3g4zlpBrwmZcCR5j//2bPed5mi0C
         GBZg==
X-Received: by 10.66.169.42 with SMTP id ab10mr41235420pac.14.1374632626156;
        Tue, 23 Jul 2013 19:23:46 -0700 (PDT)
Received: from localhost.localdomain ([114.246.130.173])
        by mx.google.com with ESMTPSA id vu5sm48294783pab.10.2013.07.23.19.23.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 19:23:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.842.g8e6673c
In-Reply-To: <d099b22989d6e7c023e160a6a9b232bc58e6349c.1374631307.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231075>

In the 1st version of this patch, I forgot to remove a shell command for
debug in t7301:

    find . > /tmp/x &&

Remove the above command in this version. Sorry about this.

Jiang Xin (1):
  git-clean: implement partial matching for selection

 builtin/clean.c              | 80 ++++++++++++++++++++++++++++----------------
 t/t7301-clean-interactive.sh | 40 ++++++++++++++++++++--
 2 files changed, 90 insertions(+), 30 deletions(-)

-- 
1.8.3.4.842.g8e6673c
