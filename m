From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: small git lesson [Was: Re: Revert
 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?]
Date: Wed, 13 Apr 2011 11:36:08 +0200
Message-ID: <20110413093608.GO18850@pengutronix.de>
References: <BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
 <20110406204327.GA11148@iram.es>
 <1302185075.24704.143.camel@thor.local>
 <20110411133128.GA24344@iram.es>
 <1302535963.24704.268.camel@thor.local>
 <20110412113033.GA16649@iram.es>
 <1302608770.27054.36.camel@thor.local>
 <20110413080204.GA3871@iram.es>
 <20110413081246.GK18850__3180.67204575545$1302682420$gmane$org@pengutronix.de>
 <m339lm8r31.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 13 11:36:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9wUt-0004XZ-1P
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 11:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab1DMJgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 05:36:13 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36814 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757966Ab1DMJgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 05:36:12 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Q9wUb-00041c-62; Wed, 13 Apr 2011 11:36:09 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Q9wUa-0000Vu-ML; Wed, 13 Apr 2011 11:36:08 +0200
Content-Disposition: inline
In-Reply-To: <m339lm8r31.fsf@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171438>

Hello,

On Wed, Apr 13, 2011 at 10:59:14AM +0200, Andreas Schwab wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > $ git name-rev --refs=3Drefs/tags/v2.6\* 69a07f0b117a40fcc1a479358d=
8e1f41793617f2
> > 69a07f0b117a40fcc1a479358d8e1f41793617f2 tags/v2.6.39-rc2~3^2~43^2~=
4
> >
> > so it was introduced just before -rc2.
>=20
> $ git tag --contains 69a07f0b117a40fcc1a479358d8e1f41793617f2
> v2.6.39-rc1
> v2.6.39-rc2
huh, I thought git name-rev prefers old[1] refs (similar to describe
prefering newer).

$ for rc in 1 2; do git name-rev --refs=3Drefs/tags/v2.6.39-rc$rc 69a07=
f0b1; done
69a07f0b1 tags/v2.6.39-rc1~79^2~31^2~4
69a07f0b1 tags/v2.6.39-rc2~3^2~43^2~4

I would prefer the v2.6.39-rc1 name even though it's nearer[1] at
v2.6.39-rc2.

If it should stay as is, what is the best way to find out the oldest
tag?
=20
Best regards
Uwe

[1] as in minimizing

	git rev-list 69a07f0b117a..$ref | wc -l

(v2.6.39-rc1 -> 21281; v2.6.39-rc2 -> 21608)

[2] as in minimizing the number of traversing a parent link.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
