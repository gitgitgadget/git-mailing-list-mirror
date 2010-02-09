From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9302: Protect against OS X normalization
Date: Tue, 9 Feb 2010 01:08:45 -0500
Message-ID: <20100209060845.GD14736@coredump.intra.peff.net>
References: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
 <1265688445-46137-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 07:09:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NejHg-0004KQ-Po
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 07:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0BIGIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 01:08:47 -0500
Received: from peff.net ([208.65.91.99]:46094 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525Ab0BIGIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 01:08:45 -0500
Received: (qmail 15677 invoked by uid 107); 9 Feb 2010 06:08:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Feb 2010 01:08:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 01:08:45 -0500
Content-Disposition: inline
In-Reply-To: <1265688445-46137-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139372>

On Mon, Feb 08, 2010 at 11:07:25PM -0500, Brian Gernhardt wrote:

> 8424981: "Fix invalid read in quote_c_style_counted" introduced a tes=
t
> that used "caract=C3=A8re sp=C3=A9cial" as a directory name.
>=20
> Git creates it as "caract\303\250re sp\303\251cial"
> OS X stores it as "caracte\314\200re spe\314\201cial"
>=20
> To work around this problem, use the already introduced $FN as the
> directory name.
>=20
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>=20
>  Junio C Hamano wrote:
>  > How about using $FN as the directory name instead?
>=20
>  I knew there was a clever answer I was missing.

I am not 100% sure this will still trigger the failure that 8424981 was
meant to fix. From my recollection of the bug, it not only needed an
unterminated string (which we get by having a directory) but the string
length and presence of multiple spread-out characters may have been
relevant.

Of course, that specific bug is fixed, so maybe it is not worth worryin=
g
about too much.

-Peff
