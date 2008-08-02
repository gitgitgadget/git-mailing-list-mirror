From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 14:32:48 -0700
Message-ID: <20080802213248.GH24723@spearce.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <alpine.LRH.1.10.0808022257470.25900@yvahk3.pbagnpgbe.fr> <20080802210828.GE24723@spearce.org> <20080802212357.GU32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOjg-0007cp-PK
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYHBVcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYHBVcu
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:32:50 -0400
Received: from george.spearce.org ([209.20.77.23]:52647 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbYHBVct (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:32:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BEA3238420; Sat,  2 Aug 2008 21:32:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080802212357.GU32184@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91187>

Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Aug 02, 2008 at 02:08:28PM -0700, Shawn O. Pearce wrote:
> > I know one very big company who cannot use or support Git because
> > Git over HTTP is too slow to be useful.  They support other tools
> > like Subversion instead.  :-|
> 
> On what projects? I'm currently using Git over HTTP (read-only) a lot
> and it doesn't seem really all that impractical to me. Maybe just using
> a more dumb-friendly packing scheme could help a lot?

They tested by taking the SVN source code and importing it into
both Git and Hg, then cloned them both over a WAN link.  Git was
22x slower.  I suspect they didn't pack the Git repository at all,
so Git had to issue thousands of HTTP GET requests for the loose
objects.  But I also suspect there was bias in the testing so they
didn't realize they needed to repack, and didn't care to find out.

I've probably already said too much.  I'm under NDAs.

But anyway.  The point I was trying to make was that there are
not just some proxy servers, but also some server platforms, that
cannot handle bidirectional communiction.  E.g. servers that are
behind reverse proxies, where the reverse proxy is acting as a sort
of firewall or content cache accelerator.

-- 
Shawn.
