From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] README: Sketch out what tg rename OLD NEW would do.
Date: Sun, 28 Feb 2010 11:13:20 +0100
Message-ID: <20100228101320.GA13987@pengutronix.de>
References: <1267310389-11984-1-git-send-email-thomas@schwinge.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Schwinge <thomas@schwinge.name>
X-From: git-owner@vger.kernel.org Sun Feb 28 11:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlg9Q-0004hO-Jn
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 11:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031748Ab0B1KNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 05:13:22 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53234 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031745Ab0B1KNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 05:13:21 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Nlg9I-0002qT-V5; Sun, 28 Feb 2010 11:13:20 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Nlg9I-0003ij-GX; Sun, 28 Feb 2010 11:13:20 +0100
Content-Disposition: inline
In-Reply-To: <1267310389-11984-1-git-send-email-thomas@schwinge.name>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141245>

Hello Thomas,

On Sat, Feb 27, 2010 at 11:39:49PM +0100, Thomas Schwinge wrote:
> ... as proposed by me and acknowledged by David Bremner and Uwe Klein=
e-K=F6nig on
> 2010-01-27 in #topgit (freenode).
> ---
>  README |   17 ++++++++++++++++-
>  1 files changed, 16 insertions(+), 1 deletions(-)
>=20
> diff --git a/README b/README
> index 495c70b..eab6fcd 100644
> --- a/README
> +++ b/README
> @@ -486,7 +486,22 @@ tg push
>  	repository.  By default the remote gets all dependencies
>  	(both tgish and non-tgish) and bases pushed to.
> =20
> -TODO: tg rename
> +tg rename
> +~~~~~~~~~
> +	There is no such command yet, but here's a receipe what ``tg rename=
 OLD
> +	NEW'' would do:
> +
> +	  - Have a clean state before beginning.
- assert NEW doesn't already exist?
> +	  - git banch -r OLD NEW
s/banch/branch/

> +	  - git update-ref refs/top-bases/NEW refs/top-bases/OLD ''
> +	  - for BRANCH in (all branches that depend on OLD,
> +			   i.e. reference OLD in .topdeps); do
> +	      git checkout BRANCH
> +	      sed -i 's%^OLD$%NEW$' .topdeps
> +	      git commit -m 'OLD -> NEW' .topdeps
> +	    done
> +	  - tg summary
> +	  - tg update as appropriate
> =20
> =20
>  IMPLEMENTATION
Otherwise looks OK

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
