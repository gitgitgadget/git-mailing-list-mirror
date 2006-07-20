From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-am: Don't accept an mbox on stdin of we already have a .dotest directory
Date: Thu, 20 Jul 2006 16:33:54 +0200
Message-ID: <20060720143353.GK13776@pasky.or.cz>
References: <44BE95D0.9090708@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 20 16:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3ZbF-0002mS-MK
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 16:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWGTOd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 20 Jul 2006 10:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWGTOd5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 10:33:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11424 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932584AbWGTOd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 10:33:57 -0400
Received: (qmail 4686 invoked by uid 2001); 20 Jul 2006 16:33:54 +0200
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <44BE95D0.9090708@etek.chalmers.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24031>

Dear diary, on Wed, Jul 19, 2006 at 10:28:00PM CEST, I got a letter
where Lukas Sandstr=F6m <lukass@etek.chalmers.se> said that...
> Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>
> ---

Please don't be afraid of putting stuff to commit message. It can only
improve things. :-)

> # git format-patch -k -3 master..conflict | git am -k -3
> =3D> git-am fails with a conflict message
> # git reset --hard
>=20
> # git format-patch -k -3 master..ok | git am -k -3
> =3D> git am fails with the same conflict message as above,
> =3D> since it's trying to apply the old .dotest directory
>=20
> With the patch it complains about an old .dotest
> directory instead.

I think this rather means that git reset --hard should clear the .dotes=
t
directory, or something (perhaps just warn)...

> -	test ",$#," =3D ",0," ||
> +	if test ",$#," !=3D ",0," || ! tty -s

=2E..but this looks like a horrible idea. Does this mean that git-am ca=
n't
be now ran without a terminal? (E.g. in a cron/at job, inside a procmai=
l
rule etc.) That's bad.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
