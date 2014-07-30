From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 0/5] git_config callers rewritten with the new config cache API
Date: Wed, 30 Jul 2014 06:39:04 -0700
Message-ID: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 15:40:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCU7D-0000gU-93
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 15:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbaG3NkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 09:40:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58954 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaG3NkP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 09:40:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so1535993pab.5
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pvHQk8MR3BsiGCjqrettCUc0E6cZ8w69CSGewm1xO3Y=;
        b=SgNMZmfoZR3VqXKonGiCJZsHeJJuVMq6J9TJRfx/8iadok7YXpiaG4SUh74fbyOWDc
         8Ef0q2DrCCIDXPgu1gvTJQPIk4qhLndwzjCBMG9aZiRZwUFyOHCt/WVme9WheP8TCu83
         nMzukE60q614z8rKxlE6H94fkbT5mTrfWmSurng5fboIB2KsbwANLqvxykm96vixp/lV
         jOwQU9I/z2HAeX10ZqzrpWhBE3dgqeMjT89e7iRfqIafd2Qi3dcwWWnKFev8JVFSJx8k
         HSSR2AUHY34kjxIpnYF3Ms+E+ZANvmQPSQG8Z+WQJ4qOPoC3Q0HqGhagh63aOHycdaxL
         MpSg==
X-Received: by 10.70.134.193 with SMTP id pm1mr4676782pdb.117.1406727614752;
        Wed, 30 Jul 2014 06:40:14 -0700 (PDT)
Received: from localhost.localdomain ([223.184.63.185])
        by mx.google.com with ESMTPSA id y4sm2397686pbt.60.2014.07.30.06.40.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 06:40:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254488>

[PATCH v4]: Tiny style nits corrected. Patch 2/5 has been totally reworked.
	One thing to check is if the config variables I changed in the series
	are single valued or multi valued. Though I have tried to ascertain
	if the variable was single valued or not by reading the docs and code,
	mistakes may creep in.

[PATCH v3]: Most of Eric's suggestions has been implemented. See [2] for discussion.
	Also, new helpers introduced in v7 of the config-set API series have been used.

This series builds on the top of 4c715ebb in pu (ta/config-set).
See [1] for the documentation of the new API functions and a general description of the
new API.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/254286/
[2]: http://thread.gmane.org/gmane.comp.version-control.git/252334

Tanay Abhra (5):

 alias.c     | 25 ++++++-------------------
 branch.c    | 24 ++++--------------------
 imap-send.c | 61 +++++++++++++++++++++++++++----------------------------------
 notes.c     | 29 ++++++++++++++---------------
 pager.c     | 40 +++++++++++++---------------------------
 5 files changed, 64 insertions(+), 115 deletions(-)

-- 
1.9.0.GIT
