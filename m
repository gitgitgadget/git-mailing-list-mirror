From: Dan Williams <dan.j.williams@intel.com>
Subject: [StGit PATCH] fix export -s
Date: Wed, 03 Dec 2008 12:18:17 -0700
Message-ID: <20081203191817.8016.5209.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 03 20:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7xG7-0004dB-OV
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 20:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYLCTST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 14:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbYLCTST
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 14:18:19 -0500
Received: from mga03.intel.com ([143.182.124.21]:37339 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbYLCTSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 14:18:18 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 03 Dec 2008 11:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,709,1220252400"; 
   d="scan'208";a="86090625"
Received: from dwillia2-linux.ch.intel.com (HELO dwillia2-linux.localdomain) ([10.2.42.224])
  by azsmga001.ch.intel.com with ESMTP; 03 Dec 2008 11:18:17 -0800
Received: from dwillia2-linux.ch.intel.com (localhost.localdomain [127.0.0.1])
	by dwillia2-linux.localdomain (Postfix) with ESMTP id CFE59248B69;
	Wed,  3 Dec 2008 12:18:17 -0700 (MST)
User-Agent: StGit/0.14.3.289.g7daff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102279>

Resolves:
stg export -s `stg top`
Traceback (most recent call last):
  File "/usr/local/lib/python2.5/site-packages/stgit/main.py", line 152, in _main
    ret = command.func(parser, options, args)
  File "/usr/local/lib/python2.5/site-packages/stgit/commands/export.py", line 169, in func
    f = sys.stdout
NameError: global name 'sys' is not defined

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 stgit/commands/export.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index dfdcea1..1236b01 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -19,6 +19,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
 import os
+import sys
 from stgit.argparse import opt
 from stgit.commands import common
 from stgit import argparse, git, templates
