From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/2] submodule: Don't print status output with submodule.<name>.ignore=all
Date: Sun,  1 Sep 2013 20:06:47 +0000
Message-ID: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, judge.packham@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 22:07:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGDvH-0001ZE-Tc
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 22:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab3IAUG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 16:06:56 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60024 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752086Ab3IAUGz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Sep 2013 16:06:55 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 338A228073;
	Sun,  1 Sep 2013 20:06:53 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233591>

There are configuration options for each submodule that specify under
what circumstances git status should display output for that submodule.
Unfortunately, these settings were not being respected, and as such the
tests were marked TODO.

This patch series consists of two patches: the first is a fix for a
confusing variable name, and the latter actually makes git status not
output the submodule information.  The tests have been updated
accordingly, and additional tests have been included to ensure that git
submodule summary is not affected by these changes unless the
--for-status option is given.

Changes from v2:

* Add tests to ensure that git submodule summary is not affected.
* Fix bug that caused git submodule summary to be affected.

Changes from v1:

* Handle moved submodules by not ignoring them.
* Use sm_path instead of path.
* Only ignore when --for-status is given.

brian m. carlson (2):
  submodule: fix confusing variable name
  submodule: don't print status output with ignore=all

 git-submodule.sh             | 15 +++++++++++----
 t/t7401-submodule-summary.sh | 30 ++++++++++++++++++++++++++++++
 t/t7508-status.sh            |  4 ++--
 3 files changed, 43 insertions(+), 6 deletions(-)

-- 
1.8.4.rc3
