From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 20:23:45 +0200
Message-ID: <20090330182345.GC10030@pengutronix.de>
References: <200903301024.08848.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 20:30:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoMFh-00055X-Ec
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 20:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758306AbZC3SXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 14:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758408AbZC3SXu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 14:23:50 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37877 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450AbZC3SXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 14:23:48 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LoM9B-0003Lt-OG; Mon, 30 Mar 2009 20:23:45 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LoM9B-0002ck-E6; Mon, 30 Mar 2009 20:23:45 +0200
Content-Disposition: inline
In-Reply-To: <200903301024.08848.brian.foster@innova-card.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115184>

On Mon, Mar 30, 2009 at 10:24:08AM +0200, Brian Foster wrote:
>   Whilst this question involves linux(-mips) kernel tree,
>  it's a git(-related?) question, not a kernel question ....
>=20
>   We are currently in the process of upgrading our embedded
>  system from kernel 2.6.21(-ish) to at least 2.6.26.8;  and
>  later, at some time in the future on to 2.6.3x or something.
>  Going from 2.6.21 to .22 to .23 and so on to .26, then to
>  .26.1 and so on to .26.8 is =E2=80=9Ceasy=E2=80=9D in the sense ther=
e are
>  very few conflicts with our existing baseline (e.g., just
>  2 or 3 in 2 or 3 files).
>=20
>   .21 --> me --> .22 --> .23 ... --> .26 --> .27 --> master
>      \              \       \           \      \
>      .21-stable  .22-stable .23-stable   \     .27-stable
>                                         .26.8
>                                            \
>                                            .26-stable
>=20
>   But (using 2.6.21-stable and 2.6.22-stable as proxies),
>  tests indicate that going from .26.8 to .27 or anything
>  later will have numerous conflicts (100s? in more than
>  30 files).  Thinking about it, this isn't too surprising
>  since the -stable branches cherry-pick important/benign
>  fixes from later revisions.
Assuming you have your master on top of .21-stable and want to go to
=2E26-stable, the following might work better for you:

	$ git checkout -b mydot26stable .26-stable
	$ git merge -s ours .21-stable
	$ git checkout master
	$ git merge mydot26stable=09

Note this is not tested, just came to my mind...

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=C3=B6nig  =
          |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
