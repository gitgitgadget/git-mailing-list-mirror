From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] send-email: extend sanitize_address_rfc822 to do rfc2047
 quoting
Date: Wed, 11 Jul 2007 14:49:28 +0200
Message-ID: <20070711124928.GJ1528MdfPADPa@greensroom.kotnet.org>
References: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de>
 <20070711084232.GE1528MdfPADPa@greensroom.kotnet.org>
 <20070711114909.GA14086@informatik.uni-freiburg.de>
 <81b0412b0707110538s7eda05e8g6973e20fc4d91931@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 14:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8bdP-0005Dc-OS
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 14:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762548AbXGKMtc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Jul 2007 08:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762596AbXGKMtc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 08:49:32 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:38054 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762370AbXGKMtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 08:49:31 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL00037YMAGJ0@smtp17.wxs.nl> for git@vger.kernel.org; Wed,
 11 Jul 2007 14:49:29 +0200 (CEST)
Received: (qmail 15844 invoked by uid 500); Wed, 11 Jul 2007 12:49:28 +0000
In-reply-to: <81b0412b0707110538s7eda05e8g6973e20fc4d91931@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52157>

On Wed, Jul 11, 2007 at 02:38:11PM +0200, Alex Riesen wrote:
> On 7/11/07, Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de> =
wrote:
> >Try:
> >
> >        my $recipient =3D 'skimo@kotnet.org';
> >        my ($recipient_name, $recipient_addr) =3D ($recipient =3D~=20
> >        /^(.*?)(\s+<.*)/);
> >        print "Hoppla\n" if (!$recipient_name);
>=20
> Still wrong. Try it on "0 <0user@buildhost.localnet>"

I was going to suggest using defined($recipient_name) to make it clear,
but it won't affect correctness as "0" won't match the regexps in
sanitize_address_rfc822 anyway.

skimo
