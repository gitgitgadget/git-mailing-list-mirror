From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] fetch: honor the user-provided refspecs when pruning
 refs
Date: Fri, 7 Oct 2011 12:39:37 -0400
Message-ID: <20111007163936.GA5212@sigill.intra.peff.net>
References: <20111006205103.GA1271@erythro.kitwarein.com>
 <1317936107-1230-1-git-send-email-cmn@elego.de>
 <1317936107-1230-3-git-send-email-cmn@elego.de>
 <20111007162625.GB4399@sigill.intra.peff.net>
 <1318005433.4579.5.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Oct 07 18:39:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCDSb-0005MU-4R
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 18:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965489Ab1JGQjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 12:39:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55008
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965451Ab1JGQjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 12:39:40 -0400
Received: (qmail 23833 invoked by uid 107); 7 Oct 2011 16:39:40 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Oct 2011 12:39:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2011 12:39:37 -0400
Content-Disposition: inline
In-Reply-To: <1318005433.4579.5.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183087>

On Fri, Oct 07, 2011 at 06:37:13PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> > I assume you mean s/tag/branch/ in the last line?
>=20
> Yeah, maybe ref would be better?

Yeah, agreed.

> > Tests?
>=20
> Good point.

It sounds like you already have a reproduction recipe for this, and for
the --tags thing in the next commit.

> OK, so take a step back and figure out what we want the rules to be
> before we call get_stale_heads. It does sound like a more elegant
> approach. I was trying to disrupt the callers as little as possible, =
but
> then again, there's only two. Will change.

Yeah. Sometimes we try hard to make a minimal patch, because it makes i=
t
easier to review. At the same time, I think it's more important to make
the code clean if it needs it. Especially when there aren't many caller=
s
to disrupt.

-Peff
