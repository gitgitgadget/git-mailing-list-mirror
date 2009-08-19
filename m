From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: ls-files -t broken? Or do I just not understand it?
Date: Wed, 19 Aug 2009 11:14:45 +0200
Message-ID: <20090819091445.GB18860@atjola.homenet>
References: <20090819082423.GA18860@atjola.homenet>
 <vpqljlguqtn.fsf@bauges.imag.fr>
 <fcaeb9bf0908190204h31bc839ai39972a251040d449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:15:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdhFx-0002Xr-Vd
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 11:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbZHSJOs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 05:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbZHSJOs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 05:14:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:47800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750969AbZHSJOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 05:14:47 -0400
Received: (qmail invoked by alias); 19 Aug 2009 09:14:47 -0000
Received: from i59F55728.versanet.de (EHLO atjola.homenet) [89.245.87.40]
  by mail.gmx.net (mp046) with SMTP; 19 Aug 2009 11:14:47 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+aihZjUtWaejwWgU2B8B8jJG2qA48xs1ZJlBYn8M
	RSgArgvKcWL1Rt
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0908190204h31bc839ai39972a251040d449@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126523>

On 2009.08.19 16:04:20 +0700, Nguyen Thai Ngoc Duy wrote:
> On Wed, Aug 19, 2009 at 3:54 PM, Matthieu Moy<Matthieu.Moy@imag.fr> w=
rote:
> > Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> >
> >> Hi,
> >>
> >> ls-files -t seems to always show status H, even if the file was mo=
dified
> >> or deleted, and thus gets shown by -m and -d respectively.
> >
> > That's not exactly "always", but I don't know whether it's the desi=
red
> > behavior:
> >
> > /tmp/git$ git st
> > # On branch master
> > # Changed but not updated:
> > # =A0 (use "git add/rm <file>..." to update what will be committed)
> > # =A0 (use "git checkout -- <file>..." to discard changes in workin=
g directory)
> > #
> > # =A0 =A0 =A0 modified: =A0 modified
> > # =A0 =A0 =A0 deleted: =A0 =A0removed
> > #
> > no changes added to commit (use "git add" and/or "git commit -a")
> > /tmp/git$ git ls-files -t
> > H modified
> > H removed
> > H unmodified
> > /tmp/git$ git ls-files -t -m
> > C modified
> > C removed
> > /tmp/git$ git ls-files -t -d
> > R removed
> > $ git ls-files -t -d -m
> > C modified
> > R removed
> > C removed
> >
> > So, you get the C and R flags only when you request explicitely -m =
and
> > -d.
>=20
> Let's see how it goes without "-t":
>=20
> pclouds@dektop /tmp/i $ git ls-files
> modified
> removed
> unmodified
> pclouds@dektop /tmp/i $ git ls-files -m
> modified
> removed
> pclouds@dektop /tmp/i $ git ls-files -d
> removed
> pclouds@dektop /tmp/i $ git ls-files -d -m
> modified
> removed
> removed
>=20
> I'd say it's expected behavior.

OK, so -t without _more_ than one of -c, -d, -m, -o, -u, -k simply
doesn't make much sense, right?

Bj=F6rn
