From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: rerere fails to record resolution if file doesn't exist in merge base
Date: Mon, 9 Jul 2007 13:35:43 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070709113543.GA12633@informatik.uni-freiburg.de>
References: <20070709070725.GA4445@lala> <7vps32ugu2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 13:36:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7rX7-0001u5-9F
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 13:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbXGILft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Jul 2007 07:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbXGILft
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 07:35:49 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:38004 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757AbXGILfs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 07:35:48 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I7rWt-0002ZU-3U; Mon, 09 Jul 2007 13:35:47 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l69BZiMN013039;
	Mon, 9 Jul 2007 13:35:44 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l69BZhh6013038;
	Mon, 9 Jul 2007 13:35:43 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vps32ugu2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51981>

Hello Junio,

Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:
>=20
> > Anyhow, the failure still exists, even though the original report w=
as
> > sent when rerere was still a perl script ...
> >
> > 	zeisberg@cassiopeia:/tmp/rerere$ git init
> > 	Initialized empty Git repository in .git/
> > 	zeisberg@cassiopeia:/tmp/rerere$ mkdir .git/rerere
>=20
> This should be creating .git/rr-cache, but what you said in your
> message is correct regardless.
You're right.  copy-n-paste error.
=20
> > In my eyes the last command should have recorded the resolution for
> > lolo, shouldn't it?
>=20
> I think two-file merge (ancestor did not have it, and you and he
> added the path differently) is rare enough that it was dropped
> outside of the radar.  A fix would probably be a trivial change
> to builtin-rerere.c::find_conflict(), I think.  While it would
> still be sane to insist that we do not do rerere for symlinks,
> and require to have stages #2 and #3, we should be able to drop
> the requirement to have stage #1.  rerere does not use
> information from there anyway.
>=20
> Not even compile tested, but something like this should do.
It compiles, but seems not to work.  I will try to make up a test.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5+choose+3
