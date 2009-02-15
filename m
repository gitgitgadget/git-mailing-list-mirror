From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] remote: use exact HEAD lookup if it is available
Date: Sun, 15 Feb 2009 14:58:26 -0500
Message-ID: <20090215195826.GA26740@coredump.intra.peff.net>
References: <20090215060815.GA7473@coredump.intra.peff.net> <20090215061818.GE30414@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 21:00:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYn9f-0004ty-TY
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbZBOT6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbZBOT6a
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:58:30 -0500
Received: from peff.net ([208.65.91.99]:59287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526AbZBOT6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:58:30 -0500
Received: (qmail 9762 invoked by uid 107); 15 Feb 2009 19:58:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 14:58:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 14:58:26 -0500
Content-Disposition: inline
In-Reply-To: <20090215061818.GE30414@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110049>

On Sun, Feb 15, 2009 at 01:18:18AM -0500, Jeff King wrote:

> A possible 6/5 would be to do something similar for local repos (or
> resurrecting the HEAD proposal).

Here is a quick and dirty series to unambiguously determine the HEAD for
local repos, but I am undecided on whether this is actually a good idea.

Note that this fails Jay's tests in t5505 which expect the ambiguity; to
be considered for inclusion, it would need to test "../two" as a remote
as well as "file://$(pwd)/../two", making sure each behaved correctly.

But I am posting it here to stimulate discussion on whether it is even
something we want.

  1/2: transport: cleanup duplicated ref fetching code
  2/2: transport: unambiguously determine local HEAD

-Peff
