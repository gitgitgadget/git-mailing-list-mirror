From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 0/3] git-p4: Search for parent commit on branch creation
Date: Sat, 21 Jan 2012 00:21:29 +0000
Message-ID: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:22:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOie-0005rg-Ux
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab2AUAVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:21:45 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61679 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab2AUAVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:21:44 -0500
Received: by wgbed3 with SMTP id ed3so950759wgb.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 16:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=G+K2FDHzNTuJJLjvdjJxdFb4PEQJEbZGN2hS002pC4o=;
        b=wD2c+1N6GDZSetbbCSfH6fpVbxhTH0DxeJtaMt4+nrCBTjAWd8Gs8rh0KcTOPeK8cX
         xB18lOckuoEN1qeKqRnm5plhrcPxAoJPdyYhDHLM427dqPSgiDsKjIfzskKQ1OWcJU+y
         HoiLHxzsEkBzb23bg0M8qbcS4jjQ7wIsJAPgg=
Received: by 10.180.106.38 with SMTP id gr6mr961201wib.0.1327105303609;
        Fri, 20 Jan 2012 16:21:43 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q7sm566234wix.5.2012.01.20.16.21.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 16:21:42 -0800 (PST)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188913>

The new version of these patches includes the improvement suggestions
from Pete Wyckoff:

 - Use os.path.join().
 - Use git update-ref -d to remove refs.
 - Read $GIT_DIR environment variable.
 - Optimize comparison cycle to avoid excessive use of checkpoint
   command.

Vitor Antunes (3):
  git-p4: Add checkpoint() task
  git-p4: Search for parent commit on branch creation
  git-p4: Add test case for complex branch import

 contrib/fast-import/git-p4 |   38 ++++++++++++++++++++-
 t/t9801-git-p4-branch.sh   |   80 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 1 deletions(-)

-- 
1.7.7.rc2.14.g5e044.dirty
