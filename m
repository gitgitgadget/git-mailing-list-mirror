From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Tue, 13 Sep 2005 00:50:32 +0200
Message-ID: <20050912225032.GA8360@vrfy.org>
References: <20050912181101.GA22221@vrfy.org> <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org> <20050912195947.GA28502@vrfy.org> <Pine.LNX.4.58.0509121316030.3266@g5.osdl.org> <20050912210006.GA32211@vrfy.org> <Pine.LNX.4.58.0509121438150.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:51:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEx8J-0005En-D6
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 00:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVILWug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 18:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVILWug
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 18:50:36 -0400
Received: from soundwarez.org ([217.160.171.123]:57735 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932331AbVILWug (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 18:50:36 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 968F959114; Tue, 13 Sep 2005 00:50:32 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509121438150.3266@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8448>

On Mon, Sep 12, 2005 at 02:42:16PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 12 Sep 2005, Kay Sievers wrote:
> > 
> > Everthing that walk from one commit to another, uses git-rev-list, sure.
> > But in the commit view, and the commitdiff the "parent" link and the parent
> > that is passed to diff is read from the commit itself.
> > 
> > > (So instead of trying to parse the parent info from the header of the 
> > > commit, just do "git-rev-list --pretty --parents" and parse that).
> > 
> > I need only one parent:
> >   git-rev-list --parents --max-count=1 <id>
> 
> Who don't you use that to show the comments too? 
> 
> So instead of doing
> 
> 	git-cat-file commit <id>
> 
> (or whatever you do), just do
> 
> 	git-rev-list --parents --pretty=raw --max-count=1 <id>

That would be nice, if I could convert everthing to this output format.

But why does --pretty=raw mangle the text with spaces?
Well the output of this  weird word combination may be "pretty" but definitely
not "raw". :)

And I would prefer --pretty=raw with '\0' termination instead of '\n' so I can
replace the output from --header with --pretty=raw and can still use the same
parsing routine.

Thanks,
Kay
