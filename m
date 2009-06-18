From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Rename org.spearce.egit -> org.eclipse.egit
Date: Fri, 19 Jun 2009 01:20:29 +0200
Message-ID: <200906190120.29915.robin.rosenberg@dewire.com>
References: <1245253576-13324-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: egit-dev@eclipse.org, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 01:20:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHQub-0008VN-5l
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 01:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbZFRXUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 19:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbZFRXUm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 19:20:42 -0400
Received: from mail.dewire.com ([83.140.172.130]:28915 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbZFRXUl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 19:20:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 11B89147D9B5;
	Fri, 19 Jun 2009 01:20:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDaLiBZlLbSv; Fri, 19 Jun 2009 01:20:32 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B2828147D9B0;
	Fri, 19 Jun 2009 01:20:30 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1245253576-13324-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121877>


Need an idea on how to proceed here. There is a problem related to updating
plugins here. We have renamed feature with one unrenamed plugin. How
to we avoid problem when switching from org.spearce to org.eclipse

One option is to release a v0.4.1 (which we should do anyway), which is the last
version from master before the split. For technical reasons this will be
a branch since the split occurred already.

That 0.4.1 feature should require jgit < 0.5. Then we jgit to v0.5 and
make org.eclipse.egit require jgit >= 0.5

Having two EGit features will be confusing. You get two of everything. E.g.
Team>Share will have two Git's to choose from, but you cannot tell which
is which.

That said, having both could be a feature, since it (didn't really try it), would
be possible to switch between new and old workspaces and get the plugin
configured for that workspace. The wierdness make me suggest we do
not do this. If we really want it we could choose to create a proxy plugin
for attaching old workspaces to the new plugins.

-- robin
