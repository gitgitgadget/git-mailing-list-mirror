From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix regression in fast-import.c due to strbufs.
Date: Fri, 26 Oct 2007 19:25:23 +0200
Message-ID: <20071026172523.GB5496@artemis.corp>
References: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com> <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com> <20071026065301.GL14735@spearce.org> <20071026075912.GA25365@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="GRPZ8SYKNexpdSJ7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Shun Kei Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 19:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlSwG-0005pU-SX
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 19:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232AbXJZRZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 13:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758154AbXJZRZ1
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 13:25:27 -0400
Received: from pan.madism.org ([88.191.52.104]:37975 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757666AbXJZRZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 13:25:26 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5B7BA25371;
	Fri, 26 Oct 2007 19:25:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 55AB14618; Fri, 26 Oct 2007 19:25:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shun Kei Leung <kevinlsk@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071026075912.GA25365@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62433>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Shun, the fast-import bug your reported has a fix.

Dear Junio, please merge the patch in the mail I'm answering to[0] into
master as it fixes a crash in fast-import.

Cheers,

  [0]  Message-Id: <20071026075912.GA25365@artemis.corp>

diff --git a/fast-import.c b/fast-import.c
index 6f888f6..f93d7d6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1616,6 +1616,7 @@ static void cmd_data(struct strbuf *sb)
 		char *term =3D xstrdup(command_buf.buf + 5 + 2);
 		size_t term_len =3D command_buf.len - 5 - 2;
=20
+		strbuf_detach(&command_buf, NULL);
 		for (;;) {
 			if (strbuf_getline(&command_buf, stdin, '\n') =3D=3D EOF)
 				die("EOF in data (terminator '%s' not found)", term);
--=20
1.5.3.4.1358.gfae55-dirty




--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHIiMDvGr7W6HudhwRAo7SAJ977sICoU4RBrita8v1yMLQ1vW4ZgCgiRZ8
fV7lcdDiAJ2liQlYo98b1Jk=
=D0Gq
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
