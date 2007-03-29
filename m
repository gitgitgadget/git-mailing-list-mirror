From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: basics... when reading docs doesn't help
Date: Thu, 29 Mar 2007 17:46:54 -0400
Message-ID: <20070329214654.GI6143@fieldses.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange> <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX2ST-00022s-BE
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 23:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934352AbXC2Vq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 17:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934353AbXC2Vq5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 17:46:57 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41287 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934352AbXC2Vq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 17:46:57 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HX2SM-0007b4-61; Thu, 29 Mar 2007 17:46:54 -0400
Content-Disposition: inline
In-Reply-To: <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43477>

On Thu, Mar 29, 2007 at 02:26:10PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > On Thu, Mar 29, 2007 at 10:50:51PM +0200, Guennadi Liakhovetski wrote:
> >> Now, my copy of Linus' tree was ATM 1.5GiB big...  Slowly it's getting
> >> scary.
> >
> > On my laptop:
> >
> > [bfields@pad linux]$ du -hs .
> > 1.5G    .
> > [bfields@pad linux]$ du -hs .git
> > 334M    .git
> >
> > So it's mostly the checked out working directory and build
> > stuff.
> >
> > If you really need a ton of build trees then you might just want to do
> > cp -al or something.
> 
> How about suggesting "clone -l -s"?

If you really want to share as much as possible, then I guess you want
to share the working trees too, since (as evidenced above), they're at
least as large as the compressed history.

Though actually on a second look, clone -l -s produces something that's
only 377M.  I hadn't realized how much space the build output takes up.
So judging from du the 1.5G Guennadi Liakhovetski mentions above seems
to break down into something like:

	330M .git
	380M working tree
	750M build output

--b.
