From: Jeff King <peff@peff.net>
Subject: Re: current repository hash
Date: Mon, 16 Jun 2008 11:04:17 -0400
Message-ID: <20080616150416.GA6164@sigill.intra.peff.net>
References: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 17:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8GH6-0006CI-Qr
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 17:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbYFPPEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 11:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbYFPPEU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 11:04:20 -0400
Received: from peff.net ([208.65.91.99]:4733 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbYFPPET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 11:04:19 -0400
Received: (qmail 11677 invoked by uid 111); 16 Jun 2008 15:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 16 Jun 2008 11:04:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2008 11:04:17 -0400
Content-Disposition: inline
In-Reply-To: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85191>

On Mon, Jun 16, 2008 at 01:51:52PM +0200, Alf Clement wrote:

> What would be the best command to get a unique identifier?

If you just want the commit sha1, then "git rev-list -1 HEAD" will give
it to you. But take a look at git-describe, which is designed to give a
nice human-readable name based on your tags.

> Do I need the 40 digit hash id?

No, but you increase your chances of a collision in the future. In
practice, 8 or 9 characters tends to give unique commits.

> How can I make sure that a shorter hash id will be unique?

git-describe will find the shortest unique hash. But bear in mind that
it may not be unique forever.

-Peff
