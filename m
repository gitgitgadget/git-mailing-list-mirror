From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Mon, 26 May 2008 19:44:45 -0400
Message-ID: <20080526234445.GF30245@spearce.org>
References: <20080526044640.GB30245@spearce.org> <19f34abd0805260113w1341a26bg140d1dbb7438bf46@mail.gmail.com> <alpine.DEB.1.00.0805261106470.30431@racer> <19f34abd0805260422m6d8c414dy746623ed609440eb@mail.gmail.com> <20080526181259.GA17449@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vegard Nossum <vegard.nossum@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Dave Watson <dwatson@mimvista.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	laforge@gnumonks.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Tue May 27 01:46:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0mOb-00075F-Ie
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbYEZXo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbYEZXo5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:44:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36568 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbYEZXo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:44:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0mMn-0008VN-Rv; Mon, 26 May 2008 19:44:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 672EA20FBAE; Mon, 26 May 2008 19:44:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080526181259.GA17449@foursquare.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82977>

Chris Frey <cdfrey@foursquare.net> wrote:
> On Mon, May 26, 2008 at 01:22:25PM +0200, Vegard Nossum wrote:
> > It does concern me, because I enjoy git and free software in general.
> > I am not trolling or trying to stop the change of license in any way,
> > but simply give a heads up to what I believe might potentially be a
> > legal issue. Maybe there are in fact no other authors that have
> > participated, but in that case I think it is a fact worthy of explicit
> > mention.
> 
> I share your concerns about licensing and keeping things accurate when it
> comes to things like changing licenses, so I took a quick look at the
> bsd branch of the jgit git tree, to see if there were any glaring
> omissions.
> 
> I'm not sure that git-blame is the best way to deal with this kind of task,
> but in this case, it worked out well.  From my analysis of git-log output,
> the lines of code from contributors who haven't explicitly consented are
> maybe 10 lines.  Looks like a job well done to me.

Thanks for your comments.  I think we are OK with the change,
as Chris points out.  Here's more details about the complete
list of contributors to jgit, since the beginning of time.

$ git log --pretty=format:%ae \
    bsd jgit org.spearce.jgit org.spearce.jgit.test \
    | sort | uniq -c | sort -nr
 364 spearce@spearce.org
 175 robin.rosenberg@dewire.com
  21 dwatson@mimvista.com
   8 me@lathund.dewire.com
   2 rogersoares@intelinet.com.br
   1 thadh@thad.corp.google.com

Now I asked for consent from the top 3 (me, robin, dwatson).
The 4th one down (me@lathund.dewire.com) is also Robin.  That
leaves only Roger C. Soares and Thad Hughes as ever having
made a contribution to jgit, surviving line or not, and who
were not consulted specifically about the license change.

The total size of their deltas is:

$ for u in rogersoares@intelinet.com.br thadh@thad.corp.google.com; \
  do \
    echo $u $(git log -p --author=$u bsd \
    jgit org.spearce.jgit org.spearce.jgit.test \
    | grep '^+' | wc -l); \
  done
rogersoares@intelinet.com.br 9
thadh@thad.corp.google.com 5
$ git log -p bsd | grep '^+' | wc -l
  122576

So in all time these users have added a total of 14 lines between
them.  Out of 122,576 total added lines.  It amounts to only 0.011%
of the total contribution.  In the US a change this small may not
even be copyrightable.

Obviously I am only counting + lines in patches.  The - lines
may also have some value in certain contexts.  But then we also
get into the discussion of what is copyrighted.  The patch or the
final result?

In the 3 changes between Roger and Thad the patches were all very
small.  They are minor bug fixes that probably would come out the
same way no matter who wrote them.  E.g. in one Roger deleted an
extra ";" at the end of a line (fixed ";;" to ";").  I'm not sure
anyone else on Earth could have written that change differently.

I hate to trivialize someone's contribution, but the reality is
that in jgit there are only 3 interesting authors at this time.
All were consulted about this license change, and all gave their
consent via a public posting to this mailing list.

-- 
Shawn.
