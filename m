From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 7 Jan 2006 15:12:44 +0300
Message-ID: <20060107151244.762e628f.vsu@altlinux.ru>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>
	<7vsls0mns8.fsf@assigned-by-dhcp.cox.net>
	<7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__7_Jan_2006_15_12_44_+0300_lav8RxWjCC8z1xbh"
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 14:16:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvDvd-0003bI-17
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 14:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWAGNQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWAGNQN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 08:16:13 -0500
Received: from master.altlinux.org ([62.118.250.235]:16144 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932724AbWAGNQN
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 08:16:13 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 78C55E3251; Sat,  7 Jan 2006 16:15:56 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id 937E6E385CB; Sat,  7 Jan 2006 15:12:48 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14260>

--Signature=_Sat__7_Jan_2006_15_12_44_+0300_lav8RxWjCC8z1xbh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 07 Jan 2006 01:56:41 -0800 Junio C Hamano wrote:

> +#if (__GNUC__ =3D=3D 2) && (__GNUC_MINOR__ =3D=3D 95)
> +#define FLEX_ARRAY 0
> +#else
> +#define FLEX_ARRAY /* empty */
> +#endif

There is also gcc 2.96, which also does not understand the C99 syntax.
So we should use something like this instead:

#if defined(__GNUC__) && (__GNUC__ < 3)
#define FLEX_ARRAY 0
#else
#define FLEX_ARRAY /* empty */
#endif

(and be prepared to get complaints from users of other compilers).

--Signature=_Sat__7_Jan_2006_15_12_44_+0300_lav8RxWjCC8z1xbh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFDv7BAW82GfkQfsqIRAijLAJ9Bd1ZQP2pFAzrfXd3UIOTWODc6LwCfYmfL
b2ByYCgyH0L4rF2fgEPse2s=
=GAXQ
-----END PGP SIGNATURE-----

--Signature=_Sat__7_Jan_2006_15_12_44_+0300_lav8RxWjCC8z1xbh--
