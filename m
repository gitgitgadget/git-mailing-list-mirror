From: Paul Mackerras <paulus@samba.org>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Sat, 11 Aug 2007 16:23:28 +1000
Message-ID: <18109.21984.26228.849806@cargo.ozlabs.ibm.com>
References: <20070810154108.GA779@ruiner>
	<20070810173242.GA23628@coredump.intra.peff.net>
	<alpine.LFD.0.999.0708101109310.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Brian Hetro <whee@smaertness.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 10:08:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJm0x-0005Y4-JA
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 10:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXHKIHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 04:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbXHKIHc
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 04:07:32 -0400
Received: from ozlabs.org ([203.10.76.45]:41659 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbXHKIH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 04:07:26 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 26C80DDF07; Sat, 11 Aug 2007 18:07:24 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0708101109310.30176@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55592>

Linus Torvalds writes:

> I think git itself is quite robust in the face of duplicate parents, and 
> it really is a gitk bug that it has problems with them. That said, I don't 
> think we should *assume* they don't happen, and while we should consider 
> it a bug in hg2git that they did, it is not a "serious" bug per se. It's 
> only gitk that reacts this violently to it.

There has been a commit with duplicate parents in the kernel git tree
for ages (13e65280), and gitk handles it just fine, so I don't think
it's simply a problem with duplicate parents.

I know gitk currently barfs if there are any dangling parents in the
git log --parents --boundary output (i.e. any ids which are listed in
the second or subsequent position on the commit lines but never in the
first position).  It shouldn't, and I'll fix it.

It would be nice to know if it is actually dangling parents that is
causing the problem, though.

Paul.
