From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 16:08:17 -0400
Message-ID: <20110714200817.GF8453@thunk.org>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com>
 <20110714194638.GE8453@thunk.org>
 <CA+55aFzuQnfo1iywnp-WAajMHe2+6_HOM85aw0bS+p0xv5RyhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:08:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhSCw-0003xV-To
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab1GNUIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:08:22 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:33106 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab1GNUIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:08:21 -0400
Received: from root (helo=tytso-glaptop)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1QhSCo-0000Ee-7u; Thu, 14 Jul 2011 20:08:18 +0000
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1QhSCn-0007YQ-EB; Thu, 14 Jul 2011 16:08:17 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzuQnfo1iywnp-WAajMHe2+6_HOM85aw0bS+p0xv5RyhA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177171>

On Thu, Jul 14, 2011 at 12:51:39PM -0700, Linus Torvalds wrote:
> 
> So it sounds like it would work - and it would probably be a simple
> matter of just incrementing the pack version number if you just say
> "cannot access the pack with old versions" - but I think it's a really
> fragile approach.

So if we ever change the pack format again, it's something to think
about adding, but probably not worth it on its own...

What if we simply have a cache file per pack, which again is generated
when the pack is first received or generated, but is otherwise not
dynamic?  It's an extra file which is icky, but it would keep things
simpler.

							- Ted
