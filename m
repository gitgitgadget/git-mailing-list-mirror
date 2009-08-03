From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] hg-to-git: don't import the unused popen2 module
Date: Mon, 3 Aug 2009 18:41:34 +0200
Message-ID: <20090803164134.GZ23059@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 18:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY0bZ-0001YY-VF
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 18:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbZHCQlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 12:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbZHCQlg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 12:41:36 -0400
Received: from virgo.iok.hu ([212.40.97.103]:54626 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932159AbZHCQlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 12:41:36 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7BD1D580AE;
	Mon,  3 Aug 2009 18:41:34 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 63FC7448F6;
	Mon,  3 Aug 2009 18:41:34 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 68B1E11F0828; Mon,  3 Aug 2009 18:41:34 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124704>

Importing the popen2 module in Python-2.6 results in the
"DeprecationWarning: The popen2 module is deprecated.  Use the
subprocess module." message. The module itself isn't used in fact, so
just removing it solves the problem.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hg-to-git/hg-to-git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 7b03204..2a6839d 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -20,7 +20,7 @@
 """
 
 import os, os.path, sys
-import tempfile, popen2, pickle, getopt
+import tempfile, pickle, getopt
 import re
 
 # Maps hg version -> git version
-- 
1.6.4
