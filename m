From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 12:56:20 +0200
Message-ID: <20080917105620.GA13144@atjola.homenet>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com> <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com> <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com> <20080917011816.GL28210@dpotapov.dyndns.org> <c49095e30809162216m5c7885dbibbb022e65f43231c@mail.gmail.com> <48D0AA1A.5060209@op5.se> <cfd18e0f0809170328pb039331m1c4dc42fd398a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Michael Kerrisk <michael.kerrisk@googlemail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	michael.kerrisk@gmail.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: mtk.manpages@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 17 12:57:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfuj3-0000HG-Ut
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbYIQK4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 06:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYIQK4a
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:56:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:46481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752068AbYIQK43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:56:29 -0400
Received: (qmail invoked by alias); 17 Sep 2008 10:56:22 -0000
Received: from i577B97D3.versanet.de (EHLO atjola.local) [87.123.151.211]
  by mail.gmx.net (mp037) with SMTP; 17 Sep 2008 12:56:22 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/pcKAmrVbpDNE9YfAK3WnKcq8CTu/J4vaOWqmQD0
	IPbxbdn0oV6Q6C
Content-Disposition: inline
In-Reply-To: <cfd18e0f0809170328pb039331m1c4dc42fd398a4d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96088>

On 2008.09.17 03:28:46 -0700, Michael Kerrisk wrote:
> Hi Andreas,
>=20
> On Tue, Sep 16, 2008 at 11:56 PM, Andreas Ericsson <ae@op5.se> wrote:
> > Michael Kerrisk wrote:
> >>
> >> Hi Dimitry,
> >>
> >> On Tue, Sep 16, 2008 at 6:18 PM, Dmitry Potapov <dpotapov@gmail.co=
m>
> >> wrote:
> >>>
> >>> On Wed, Sep 17, 2008 at 01:40:36AM +0200, Michael Kerrisk wrote:
> >>>>
> >>>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk =
-b
> >>>> branches
> >>>>
> >>>> takes about half an hour to run, the other command (which I alre=
ady
> >>>> started yesterday) seems to be taking (far) more than a day!
> >>>
> >>> What version of Git do you use?
> >>
> >> 1.5.4.5, on Linux.
> >>
> >
> > An upgrade would do you good.
>=20
> But, is it going to make this much difference to the run time?  By
> now, the import using

It should.

> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T
> trunk/man-pages -b branches
>=20
> has been running for over 2 days (and I still don't know if it will
> give the layout I want), and seems to be slowing down exponentially a=
s
> it gets further along in the import process, so at this rate it looks
> like it would take several more days to complete, whereas
>=20
> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b br=
anches
>=20
> which doesn't give the layout I want, takes less than an hour.  We're
> talking about a factor of at least 100 x in the speed difference for
> the two imports.

I guess your old import doesn't see any relations between the trunk and
the tags/branches, right? Then the huge increase in runtime would be, a=
t
least in part, explained by git-svn searching for ancestry. That you se=
e
those tags/1.2.3@123 things also means that the 1.2.3 tags got deleted
and recreated, or at least git-svn thinks so. Maybe the ancestry
detection goes nuts, hard to tell.

Is that svn repo available anywhere?

Bj=F6rn
