From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH 0/3] Support for loading .gitmodules from blobs
Date: Wed, 24 Jun 2009 21:48:02 +0400
Message-ID: <1245865685-1288-1-git-send-email-constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 19:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJWac-0003ms-S3
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 19:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760378AbZFXRsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 13:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761371AbZFXRsL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 13:48:11 -0400
Received: from mail.intellij.net ([213.182.181.98]:51268 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760889AbZFXRsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 13:48:09 -0400
Received: (qmail 32252 invoked by uid 89); 24 Jun 2009 17:48:05 -0000
Received: by simscan 1.1.0 ppid: 32219, pid: 32244, t: 0.0358s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 24 Jun 2009 17:48:05 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122148>

This series of patches is developed to support accessing 
.gitmodules file stored inside the repository. This functionality
is needed for server-side processing of submodules.

Constantine Plotnikov (3):
 Extracted functionality independent from .git/config from RepositoryConfig
 Config.getSubsections(...) now loads the file if it has not been loaded
 Added BlobBasedConfig that allows accessing configuration files stored in the blobs

 .../src/org/spearce/jgit/lib/BlobBasedConfig.java  |  145 +++
 .../src/org/spearce/jgit/lib/Commit.java           |    7 +
 .../src/org/spearce/jgit/lib/Config.java           | 1018 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |  120 +++
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |  939 +------------------
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    2 +-
 6 files changed, 1301 insertions(+), 930 deletions(-)
