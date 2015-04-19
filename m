From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V2 0/2] git-p4: improve client path detection with branches used
Date: Sun, 19 Apr 2015 11:56:47 +0100
Message-ID: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com>
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 12:57:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjmui-0001Ty-HK
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 12:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbbDSK5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 06:57:19 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32973 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbDSK5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 06:57:18 -0400
Received: by wiax7 with SMTP id x7so62958032wia.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UgHeaqeR4ZjDnLSu51WrCGv0tSEEBqZ3Im44RoPdlBk=;
        b=N3RpSUujS7A+nXRnU8gfuWVn1GMtk/Imm0NxuiiF0kV0eGxvWL2XVTmWlte2+Pcw0H
         YSHDJnvX4JIh8092+uRLSyjDsE3TWWFzkPoM2J35Q/CGCOBbAnOvr4mL0oVUcBkWJYlP
         Bfll/4rDLYu1wtdSu+jPV1Hdf0uewmytGfIbN2yvhK12HbJ+khbxxSJeead7LfyZL1oB
         t/tah0RB56IuHTNTvnRVjDghXLl/8PpzHcAGoavCYs/0Nk8+vhURDsygTbgWtDigw34T
         Ux9ePo8XMoeB4jLRs7IqwvIUglX5xj9ReiRqgDVkaBqDROxfiO/IRMj5r72LhoFhR8Zf
         geFg==
X-Received: by 10.194.19.197 with SMTP id h5mr21204459wje.109.1429441037551;
        Sun, 19 Apr 2015 03:57:17 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id z13sm22576630wjr.44.2015.04.19.03.57.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2015 03:57:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267435>

Robustness improvement in regards to previous patches, both in the test case and
git-p4 functionality.

1. Test case now includes a mapped sub-file, to guarantee that git-p4 copes with
   such client view.

2. git-p4 now searches for paths starting with the branch's depot path and
   ending with "/..." to guarantee that the correct client side path is
   identified.

Vitor Antunes (2):
  t9801: check git-p4's branch detection and client view together
  git-p4: improve client path detection when branches are used

 git-p4.py                |   13 ++++--
 t/t9801-git-p4-branch.sh |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 4 deletions(-)

-- 
1.7.10.4
