From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/13] strbuf: add strbuf_add*_urlencode
Date: Tue, 29 Nov 2011 22:20:28 -0500
Message-ID: <20111130032028.GA24704@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110728.GI8417@sigill.intra.peff.net>
 <7vzkfessff.fsf@alter.siamese.dyndns.org>
 <20111129211950.GD1793@sigill.intra.peff.net>
 <4ED56A1C.9050800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Nov 30 04:20:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVaj1-0005JF-Tu
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 04:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab1K3DUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 22:20:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55946
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab1K3DUa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 22:20:30 -0500
Received: (qmail 5997 invoked by uid 107); 30 Nov 2011 03:27:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 22:27:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 22:20:28 -0500
Content-Disposition: inline
In-Reply-To: <4ED56A1C.9050800@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186098>

On Wed, Nov 30, 2011 at 12:26:20AM +0100, Ren=C3=A9 Scharfe wrote:

> >>> +static int is_rfc3986_reserved(char ch)
> >>> +{
> >>> +	switch (ch) {
> >>> +	case '!': case '*': case '\'': case '(': case ')': case ';':
> >>> +	case ':': case '@': case '&': case '=3D': case '+': case '$':
> >>> +	case ',': case '/': case '?': case '#': case '[': case ']':
> >>> +		return 1;
> >>> +	}
> [...]
> Sorry for my bikeshedding, but I'd paint it like this:
>=20
> 	return !!strchr("!*'();:@&=3D+$,/?#[]", ch);

I was always under the impression that computed jumps via "switch" woul=
d
out-perform even an optimized strchr. Of course, I never tested. And I
doubt performance is even relevant here, and I admit I don't care overl=
y
much. I find them both equally readable.

I'm going to leave it as-is unless somebody else wants to say "I
strongly prefer version X".

-Peff
