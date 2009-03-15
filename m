From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 6/5 v2] Add tests for RevWalk and its supporting code
Date: Sun, 15 Mar 2009 12:34:36 +0100
Message-ID: <200903151234.36812.robin.rosenberg.lists@dewire.com>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org> <20090314001345.GI22920@spearce.org> <20090314005617.GK22920@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 15 12:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liodb-0000c9-Pg
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 12:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZCOLeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 07:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbZCOLeq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 07:34:46 -0400
Received: from mail.dewire.com ([83.140.172.130]:21309 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbZCOLep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 07:34:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DC40380289C;
	Sun, 15 Mar 2009 12:34:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gIgIWVdkWSnp; Sun, 15 Mar 2009 12:34:38 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id EF06C80286F;
	Sun, 15 Mar 2009 12:34:37 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <20090314005617.GK22920@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113281>


A few /09 interesting/ places in StartGenerator are not covered by the tests.

		if (q instanceof DateRevQueue)
			pending = (DateRevQueue)q;
		else
-->			pending = new DateRevQueue(q);

and

		if (tf != TreeFilter.ALL) {
-->			rf = AndRevFilter.create(rf, new RewriteTreeFilter(w, tf));
-->			pendingOutputType |= HAS_REWRITE | NEEDS_REWRITE;
		}

PendingGenerator
						if (n != null && n.commitTime >= last.commitTime) {
							// This is too close to call. The next commit we
							// would pop is dated after the last one produced.
							// We have to keep going to ensure that we carry
							// flags as much as necessary.
							//
-->							overScan = OVER_SCAN;


I'll merge it anyway since this is still a huge improvement compared to the previous
state.

-- robin
