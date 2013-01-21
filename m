From: Barry Wardell <barry.wardell@gmail.com>
Subject: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Mon, 21 Jan 2013 01:22:00 +0000
Message-ID: <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
References: <20120308005103.GA27398@dcvr.yhbt.net>
Cc: Barry Wardell <barry.wardell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 02:28:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx6BI-0006DN-IB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab3AUB1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:27:50 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:39996 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab3AUB1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:27:50 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so97245wgi.27
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 17:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=rc5qIjbWgBlY1zxgGSrq3MXKTUrEOzi9UluPsPDjJYc=;
        b=YolIIZ7j1x9IF3Vi2g/UZDVRn6Ct12InSin0Tc5WsKHIWyf/RrUsqIAhE8FXLrybXH
         ZdeQTqSP4o9apK4nJPpGNTgaZoJNKHn/HKmADIOqM9H5UMQgTLRlCXroP2Uux9ANPWqY
         9M2n08s9FXTybuybMSPleFVILrHLKKmIaxrVOQj3g0LUDswTdhh7iyNdP/gqLU2C+Ncy
         T2aWLcuaCw7DEjTzN2cbbsqSYDT6vYRpAKhSlqyqUA4F0S7LOVMZsSSZr1pT72b2vNLa
         T93b9BA1449qSy1Xrw5B5BSOwh10a+QCcK/B9oGn9DNY73oy329FTnvdZmku/6662baP
         VQMQ==
X-Received: by 10.180.95.135 with SMTP id dk7mr12785451wib.29.1358731325484;
        Sun, 20 Jan 2013 17:22:05 -0800 (PST)
Received: from localhost.localdomain (87-198-121-119.ptr.magnet.ie. [87.198.121.119])
        by mx.google.com with ESMTPS id hu8sm14717231wib.6.2013.01.20.17.22.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 17:22:03 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <20120308005103.GA27398@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214066>

These patches fix a bug which prevented git-svn from working with repositories
which use gitdir links.

Changes since v2:
 - Rebased onto latest master.
 - Added test case which verifies that the problem has been fixed.
 - Fixed problems with git svn (init|clone|multi-init).
 - All git-svn test cases now pass (except two in t9101 which also failed
   before these patches).

Barry Wardell (2):
  git-svn: Add test for git-svn repositories with a gitdir link
  git-svn: Simplify calculation of GIT_DIR

 git-svn.perl             | 36 +++++++++++++-----------------------
 t/t9100-git-svn-basic.sh |  8 ++++++++
 2 files changed, 21 insertions(+), 23 deletions(-)

-- 
1.8.0
