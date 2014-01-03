From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/4] Fix branch.autosetup(merge|rebase) completion
Date: Fri,  3 Jan 2014 13:30:27 +0530
Message-ID: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 09:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyzgQ-00059v-8h
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 09:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbaACIAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 03:00:38 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37827 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaACIAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 03:00:37 -0500
Received: by mail-pa0-f49.google.com with SMTP id kx10so15298094pab.8
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cYdDbFtQcaf4UBHL/cJqk6J/A/4lodVEby+ygMlMoJI=;
        b=CFcbWgI/6FpI8SqaU1He1C+6nCCrHe1EaXbdHgesj5iE5SARCeFMwA+6szFaYjqqAQ
         +y5v4h00aIe6ctdSvk11A4hIRLj2FZ0b9EdKsHnZnW7/I/SLMIf/AueYIUkfo6Ju4d2A
         VhqDZaVCgirGwPhInobVWVTuEdCUZjLZ773JnmpcJ9r2D1X1DOVgqADSkRz7ds0uuyil
         KRBzneiAw8xDooR8RZUcSiFpPjfqX5IJ4qLPDlpeuauuchld7rky55IKMjAOhb6+ERvO
         znAWZUJOo6B63lGAgl6tFuHupwXY1oMjOKnIgErSem6AleE/MTqSZnfu+ZhMduNPS0we
         S1rw==
X-Received: by 10.68.143.33 with SMTP id sb1mr54452897pbb.99.1388736036897;
        Fri, 03 Jan 2014 00:00:36 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id gf5sm106943913pbc.22.2014.01.03.00.00.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 00:00:35 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239906>

Hi,

In this iteration, I've removed hunks to prevent completing:

  $ git config remote.pushdefault.<TAB>
  $ git config branch.autosetupmerge.<TAB>
  $ git config branch.autosetuprebase.<TAB>

Since they're perfectly valid remote/ branch names.

Thanks.

Ramkumar Ramachandra (4):
  completion: prioritize ./git-completion.bash
  completion: introduce __gitcomp_2 ()
  completion: fix branch.autosetup(merge|rebase)
  completion: fix remote.pushdefault

 contrib/completion/git-completion.bash | 36 ++++++++++++++++++++++++++++++++--
 contrib/completion/git-completion.zsh  | 12 +++++++++++-
 2 files changed, 45 insertions(+), 3 deletions(-)

-- 
1.8.5.2.227.g53f3478
