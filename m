From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/6] RevObject selection handler
Date: Fri, 11 Jul 2008 00:39:27 +0200
Message-ID: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4ti-0003md-QR
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbYGJWom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbYGJWom
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:44:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13059 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbYGJWol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:44:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CEAAAA149A3;
	Fri, 11 Jul 2008 00:44:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imVcrz9ZH2Vq; Fri, 11 Jul 2008 00:44:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C5DC08027F7;
	Fri, 11 Jul 2008 00:44:38 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88025>

This adds a new type of selection handler that connects to the
history view, but could be used in other, yet to be invented
views. It allows us to declare actions using the view and 
object contribution mechanism. And then some uses of that code.

-- robin

Robin Rosenberg (6):
  Create a selection handler for the revision graph.
  Using the page site selection turned out to be cumbersome.
  Adapt Git team operations to non-resouce objects
  Teach the revision selection handler about the active repository
  Create baseclasses for actions and operations on RevObjects
  Add actions in history view to perform reset actions

 .../org/spearce/egit/core/internal/UpdateJob.java  |    2 +
 .../egit/core/op/AssumeUnchangedOperation.java     |    6 +-
 .../egit/core/op/DisconnectProviderOperation.java  |    7 +-
 .../org/spearce/egit/core/op/TrackOperation.java   |    6 +-
 .../org/spearce/egit/core/op/UntrackOperation.java |    6 +-
 org.spearce.egit.ui/plugin.xml                     |   28 ++++++++
 .../internal/actions/AbstractOperationAction.java  |   15 +++--
 .../internal/actions/AbstractRevObjectAction.java  |   26 ++++++++
 .../actions/AbstractRevObjectOperation.java        |   21 ++++++
 .../actions/HardResetToRevisionAction.java         |   26 ++++++++
 .../actions/MixedResetToRevisionAction.java        |   26 ++++++++
 .../actions/SoftResetToRevisionAction.java         |   26 ++++++++
 .../egit/ui/internal/history/GitHistoryPage.java   |   16 ++++-
 .../history/RevObjectSelectionProvider.java        |   67 ++++++++++++++++++++
 14 files changed, 258 insertions(+), 20 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectOperation.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java
