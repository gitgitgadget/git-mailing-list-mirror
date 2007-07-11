From: Jan Hudec <bulb@ucw.cz>
Subject: Re: pushing changes to a remote branch
Date: Wed, 11 Jul 2007 21:29:59 +0200
Message-ID: <20070711192959.GB3069@efreet.light.src>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 21:31:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hty-0000Rc-VL
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 21:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174AbXGKTaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 15:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759902AbXGKTaH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 15:30:07 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47480 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933667AbXGKTaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 15:30:04 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 53D2557348
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 21:30:01 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 0EqKykEy7MLE for <git@vger.kernel.org>;
	Wed, 11 Jul 2007 21:29:59 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id DC28F57333
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 21:29:59 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I8hst-0002ke-9W
	for git@vger.kernel.org; Wed, 11 Jul 2007 21:29:59 +0200
Content-Disposition: inline
In-Reply-To: <20070710143614.GA29681@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52192>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2007 at 16:36:14 +0200, martin f krafft wrote:
>   git checkout origin/vim
>     Note: moving to "origin/vim" which isn't a local branch

There is more to that message, no? However, it only says "Head is now at
<commit-id>", which does not really indicate, that the HEAD has been
"detached". This means that it now contains a commit-id rather than name of
some branch.

Git detaches head whenever you check out, without -b option, anything other
than branch (without it's refs/heads prefix). If you than check out a branc=
h,
you can't see the commit on any branch anymore. However, you can still acce=
ss
it in reflog, ie. via expressions like HEAD@{1} or HEAD@{1 hour ago}.

You should also be able to:

 git push origin HEAD:vim

after the commit, and even (I didn't try it, but documentation seems to cla=
im
it should work):

 git push origin HEAD@{1}:vim

if you already changed HEAD more.

You can see this "metahistory" of HEAD via:

 git reflog

which is shorthand for git reflog show HEAD

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlS+3Rel1vVwhjGURAjJZAJ94W1QSigKho7eL0DjNLHNUTctwmACaA3Ej
zFVCo18DsT+BTi5mZrOUU2Q=
=VQRf
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
