From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Sun, 3 Aug 2008 20:37:49 +0200
Message-ID: <20080803183749.GA3482@efreet.light.src>
References: <20080723145518.GA29035@laptop> <alpine.DEB.1.00.0807231713280.8986@racer> <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com> <alpine.DEB.1.00.0807231753240.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 03 20:39:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPiTt-00009g-Nm
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 20:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYHCSh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2008 14:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbYHCSh7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 14:37:59 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:39192 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbYHCSh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 14:37:58 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 2382C57315;
	Sun,  3 Aug 2008 20:37:57 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 1wn9nG8vKtxS; Sun,  3 Aug 2008 20:37:54 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id B5D86572D0;
	Sun,  3 Aug 2008 20:37:53 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KPiSj-0001SZ-N7; Sun, 03 Aug 2008 20:37:49 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231753240.8986@racer>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91258>

Hello,

sorry for replying to an old thread, but I am a bit puzzled here,

On Wed, Jul 23, 2008 at 17:55:14 +0100, Johannes Schindelin wrote:
> On Wed, 23 Jul 2008, Nguyen Thai Ngoc Duy wrote:
> > On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >  On Wed, 23 Jul 2008, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy w=
rote:
> > >
> > >  > So in short, sparse prefix will be stored in config,=20
> > >  > core.sparsecheckout.
> > >
> > > Do you really think the prefix should be stored anywhere else tha=
n the=20
> > > index?
> > >
> > > With core.sparseCheckout you have to introduce a _sh*tload_ of co=
nfig=20
> > > loaders.
> > >
> > > And with core.sparseCheckout you are at the whim of the user, sin=
ce=20
> > > .git/config is _supposed_ to be user-editable.
> > >
> > > From a logical point of view, I'd say that the sparse prefix has=20
> > > nothing to do with the "configuration" of the local repository.
> >=20
> > Well, whatever place. I chose .git/config because I did not want to=
=20
> > introduce a new config place. But then how about .git/sparsecheckou=
t?
>=20
> No, I did mean the index.  This is an attribute of the index: either =
it is=20
> sparsely checked out or not.  You can even have multiple indices=20
> (switching between them by setting GIT_INDEX_FILE) which have differe=
nt=20
> prefixes.

Um, but does the prefix we want to use depend on what files are physica=
lly
present in the tree? That would however imply that it's /not/ an attrib=
ute of
the index, but the tree and therefore should be stored in a separate ob=
ject.

The question whether it goes in the .git/config or .git/sparsecheckout =
is
than that of semantics -- if it's in .git/config, than user changes tha=
t by
editing the file or git config and no other way, while if it's in
=2Egit/sparsecheckout, user changes it by running checkout with appropr=
iate
arguments.

By the way, why is it *prefix*? Wouldn't a *path limit* be better?

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
