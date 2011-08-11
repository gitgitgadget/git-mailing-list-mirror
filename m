From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 0/5] fixes for committer/author parsing/check
Date: Thu, 11 Aug 2011 16:21:05 +0600
Message-ID: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 12:21:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSO2-0004S2-DJ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab1HKKU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:20:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56320 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab1HKKU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:20:57 -0400
Received: by bke11 with SMTP id 11so867233bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=p7GPwul1AZRa0OsjrIEzfxdbevwL9bvgQOHdtRcFG1M=;
        b=B5pjKWXfD8nk73edhsgsfJx/X67+RN3G9P60FucBhf/E4NQmeQPNHc7CMaWxJ7v7po
         c5v2Yj/5510a0ER+xwuEibnWCBcoKUC8jOXiO4qyHoN/nPKBfzcq7vOFFGirZFBcSCVJ
         KaHEmMC4PnL6HWLgY7o9Tm6phAEc8Y/Z8vILw=
Received: by 10.204.138.200 with SMTP id b8mr3022028bku.45.1313058056170;
        Thu, 11 Aug 2011 03:20:56 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id p15sm476918bkd.62.2011.08.11.03.20.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:20:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179101>

This is a second version of [1]. It features one more test for a
fsck message and reworked commit messages.

Aside from fixing a parsing bug in fast-import and improving error
messages in git-fsck it makes them both to deny "name> <email>"
identities.

[1] http://thread.gmane.org/gmane.comp.version-control.git/178035

Dmitry Ivankov (5):
  fast-import: add input format tests
  fast-import: don't fail on omitted committer name
  fast-import: check committer name more strictly
  fsck: add a few committer name tests
  fsck: improve committer/author check

 Documentation/git-fast-import.txt |    4 +-
 fast-import.c                     |   33 ++++++++-----
 fsck.c                            |   10 ++--
 t/t1450-fsck.sh                   |   36 +++++++++++++
 t/t9300-fast-import.sh            |   99 +++++++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+), 18 deletions(-)

-- 
1.7.3.4
