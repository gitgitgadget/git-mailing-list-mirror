From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 00:44:00 -0400
Message-ID: <20080722044359.GB20787@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <7vljzur5wd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Bremner <bremner@unb.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 06:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL9kF-0004MP-8j
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 06:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYGVEoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 00:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYGVEoB
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 00:44:01 -0400
Received: from peff.net ([208.65.91.99]:4961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbYGVEoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 00:44:00 -0400
Received: (qmail 2401 invoked by uid 111); 22 Jul 2008 04:44:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 00:44:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 00:44:00 -0400
Content-Disposition: inline
In-Reply-To: <7vljzur5wd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89433>

On Mon, Jul 21, 2008 at 07:48:02PM -0700, Junio C Hamano wrote:

> Another possibility is to set up an extra process whose sole purpose is to
> wait for the main process that feeds the pager pipe and relay its exit
> status to the outside world.  But I do not think we would want to go
> there...

We could also swap the parent/child relationship, and have the pager as
child. But I assume that it is done the way we have it because otherwise
the shell gets confused about when the command ends (i.e., we want it to
run until pager completion). I didn't test, though.

-Peff
