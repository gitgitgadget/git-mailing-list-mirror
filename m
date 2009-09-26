From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found
  by the clang static analyzer
Date: Sat, 26 Sep 2009 21:28:42 +0200
Message-ID: <4ABE6B6A.4000400@lsrfire.ath.cx>
References: <87ab0hepcn.fsf@master.homenet>	<alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>	<871vltefdj.fsf@master.homenet>	<fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com> <87ske9cya9.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 21:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrcx8-0005WW-6H
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 21:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbZIZT2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2009 15:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbZIZT2w
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 15:28:52 -0400
Received: from india601.server4you.de ([85.25.151.105]:51865 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbZIZT2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 15:28:52 -0400
Received: from [10.0.1.101] (p57B7CED9.dip.t-dialin.net [87.183.206.217])
	by india601.server4you.de (Postfix) with ESMTPSA id E42A82F805B;
	Sat, 26 Sep 2009 21:28:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <87ske9cya9.fsf@master.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129169>

> diff --git a/diff.c b/diff.c
> index e1be189..e75f58e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -901,7 +901,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
> =20
>  	/* Find the longest filename and max number of changes */
>  	reset =3D diff_get_color_opt(options, DIFF_RESET);
> -	set   =3D diff_get_color_opt(options, DIFF_PLAIN);
> +	diff_get_color_opt(options, DIFF_PLAIN);
>  	add_c =3D diff_get_color_opt(options, DIFF_FILE_NEW);
>  	del_c =3D diff_get_color_opt(options, DIFF_FILE_OLD);

diff_get_color_opt() has no side-effects; the changed line is a no-op.

Ren=E9
