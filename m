From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/2] Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
Date: Sat, 23 Jul 2011 22:27:29 +1000
Message-ID: <1311424051-29644-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 14:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkbJ7-0004aK-Fg
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 14:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab1GWM1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 08:27:44 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48185 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1GWM1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 08:27:43 -0400
Received: by pzk37 with SMTP id 37so5170930pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=UKsFv2/T+J6yuWJK4SKxqXcZF/p+ZT+5fiVVQYu/IEk=;
        b=X9w2jjeyrPrj8bVecyrFG3mC7Csiu/bc6iiI68yUGLnmscIW2abMZoJYN1BgEsbT7p
         CFn5aWbUXNogRQCfY/1ZnTkiTplAw/nfJ3vYKgCMw6EIPPIZavadTkzJvyYLJDLx+Mxl
         d+HtyRP7OS5rX1qbDNMXjuPBytGoPUWCt0Jrw=
Received: by 10.68.36.199 with SMTP id s7mr487058pbj.225.1311424063041;
        Sat, 23 Jul 2011 05:27:43 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id q2sm2683647pbj.3.2011.07.23.05.27.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 05:27:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g6a5a9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177690>

While working with a damaged repository, I noticed that git ls-tree was reporting an error 
even though it set a zero exit code. 

This patch uses the return code from read_tree_recursive instead.

Jon Seymour (2):
  Add a test to check that git ls-tree sets non-zero exit code on
    error.
  Ensure git ls-tree exits with a non-zero exit code if
    read_tree_recursive fails.

 builtin/ls-tree.c               |    6 +++---
 t/t3103-ls-tree-missing-tree.sh |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100755 t/t3103-ls-tree-missing-tree.sh

-- 
1.7.6.347.g6a5a9c
