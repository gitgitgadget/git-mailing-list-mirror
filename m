From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 10:08:29 -0500
Message-ID: <20071127150829.GB3853@fieldses.org>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com> <Pine.LNX.4.64.0711271109130.27959@racer.site> <alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix242-00027m-KU
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbXK0PIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 10:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbXK0PIt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:08:49 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38848 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755332AbXK0PIs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:08:48 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ix233-0002kc-6U; Tue, 27 Nov 2007 10:08:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66223>

On Tue, Nov 27, 2007 at 09:29:21AM -0500, Nicolas Pitre wrote:
> On Tue, 27 Nov 2007, Johannes Schindelin wrote:
>=20
> > Hi,
> >=20
> > On Tue, 27 Nov 2007, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=
=81=AA=E3=81=93 wrote:
> >=20
> > > Was it coded poorly, buggy or were there some other issues?
> >=20
> > It is very well possible that it was coded poorly ;-)
> >=20
> > The main reason, I believe, was that some old-timers who know the=20
> > implications said that it would encourage a wrong workflow.  One th=
ing=20
> > that could go possibly wrong, for example, is to rebase commits tha=
t you=20
> > already published.
>=20
> Being much more involved in the maintenance of a published Git tree=20
> lately, I must disagree with the "wrong workflow" statement.  Until t=
he=20
> stuff I maintain is finally merged upstream, I have to constantly=20
> amend/replace/fold/split random commits in my repo to follow the revi=
ew=20
> cycles involved.  yet I have to publish the result to let others base=
=20
> their work on top of my latest tree.  A fetch+rebase is the only opti=
on=20
> for those following my tree, and I made it clear that they have to=20
> rebase after a fetch because I constantly rebase commits that I have=20
> already published myself.

Right.  But a rebase "merge strategy" doesn't work for those people,
because it's not possible in general for their git to know exactly whic=
h
part is their work (which needs to be rebased) and which is your old
work (which should be discarded).  Manual inspection is required.

> And in this case, constant rebasing is a perfectly fine work flow to =
me.=20

Again, if you have people basing work on top of yours, I think the best
option may really be to add a merge commit on top of each new version o=
f
the series with first parent the new series and second parent the
previous history.

That way the history does have the information necessary to rebase thei=
r
work automatically.

--b.
