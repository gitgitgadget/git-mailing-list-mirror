From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Use more strbufs series [on top of next]
Date: Sun, 09 Sep 2007 02:12:05 +0200
Message-ID: <20070909001205.GD13385@artemis.corp>
References: <11892962763548-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Ycz6tD7Th1CMF4v7";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 10:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOS-00040f-6R
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:48 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAVR-0001gT-HY
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:18:29 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAVL-0007Ld-0D
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbXIIAMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbXIIAMI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:12:08 -0400
Received: from pan.madism.org ([88.191.52.104]:57437 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338AbXIIAMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:12:07 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CA31C1E18B
	for <git@vger.kernel.org>; Sun,  9 Sep 2007 02:12:05 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7266663FA; Sun,  9 Sep 2007 02:12:05 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11892962763548-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.7, required=12.0, autolearn=disabled, AWL=1.337,UIO_VGER=-3)
X-UiO-Scanned: 1252669060C3F9EDC0ADE198820E126DE8C4ABF9
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -16 maxlevel 200 minaction 2 bait 0 mail/h: 10 total 517796 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58143>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 09, 2007 at 12:04:30AM +0000, Pierre Habouzit wrote:
>   Here is a series of patches on top of next, which use strbufs in even
> more places. Most notably, it uses it in the commit pretty printer (and
> commit message formatter), and it supersedes definitely read_fd
> (previously in sha1_file.c).

  A side note that could help the patch readers: in some places I've
made hunks that basically rename variables called space or size into
len. The reason is that (in my coding standards) length is the length of
the object we are referring to, whereas space/size/... is the amount of
memory we have allocated for it. For a string, the latter is strictly
greater than the former because of the ending NUL of course.

  The rename is because my brain is used to this way of thinking and
that it helps knowing if the off-by-some (off-by-one for a string) are
included in the length-related number you work with or not. So please
don't discard those :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4zpVvGr7W6HudhwRAjlGAKCmycdelRJbteOlEh/FBBokPyoTkwCfRcBL
16KiwV/veCuLExb8Aecw5Mo=
=fRAC
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
