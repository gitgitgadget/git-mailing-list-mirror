From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 0/3] git-p4: Search for parent commit on branch creation
Date: Mon, 16 Jan 2012 00:39:17 +0000
Message-ID: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 01:39:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmaby-00064O-Dh
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 01:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab2APAjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 19:39:41 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40303 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab2APAjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 19:39:41 -0500
Received: by wibhm6 with SMTP id hm6so227546wib.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 16:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6g5o9CKkxjnZOqg0NBCD9Px3Rq5Q50PwywbAE43cbLo=;
        b=T09K22+VGcRYSV0VVXhBkSOrzlxcRVt1xUhlOBzVCuhie4QSUnMywElVdL1gH5A3Q/
         QvUazxrNiry3p+wHoeKsuofgdKcZzYyKT365q9taHtoIuPH+5Ii/kv+y/3E888Y9uAK7
         ANGGQEj0bBEp3XiKu2Itjhb3bw3mbFik+NYnQ=
Received: by 10.180.96.7 with SMTP id do7mr10757347wib.16.1326674379872;
        Sun, 15 Jan 2012 16:39:39 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q5sm20225601wbo.8.2012.01.15.16.39.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 16:39:39 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188601>

This patch was originally sent as a RFC and was improved since then
according to feedback given by Pete Wyckoff. At the time it required
calling fast-import with the --force argument. To avoid this the new
version tracks the temporary branches created during post-processing and
removes them at the end of the import process.

Vitor Antunes (3):
  git-p4: Add checkpoint() task
  git-p4: Search for parent commit on branch creation
  git-p4: Add test case for complex branch import

 contrib/fast-import/git-p4 |   39 ++++++++++++++++++++-
 t/t9801-git-p4-branch.sh   |   83 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 1 deletions(-)

-- 
1.7.8.3
