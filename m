From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH 2/3] refactor: use bitsizeof() instead of 8 * sizeof()
Date: Thu, 23 Jul 2009 08:22:50 +0200
Message-ID: <20090723062250.GH4750@laphroaig.corp>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <1248298475-2990-2-git-send-email-madcoder@debian.org>
 <1248298475-2990-3-git-send-email-madcoder@debian.org>
 <20090723050711.GB9189@coredump.intra.peff.net>
 <7v3a8o6l3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:23:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTriV-0007OR-3s
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 08:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbZGWGWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 02:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbZGWGWy
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 02:22:54 -0400
Received: from pan.madism.org ([88.191.52.104]:48772 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbZGWGWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 02:22:53 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id A445341D6A;
	Thu, 23 Jul 2009 08:22:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3a8o6l3v.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123848>

On Wed, Jul 22, 2009 at 10:09:56PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Wed, Jul 22, 2009 at 11:34:34PM +0200, Pierre Habouzit wrote:
> >
> >>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
> >> +#define bitsizeof(x)  (CHAR_BIT * sizeof(x))
> >
> > Isn't our style to use all-caps for macros? I.e., BITSIZEOF?
>=20
> Perhaps but I'd say similarity between sizeof() and bitsizeof() calls=
 for
> consistency in the lowercase in this particular case.

Yes, I usually have a few other macros that I use in code I write,
namely bitsizeof, fieldsizeof, fieldtypeof and a couple other, and all
are lowercased because:
  - it's a safe macro (doesn't multi-evaluate its arguments), hence the
    user doesn't really need to know it's a macro ;
  - similarity with sizeof().

--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
=46ax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie
