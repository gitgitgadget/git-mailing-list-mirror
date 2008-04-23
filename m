From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
	"git clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 18:25:05 -0400
Message-ID: <20080423222505.GF30057@sigill.intra.peff.net>
References: <480EF334.1090907@gnu.org> <7vhcdstv0f.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0804231210000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:25:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JonPW-0005Kj-79
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 00:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbYDWWZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbYDWWZE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 18:25:04 -0400
Received: from peff.net ([208.65.91.99]:3840 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbYDWWZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 18:25:03 -0400
Received: (qmail 32569 invoked by uid 111); 23 Apr 2008 22:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 18:25:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 18:25:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0804231210000.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80268>

On Wed, Apr 23, 2008 at 12:56:41PM -0400, Daniel Barkalow wrote:

> Something needs to get the code to figure out the remote HEAD, and it 
> shouldn't be "remote" for clone's use, because then clone would take an 
> extra connection, since "fetch" obviously has to connect and "remote" 
> would run before it and in a separate process.

Actually, having "fetch" figure out the HEAD would be a nice feature,
since then you could track the remote's idea of HEAD as time passes.

AIUI, we could get by with a single connection over git:// with a
protocol extension.

-Peff
