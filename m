From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 0/4] tag: configure default tag sort via .gitconfig
Date: Tue, 15 Jul 2014 14:29:10 -0700
Message-ID: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 23:29:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7AHs-0001gV-FK
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 23:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbaGOV3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 17:29:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:55381 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaGOV3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 17:29:20 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 14:29:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="573664221"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2014 14:29:19 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253602>

This patch series is hopefully the final version of a series of patches which
updates git-tag to allow the .gitconfig variable 'tag.sort' to be used as the
default sort parameter. This version uses a new set/pop error routine setup
which enables correctly modifying the error routine to handle the config vs the
command line.

In addition, I split the patch such that all the changes to the original
parse_opt_sort are shown, and the following patch which extracts this function
is just a function extraction with no changes, making it easier to review the
new changes. One other minor bug fix is included as well.

Jacob Keller (4):
  usage: make error functions a stack
  tag: fix --sort tests to use cat<<-\EOF format
  tag: update parsing to be more precise regarding errors
  tag: support configuring --sort via .gitconfig

 Documentation/config.txt  |  5 +++
 Documentation/git-tag.txt |  5 ++-
 builtin/tag.c             | 97 ++++++++++++++++++++++++++++++++++++-----------
 git-compat-util.h         |  1 +
 t/t7004-tag.sh            | 76 +++++++++++++++++++++++++++----------
 usage.c                   | 29 ++++++++++++--
 6 files changed, 167 insertions(+), 46 deletions(-)

-- 
2.0.1.475.g9b8d714
