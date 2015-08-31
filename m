From: larsxschneider@gmail.com
Subject: [PATCH] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 17:40:15 +0200
Message-ID: <1441035616-39128-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 17:40:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWRC9-0004Qg-7l
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 17:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbbHaPkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 11:40:21 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35030 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbbHaPkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 11:40:20 -0400
Received: by wibq14 with SMTP id q14so4394507wib.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0Ud8EQqFXwgYwnWLAhU7JpZ7qzeoYq73tvN7Js4Z7u0=;
        b=gBZMg4Pb21Ut/hibKIezxva+HDKrTSLYUbVNuxjzKgLIG5BiSlSou/g5pPQ7wysEt7
         LwbDSJcUXLvr7/OekQlXcHhTCwGO5Miqglh4jiTNzrRsqtZmAMLC3KcxfWV9i7hdcJTG
         l0y7oUqcSP8kTRZ09VWfg29PiagODTknRgyxWN6giX9p5WbbRPY5MHplVEajKlhgFf3y
         ISnn/l9Rd8M0eu4GAtOM0aChRjxk/ooCAvLDhwRvQUATDumf54rpPgbACpS4NBbQM6Bj
         rVZxLMlE4T1cLR0MdY1wiLwaL+SvMx2Th861yjUhH40yWtpZDBkaottKWyBdSJNXNHkK
         pnrg==
X-Received: by 10.194.158.34 with SMTP id wr2mr28129150wjb.23.1441035619324;
        Mon, 31 Aug 2015 08:40:19 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id fz16sm18598204wic.3.2015.08.31.08.40.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 08:40:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276884>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

I think I discovered a path encoding issue if you migrate P4 repositories that contain path names generated with Windows. I added a test case to prove my point. Character encoding is a complicated topic. Feedback is highly appreciated.

Thanks,
Lars

Lars Schneider (1):
  git-p4: add "--path-encoding" option

 Documentation/git-p4.txt        |  4 ++++
 git-p4.py                       |  6 ++++++
 t/t9821-git-p4-path-encoding.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100755 t/t9821-git-p4-path-encoding.sh

--
2.5.1.1.g36ff854
