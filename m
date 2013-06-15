From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/2] Fix am with stray $dotest directory
Date: Sat, 15 Jun 2013 18:13:10 +0530
Message-ID: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 14:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnprN-0001iF-7O
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 14:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab3FOMpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 08:45:07 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:41937 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab3FOMpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 08:45:05 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so1361776pbb.8
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ocMlVt1WyoiKi94OnCh0aeUOQwnULS2/bOmKPMeAbG0=;
        b=Mj/L2uBOGTwGTTqZFkOMxRlCilo90NioMdYwIr7TpbMdy23PRzzXdYtVfCCMLrRspM
         rD52C36RNL9lIlx+53adi3s51zkN3CEA4HONxQazGfTgkpaH2Ap7WuGvxclH4JOlx010
         6XMaDhUayAiRs6HOyFvGbKoD793HGxvV+yCSazWPw+rteC7xbBvvL0Fx9mjoTs7B4qQg
         uoUv9WPgN7AENXwfVaRjE4PX8LjkJQRItUoc3WZMMq0Jy7KV7CPBi7WL7Px3Z08Bavj9
         ZUPS8MeEtDTzW3mQa4bj8QcWtoFtZ8E/gFapOIzUW5KnmV3qHCrJL0oreQuM8fxxD4eZ
         /OBg==
X-Received: by 10.66.119.103 with SMTP id kt7mr6189115pab.125.1371300304766;
        Sat, 15 Jun 2013 05:45:04 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pl9sm6194950pbc.5.2013.06.15.05.45.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 05:45:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g8881048.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227946>

The test in [1/2] was too loose in the previous iteration: guard it
with "test -z $rebasing".  Also fix a couple of minor problems pointed
out by Junio (extra indentation, $-unescaped).

Thanks.

Ramkumar Ramachandra (2):
  am: handle stray $dotest directory
  t/am: use test_path_is_missing() where appropriate

 git-am.sh     | 17 +++++++++++++++++
 t/t4150-am.sh | 40 +++++++++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 17 deletions(-)

-- 
1.8.3.1.383.g8881048.dirty
