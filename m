From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 19:34:40 +0100
Message-ID: <201112121934.40953.trast@student.ethz.ch>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch> <20111212181915.GD31793@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAiA-0006EH-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab1LLSeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:34:46 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:18186 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286Ab1LLSep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:34:45 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:34:41 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:34:43 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111212181915.GD31793@elie.hsd1.il.comcast.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186929>

Jonathan Nieder wrote:
> Hi,
> 
> Thomas Rast wrote:
> > -# Run @$argv in the background with stdio redirected to $out and $err.
> > +# Run @$argv in the background with stdio redirected from $in and to $out and $err.
> 
> I'm not thrilled about this change.  The original purpose of
> test_terminal was to test commands like "git log" that need to check
> whether stdout is a tty in order to decide whether to use color and to
> paginate their output.  Perhaps whether stdin is a tty _should_ affect
> those decisions, but it currently doesn't (for example, "echo HEAD |
> git log --stdin" works) and that would deserve a separate test, I'd
> think.
> 
> The testsuite bug you mentioned sounds like a real one and worth
> fixing, though.  Maybe there would be some way for test_terminal to
> give the caller some control over which file descriptors to replace
> with a terminal.

I'm not sure I understand what you are arguing for or why.  That I
avoid wasting a Pty, and only replace stdin with /dev/null?

(Because with the current state of the tests, this shouldn't make much
of a difference.  I just figured I should go all the way and give
commands an environment that really looks like they'd been called from
the terminal.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
