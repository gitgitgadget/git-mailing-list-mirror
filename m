From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 16:18:28 -0400
Message-ID: <20080821201828.GA28844@coredump.intra.peff.net>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com> <48AD99DF.5090802@zytor.com> <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com> <48ADA467.1030407@zytor.com> <20080821173842.GB26920@coredump.intra.peff.net> <20080821201307.GC27705@coredump.intra.peff.net> <48ADCCB1.6040803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Peter Valdemar =?utf-8?B?TcO4cmNoIChMaXN0cyk=?= 
	<4ux6as402@sneakemail.com>, flucifredi@acm.org,
	Git ML <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGdG-0003aa-A1
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbYHUUSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbYHUUSc
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:18:32 -0400
Received: from peff.net ([208.65.91.99]:1981 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963AbYHUUSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:18:31 -0400
Received: (qmail 9347 invoked by uid 111); 21 Aug 2008 20:18:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 16:18:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 16:18:28 -0400
Content-Disposition: inline
In-Reply-To: <48ADCCB1.6040803@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93200>

On Thu, Aug 21, 2008 at 01:14:41PM -0700, H. Peter Anvin wrote:

>> Ah, OK. My problem was that the pages actually need to be named "am.git",
>> etc. But with 'git' in the section field, "man git am" does work.
>> Unfortunately, it seems to break "man git". :(
>
> Yeah, that pretty much makes it not a general solution.

Oh, sorry, this was just me being incompetent. I was testing with

  MANSECT=git man git am

and of course

  MANSECT=git man git

broke because we are no longer looking in section "1".

Setting the sections properly (by adding "git" to /etc/manpath.config,
or using MANSECT=1:git) and creating a linkfarm in .../man/mangit (with
am.git pointing to ../man1/git-am.1) makes both "man git" and "man git
am" work fine.

The changes to manpath.config make it a bit outside the scope of git's
regular install, but maybe this is something distro people would want to
do.

-Peff
