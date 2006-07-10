From: Diego 'Flameeyes' =?iso-8859-1?q?Petten=F2?= 
	<flameeyes@gentoo.org>
Subject: [PATCH] Allow usage of git-svnimport's -d/-D options with https
Date: Mon, 10 Jul 2006 21:34:36 +0200
Message-ID: <200607102134.58247@enterprise.flameeyes.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1824830.OojfqmJGna";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 10 21:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G01j4-0003dE-RU
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 21:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWGJTqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 15:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbWGJTqw
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 15:46:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:29297 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422680AbWGJTqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 15:46:51 -0400
Received: by nf-out-0910.google.com with SMTP id d4so769450nfe
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:46:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:x-face:mime-version:content-type:content-transfer-encoding:message-id:sender;
        b=c+sp8mbyiC3ZjLVgFTth61dfJS+ZMSiSXkzGbqlc+OkTlU31fJ1fJyRWGBwfmAv2KxdgtV4u+ImvMOPJtpo1Gk1X7hG/BkauLs9lNsI32y7AeTU+Qo1BGN9P+LXBDeUdW2B+BHB+EGkOd423uK3oeLW8eOOUu2azvqSzoxhAdOU=
Received: by 10.78.177.11 with SMTP id z11mr1849674hue;
        Mon, 10 Jul 2006 12:46:49 -0700 (PDT)
Received: from enterprise.flameeyes.is-a-geek.org ( [151.56.118.124])
        by mx.gmail.com with ESMTP id 38sm4104208hua.2006.07.10.12.46.48;
        Mon, 10 Jul 2006 12:46:49 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
X-Face: +=-v@W}H`=.Bn2t&97Un7{[.c0aP0"8)JI?7Z<D)?o\/2TO|,=?utf-8?q?j=5EzC=3AoDSA=24++z3eixq-H=5E=0A=09+g?=<5?pNbV&a1{sZc=}l\wjrMam[JwcgZ%q{M%k~zJ!;#BCjK.n9y`>?E>l>ZNY|,=?utf-8?q?mL=5C3bs=0A=09xW=23jRz=7CVa=5C?=@NIS3-'W[F.^YLqK=rS:D*Ke`Y5giI@$(xIBQ<0i740;wuI{lYd>>=?utf-8?q?eFVDuAr=0A=09=3Br=5B*=7E/zd=604dEI?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23644>

--nextPart1824830.OojfqmJGna
Content-Type: multipart/mixed;
  boundary="Boundary-01=_NvqsEdiPQPYqaZg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_NvqsEdiPQPYqaZg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

While importing an SVN https repository (from SourceForge), I noticed that =
the=20
svnimport script just accepts http as url scheme to use -d/-D options, whil=
e=20
it seems to work fine with https too. The attached patch fixes that for me.

HTH,
=2D-=20
Diego "Flameeyes" Petten=F2 - http://farragut.flameeyes.is-a-geek.org/
Gentoo/Alt lead, Gentoo/FreeBSD, Video, AMD64, Sound, PAM, KDE

--Boundary-01=_NvqsEdiPQPYqaZg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="git-svnimport-https.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-svnimport-https.patch"

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 26dc454..9a69369 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -209,7 +209,7 @@ if($opt_d or $opt_D) {
 	} else {
 		$svn_dir = "";
 	}
-	if ($svn_url->scheme eq "http") {
+	if ($svn_url->scheme eq "http" or $svn_url->scheme eq "https") {
 		use LWP::UserAgent;
 		$lwp_ua = LWP::UserAgent->new(keep_alive => 1, requests_redirectable => []);
 	} else {

--Boundary-01=_NvqsEdiPQPYqaZg--

--nextPart1824830.OojfqmJGna
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEsqvie2h1+2mHVWMRAvZSAKCZJvwK3dfYmgVhTdCKi72zZLX2IACg4xFu
aQbTUqjgd3tLy0SlzK5BwAI=
=PyxN
-----END PGP SIGNATURE-----

--nextPart1824830.OojfqmJGna--
