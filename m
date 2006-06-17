From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-1.4.0 make problems
Date: Sat, 17 Jun 2006 08:58:24 +0200
Message-ID: <4493A810.6010706@lsrfire.ath.cx>
References: <200606170218.k5H2I0o0003192@grail.cba.csuohio.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 08:58:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrUlH-0007gn-Av
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 08:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWFQG6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Jun 2006 02:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWFQG6Y
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 02:58:24 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:9437
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932468AbWFQG6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 02:58:24 -0400
Received: from [10.0.1.3] (p508E7A54.dip.t-dialin.net [80.142.122.84])
	by neapel230.server4you.de (Postfix) with ESMTP id B9C8C6174;
	Sat, 17 Jun 2006 08:58:22 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Michael Somos <somos@grail.cba.csuohio.edu>
In-Reply-To: <200606170218.k5H2I0o0003192@grail.cba.csuohio.edu>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22007>

| I downloaded the git-1.4.0.tar.bz2 recently and encountered a few
| problems.
|
| 1) The untar process creates a stray file "pax_global_header".
| I am using GNU tar v1.13.22 and I get this message :
|
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| > tar jxf ~/u/source/git-1.4.0.tar.bz2
| tar: pax_global_header: Unknown file type 'g', extracted as normal
| file
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

You can ignore or delete that file.  It is a pax extended global header=
,
containing the git commit ID as a comment.  GNU tar started supporting
pax headers with version 1.13.93 (released 2004-02-23).  Version 1.13.2=
2
was released on 2001-08-29, by the way.  May I ask what operating syste=
m
and version you are using?

| 2) The make install process ignores the "prefix=3D..." argument. I ha=
ve
| to comment out one line for this :
|
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| > diff Makefile git-1.4.0/
| 94c94
| < #prefix =3D $(HOME)
| ---
| > prefix =3D $(HOME)
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It took me a while to realize that your diffs are reversed.  It's too
early for me, I think I'll go to bed again. :)

Anyway, prefix handling is currently being worked on.  Yakov Lerner sen=
t
a patch which seems to make make do what you need.

| 3) The make has a problem with "expat" include and libararies.
| I have to add more lines to the Makefile to handle this like some
| of the other include and libraries :
|
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| 351,358c351
| < endif
| <
| < ifndef NO_EXPAT
| <       ifdef EXPATDIR
| <               # This is still problematic -- gcc does not always wa=
nt -R.
| <               ALL_CFLAGS +=3D -I$(EXPATDIR)/include
| <               EXPAT_LIBEXPAT =3D -L$(EXPATDIR)/lib -R$(EXPATDIR)/li=
b -lexpat
|
| <           else
| ---
| >       ifndef NO_EXPAT
| 360c353
| <           endif
| ---
| >       endif
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Looks sensible, except for the formatting.

| Other than that, it installed okay. I will have to read the docs and
| use it to see how it goes otherwise.

A good first exercise would be to fetch the git repository, edit Makefi=
le
and commit your change, and then send a patch to this list -- all using
git (except the editing part). :-)  Care to try that?  Please let us kn=
ow
of any difficulties you may encounter.

Thanks,
Ren=E9
