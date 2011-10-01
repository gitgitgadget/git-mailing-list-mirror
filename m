From: Jeff King <peff@peff.net>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need
 before updating our ref) breaks fetch
Date: Sat, 1 Oct 2011 02:03:53 -0400
Message-ID: <20111001060353.GA25228@sigill.intra.peff.net>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
 <m3y5x8o527.fsf@localhost.localdomain>
 <1317426849.4331.29.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Oct 01 08:04:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9sgF-00054i-0L
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 08:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944Ab1JAGD5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 02:03:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50667
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab1JAGD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 02:03:56 -0400
Received: (qmail 8447 invoked by uid 107); 1 Oct 2011 06:08:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Oct 2011 02:08:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Oct 2011 02:03:53 -0400
Content-Disposition: inline
In-Reply-To: <1317426849.4331.29.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182539>

On Sat, Oct 01, 2011 at 01:54:08AM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> > Have you tried
> >=20
> >   $ ./git fetch git://repo.or.cz/git
>=20
> But this would execute /usr/local/libexec/git-fetch, wouldn't it? Tha=
t
> is precisely what I don't want to execute, because I changed some cod=
e
> in builtin/fetch.c that I want to test.

No, but only because fetch is a builtin. However, it still doesn't set
up exec_path correctly, so your rev-list problem would not go away.

> I guess I'll have to either properly install git from 'next' or base =
my
> changed on 'maint'

Just use bin-wrappers/git. That's exactly what it's there for (and it's
what the test scripts use to make sure we are testing what is compiled)=
=2E

Your change isn't the problem; only your testing method.

-Peff
