From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/8] Minor push fixups
Date: Mon, 30 Jun 2008 23:03:57 -0400
Message-ID: <1214881445-3931-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWK9-0003pl-Co
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbYGADN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbYGADMx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:12:53 -0400
Received: from george.spearce.org ([209.20.77.23]:58263 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYGADMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8A86538195; Tue,  1 Jul 2008 03:04:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 090F638153;
	Tue,  1 Jul 2008 03:04:27 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86993>

A (small by recent standards) series to fix some issues with push
in both the dumb and smart transports.

We also can now package jgit as a stand-alone shell+JAR combination;
I install this into my path and have been favoring it over C Git
for a few days now.

--

Shawn O. Pearce (8):
  Correct thin pack completion in IndexPack to handle some bundles
  Delete reflog when deleting ref during dumb transport push
  Refuse to create or delete funny ref names over dumb transports
  Shorten progress message text from PackWriter
  Correctly name the stderr redirection thread for local transport
  Support 'git upload-pack' and 'git receive-pack' over SSH
  Pack jgit into a portable single file command line utility
  Don't try to pack 0{40} during push of delete and update

 .gitignore                                         |    1 +
 jgit                                               |   37 ----------------
 jgit.sh                                            |   45 ++++++++++++++++++++
 make_jgit.sh                                       |   26 +++++++++++
 .../src/org/spearce/jgit/lib/PackWriter.java       |    4 +-
 .../jgit/transport/BasePackPushConnection.java     |    6 ++-
 .../src/org/spearce/jgit/transport/IndexPack.java  |   11 ++++-
 .../spearce/jgit/transport/TransportGitSsh.java    |    8 +++-
 .../org/spearce/jgit/transport/TransportLocal.java |    6 +-
 .../spearce/jgit/transport/WalkPushConnection.java |   14 ++++++
 .../jgit/transport/WalkRemoteObjectDatabase.java   |   13 ++++++
 11 files changed, 124 insertions(+), 47 deletions(-)
 create mode 100644 .gitignore
 delete mode 100755 jgit
 create mode 100755 jgit.sh
 create mode 100755 make_jgit.sh
