From: Jeff King <peff@peff.net>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 5 May 2011 16:01:30 -0400
Message-ID: <20110505200130.GB1770@sigill.intra.peff.net>
References: <4DC1934D.6070608@aldan.algebra.com>
 <4DC19955.7040503@kdbg.org>
 <7viptqdvrf.fsf@alter.siamese.dyndns.org>
 <4DC20461.4090703@aldan.algebra.com>
 <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
 <4DC2FB0A.2090100@aldan.algebra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: "Mikhail T." <mi+thun@aldan.algebra.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4jy-00055h-9Y
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab1EEUBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:01:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40647
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028Ab1EEUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:01:32 -0400
Received: (qmail 2580 invoked by uid 107); 5 May 2011 20:03:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 16:03:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 16:01:30 -0400
Content-Disposition: inline
In-Reply-To: <4DC2FB0A.2090100@aldan.algebra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172897>

On Thu, May 05, 2011 at 03:31:22PM -0400, Mikhail T. wrote:

> On 04.05.2011 22:14, Junio C Hamano wrote:
> >I think that is what exactly "blame -C -C" gives you.
> For that to be useful, one has to suspect, the file was derived by
> copying something else... Simple "git log" will not suggest that --
> unless the commit message, that adds the new copy of a file points to
> it...

I think "git log --follow" will do what you want; it uses
FIND_COPIES_HARDER.

> On 05.05.2011 14:02, Piotr Krukowiecki wrote:
> >Maybe Mikhail wanted to say that if there's a git-mv as a shortcut for
> >   "cp old new ; rm old; add new"
> git-mv preserves the old's change-history in new, so it is more than
> the above, is not it?

No. The renames are detected at the time of viewing, not at the time of
commit.

-Peff
