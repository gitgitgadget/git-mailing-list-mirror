From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Thu, 05 Jul 2012 09:22:06 +0200
Message-ID: <1341472926.10752.5.camel@flaca.cmartin.tk>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
	 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
	 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
	 <20120703180439.GC3294@sigill.intra.peff.net>
	 <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
	 <20120703184018.GB5765@sigill.intra.peff.net>
	 <1341386512.3871.4.camel@flaca.cmartin.tk>
	 <CABURp0rVPAvxP1sp_nmoNYd+F+OsvWeHgUAeo7-VTnQhdebFeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"jonsmirl@gmail.com" <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 09:22:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgOh-0008RY-KL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2GEHWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 03:22:38 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:55761 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab2GEHWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:22:15 -0400
Received: from [141.23.102.101] (unknown [141.23.102.101])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 43D7B46057;
	Thu,  5 Jul 2012 09:22:13 +0200 (CEST)
In-Reply-To: <CABURp0rVPAvxP1sp_nmoNYd+F+OsvWeHgUAeo7-VTnQhdebFeg@mail.gmail.com>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201023>

On Wed, 2012-07-04 at 22:23 -0400, Phil Hord wrote:
>=20
> On Jul 4, 2012 3:22 AM, "Carlos Mart=C3=ADn Nieto" <cmn@elego.de> wro=
te:
> >
> > On Tue, 2012-07-03 at 14:40 -0400, Jeff King wrote:
> > > On Tue, Jul 03, 2012 at 02:34:59PM -0400, jonsmirl@gmail.com
> wrote:
> > >
> > > > > and now:
> > > > >
> > > > >   $ git push origin :bogus
> > > > >   error: unable to delete 'bogus': remote ref does not exist
> > > > >   error: failed to push some refs to '$URL'
> > > >
> > > > This error return would have made my mistake obvious.
> > >
> > > Thanks for confirming.
> > >
> > > > Might want to add a paragraph to the doc saying this is how you
> delete
> > > > remote branches since it is not an obvious solution. I found it
> via
> > > > Google and a question asked on stackoverflow.com
> > >
> > > It's already in git-push(1):
> > >
> > >   OPTIONS
> > >      ...
> > >      <refspec>
> > >        ...
> > >        Pushing an empty <src> allows you to delete the <dst> ref
> from
> > >        the remote repository.
> > >
> >
> > There is also a flag you can pass, which you can see a few
> paragraphs
> > under it which. It explains what it does underneath but removes the
> need
> > to know that an empty source will delete the ref.
> >
> >     --delete
> >        All listed refs are deleted from the remote repository. This
> is
> >        the same as prefixing all refs with a colon.
>=20
>=20
> I do like that, but I agree with OP that 'git push' is not an obvious
> to look for delete branch functionality for new users.

Like it? I don't get what you mean, it's a quote of what's already
there.

The reason that it's in git-push is because that's the only git command
that modifies another repository. There isn't another git command where
it would fit. You could try to put it somewhere under git-remote, but
then you'd have a single subcommand that affects a remote among a lot o=
f
others that don't, introducing an inconsistency in the command.

   cmn
