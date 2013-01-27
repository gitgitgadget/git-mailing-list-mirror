From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v4 0/2] for-each-repo: new command for multi-repo operations
Date: Sun, 27 Jan 2013 13:46:15 +0100
Message-ID: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 13:46:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzRdO-0004FU-10
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 13:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673Ab3A0Mqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 07:46:33 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:52981 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab3A0Mqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 07:46:32 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so2797507lbj.3
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 04:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=SWWd2I0DuYkvS5cE3snC10kl+aJ4N5RJYbXCm9hsXzA=;
        b=c5YM6Rf9nJrEVMC/K7gF1Sa40IKMFzpHk3sOB0/nh6LhqSrw36MixsgXEiAAl72RMe
         L64dJniytB/JZx0BxDEAHwgA0SSqPrbVzhMx6E9hufOutzxQ2ITTGH3Dpp31+dSH2OrM
         Bfi93ro44LtY9aSiFDT6XN88YNqZYkCMgY9ArUWzG6v3q11rqmANXTPfeB77/UeM2OSA
         Wa5+wtd269BF2xCYdDUlJbdq7zwALT7mrtWbrS7HSKYK10b1VYPLGWuepSRWas38SXze
         cJ6fo4T1DBMVJoWYRWi/+oia/iw+90dqpo4ZzMMPFgmuc9o05PzqtL2VYJd0hinqPDLY
         TogA==
X-Received: by 10.152.133.133 with SMTP id pc5mr10205565lab.32.1359290790619;
        Sun, 27 Jan 2013 04:46:30 -0800 (PST)
Received: from slacktop.getinternet.no (cm-84.212.47.55.getinternet.no. [84.212.47.55])
        by mx.google.com with ESMTPS id tm10sm2326630lab.10.2013.01.27.04.46.29
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 04:46:29 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.349.g4cdd23e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214695>

Changes since v3:
* option -x used to execute non-git commands
* option -z used to NUL-terminate paths
* write_name_quoted() used to print repo paths
* repos are handled in sorted order (as defined by strcmp(3)) to get
  predictable output from the command
* unsetenv() reintroduced to avoid problems from GIT_DIR/WORK_TREE
* more tests

Lars Hjemli (2):
  for-each-repo: new command used for multi-repo operations
  git: rewrite `git -a` to become a git-for-each-repo command

 .gitignore                          |   1 +
 Documentation/git-for-each-repo.txt |  71 ++++++++++++
 Makefile                            |   1 +
 builtin.h                           |   1 +
 builtin/for-each-repo.c             | 145 ++++++++++++++++++++++++
 git.c                               |  37 +++++++
 t/t6400-for-each-repo.sh            | 213 ++++++++++++++++++++++++++++++++++++
 7 files changed, 469 insertions(+)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100755 t/t6400-for-each-repo.sh

-- 
1.8.1.1.349.g4cdd23e
