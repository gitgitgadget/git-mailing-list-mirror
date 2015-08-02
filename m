From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 0/4] notes: add support for notes.merge option
Date: Sun,  2 Aug 2015 03:10:22 -0700
Message-ID: <1438510226-1163-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 12:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLqE1-0000Me-GE
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 12:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbbHBKKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 06:10:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:22472 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbbHBKKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 06:10:31 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 02 Aug 2015 03:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,594,1432623600"; 
   d="scan'208";a="534566115"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2015 03:10:31 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275133>

From: Jacob Keller <jacob.keller@gmail.com>

This series incorporates the feedback from both Johan and Eric. In
addition, I included an RFC implementing suggestion from Johan regarding
per-ref merge strategies.

I split the tests for --merge/--commit/--strategy out into their own
patch to help review and keep the "one commit = one change" logic.

I am not certain the RFC is ready yet, but the first 3 patches (now
based on next) should be ready to go.

Jacob Keller (4):
  notes: document cat_sort_uniq rewriteMode
  notes: add tests for --commit/--abort/--strategy exclusivity
  notes: add notes.merge option to select default strategy
  notes: add per-ref configuration of merge strategy

 Documentation/config.txt              |  18 +++-
 Documentation/git-notes.txt           |  23 ++++-
 builtin/notes.c                       | 167 ++++++++++++++++++++++++++++++----
 notes-merge.h                         |  16 ++--
 t/t3309-notes-merge-auto-resolve.sh   |  79 ++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh |  12 +++
 6 files changed, 288 insertions(+), 27 deletions(-)

-- 
2.5.0.482.gfcd5645
