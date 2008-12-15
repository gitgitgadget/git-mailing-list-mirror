From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 15:08:34 +0100
Message-ID: <20081215140834.GA3684@atjola.homenet>
References: <808wqhzjl9.fsf@tiny.isode.net> <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 15:10:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCE8z-0005gB-Eq
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 15:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYLOOIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Dec 2008 09:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYLOOIj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 09:08:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:52704 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751985AbYLOOIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 09:08:38 -0500
Received: (qmail invoked by alias); 15 Dec 2008 14:08:36 -0000
Received: from i577BB567.versanet.de (EHLO atjola.local) [87.123.181.103]
  by mail.gmx.net (mp014) with SMTP; 15 Dec 2008 15:08:36 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1800+ogE+00aygLi8rPf46JHQExQtfLiBnm8bERPh
	cVSEpR0qh71jJs
Content-Disposition: inline
In-Reply-To: <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103167>

On 2008.12.15 14:38:56 +0100, Mikael Magnusson wrote:
> 2008/12/15 Bruce Stephens <bruce.stephens@isode.com>:
> > I couldn't see a test for this, but perhaps I'm just missing it?
> >
> >    brs% git count-objects
> >    161 objects, 1552 kilobytes
> >    brs% git gc
> >    Counting objects: 80621, done.
> >    Compressing objects: 100% (22372/22372), done.
> >    Writing objects: 100% (80621/80621), done.
> >    Total 80621 (delta 57160), reused 80305 (delta 56884)
> >    brs% git count-objects
> >    207 objects, 2048 kilobytes
> >
> >
> > And I see lots of directories under .git/objects which confirms
> > things.
> >
> > I don't think I've changed any relevant configuration.
> >
> > This is with 8befc50c49e8a271fd3cd7fb34258fe88d1dfcad (also whateve=
r
> > version I used before, erm, probably
> > de0db422782ddaf7754ac5b03fdc6dc5de1a9ae4), and possibly earlier
> > versions---I've just started noticing now that the number of loose
> > objects has started causing git gui to complain.
> >
> > (Hmm, I note that git gui reports a larger number of loose objects
> > than git count-objects.  Ah, OK, it really is just an approximation=
,
> > so no surprise.)
>=20
> IIRC git gc only removes loose objects older than two weeks, if you
> really want to remove them now, run git prune. But make sure no other
> git process can be active when you run it, or it could possibly step
> on something.

To clarify that a bit more: git gc keeps unreachable objects unpacked,
so that git prune can drop them. And git gc invokes git prune so that
only unreachable objects older than 2 weeks are dropped.

Bj=F6rn
