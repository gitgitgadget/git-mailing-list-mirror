From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 08:50:28 +0100
Message-ID: <20071204075028.GB31042@auto.tuwien.ac.at>
References: <4753D419.80503@clearchain.com> <m3prxougmx.fsf@roke.D-201> <20071203163856.GA24269@auto.tuwien.ac.at> <200712031802.55514.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 08:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzSZL-0008A9-EU
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 08:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXLDHvb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 02:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbXLDHvb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 02:51:31 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:46651 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbXLDHva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 02:51:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 361508C067B6;
	Tue,  4 Dec 2007 08:50:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gkrQpcap6-hW; Tue,  4 Dec 2007 08:50:28 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id AE6E68C06790; Tue,  4 Dec 2007 08:50:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712031802.55514.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67013>

On Mon, Dec 03, 2007 at 06:02:54PM +0100, Jakub Narebski wrote:
> On Mon, 3 Dec 2007, Martin Koegler wrote:
> > eval { $res =3D decode_utf8(...); }
> > if ($@)=20
> >      return decode(...);
> > return $res
> >=20
> > or
> >=20
> > eval { $res =3D decode_utf8(...); }
> > if (defined $res)
> >       return $res;
> > else
> >     return decode(...);
> >=20
> > show the same (wrong) behaviour on Debian sarge. They do not always
> > decode non UTF-8 characters correctly, eg.
> > #=F6=E4=FC does not work
> > #=E4=F6=FC=E4 does work
> >=20
> > On Debian etch, both versions are working.
>=20
> I don't know enough Perl to decide if it is a bug in gitweb usage
> of decode_utf8, if it is a bug in your version of Encode, or if it
> is bug in Encode.
>=20
> Send copy of this mail to maintainers of Encode perl module.

The bug affects old versions of perl (Debian sarge =3D oldstable).
As it works on the newer Debian etch, do you really think, that it is
a good idea to report issue?=20

How would you handle a bug report, which reports a bug for gitweb in GI=
T
1.4, and tells you, that a newer versions works?

As Debian sarge has reached its end of life, the distribution will
probable also issue no update.

mfg Martin K=F6gler
