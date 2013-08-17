From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/2] Don't print status output with submodule.<name>.ignore=all
Date: Sat, 17 Aug 2013 17:25:41 +0000
Message-ID: <1376760343-741047-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 17 19:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAkGE-0007U7-IU
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 19:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab3HQRZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 13:25:51 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45913 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753878Ab3HQRZv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Aug 2013 13:25:51 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E03C928073
	for <git@vger.kernel.org>; Sat, 17 Aug 2013 17:25:49 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232464>

There are configuration options for each submodule that specify under what
circumstances git status should display output for that submodule.
Unfortunately, these settings were not being respected, and as such the tests
were marked TODO.

This patch series consists of two patches: the first is a fix for a confusing
variable name, and the latter actually makes git status not output the submodule
information.  The tests have been updated accordingly.

Changes from v1:

* Handle moved submodules by not ignoring them.
* Use sm_path instead of path.
* Only ignore when --for-status is given.

brian m. carlson (2):
  submodule: fix confusing variable name
  submodule: don't print status output with ignore=all

 git-submodule.sh  | 15 +++++++++++----
 t/t7508-status.sh |  4 ++--
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
1.8.4.rc2.564.g10ce5ae
