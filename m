From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Fix git checkout - (early preview)
Date: Mon, 10 Jun 2013 21:52:09 +0530
Message-ID: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:20:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4pV-0005Bq-J0
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab3FJQUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:20:21 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:65169 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3FJQUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:20:20 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so6409185pbc.16
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=v5uff3vWE3+mZ9TyvijDgxMzzPyUjrwSe4p00G9YQLk=;
        b=Cb8h9EMLDjf77MDtiGlwWZZIrMjnhsNX2vGSWhy9/JerjOiB4R/RHGzQRU5dOqjD9W
         WK6Rz5xK0RZryM6lDw48nr2kUCPFX2IyBDPsZGlvb+fRaHb6f220mQ3XXSk5aJApbvDq
         olYX7rxRpCnyzxijyEc5WdA+qQDLbSPAu5RPhNkqatB3eBcKTXUSIxvSsrAXk2xI7ndM
         ESRPoZajk5/CSYwS97rSyWeDI7GII9675xh0W/hGKUJ19AULbAbPOve0OAW7gYeehK8Z
         W1Ta3FXdNKi3pz6mRuKvWTwoSibYtTX7DOckuWYH6G1vl6cv7fPET7SZc7VE94VzvspH
         Jjyw==
X-Received: by 10.66.87.5 with SMTP id t5mr15019738paz.169.1370881219954;
        Mon, 10 Jun 2013 09:20:19 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id 6sm10895528pbn.45.2013.06.10.09.20.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 09:20:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.254.g60f9e5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227314>

Hi,

So, this 'git checkout -' not working after a 'rebase -i' has annoyed
me to no end.  This is the fix.

Unfortunately, some tests fail and I'm still tracking down what
exactly is going on.

Thanks.

Ramkumar Ramachandra (3):
  t/checkout-last: checkout - doesn't work after rebase -i
  checkout: respect GIT_REFLOG_ACTION
  rebase -i: write better reflog messages for start

 builtin/checkout.c         | 11 ++++++++---
 git-rebase--interactive.sh |  2 ++
 t/t2012-checkout-last.sh   |  8 ++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
1.8.3.254.g60f9e5b
