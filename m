From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 14 Mar 2014 00:37:49 -0400
Message-ID: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 05:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJu9-0002wf-26
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbaCNEjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:39:01 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:48966 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaCNEjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:39:00 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so2079616iec.11
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 21:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+bK1J1K25MCJhEI1AqGgo4TkoHoRn9zliETsE7jN+K8=;
        b=sDKfEEuZUGDamyXXsEDemf30jYXVBYyDRerrrGcFkUCm9nmbHtGv4cUlCOGCL77X3v
         O2P9pyIXK9utEHKbfJUAInwqVwpvZ2ORhn6X04LREKwpJUwxe22w26BUTKS0y5OMKYh5
         vq7gd01Vy+xlckRKXX9G2TKbqlCIG+y76o300GiJgyNEGBaAmBXyb8l/maG26QoVUspL
         Q9mpXqZnXIbf8YNh/OEYyIeF6WA+4lUsvJK95hOcKNrT8mZO6JK+K5v16pDMoSv3fSB3
         +XfnZzajUA1WiLI6x2nfYpD5md0KtUuMXQUqI+NrnL8R3xsm6aDHXP6S1J3eP00S5Drp
         bCig==
X-Received: by 10.50.73.130 with SMTP id l2mr5524420igv.42.1394771940588;
        Thu, 13 Mar 2014 21:39:00 -0700 (PDT)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id ji9sm2293656igb.1.2014.03.13.21.38.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 21:38:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.175.gb69385f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244077>

2/3: I've added advice.mergeHints to silent the messages that suggests "git
merge--abort".

3/3: I've added a warning message when users used "git reset" during a merge.
This warning will be printed if the user is in the middle of a merge. In future
releases, we'll change this into an error to prevent work tree from becoming a
mess.

Andrew Wong (3):
  wt-status: Make status messages more consistent with others
  merge: Advise user to use "git merge --abort" to abort merges
  reset: Print a warning when user uses "git reset" during a merge

 Documentation/config.txt |  3 +++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 builtin/merge.c          |  6 ++++++
 builtin/reset.c          | 21 +++++++++++++++++++++
 wt-status.c              | 23 +++++++++++++----------
 6 files changed, 46 insertions(+), 10 deletions(-)

-- 
1.9.0.174.g6f75b8f
