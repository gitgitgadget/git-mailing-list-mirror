From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 16:12:08 +0200
Message-ID: <20091209141208.GM2977@redhat.com>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <vpqiqcgp95t.fsf@bauges.imag.fr> <20091209134535.GK2977@redhat.com> <20091209140145.GA31130@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 15:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NINJn-0002Uv-Pj
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 15:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbZLIOOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 09:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754834AbZLIOOu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 09:14:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758AbZLIOOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 09:14:50 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB9EEqNf007320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Dec 2009 09:14:52 -0500
Received: from redhat.com (vpn2-9-43.ams2.redhat.com [10.36.9.43])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB9EEowA017237;
	Wed, 9 Dec 2009 09:14:51 -0500
Content-Disposition: inline
In-Reply-To: <20091209140145.GA31130@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134972>

On Wed, Dec 09, 2009 at 03:01:45PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.12.09 15:45:36 +0200, Michael S. Tsirkin wrote:
> > On Wed, Dec 09, 2009 at 02:30:06PM +0100, Matthieu Moy wrote:
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >=20
> > > > So perhaps a good way to move forward is to teach "git cherry-p=
ick A..B"
> > > > to be a thin wrapper that invokes a new hidden mode of operatio=
n added to
> > > > "rebase" that is not advertised to the end user.
> > > >
> > > > I would suggest calling the option to invoke that hidden mode n=
ot
> > > > "--revisions", but "--reverse" or "--opposite" or something of =
that
> > > > nature, though.  It makes "rebase" work in different direction.
> > >=20
> > > Intuitively,
> > >=20
> > >   git rebase --reverse A..B
> > >=20
> > > would mean "take the range A..B, and start applying the patches f=
rom
> > > B, going in reverse order up to A", like "git log --reverse". So,=
 I'd
> > > find it misleading.
> > >=20
> > > Perhaps "git rebase --cherry-pick A..B" would be a better name. N=
o
> > > objection for --opposite either.
> >=20
> > I relly like --cherry-pick. Junio, objections to that one?
>=20
> Hm, there's also (the probably not so well known)
> "git rev-list --cherry-pick A...B", which excludes commits that appea=
r
> on both A and B and have the same patch id. I'd rather call the rev-l=
ist
> option a misnomer than the suggested hidden option for rebase, but I'=
d
> call it --cherry-pick-mode or --cherry-picking (like am's hidden "git=
 am
> --rebasing"), just to make sure... Of course, it's not _that_ importa=
nt,
> as it's going to be a hidden option, so user confusion is probably no=
t
> that much of a concern.
>=20
> Bj=F6rn

OK, --cherry-picking looks fine as well.
