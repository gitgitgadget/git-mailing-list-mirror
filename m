From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 0/2] refs: cleanup and new behavior
Date: Wed, 22 Jul 2015 14:05:31 -0700
Message-ID: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:05:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI1D2-0004cH-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 23:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbGVVFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 17:05:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:27486 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbbGVVFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 17:05:37 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 22 Jul 2015 14:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,525,1432623600"; 
   d="scan'208";a="769372403"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2015 14:05:36 -0700
X-Mailer: git-send-email 2.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274468>

From: Jacob Keller <jacob.keller@gmail.com>

As per Junio's suggestion, break cleanup/fix and new functionality into
separate patches. Also update description of the new functionality.

The first patch is entirely cleanup of comments with no functionality
change at all (indeed only changes to comment text!). It now correctly
highlights all characters which are disallowed. Discovered by creating a
test function that printed out the whole list.

The second patch introduces the new functionality for "*" and details
how it is now checked per-component. It also explains how the flags are
now passed as a pointer so that we can reject any multi-"*" reference,
by clearing the REFNAME_REFSPEC_PATTERN bit.

Change since v4
- split the cleanup to a separate patch and included all missing values
  from the disposition "4" on the comments.

Jacob Keller (2):
  refs: cleanup comments regarding check_refname_component
  refs: loosen restriction on wildcard "*" refspecs

 Documentation/git-check-ref-format.txt |  4 ++--
 refs.c                                 | 44 +++++++++++++++++++---------------
 refs.h                                 |  4 ++--
 t/t1402-check-ref-format.sh            |  8 ++++---
 4 files changed, 34 insertions(+), 26 deletions(-)

-- 
2.4.3
