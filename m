From: Jeff King <peff@peff.net>
Subject: Re: git-send-email: Skipping  - not found.
Date: Tue, 29 Apr 2008 16:06:19 -0400
Message-ID: <20080429200619.GA20509@sigill.intra.peff.net>
References: <48163E6C.60104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:07:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqw6p-0001p9-Mi
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838AbYD2UGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbYD2UGV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:06:21 -0400
Received: from peff.net ([208.65.91.99]:3480 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756153AbYD2UGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:06:20 -0400
Received: (qmail 10684 invoked by uid 111); 29 Apr 2008 20:06:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 16:06:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 16:06:19 -0400
Content-Disposition: inline
In-Reply-To: <48163E6C.60104@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80723>

On Mon, Apr 28, 2008 at 04:15:24PM -0500, Timur Tabi wrote:

> When I issue this command:
> 
> git-send-email  --from Timur Tabi <timur@freescale.com> --suppress-cc=all --to
> timur@tabi.org --smtp-server remotesmtp.freescale.net
> 0001--PATCH-Update-CS4270-driver-to-ASoC-V2.patch

Surely that is not the command you issued, since it lacks shell quoting
around your name and email address.

> I don't know enough about Perl to debug this, but I presume the problem is in
> this code:
> [...]
> for my $f (@ARGV) {
> [...]
> 		print STDERR "Skipping $f - not found.\n";

Yes, that is what is producing the error message. But that is the first
time we ever look at @ARGV, let alone modify it. So the error is almost
certainly caused by a blank argument being passed on the command line.
And we can't debug that unless you show us the exact shell invocation
that was used.

-Peff
