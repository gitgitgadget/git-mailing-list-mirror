From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 10:49:08 -0400
Message-ID: <20070330144908.GA15224@fieldses.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange> <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net> <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange> <20070330024327.GC3198@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 16:49:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXIPj-00021S-Ak
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 16:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbXC3OtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 10:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbXC3OtM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 10:49:12 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35354 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbXC3OtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 10:49:11 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HXIPc-0004Im-Ko; Fri, 30 Mar 2007 10:49:08 -0400
Content-Disposition: inline
In-Reply-To: <20070330024327.GC3198@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2007 at 10:43:27PM -0400, Theodore Tso wrote:
> On Fri, Mar 30, 2007 at 12:13:02AM +0200, Guennadi Liakhovetski wrote:
> > On Thu, 29 Mar 2007, J. Bruce Fields wrote:
> > > Though actually on a second look, clone -l -s produces something that's
> > > only 377M.  I hadn't realized how much space the build output takes up.
> > > So judging from du the 1.5G Guennadi Liakhovetski mentions above seems
> > > to break down into something like:
> > > 
> > > 	330M .git
> > > 	380M working tree
> > > 	750M build output
> 
> Hmm.... That doesn't look right.  My packed .git directory is 156 megs
> (using post git 1.5 and repack.usedeltabaseoffset=true and
> core.legacyheaders=false).

I haven't run more than git-gc in a while, because I have local clones
and didn't want to figure out how to prune.  Hm, now that I've looked it
up:

git prune -- $(cd ../linux-clone/ && echo $(git-rev-parse --all))

just gets me the git-prune usage message.  In fact, contrary to the
prune man page, git-prune doesn't seem to accept any <head> arguments.
Isn't this a bug?  I'm on 1.5.0.3.31.ge47c.

--b.
