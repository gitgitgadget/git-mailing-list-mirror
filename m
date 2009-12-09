From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 15:01:45 +0100
Message-ID: <20091209140145.GA31130@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <vpqiqcgp95t.fsf@bauges.imag.fr>
 <20091209134535.GK2977@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 15:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIN77-0005Qb-DU
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 15:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbZLIOBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 09:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbZLIOBp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 09:01:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:41842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755996AbZLIOBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 09:01:44 -0500
Received: (qmail invoked by alias); 09 Dec 2009 14:01:48 -0000
Received: from i59F5468C.versanet.de (EHLO atjola.homenet) [89.245.70.140]
  by mail.gmx.net (mp022) with SMTP; 09 Dec 2009 15:01:48 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+n/JUzG9mn5Pr6lnV6+64fepoXwmzXhNwZTeduiT
	QVGQvZ38285KrX
Content-Disposition: inline
In-Reply-To: <20091209134535.GK2977@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134970>

On 2009.12.09 15:45:36 +0200, Michael S. Tsirkin wrote:
> On Wed, Dec 09, 2009 at 02:30:06PM +0100, Matthieu Moy wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > > So perhaps a good way to move forward is to teach "git cherry-pic=
k A..B"
> > > to be a thin wrapper that invokes a new hidden mode of operation =
added to
> > > "rebase" that is not advertised to the end user.
> > >
> > > I would suggest calling the option to invoke that hidden mode not
> > > "--revisions", but "--reverse" or "--opposite" or something of th=
at
> > > nature, though.  It makes "rebase" work in different direction.
> >=20
> > Intuitively,
> >=20
> >   git rebase --reverse A..B
> >=20
> > would mean "take the range A..B, and start applying the patches fro=
m
> > B, going in reverse order up to A", like "git log --reverse". So, I=
'd
> > find it misleading.
> >=20
> > Perhaps "git rebase --cherry-pick A..B" would be a better name. No
> > objection for --opposite either.
>=20
> I relly like --cherry-pick. Junio, objections to that one?

Hm, there's also (the probably not so well known)
"git rev-list --cherry-pick A...B", which excludes commits that appear
on both A and B and have the same patch id. I'd rather call the rev-lis=
t
option a misnomer than the suggested hidden option for rebase, but I'd
call it --cherry-pick-mode or --cherry-picking (like am's hidden "git a=
m
--rebasing"), just to make sure... Of course, it's not _that_ important=
,
as it's going to be a hidden option, so user confusion is probably not
that much of a concern.

Bj=F6rn
