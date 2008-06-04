From: Jeff King <peff@peff.net>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 20:35:16 -0400
Message-ID: <20080604003516.GA24232@sigill.intra.peff.net>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org> <7v3anv5fy3.fsf@gitster.siamese.dyndns.org> <7vskvv3xmx.fsf@gitster.siamese.dyndns.org> <20080603104009.GA559@neumann> <7vabi22u5h.fsf@gitster.siamese.dyndns.org> <20080603203924.GA6588@neumann> <7vk5h6189b.fsf@gitster.siamese.dyndns.org> <20080603231020.GB6588@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 02:36:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3gz6-0006Uv-Th
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 02:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYFDAfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 20:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYFDAfT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 20:35:19 -0400
Received: from peff.net ([208.65.91.99]:4233 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbYFDAfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 20:35:18 -0400
Received: (qmail 9734 invoked by uid 111); 4 Jun 2008 00:35:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 03 Jun 2008 20:35:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2008 20:35:16 -0400
Content-Disposition: inline
In-Reply-To: <20080603231020.GB6588@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83736>

On Wed, Jun 04, 2008 at 01:10:20AM +0200, SZEDER G=C3=A1bor wrote:

> Yes, the first hunk fixes the problem (and the second one does not
> introduce any new breakage on my system ;)
>=20
> However, I don't really see why the new test failed only at me...

Because you were the only person (so far) whose gecos information wasn'=
t
sufficient for git-commit to work. In Junio's case, the test script
accidentally unset the GIT_COMMITTER_{NAME,EMAIL} variables, which
caused git-commit to fall back on the information in /etc/passwd; it
worked, but it was doing something unintended. On your system, that
information wasn't available, so git-commit just broke.

-Peff
