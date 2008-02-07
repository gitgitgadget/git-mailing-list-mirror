From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 17:40:54 -0500
Message-ID: <20080207224054.GA18502@coredump.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207142322.GC18497@mail-vs.djpig.de> <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org> <20080207204026.GA2550@sigill.intra.peff.net> <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 23:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNFQy-0001U5-IQ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 23:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760697AbYBGWk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 17:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760526AbYBGWk6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 17:40:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3776 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757910AbYBGWk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 17:40:57 -0500
Received: (qmail 21321 invoked by uid 111); 7 Feb 2008 22:40:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 07 Feb 2008 17:40:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 17:40:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73012>

On Thu, Feb 07, 2008 at 01:01:09PM -0800, Linus Torvalds wrote:

> > FWIW, this is not about OpenSSL for SHA1; it is about the underlying
> > library used by curl to do SSL (gnutls vs openssl).
> 
> My comment was about claiming "not distributable". That was simply not 
> true. It's perfectly distributable, it's just Debian that has issues with 
> OpenSSL (but then they shouldn't link it against curl either, so there 
> seems to be some _other_ problem there too).

And I happen to agree with you, but...

> > And the problem is that curl linked against gnutls seems _broken_, so 
> > Anand has asked if Debian can ship a binary git linked against a curl 
> > that is linked against openssl (and the answer is probably "no, Debian 
> > people think that is wrong").
> 
> Sure. And you can probably fix it by using NO_OPENSSL, which uses the 
> Mozilla SHA1 library. As I also pointed out.

what I was saying before is that NO_OPENSSL _doesn't_ fix the problem,
because this has nothing whatsoever to do with the mozilla sha1 library
or any decision that git can make.

Debian provides two versions of curl, one that uses openssl and one that
uses gnutls. The question of which is used depends on which Debian
package you happen to have installed. So it is not a git matter at all,
but rather a matter of Debian policy about which version of curl is used
when building the official binary packages.

> In short - I just wanted to make sure that we do not make the insane 
> Debian policies somehow official git ones.

Agreed. There is no fallout from this issue for git; it is purely a
Debian build process issue.

-Peff
