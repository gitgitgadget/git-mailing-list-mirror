From: Jeff King <peff@peff.net>
Subject: Re: Conditionally define vars to improve portability
Date: Tue, 8 Sep 2015 02:30:34 -0400
Message-ID: <20150908063034.GF26331@sigill.intra.peff.net>
References: <81961DE1-FA30-4E55-8818-9FCA3BC59B81@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Renato Botelho <garga@FreeBSD.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:30:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZCQT-0007e3-P0
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 08:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbbIHGai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 02:30:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:56131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751344AbbIHGah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 02:30:37 -0400
Received: (qmail 18741 invoked by uid 102); 8 Sep 2015 06:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 01:30:37 -0500
Received: (qmail 19431 invoked by uid 107); 8 Sep 2015 06:30:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 02:30:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 02:30:34 -0400
Content-Disposition: inline
In-Reply-To: <81961DE1-FA30-4E55-8818-9FCA3BC59B81@FreeBSD.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277491>

On Mon, Sep 07, 2015 at 02:51:42PM -0300, Renato Botelho wrote:

> Default variables used to build are set using =3D on Makefile, (e.g. =
CC,
> INSTALL, CFLAGS, =E2=80=A6). GNU make overwrite these values if it=E2=
=80=99s passed as
> an argument (make CC=3Dclang) and it works as expected.
>=20
> Default method of passing arguments for make operations on FreeBSD
> ports tree is using environment variables instead of make arguments,
> then we have CC set on env before call gmake. Today these values are
> ignored by git Makefile, and we ended up patching Makefile replacing =
=3D
> by ?=3D on variable assignments [1].

Hmm. I can't really think of a downside to doing so, unless we expect
users to have things like CC set in the environment and _not_ want them
to bleed through to our build.

But doesn't "gmake -e" solve your problem without a patch?

-Peff
