From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 01:57:46 +0100
Message-ID: <200801120157.47854.robin.rosenberg@dewire.com>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <200801120026.01930.robin.rosenberg@dewire.com> <7v3at3280v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:58:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUhd-00029n-SW
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbYALA56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 19:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbYALA56
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:57:58 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8235 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbYALA55 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:57:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 491CA80289F;
	Sat, 12 Jan 2008 01:57:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYbJIAe4rRwb; Sat, 12 Jan 2008 01:57:54 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B0B8A802643;
	Sat, 12 Jan 2008 01:57:54 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7v3at3280v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70241>

l=F6rdagen den 12 januari 2008 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>=20
> > Could we just have a lookup table index extension for identifying t=
he=20
> > duplicates (when checking is enabled using core configuration optio=
n #3324)?=20
> > That table would keep a mapping from a normalized form (maybe inclu=
de=20
> > canonical encoding while we're at it) to the actual octet sequence(=
s) used.
>=20
> I would agree that the index extension, if we ever are going to
> do this, would be the right place to store this information, at
> the single repository level.
>=20
> However, this opens up a can of worms.  What's the canonical key
> should be?  If you want to protect yourself from a unicode
> normalizing filesystem, you would use one canonicalization,
> while if you want to protect from a case losing filesystem you
> would use another?  Or do we at the same time downcase and NFD
> normalize at the same time and be done with it?

The worms are out already. So the question is whether there
is a way of keeping them in the can instead of having them crawl
all around. I think we could to both unicode (UTF-8 or NFD) and
downcase at the same time.

> And where should the configuration be stored?  If a project
> wants to be interoperable across Linux and vfat, for example,

In the brand new ".gitconfig". It could in principle contain any config=
 option,
but that would not be safe so I guess one should only allow "safe" opti=
ons
there.

-- robin
