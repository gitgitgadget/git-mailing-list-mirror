From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/5] Quickdiff improvements
Date: Thu,  2 Apr 2009 20:46:26 +0200
Message-ID: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 02 20:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRxh-00078a-BN
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbZDBSqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbZDBSqp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:46:45 -0400
Received: from mail.dewire.com ([83.140.172.130]:5481 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbZDBSqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:46:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7428C1484DAF;
	Thu,  2 Apr 2009 20:46:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KfaAvWx6-Ag; Thu,  2 Apr 2009 20:46:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id CCB2C1484141;
	Thu,  2 Apr 2009 20:46:36 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.1.345.g89fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115482>

I noticed Eclipse could hang for long period, especially
during rebase. This series fixes that.

-- robin

Robin Rosenberg (5):
  Make the equals method work for AnyObjectId, not just ObjectId
  quickdiff - Don't add GitDocument as repository listener more than
    once
  Move dcocument to repository mapping to GitDocument
  Update Quickdiff tracing statements
  Cache resolved ids in quickdiff document for faster update

 .../egit/ui/internal/decorators/GitDocument.java   |  104 +++++++++++++++++---
 .../internal/decorators/GitQuickDiffProvider.java  |   10 +--
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    4 +-
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +
 .../src/org/spearce/jgit/revwalk/RevObject.java    |    2 +-
 5 files changed, 97 insertions(+), 25 deletions(-)
