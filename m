From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/6] Add prune of stale tracking branches to fetch
Date: Thu, 12 Feb 2009 16:42:45 -0800
Message-ID: <20090213004245.GZ30949@spearce.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org> <7v7i3vi33b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 01:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXmAA-0001fg-PG
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 01:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284AbZBMAmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 19:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758249AbZBMAmr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 19:42:47 -0500
Received: from george.spearce.org ([209.20.77.23]:56065 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758197AbZBMAmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 19:42:46 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C9A2A38210; Fri, 13 Feb 2009 00:42:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v7i3vi33b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109694>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > This series teaches "jgit fetch" how to prune stale tracking branches
> > that have been removed from the remote repository.  We can now do
> > both a fetch and a prune in a single network connection.
> 
> I am not sure if that is a good feature.
> 
> The user at the local side may well be using the (now stale) tracking
> branch as an achoring point to remember where his own development forked
> from, and that may be the reason he is fetching but not running "remote
> prune", not to lose that anchor.

Well.

Its off by default.

You have to ask for it with "jgit fetch --prune origin".

Compare to asking for it with "git remote prune origin".

We're already opening a #@!*@!* network connection to perform either
fetch or prune, so we might as well let the user perform both in
one step.  Which is what this patch does.

-- 
Shawn.
