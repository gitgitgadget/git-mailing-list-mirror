From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 19:48:43 +0200
Message-ID: <20091017174843.GA16251@atjola.homenet>
References: <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
 <alpine.LFD.2.00.0910161557500.20122@xanadu.home>
 <alpine.LNX.2.00.0910171606180.6644@reaper.quantumfyre.co.uk>
 <20091017170421.GA10490@atjola.homenet>
 <alpine.LNX.2.00.0910171829430.7906@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzDOh-0003Nz-MP
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbZJQRsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 13:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbZJQRsp
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:48:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:45154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753252AbZJQRso (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 13:48:44 -0400
Received: (qmail invoked by alias); 17 Oct 2009 17:48:48 -0000
Received: from i59F5B216.versanet.de (EHLO atjola.homenet) [89.245.178.22]
  by mail.gmx.net (mp069) with SMTP; 17 Oct 2009 19:48:48 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX186i0EOX6E6Y9f+y2YJc2W7b/5YDTVQNEzqO58zkK
	Yb2h53bK6XnhsJ
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910171829430.7906@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130573>

On 2009.10.17 18:35:38 +0100, Julian Phillips wrote:
> On Sat, 17 Oct 2009, Bj?rn Steinbrink wrote:
> >Do you have multiple (annotated) tags for the same commit?
>=20
> Potentially, yes.  Releasing isn't the only thing that requires
> keeping track of things.  It's even possible that the person
> creating the newer tag doesn't yet know that a release tag has been
> applied if the person who applied it hasn't yet pushed it back.

OK, I'd consider that namespace pollution, as things like
"this-version-sucks" doesn't seem like it show go into public repos, bu=
t
anyway. If your release tags fix into a certain "unique" format, you
could use describe with --match, like:
git describe --match 'v[0-9]*'

> >Otherwise, I don't see why "git describe HEAD" should print the
> >wrong one. If there's a tag that can be resolved to the same
> >commit that HEAD can be resolved, then "git describe HEAD" must
> >output that one. Otherwise, that'd be a clear bug to me.
>=20
> Oh, definately no bug.  git describe works exactly as expected, the
> problem is that the tag checked out isn't always the latest tag
> applied to that commit.

I misworded that one. Should be "If there's only tag that can be ...".
IOW it was meant for "only one tag per commit", which is what I assumed
to be the case.

Bj=F6rn
