From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 02:53:39 -0500
Message-ID: <20070121075339.GA10632@spearce.org>
References: <20070118172408.GG15428@spearce.org> <20070118174244.GA14287@moooo.ath.cx> <20070118175134.GH15428@spearce.org> <20070118222919.GA22060@moooo.ath.cx> <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org> <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net> <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 08:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8XWS-0003yd-AP
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 08:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXAUHxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 02:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXAUHxq
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 02:53:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60218 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbXAUHxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 02:53:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H8XVe-0002O9-Mu; Sun, 21 Jan 2007 02:53:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD26A20FBAE; Sun, 21 Jan 2007 02:53:39 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37309>

Junio C Hamano <junkio@cox.net> wrote:
> The way we might want to address this would be when 'clone -s'
> makes a new repository that borrows from an existing repository,
> we could make a symlink under .git/refs/borrowers/ in the
> original repository that points at .git/refs directory of the
> cloned repository -- you can do that by hand today and it would
> be much nicer than having to specify the other repository when
> running 'git prune' as the example suggests.

Unrelated topic: We may also want to consider doing the reverse,
that is symlink '.git/refs/borrows-from' of the cloned repository
to '.git/refs' in the original repository.  This way pushing into
the cloned repository can avoid uploading objects which the cloned
repository already has access to via its objects/info/alternates
setup.

This would especially be nice with project forks, such as on
repo.or.cz.  I don't need to upload all of 'master' if it has
already been uploaded by pasky's mirror job, for example.

-- 
Shawn.
