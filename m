From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: creating tags from a subdirectory of trunk
Date: Mon, 16 Mar 2009 14:08:56 -0700
Message-ID: <20090316210856.GB19153@dcvr.yhbt.net>
References: <632a37a0903151418u483ca6cal1582518b9120da8e@mail.gmail.com> <20090315232105.GA21667@dcvr.yhbt.net> <632a37a0903161202w23848f41g5cde3942195369cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tom Huybrechts <tom.huybrechts@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:10:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjK4r-0002hk-8k
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 22:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbZCPVI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbZCPVI7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 17:08:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34321 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbZCPVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 17:08:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16361F605;
	Mon, 16 Mar 2009 21:08:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <632a37a0903161202w23848f41g5cde3942195369cb@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113383>

Tom Huybrechts <tom.huybrechts@gmail.com> wrote:
> On Mon, Mar 16, 2009 at 12:21 AM, Eric Wong <normalperson@yhbt.net> w=
rote:
> > Tom Huybrechts <tom.huybrechts@gmail.com> wrote:
> >> Hi,
> >>
> >> I'm trying to setup a git mirror of a svn repository. =A0The tags =
in
> >> this repository are not created trunk it self, but from subdirecto=
ries
> >> of trunk. The tags and branches are in the standard places.
> >> e.g:
> >> /trunk/main -> tags/main-1
> >> /trunk/plugins/foo -> tags/foo-1
> >> /trunk/plugins/bar -> tags/bar-1
> >>
> >> I run 'git svn clone -s svn-url target'. It starts going over the
> >> history nicely until it reaches the first branch. It calls this br=
anch
> >> something like tags/tag-name@revision, and starts retrieving the
> >> entire project history again from r1. This is repeated for every
> >> branch.
> >
> > Hi Tom,
> >
> > This is a known problem with some repositories. =A0My suggestion is=
 to
> > use individual "fetch" directives for each of those tags you want t=
o
> > follow.
> >
> > The -s/--stdlayout is only for projects that follow the SVN-recomme=
nded
> > repository layout exactly and we haven't thought of a generic way t=
o
> > handle those non-standard tags in repos...
> >
> > --
> > Eric Wong
> >
>=20
> Hi Eric,
>=20
> The repository I'm trying to convert is that of Hudson. I did some
> digging in the list archives, and found this came up earlier
> (2009/01/08).
> Back then you replied:
>=20
> """
> Alternately, you could just clone the root and have all the branches =
all
> over the place in one tree (your eventually working copy will be huge=
).
>=20
>   git svn clone https://svn.dev.java.net/svn/hudson
>=20
>=20
> Basically this is the equivalent of:
>=20
>   svn co https://svn.dev.java.net/svn/hudson
>=20
> Except you'll have the full history.
> """
>=20
> Is that still valid ? That is what I did, and which caused the
> behaviour I described.

I did not use the -s/--stdlayout option in my example.
But yeah, either way that repository is nasty with git-svn :<

--=20
Eric Wong
