From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] doc/http-backend: give some lighttpd config examples
Date: Thu, 11 Apr 2013 13:02:33 -0400
Message-ID: <20130411170233.GB1255@sigill.intra.peff.net>
References: <20130411033022.GA14462@sigill.intra.peff.net>
 <20130411033613.GB14551@sigill.intra.peff.net>
 <5166E935.2080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus Therning <magnus@therning.org>, git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 19:02:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKtZ-0000da-T8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935848Ab3DKRCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 13:02:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934893Ab3DKRCl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 13:02:41 -0400
Received: (qmail 16754 invoked by uid 107); 11 Apr 2013 17:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 13:04:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 13:02:33 -0400
Content-Disposition: inline
In-Reply-To: <5166E935.2080206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220893>

On Thu, Apr 11, 2013 at 06:47:49PM +0200, Jakub Nar=C4=99bski wrote:

> W dniu 11.04.2013 05:36, Jeff King napisa=C5=82:
>=20
> > +Note that unlike the similar setup with Apache, we can easily matc=
h the
> > +query string for receive-pack, catching the initial request from t=
he
> > +client. This means that the server administrator does not have to =
worry
> > +about configuring `http.receivepack` for the repositories (the def=
ault
> > +value, which enables it only in the case of authentication, is
> > +sufficient).
>=20
> Perhaps it would be worth including for Apache2 beside basic setup th=
at
> requires http.receivepack set to true, also one like for LigHTTPd, i.=
e.
>=20
>   RewriteCond %{QUERY_STRING} =3Dservice=3Dgit-receive-pack [OR]
>   RewriteCond %{REQUEST_URI} /git-receive-pack$
>   RewriteRule (.*) $1 [E=3DAUTHREQUIRED:yes]
>=20
>   <Location /gitweb/>
>       Order Deny,Allow
>       Deny from env=3DAUTHREQUIRED
>=20
>       AuthType Basic
>       AuthName "Git Access"
>       Require group committers
>=20
>       Satisfy Any
>   <Location>
>=20
> And perhaps also adding it as test...

That was the "I am not clever nor interested in Apache enough to figure
out how to do this..." part that I wrote. I have no clue if the above
works, but I'd be happy if you wanted to test it out and submit it as a
patch on top (I think it could even replace my 1/2, as making it just
work is a much better solution than having to explain the extra step in
the documentation).

-Peff

> --=20
> Jakub Nar=C4=99bski
