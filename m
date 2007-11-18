From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: improve error reporting for total remote
	unpack
Date: Sun, 18 Nov 2007 02:09:11 -0500
Message-ID: <20071118070910.GA23410@sigill.intra.peff.net>
References: <20071118055804.GA19313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 08:09:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IteHh-0008Su-B0
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 08:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbXKRHJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 02:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXKRHJQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 02:09:16 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1333 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbXKRHJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 02:09:16 -0500
Received: (qmail 8605 invoked by uid 111); 18 Nov 2007 07:09:14 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 02:09:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 02:09:11 -0500
Content-Disposition: inline
In-Reply-To: <20071118055804.GA19313@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65343>

On Sun, Nov 18, 2007 at 12:58:06AM -0500, Jeff King wrote:

> One other thing I noticed while doing this patch is that our remote ref
> status reporting isn't foolproof.  We set every ref we send to 'OK' with
> the nice effect that if status reporting isn't enabled, we just assume
> that it worked. However, if the status coming back is truncated (i.e.,
> some refs are missing in receive_status), we will just fail to notice and
> assume all is well. So to be perfect, we would need a
> REF_STATUS_EXPECTING_REPORT.

This turned out to be pretty easy, given the other recent changes, and I
think it actually makes the code a bit clearer. Please scrap the patch
to which I am replying, and I will post a replacement series in a
second.

-Peff
