From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Circument situations where Eclipse tries to decorate resources that do not exist
Date: Mon, 10 Mar 2008 19:40:28 -0400
Message-ID: <20080310234028.GI8410@spearce.org>
References: <200803100033.53905.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 00:41:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYrcF-0001WC-Ce
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 00:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbYCJXkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbYCJXkc
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 19:40:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55966 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbYCJXkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 19:40:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYrbP-0004TG-Jg; Mon, 10 Mar 2008 19:40:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F073C20FBAE; Mon, 10 Mar 2008 19:40:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200803100033.53905.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76771>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This happens when the workspace has not been refreshed properly, e.g.
> when switching branches behind Eclipse's back.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../internal/decorators/GitResourceDecorator.java  |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> This one seems hard to replicate though I think it shouldn't. Maybe Eclipse refereshes on demand
> sometime and sometimes not.

Yup.  Earlier versions used to do a periodic refresh more often,
which really screwed up my Ant based build when Eclipse started
to _also_ build the same project to the same class folder at the
same time.

3.3.1.1 seems to not do this as often to me, and tends to wait for
a user-demanded refresh.  But then every once in a while it just
starts building all of a sudden, which makes me think they still
are doing a periodic refresh.  I don't know what is up with Eclipse.

And SWT is all about "we need access to the host native drawing APIs
to get good performance" but then Eclipse's resource system does
not appear to have filesystem monitors like inotify implemented for
the major OSes that Eclipse runs on.  Yet another aspect I don't get.

Yea, yea, if it bothers me, write the patch and submit it to Eclipse.
I'm too busy working on Git support.  I'll wait for someone else
to write it and submit it for me.  They may be waiting for me to
finish Git support first.  ;-)

> This stacktrace suggests this is the right thing to do.

Yea, I think so too.  Sucks.
 
-- 
Shawn.
