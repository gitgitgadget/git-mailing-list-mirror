From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Re: [PATCH 2/2] completion: enhance "current branch" display
Date: Sun, 10 May 2009 13:33:30 +0200
Message-ID: <87my9lnqet.fsf@erwin.mina86.com>
References: <7vvdo91glm.fsf@alter.siamese.dyndns.org>
	<200905101259.07175.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun May 10 13:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M37Hv-0006ej-Mq
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 13:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbZEJLdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 07:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbZEJLdi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 07:33:38 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:37010 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZEJLdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 07:33:38 -0400
Received: by ewy24 with SMTP id 24so2837050ewy.37
        for <git@vger.kernel.org>; Sun, 10 May 2009 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :references:x-url:x-pgp-fp:x-pgp:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yX0c0uUS+GJnVnkbKpQu9kkAQavbXYEyPFiDMuyBja4=;
        b=eZCythx1+XICWhlLWPFrZb7ks3t2vTzZOk28hxvCOK0wZShlElkkAXqsz7laAe+wSl
         cfdq08z+T6RE0StCJW75e4c6EczCTt2RWMH1a+uRPe1suRGbyiinKEYeeZmjPrN0R735
         qldE4lyF3ZdRyEV5qOOkhoAfr5c3JU+2DqtGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:references:x-url:x-pgp-fp:x-pgp:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        b=U+GTaLuNf2DFmLwjH/XTBijpIgYhTRD9bS2NfcK2ygWKCwpFSY/DGVVgfOlETRu6hA
         GayTRUwN9gDjnl2DC+uwgDxAw8oTmOvGgxPlSBuX/44RXuYmP2+v9CU73j3aE39uqqxB
         Q79BU5V9M6iQvxwn8KZkHpKcxSjFOTSruy6d0=
Received: by 10.210.18.8 with SMTP id 8mr2111497ebr.16.1241955217717;
        Sun, 10 May 2009 04:33:37 -0700 (PDT)
Received: from erwin.piotrekn (aaqs121.neoplus.adsl.tpnet.pl [83.5.178.121])
        by mx.google.com with ESMTPS id 7sm5504298eyg.27.2009.05.10.04.33.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 04:33:37 -0700 (PDT)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
In-Reply-To: <200905101259.07175.j6t@kdbg.org> (Johannes Sixt's message of
	"Sun, 10 May 2009 12:59:07 +0200")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118715>

--=-=-=
Content-Transfer-Encoding: quoted-printable

Johannes Sixt <j6t@kdbg.org> writes:

> On Sonntag, 10. Mai 2009, Junio C Hamano wrote:
>>  				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
>
> While you are here, you could turn this line into
>
> 		{ b=3D$(< "$g/HEAD") && b=3D${b:0:7}...; } 2>/dev/null ||
>
> to save a process. $(< foo) is a bash feature and does the same as
> $(cat foo), but faster.

Excuse me this little cavil but how about something that works on other
shells as well:

{ read b <$g/HEAD && _b=3D${b#???????} && b=3D${b%"$_b"}... && unset _b }

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoGu48ACgkQUyzLALfG3x4DawCdGApmk+8oBTom0Zta31oMIPjj
N/AAoI+srJr0N1gHBQrwSk/s5aw0bvJc
=gZFC
-----END PGP SIGNATURE-----
--=-=-=--
