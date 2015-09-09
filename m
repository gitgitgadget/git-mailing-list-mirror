From: larsxschneider@gmail.com
Subject: [PATCH v4 0/5] git-p4: add support for large file systems
Date: Wed,  9 Sep 2015 13:59:05 +0200
Message-ID: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 13:59:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZe2N-0001L2-JD
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 13:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbbIIL7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 07:59:15 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38618 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbbIIL7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 07:59:13 -0400
Received: by wiclk2 with SMTP id lk2so18885773wic.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=lf4eHdzm8/TC8vfYkMR233i69PrIPHLj0r43Hr6rYPs=;
        b=um3KhUGA8/Dta9rT/sINkhYMDaG1l3S19eDMDKDeaEK2jNH/J90o/V0OwG0z58pxKr
         pKZNzVBJIBcWsNvpiTceyEzYc6Aym2F46skhcTo6vnFItNeRC2hkWOGElbxOEikaRw85
         Pmfhi5eRRyDHoVwVIwCe0f1GycxacL3sqpG1C5I3Var1Z835VOwQ/LML4DOKYrDjcBuK
         J3PJu1zeNJRPuXenjgzoMWjZE4iHi/WoTGvqkDBQrazVg8OuXokOumJrJyO4RP1HDdod
         syOOTCjwBqG9xVGhnbYZg1kQjfSBWpMRPfOxaF1v8prcbxPtFcBgowlSEeO14dIyQNEs
         QGCw==
X-Received: by 10.180.91.131 with SMTP id ce3mr56318477wib.84.1441799952559;
        Wed, 09 Sep 2015 04:59:12 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u1sm3498338wiz.22.2015.09.09.04.59.11
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2015 04:59:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277548>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v3:
* add large file system mock class for testing (Thanks Luke!)
* add early exit for compressed threshold: If a file is smaller then the threshold then we don't need to compress it.

Thanks,
Lars

Lars Schneider (5):
  git-p4: add optional type specifier to gitConfig reader
  git-p4: add gitConfigInt reader
  git-p4: return an empty list if a list config has no values
  git-p4: add support for large file systems
  git-p4: add Git LFS backend for large file system

 Documentation/git-p4.txt   |  28 +++++
 git-p4.py                  | 223 +++++++++++++++++++++++++++++++++++++---
 t/t9823-git-p4-mock-lfs.sh | 106 +++++++++++++++++++
 t/t9824-git-p4-git-lfs.sh  | 249 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 593 insertions(+), 13 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh
 create mode 100755 t/t9824-git-p4-git-lfs.sh

--
2.5.1
