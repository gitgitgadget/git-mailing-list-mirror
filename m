From: Jeff King <peff@peff.net>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Sat, 22 Nov 2014 14:48:42 -0500
Message-ID: <20141122194841.GA13665@peff.net>
References: <5468C33E.2080108@whonix.org>
 <20141117212657.GC15880@peff.net>
 <546FC446.50101@whonix.org>
 <1B02B87E88254A4A95EE138C9D2C4B8B@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org,
	Patrick Schleizer <patrick-mailinglists@whonix.org>,
	whonix-devel@whonix.org, mikegerwitz@gnu.org
X-From: git-owner@vger.kernel.org Sat Nov 22 20:48:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsGfo-0001pl-8P
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 20:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbaKVTso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 14:48:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:43541 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752752AbaKVTsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 14:48:43 -0500
Received: (qmail 15043 invoked by uid 102); 22 Nov 2014 19:48:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Nov 2014 13:48:43 -0600
Received: (qmail 1283 invoked by uid 107); 22 Nov 2014 19:48:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Nov 2014 14:48:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Nov 2014 14:48:42 -0500
Content-Disposition: inline
In-Reply-To: <1B02B87E88254A4A95EE138C9D2C4B8B@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260075>

On Fri, Nov 21, 2014 at 06:32:46PM -0500, Jason Pyeron wrote:

> The whole issue is a lot better than this makes it sound. Yes it is
> just a SHA1 hash, but it is a hash of a structured data format.
> 
> You have very observable parts of that well structured data providede to the hash.

Yeah, I glossed over that because I don't know enough about the specific
attacks.  In the worst case, you have a binary file format that lets
people stick arbitrary bits of data in the middle (like the MD5 attacks
on Postscript and PDF files), and you do the collision on the blobs.

But even with that, the sha1s are taken over "blob <n>\0<content>" where
<n> is the number of bytes of <content>. Depending on the exact scheme
for generating probable collisions is less than brute force time, even
that amount of structure may prove problematic. I don't know whether
that is the case for the best-known attacks or not (remember that nobody
has _actually_ generated a sha-1 collision at all yet).

-Peff
