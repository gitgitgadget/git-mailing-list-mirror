From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v5 0/4] Add --base option to git-format-patch to record base tree info
Date: Fri, 22 Apr 2016 13:42:32 +0800
Message-ID: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 07:44:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atTsq-0001Tn-L7
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 07:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbcDVFn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 01:43:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:18374 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbcDVFn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 01:43:58 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 21 Apr 2016 22:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,516,1455004800"; 
   d="scan'208";a="950498143"
Received: from yexl-desktop.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2016 22:43:48 -0700
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292168>

Thanks for Junio's reviews and suggestions.

This version contains the following changes since v4:

 - Refine the commit log as well as the documentation according to
   Junio's comments.

 - Separate out get_base_commit function from prepare_bases to obtain
   the base commit.

 - Use repeated pair-wise computation to get the merge base for the
   validation of base commit.

 - Extract "auto handling thing" from prepare_bases and put it into
   get_base_commit.

 - Use format.useAutoBase boolean variable for the auto configuration
   in format section.


Thanks,
Xiaolong.

Xiaolong Ye (4):
  patch-ids: make commit_patch_id() a public helper function
  format-patch: add '--base' option to record base tree info
  format-patch: introduce --base=auto option
  format-patch: introduce format.useAutoBase configuration

 Documentation/config.txt           |   5 ++
 Documentation/git-format-patch.txt |  60 ++++++++++++++
 builtin/log.c                      | 165 +++++++++++++++++++++++++++++++++++++
 patch-ids.c                        |   2 +-
 patch-ids.h                        |   2 +
 t/t4014-format-patch.sh            |  48 +++++++++++
 6 files changed, 281 insertions(+), 1 deletion(-)

-- 
2.8.1.221.ga4c6ba7

base-commit: e6ac6e1f7d54584c2b03f073b5f329a37f4a9561
