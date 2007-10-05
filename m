From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 5 Oct 2007 08:45:36 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	<git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:46:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdpNh-0005R1-PI
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805AbXJEPpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbXJEPpw
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:45:52 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:56506 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497AbXJEPpv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 11:45:51 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l95FjbP7001592
	for <git@vger.kernel.org>; Fri, 5 Oct 2007 08:45:37 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l95FjbPO008695
	for <git@vger.kernel.org>; Fri, 5 Oct 2007 10:45:37 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20071005144540.GM19879@artemis.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ALTERNATE PATCH] Add a simple option parser.
Thread-Index: AcgHXnzmfDjqmrVRR4SkUUcasGEWVAABc30g
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60094>

Hi,


You probably already considered and rejected the GNU argp parser. I use=
d it before and I'd like to know reasons I should stay away from it.


Cheers,
Emil.


> -----Original Message-----
> From: git-owner@vger.kernel.org=20
> [mailto:git-owner@vger.kernel.org] On Behalf Of Pierre Habouzit
> Sent: Friday, October 05, 2007 9:46 AM
> To: Mike Hommey
> Cc: Kristian H=F8gsberg; git@vger.kernel.org; Junio C Hamano
> Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
>=20
> On Fri, Oct 05, 2007 at 02:30:14PM +0000, Mike Hommey wrote:
> > On Fri, Oct 05, 2007 at 04:25:07PM +0200, Pierre Habouzit=20
> <madcoder@debian.org> wrote:
> > > The option parser takes argc, argv, an array of struct option
> > > and a usage string.  Each of the struct option elements=20
> in the array
> > > describes a valid option, its type and a pointer to the=20
> location where the
> > > value is written.  The entry point is parse_options(),=20
> which scans through
> > > the given argv, and matches each option there against the=20
> list of valid
> > > options.  During the scan, argv is rewritten to only contain the
> > > non-option command line arguments and the number of these=20
> is returned.
> > >=20
> > > Aggregation of single switches is allowed:
> > >   -rC0 is the same as -r -C 0 (supposing that -C wants an arg).
> >=20
> > I like options aggregation, but I'm not sure aggregating=20
> option arguments
> > is a good idea... I can't even think of an application that does it=
=2E
>=20
>   You mean like `grep -A1` or `diff -u3` or `ls -w10` ?
>=20
> getopt does that by default as well, so you may not have aware of it,
> but it's how things work in your system already.
>=20
>   btw `ls -rw10` works, though `ls -w10r` drops the 'r'=20
> silently. FWIW I
> don't, in that case, the alternate patch I propose complains=20
> about "10r"
> not being a valid integer, and that's because unlike getopt, the patc=
h
> krh proposed knows what an integer is ;)
> --=20
> =B7O=B7  Pierre Habouzit
> =B7=B7O                                                madcoder@debia=
n.org
> OOO                                               =20
> http://www.madism.org
