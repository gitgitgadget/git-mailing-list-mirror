From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 0/3] Fix documented fixme's throughout
Date: Wed,  7 Mar 2012 17:21:24 -0500
Message-ID: <cover.1331158240.git.jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 23:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PEm-0004p8-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324Ab2CGWVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 17:21:32 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37079 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752636Ab2CGWVa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 17:21:30 -0500
Received: by obbuo6 with SMTP id uo6so7476933obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4EWZH07FRLnlOxtGe4o8O/GfAMLZbrHt4oCoqsx2lFs=;
        b=cCoIb2AccTPlfzdp07w7Cp/A4yjaJuMnCeUhqV7aiWQw1YvjibX8fTPaPFevtAVwg5
         T+KMXhajq3rWPfWHOyWh8veKcvfho5Q3yAVsicuZXgemKqsEmmm9HWyGs1ElnVWKvN4J
         XFW2rdEFB2B280n9I/7bTINVsnDszzyMa6rqcqFBLr8hFxCO2xcJx4GTguHOScFwwah7
         QIwCdrZM5LuE+EQTn1fnjtk/liGg5CJCMWgfRxMKPFS/G74JKOkBuj6850TT0xgr0Cw5
         vHAZzGuxRdBCT/sNSZNDy3U35k4XA6ReN8RdaEYJ74BbHQIH7Wcvtnyv1N0NloohU6Wl
         oo0g==
Received: by 10.182.231.41 with SMTP id td9mr1487178obc.22.1331158890105;
        Wed, 07 Mar 2012 14:21:30 -0800 (PST)
Received: from localhost.localdomain (mail.middletownlibrary.org. [66.213.99.6])
        by mx.google.com with ESMTPS id gl4sm23853230obb.23.2012.03.07.14.21.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 14:21:29 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192492>

A few patches that (hopefully) don't change the behavior of git except to
rectify a memory error. Also, this should ever so slightly help with
the parallelism of git (a GSoC proposal). All of these were found with
commented FIXME and git grep.

Jared Hance (3):
  Fix memory leak in apply_patch in apply.c.
  Add threaded versions of functions in symlinks.c.
  Use startup_info->prefix rather than prefix.

 builtin/apply.c |   31 ++++++++++++++++++++++++++++---
 cache.h         |    4 +++-
 git.c           |    2 +-
 symlinks.c      |   28 ++++++++++++++++++++++++++--
 trace.c         |   10 +++++-----
 5 files changed, 63 insertions(+), 12 deletions(-)

-- 

Minor style changes and move the most controversial commit to the end of the
patch series.

Sorry, accidently sent out an old saved version of this just a bit before.

1.7.3.4
