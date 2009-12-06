From: Jeff King <peff@peff.net>
Subject: Re: git reset --hard in .git causes a checkout in that directory
Date: Sat, 5 Dec 2009 23:15:17 -0500
Message-ID: <20091206041517.GA23983@coredump.intra.peff.net>
References: <4B17A166.60306@gmail.com>
 <20091204111158.GE27495@coredump.intra.peff.net>
 <7vljhislbj.fsf@alter.siamese.dyndns.org>
 <7vfx7pwa6p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 05:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH8X5-0006KT-GW
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 05:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103AbZLFEPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 23:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758096AbZLFEPP
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 23:15:15 -0500
Received: from peff.net ([208.65.91.99]:57214 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758093AbZLFEPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 23:15:14 -0500
Received: (qmail 28383 invoked by uid 107); 6 Dec 2009 04:19:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Dec 2009 23:19:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2009 23:15:18 -0500
Content-Disposition: inline
In-Reply-To: <7vfx7pwa6p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134643>

On Sat, Dec 05, 2009 at 10:24:46AM -0800, Junio C Hamano wrote:

> > ...  The test already checks that the change won't break soft reset,
> > which is good, but it does not seem to check/specify what should happen in
> > the mixed reset in this case (I think it should be allowed).
> 
> Heh, I was not thinking straight. A bare repository does not have the
> index, so allowing (cd .git && git reset) is Ok but mixed in a bare
> repository (cd bare.git && git reset) is not.

Hmm. I would have thought it would be allowed in a bare repository, to
explicitly let people treat the bare repo as a pseudo-database, just
pulling out the files when they want to. And I was all set to argue
against restricting it, but looking at your tests, it seems we already
disallow it. So I don't see a harm in verifying the current behavior.

-Peff
