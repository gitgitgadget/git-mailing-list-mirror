From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Thu, 10 May 2007 22:01:55 +0200
Message-ID: <20070510200155.GB10353@diana.vm.bytemark.co.uk>
References: <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site> <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site> <Pine.LNX.4.64.0705091210570.18541@iabervon.org> <Pine.LNX.4.64.0705091822590.4167@racer.site> <20070509170725.GB23778@fieldses.org> <Pine.LNX.4.64.0705092208230.4167@racer.site> <Pine.LNX.4.64.0705091625200.18541@iabervon.org> <Pine.LNX.4.64.0705100015120.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Petr Baudis <pasky@suse.cz>, junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 10 22:02:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEqO-0003R6-GW
	for gcvg-git@gmane.org; Thu, 10 May 2007 22:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039AbXEJUCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 16:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757046AbXEJUCR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 16:02:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1291 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039AbXEJUCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 16:02:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HmEpn-0002xj-00; Thu, 10 May 2007 21:01:55 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705100015120.4167@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46894>

On 2007-05-10 00:23:50 +0200, Johannes Schindelin wrote:

> I was not aware originally, that no arithmetic is involved in SHA-1
> computation.
>
> If you store large integers, it makes tons of sense to follow the
> endianness, especially if you do _both_ boolean and integer
> operations on them.

Actually, if you take a look at

  http://en.wikipedia.org/wiki/Sha1#SHA-1_algorithm

you'll see that in addition to an unholy mess of bitwise operations,
it does do some additions, on 32-bit big-endian words according to the
article.

But thinking of them as addition gives you the wrong mental picture;
they're simply one of many ways for a standard processor to mix bits
efficiently as far as SHA-1 is concerned. The algorithm is specified
as yielding a 160-bit binary blob, and can and should be thought of as
a black NSA-certified box with "warranty void if this seal is broken"
stickers. (Unless you're the one implementing it, of course. But then
you know what you're doing.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
