From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] builtin-remote: move duplicated cleanup code its
	own function
Date: Wed, 11 Feb 2009 20:50:07 -0500
Message-ID: <20090212015007.GA3187@sigill.intra.peff.net>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com> <1234332083-45147-2-git-send-email-jaysoffian@gmail.com> <20090212001836.GB30231@coredump.intra.peff.net> <76718490902111744p27e83238x34cb7004d8e3e48f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 02:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXQjq-00087L-S6
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 02:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbZBLBuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 20:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbZBLBuL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 20:50:11 -0500
Received: from peff.net ([208.65.91.99]:34142 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbZBLBuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 20:50:10 -0500
Received: (qmail 4698 invoked by uid 107); 12 Feb 2009 01:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 11 Feb 2009 20:50:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 20:50:07 -0500
Content-Disposition: inline
In-Reply-To: <76718490902111744p27e83238x34cb7004d8e3e48f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109557>

On Wed, Feb 11, 2009 at 08:44:13PM -0500, Jay Soffian wrote:

> I spent about 5 minutes which was enough time for me to realize that
> the reason the previous author left it as "NEEDSWORK" is because
> fixing it is more than 5 minutes of work. This is the remote object --
> maybe you could offer me some clues that allow me to know which of its
> fields need to be freed individually:
> [...]
> I *think* const is a clue that the field need not be freed, because
> the pointer is to storage that is on the stack. But I wasn't sure, esp
> with the double pointers. And I really wasn't sure about the struct
> pointers.

OK, I am satisfied that it is not trivial, and doesn't need to be part
of this patch series. :)

Like I said, I don't actually know this corner of the code very well,
but since you hadn't mentioned it in your cover letter, I didn't know if
it was "too lazy to do cleanups" or "code is too scary to be cleaned
up".

-Peff
