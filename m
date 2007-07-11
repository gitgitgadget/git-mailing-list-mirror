From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] send-email: extend sanitize_address_rfc822 to do rfc2047
 quoting
Date: Wed, 11 Jul 2007 14:08:07 +0200
Message-ID: <20070711120807.GH1528MdfPADPa@greensroom.kotnet.org>
References: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de>
 <20070711084232.GE1528MdfPADPa@greensroom.kotnet.org>
 <20070711114909.GA14086@informatik.uni-freiburg.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 14:08:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8azP-0004f0-TD
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 14:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbXGKMIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Jul 2007 08:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757899AbXGKMIK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 08:08:10 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:41356 "EHLO smtp16.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641AbXGKMIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 08:08:09 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL000KBXKDJQ5@smtp16.wxs.nl> for git@vger.kernel.org; Wed,
 11 Jul 2007 14:08:07 +0200 (CEST)
Received: (qmail 14573 invoked by uid 500); Wed, 11 Jul 2007 12:08:07 +0000
In-reply-to: <20070711114909.GA14086@informatik.uni-freiburg.de>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52154>

On Wed, Jul 11, 2007 at 01:49:09PM +0200, Uwe Kleine-K=F6nig wrote:
> Sven Verdoolaege wrote:
> > On Tue, Jul 10, 2007 at 07:02:43PM +0200, Uwe Kleine-K=F6nig wrote:
> > >  	my ($recipient) =3D @_;
> > > -	my ($recipient_name) =3D ($recipient =3D~ /^(.*?)\s+</);
> > > +	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.=
*?)(\s+<.*)/);
> > > +
> > > +	if ($recipient_name && $recipient_name =3D~ /[^-a-zA-Z0-9!*+\/ =
]/ && $recipient_name !~ /=3D\?utf-8\?q?.*\?=3D/) {
> >=20
> > Why the extra test for truthness of $recipient_name ?
>=20
> i.e. if the pattern doesn't match, recipient_name is undefined.

I know.  I just didn't realize git-send-email was run with -w.
Sorry for the noise.

skimo
