From: Jeff King <peff@peff.net>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Tue, 20 May 2008 19:16:31 -0400
Message-ID: <20080520231631.GB22934@sigill.intra.peff.net>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com> <20080519131942.GA5526@atjola.homenet> <20080520223158.GB13123@steel.home> <20080520230204.GA5383@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Alexander Gladysh <agladysh@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 21 01:17:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyb5T-0005n4-LN
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 01:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbYETXQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2008 19:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYETXQf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 19:16:35 -0400
Received: from peff.net ([208.65.91.99]:4015 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbYETXQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 19:16:34 -0400
Received: (qmail 4701 invoked by uid 111); 20 May 2008 23:16:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 May 2008 19:16:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 May 2008 19:16:31 -0400
Content-Disposition: inline
In-Reply-To: <20080520230204.GA5383@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82517>

On Wed, May 21, 2008 at 01:02:04AM +0200, Bj=C3=B6rn Steinbrink wrote:

> > Redirect stdin from /dev/null
>=20
> Does that actually work for you? It didn't work for me, because ssh t=
hen
> simply goes and opens /dev/tty to ask for the password.
>=20
> $ ssh -V
> OpenSSH_4.7p1 Debian-10, OpenSSL 0.9.8g 19 Oct 2007

I had to perform this same task a few weeks ago, and ended up using
'setsid' to get rid of the controlling tty. You may also need to unset
SSH_ASKPASS and DISPLAY.

-Peff
