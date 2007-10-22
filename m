From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Correct some sizeof(size_t) != sizeof(unsigned long)  typing errors
Date: Mon, 22 Oct 2007 00:00:10 -0400
Message-ID: <20071022040010.GH14735@spearce.org>
References: <20071021052537.GB31927@spearce.org> <471B1AA5.8070009@lsrfire.ath.cx> <20071021103132.GA25741@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 06:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjoSx-0006NJ-M2
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 06:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbXJVEAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 00:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbXJVEAV
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 00:00:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43957 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbXJVEAQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 00:00:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjoSO-0000ci-7L; Mon, 22 Oct 2007 00:00:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D903120FBAE; Mon, 22 Oct 2007 00:00:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071021103132.GA25741@artemis.corp>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61928>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Sun, Oct 21, 2007 at 09:23:49AM +0000, Ren=C3=A9 Scharfe wrote:
> > > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > > ---
> > >  builtin-apply.c   |    2 +-
> > >  builtin-archive.c |    2 +-
> > >  diff.c            |    4 ++--
> > >  entry.c           |    2 +-
> > >  strbuf.h          |    8 +++++++-
> > >  test-delta.c      |    3 ++-
> > >  6 files changed, 14 insertions(+), 7 deletions(-)
> >=20
> > I have a feeling this is going in then wrong direction.  Shouldn't
> > we rather use size_t everywhere?  malloc() takes a size_t, and it's
> > the basis of strbuf and also of the file content functions.
>=20
>   I agree, Junio was working on a patch that generalized use of size_=
t's
> when unsigned long where used and size_t meant, I suppose he didn't h=
ad
> the time to push it.

Yea, you guys convinced me to go with Ren=C3=A9's patch.  I'm
replacing mine and will put it into next tonight.

I actually had started with what Ren=C3=A9 wrote but changed it to
what you saw before posting it to the list.  :-)

--=20
Shawn.
