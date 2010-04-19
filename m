From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output (inc.
 current status)
Date: Mon, 19 Apr 2010 15:40:20 -0400
Message-ID: <20100419194020.GA25883@coredump.intra.peff.net>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <201004151107.33892.jnareb@gmail.com>
 <20100417095259.GA23110@coredump.intra.peff.net>
 <201004171502.42044.jnareb@gmail.com>
 <20100417140053.GA10997@coredump.intra.peff.net>
 <203d6cefd3cd1020eb94fbd3d5e25eae@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Eric Raymond <esr@thyrsus.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 19 21:40:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3wq2-0004I4-4B
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 21:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab0DSTkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 15:40:51 -0400
Received: from peff.net ([208.65.91.99]:48683 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab0DSTkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 15:40:51 -0400
Received: (qmail 23637 invoked by uid 107); 19 Apr 2010 19:40:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Apr 2010 15:40:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Apr 2010 15:40:20 -0400
Content-Disposition: inline
In-Reply-To: <203d6cefd3cd1020eb94fbd3d5e25eae@212.159.54.234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145323>

On Sun, Apr 18, 2010 at 10:46:18PM +0100, Julian Phillips wrote:

> It might help standardise the output between commands if there were helper
> functions for some of the larger structures - e.g. commits.  Though I don't
> think that those functions would be able to do legacy output, due to the
> current lack of cross-command output compatibility.  I'm starting to see
> this with blame and diff-tree (and family), where they both want to output
> information about commits.

Yeah, that was what I saw on looking at the code. And we have to support
those old formats, obviously. For the most part, I found the level of
verbosity in the patches you posted (and I just peeked at your repo) to
be fine. Sure, it's more lines, but they're IMHO very easy to read.

If we have to tradeoff between either duplicating output entirely (for
both the output form and traditional form) or having a more flexible but
slightly more verbose output library, I think I would rather go with the
latter. It will be more maintainable in the long run.

-Peff
