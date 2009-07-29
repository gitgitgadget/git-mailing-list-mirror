From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/5] Some minor bug fixes
Date: Wed, 29 Jul 2009 08:50:22 -0700
Message-ID: <1248882627-7285-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBQl-0000Sa-W8
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 17:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbZG2Pu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 11:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbZG2Pu3
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 11:50:29 -0400
Received: from george.spearce.org ([209.20.77.23]:45978 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbZG2Pu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 11:50:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4683F38215; Wed, 29 Jul 2009 15:50:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5971138195;
	Wed, 29 Jul 2009 15:50:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc3.201.gd9d59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124357>

I'm just throwing this series into the repository as-is.

The first in the series is needed to fix Gerrit Code Review (busted
due to a recent change to ReceivePack).  The rest of the series is
really minor public API corrections.

Shawn O. Pearce (5):
  Don't dispose of RevFlag used to advertise objects in ReceivePack
  Allow RemoteConfig.getAllRemoteConfigs on any Config object
  Add ConfigInvalidException constructor to take Throwable
  Add no fallback constructor to FileBasedConfig
  Include the file path when FileBasedConfig.load throws an exception

 .../tst/org/spearce/jgit/lib/MockSystemReader.java |    2 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    2 +-
 .../jgit/errors/ConfigInvalidException.java        |   12 ++++++++++++
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |   16 ++++++++++++++++
 .../org/spearce/jgit/transport/ReceivePack.java    |    1 -
 .../org/spearce/jgit/transport/RemoteConfig.java   |    5 ++---
 .../src/org/spearce/jgit/util/SystemReader.java    |    3 +--
 7 files changed, 33 insertions(+), 8 deletions(-)
