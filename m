From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 00:54:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705090015360.18541@iabervon.org>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070508210153.GA3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705082306100.4167@racer.site>
 <20070508213158.GB3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705090105450.4167@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-551026735-1178686302=:18541"
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	bfields@citi.umich.edu, junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 06:54:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HleBo-0002On-AQ
	for gcvg-git@gmane.org; Wed, 09 May 2007 06:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbXEIEyH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 00:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934664AbXEIEyH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 00:54:07 -0400
Received: from iabervon.org ([66.92.72.58]:1648 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011AbXEIEyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 00:54:05 -0400
Received: (qmail 18522 invoked by uid 1000); 9 May 2007 04:54:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2007 04:54:03 -0000
In-Reply-To: <Pine.LNX.4.64.0705090105450.4167@racer.site>
Content-ID: <Pine.LNX.4.64.0705090052370.18541@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46658>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-551026735-1178686302=:18541
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0705090052371.18541@iabervon.org>

On Wed, 9 May 2007, Johannes Schindelin wrote:

> Hi,
>=20
> On Tue, 8 May 2007, Karl Hasselstr=F6m wrote:
>=20
> > On 2007-05-08 23:07:04 +0200, Johannes Schindelin wrote:
> >=20
> > > On Tue, 8 May 2007, Karl Hasselstr=F6m wrote:
> > >
> > > > On 2007-05-08 17:10:47 +0200, Johannes Schindelin wrote:
> > > >
> > > > > +  char *`, but is actually expected to be a pointer to `unsigned
> > > > > +  char[20]`.  This variable will contain the big endian version =
of the
> > > > > +  40-character hex string representation of the SHA-1.
> > > >
> > > > Either it should be "unsigned char[40]" (or possibly 41 with a
> > > > terminating \0), or else you shouldn't be talking about
> > > > hexadecimal since it's just a 20-byte big-endian unsigned integer.
> > > > (A third possibility is that I'm totally confused.)
> > >
> > > It is 40 hex-character, but 20 _byte_. If you have any ideas how to
> > > formulate that better than I did...
> >=20
> > I think this is less confusing:
> >=20
> >   This variable will contain the 160-bit SHA-1.
> >=20
> > It avoids talking of hex, since it's not really stored in hex format
> > any more than any other binary number with a number of bits divisible
> > by four. And it avoids saying big-endian, which is not relevant anyway
> > since we don't use hashes as integers.
>=20
> Well, I do not buy into that. First, we _have_ to say that it is=20
> big-endian. It was utterly confusing to _me_ that the hash was not little=
=20
> endian, as I expected on an Intel processor.

SHA-1 is defined as producing a octet sequence, and to have a canonical=20
hex digit sequence conversion with the high nibbles first. Internally, it=
=20
is canonically specified using big-endian math, but the same algorithm=20
could equally be specified with little-endian math and different rules for=
=20
input and output.

> And I'd rather mention the hex representation (what you see in git-log an=
d=20
> git-ls-tree). This helps debugging, believe me.

It's kind of important to distinguish between the hex representation and=20
the octet representation, because your code will not work at all if you=20
use the wrong one. And "unsigned char *" or "unsigned char[20]" is always=
=20
the octets; the hex is always "char *". Primarily mentioning the one that=
=20
is more intuitive but less frequently used doesn't help with understanding=
=20
the actual code.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-551026735-1178686302=:18541--
