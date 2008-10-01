From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 4/5] Expose the critical receive configuration options to JGit
Date: Wed, 1 Oct 2008 22:54:09 +0200
Message-ID: <200810012254.09169.robin.rosenberg.lists@dewire.com>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org> <1222824690-7632-4-git-send-email-spearce@spearce.org> <1222824690-7632-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:56:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8kG-0002UU-S4
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 22:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYJAUzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 16:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYJAUzS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:55:18 -0400
Received: from av6-1-sn3.vrr.skanova.net ([81.228.9.179]:38234 "EHLO
	av6-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYJAUzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 16:55:17 -0400
Received: by av6-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id A2F2238760; Wed,  1 Oct 2008 22:55:15 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av6-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 5256A38605; Wed,  1 Oct 2008 22:55:15 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id CE8F237E45;
	Wed,  1 Oct 2008 22:55:14 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1222824690-7632-5-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97267>


The repo configuration setup fails. I'll squash this in

--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -534,6 +534,7 @@ public void create() {
                add(e);

                core = new CoreConfig(this);
+               transfer = new TransferConfig(this);
        }

        /**

i.e. initialize the transfer object when creating a new repo in junit tests.

I also noted we try to read ~/.gitconfig which may give us som headaches
later on.

-- robin
