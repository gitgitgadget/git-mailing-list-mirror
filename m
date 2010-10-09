From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 09/10] [RFC] tg-patch: use ui diff when pager is
	active
Date: Sat, 9 Oct 2010 22:43:48 +0200
Message-ID: <20101009204348.GO29673@pengutronix.de>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com> <0fd777939e0ca49b6e0013ab667cadbfae55e879.1286524446.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:44:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gGq-0003ZH-FH
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab0JIUnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 16:43:51 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37315 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757075Ab0JIUnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:43:50 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4gGj-0004Z2-Ke; Sat, 09 Oct 2010 22:43:49 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4gGi-0000ci-6T; Sat, 09 Oct 2010 22:43:48 +0200
Content-Disposition: inline
In-Reply-To: <0fd777939e0ca49b6e0013ab667cadbfae55e879.1286524446.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158608>

Hi Bert,


On Fri, Oct 08, 2010 at 09:58:07AM +0200, Bert Wesarg wrote:
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

can you tell me the motivation for this patch again?  It should go into
the commit log, too.

Thanks
Uwe

> ---
>  tg-patch.sh |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>=20
> diff --git a/tg-patch.sh b/tg-patch.sh
> index 9def6e5..dcce672 100644 tg-patch.sh
> --- a/tg-patch.sh
> +++ b/tg-patch.sh
> @@ -70,7 +70,12 @@ t_tree=3D$(pretty_tree "$name" $head_from)
>  if [ $b_tree =3D $t_tree ]; then
>  	echo "No changes."
>  else
> -	git diff-tree -p --stat $b_tree $t_tree
> +	# use the ui diff command when the pager is active
> +	diff_command=3Ddiff
> +	[ "x$GIT_PAGER_IN_USE" =3D "x1" ] ||
> +		diff_command=3Ddiff-tree
> +
> +	git $diff_command -p --stat $b_tree $t_tree
>  fi
> =20
>  echo '-- '
> --=20
> 1.7.1.1067.g5aeb7
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
