From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 0/5] git-p4: small fixes to branches and labels
Date: Thu, 19 Jan 2012 09:52:24 +0000
Message-ID: <1326966749-9077-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 10:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnofu-00023s-Je
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149Ab2ASJwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 04:52:39 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50038 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab2ASJwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:52:39 -0500
Received: by wics10 with SMTP id s10so212418wic.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:52:37 -0800 (PST)
Received: by 10.180.100.130 with SMTP id ey2mr9713721wib.15.1326966757768;
        Thu, 19 Jan 2012 01:52:37 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id bj10sm27093411wib.9.2012.01.19.01.52.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 01:52:37 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188799>

This is the fourth version of some small fixes to git-p4 branch and
label handling, incorporating a fix from Pete Wyckoff and an
additional failing test.

This change does not fix the other problems with git-p4 labels:

- two p4 labels on the same changelist will fall over
- labels must match exactly the list of files imported
- you can't import a label without a p4 commit


Luke Diamand (5):
  git-p4: handle p4 branches and labels containing shell chars
  git-p4: cope with labels with empty descriptions
  git-p4: importing labels should cope with missing owner
  git-p4: add test for p4 labels
  git-p4: label import fails with multiple labels at the same
    changelist

 contrib/fast-import/git-p4        |   79 ++++++++++++++-----------
 t/t9803-git-p4-shell-metachars.sh |   48 ++++++++++++++++
 t/t9804-git-p4-label.sh           |  113 +++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 35 deletions(-)
 create mode 100755 t/t9804-git-p4-label.sh

-- 
1.7.8.rc1.209.geac91.dirty
