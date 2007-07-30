From: Craig Boston <craig@olyun.gank.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 16:49:14 -0500
Message-ID: <20070730214914.GD64467@nowhere>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org> <20070730201023.GC64467@nowhere> <7vabtdk2ch.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFd7M-00005E-Fs
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968414AbXG3VtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939545AbXG3VtU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:49:20 -0400
Received: from ion.gank.org ([69.55.238.164]:4355 "EHLO ion.gank.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S939519AbXG3VtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:49:19 -0400
Received: by ion.gank.org (Postfix, from userid 1001)
	id 989B710FD9; Mon, 30 Jul 2007 16:49:14 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vabtdk2ch.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54281>

On Mon, Jul 30, 2007 at 02:29:02PM -0700, Junio C Hamano wrote:
> Craig Boston <craig@olyun.gank.org> writes:
> > 2) Have one repository clone that gets re-used for each import, with the
> >    "checked out" branch getting changed before the import.  As far as I can
> >    tell this means suffering the "git checkout" overhead for 30,000 files,
> >    which is conceptually inefficient but in real time only a minute or so.
> 
> That should only be "conceptually" in fact, as switching between
> branches should not touch paths that are the same between
> branches.

I suspected as much, though in practice almost every file is different
between the branches that I'm tracking.  RELENG_4 and RELENG_6 for
instance have years of development between them, with almost every major
subsystem and API reorganized in some way.

I might have to do a quick compare once I get things imported and see
exactly what the numbers are.

Craig
