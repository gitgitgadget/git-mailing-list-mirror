From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Sat, 9 Nov 2013 16:21:07 -0500
Message-ID: <20131109212106.GA2712@sigill.intra.peff.net>
References: <527C0CEA.4020705@ramsay1.demon.co.uk>
 <20131107221944.GA19238@sigill.intra.peff.net>
 <527D1B06.3090807@web.de>
 <20131108222903.GB19912@sigill.intra.peff.net>
 <527E1DED.9030800@web.de>
 <527E7021.8060204@kdbg.org>
 <87txflnv7n.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Nov 09 22:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfFxz-0001bt-9P
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 22:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757920Ab3KIVVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 16:21:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:36438 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752246Ab3KIVVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 16:21:09 -0500
Received: (qmail 21952 invoked by uid 102); 9 Nov 2013 21:21:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 09 Nov 2013 15:21:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Nov 2013 16:21:07 -0500
Content-Disposition: inline
In-Reply-To: <87txflnv7n.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237582>

On Sat, Nov 09, 2013 at 10:03:56PM +0100, Thomas Rast wrote:

> > Of course. You write little endian and also read back little endian;
> > that should work just fine, no?
> >
> > OTOH, if you write with Intel and read with PPC, then you should observe
> > misbehavior with the above patch.
> 
> Maybe you could check in a simple test that the bitmap for a very
> predictable pack (e.g. only one commit) has a certain content, by
> checking its hash.  That would guard against accidental format changes.

Another option would be to cross-check reading and writing against JGit,
which is valuable for other reasons besides checking endianness. I do
not think most people will have JGit installed, but it's better than
nothing (and if even one person runs it, we have a chance of finding a
bug).

-Peff
