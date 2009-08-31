From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Mon, 31 Aug 2009 00:36:10 -0400
Message-ID: <20090831043610.GB16646@coredump.intra.peff.net>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
 <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
 <20090830095509.GB30922@coredump.intra.peff.net>
 <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 06:36:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhycx-00045c-S1
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 06:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbZHaEgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 00:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbZHaEgM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 00:36:12 -0400
Received: from peff.net ([208.65.91.99]:59806 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbZHaEgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 00:36:11 -0400
Received: (qmail 20755 invoked by uid 107); 31 Aug 2009 04:36:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 31 Aug 2009 00:36:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 00:36:10 -0400
Content-Disposition: inline
In-Reply-To: <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127458>

On Sun, Aug 30, 2009 at 01:01:11PM -0700, Junio C Hamano wrote:

> One thing I noticed was that while unstashing without --index, we add full
> contents to the index of new files.  I think it is because back then when
> stash was written there was no other way, but now we have intent-to-add
> and a way to stash such an entry, I think we should add only the intent to
> add them in that codepath.
> 
> Of course we will not do this when unstashing with --index.

And btw, I think your suggestion is reasonable, though I don't feel
strongly either way. I don't know that the current behavior is really
bothering anybody.

-Peff
