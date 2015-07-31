From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 0/2] notes: add notes.merge strategy option
Date: Fri, 31 Jul 2015 16:12:19 -0700
Message-ID: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:12:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLJTh-0003sa-N9
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbbGaXMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:12:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:46299 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbbGaXMc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:12:32 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP; 31 Jul 2015 16:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,587,1432623600"; 
   d="scan'208";a="617069086"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2015 16:12:31 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275091>

From: Jacob Keller <jacob.keller@gmail.com>

This series adds a default merge strategy option for git-notes, so that
the user does not have to type "-s" every time. It is overridden by the
-s option.

I also added some tests to ensure that the "--abort" "--commit" and "-s"
options must be independent. In addition, I found a small documentation
bug which is corrected in the first patch of the series.

I Cc'd a couple more people in this version of the patch in order to
hopefully get some more review. This is based on pu incase there were
any other conflicts, but I can easily rebase if necessary.

Jacob Keller (2):
  notes: document cat_sort_uniq rewriteMode
  notes: add notes.merge option to select default strategy

 Documentation/config.txt              | 11 +++++--
 Documentation/git-notes.txt           | 33 +++++++++++++--------
 builtin/notes.c                       | 55 +++++++++++++++++++++++++----------
 notes-merge.h                         | 16 +++++-----
 t/t3309-notes-merge-auto-resolve.sh   | 29 ++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh | 12 ++++++++
 6 files changed, 119 insertions(+), 37 deletions(-)

-- 
2.5.0.482.gfcd5645
