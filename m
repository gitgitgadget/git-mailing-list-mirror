From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 16:21:40 +0200
Message-ID: <20071005142140.GK19879@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="KrHCbChajFcK0yQE";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 16:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ido40-0000Q4-GS
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 16:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbXJEOVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 10:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbXJEOVv
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 10:21:51 -0400
Received: from pan.madism.org ([88.191.52.104]:55071 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755062AbXJEOVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 10:21:50 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 20685238A7;
	Fri,  5 Oct 2007 16:21:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 09F866C63; Fri,  5 Oct 2007 16:21:40 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1191447902-27326-1-git-send-email-krh@redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60083>


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +/* Parse the given options against the list of known options.  The
> + * order of the option structs matters, in that ambiguous
> + * abbreviations (eg, --in could be short for --include or
> + * --interactive) are matched by the first option that share the
> + * prefix.

  Do we really want that ?

  I do believe that it's a very bad idea, as it silently breaks. Most of
the command line switches people need to use have a short form, or their
shell will complete it properly.

  A very interesting feature though, would be to finally be able to
parse aggregated switches (`git rm -rf` anyone ?).

  I also believe that it's a pity that parse_options isn't able to
generate the usage by itself. But we can add that later.

  I've though an alternate proposal, based on your work, for the first
patch.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBkh0vGr7W6HudhwRAmuMAJ9iV1gTf71Ydot4cpdvGro3m4Po8ACgmvW+
lkN+yH9yETPTwnk4GkjBdwQ=
=yqmx
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
