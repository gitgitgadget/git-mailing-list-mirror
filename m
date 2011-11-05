From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 0/3] fast-export fixes
Date: Sun,  6 Nov 2011 00:23:24 +0100
Message-ID: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Nov 06 00:25:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMpcS-0001pt-6X
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 00:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1KEXZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 19:25:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51987 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1KEXZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 19:25:17 -0400
Received: by eye27 with SMTP id 27so2888126eye.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=KeU0fICAk7/3v+4cEvQRZ/X4tyTReLf6ps4dhqGrshA=;
        b=VcenMCoK+1J1p58kym+JmaaUCf/uTpcY1GUbgEQRcX29y7Z1lhdoGeRpfS0Ftpe+df
         XS1+JPbP0ZsUcYkmfyHkQQs/kN6lhkLFlT8kNAnln4V/Mzv6XsYg7YRxhoFPmc6QNqgX
         2FophSTph/lUmdqMXB4RkLchEugnCajeFsY2o=
Received: by 10.14.15.11 with SMTP id e11mr1850422eee.45.1320535516094;
        Sat, 05 Nov 2011 16:25:16 -0700 (PDT)
Received: from laptop-sverre.lijbrandt.nl ([188.142.63.148])
        by mx.google.com with ESMTPS id v3sm37271459eej.7.2011.11.05.16.25.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 16:25:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.rc0.36.g67522.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184874>

Dscho and I worked on this patch series during a mini-hackathon in
late July, but Junio held the series back since he saw a more elegant
way to tackle the problem that would pave the way to solve a problem
he was having. Since then I've had very little time to work on git,
so I was very glad to have the chance to work on this during another
mini-hackathon in Amsterdam today.

I've used the new rev_info mechanism Junio introduced, and while I
can't say I completely understand how the tag_of_filtered_mode bit
works, I'm happy to say that all the tests pass now :).

Johannes Schindelin (2):
  fast-export: do not refer to non-existing marks
  setup_revisions: remember whether a ref was positive or not

Sverre Rabbelier (1):
  t9350: point out that refs are not updated correctly

 builtin/fast-export.c  |   48 ++++++++++++++++++++++++++++++++++++++++++------
 t/t9350-fast-export.sh |   11 +++++++++++
 2 files changed, 53 insertions(+), 6 deletions(-)

-- 
1.7.8.rc0.36.g67522.dirty
