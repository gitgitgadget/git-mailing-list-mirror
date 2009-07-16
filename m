From: Jeff King <peff@peff.net>
Subject: Re: Make a non-bare repo bare.
Date: Wed, 15 Jul 2009 22:19:21 -0400
Message-ID: <20090716021921.GA29139@coredump.intra.peff.net>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
 <4A5E4EBA.4050708@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 04:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRGZO-0000hP-II
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 04:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbZGPCT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 22:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757095AbZGPCTZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 22:19:25 -0400
Received: from peff.net ([208.65.91.99]:52264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057AbZGPCTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 22:19:25 -0400
Received: (qmail 17333 invoked by uid 107); 16 Jul 2009 02:21:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Jul 2009 22:21:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jul 2009 22:19:21 -0400
Content-Disposition: inline
In-Reply-To: <4A5E4EBA.4050708@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123354>

On Wed, Jul 15, 2009 at 11:48:42PM +0200, Paolo Bonzini wrote:

> On 07/15/2009 11:43 PM, Tim Visher wrote:
> >I recently had occasion to make a previously non-bare repo bare.  Is
> >there any way to do this?  It will not allow me to delete a branch
> >that I'm on so I wasn't sure how to proceed.
> 
> Just do "mv repo/.git repo.git; rm -rf repo" (with care!).

That used to work, but these days there is a "core.bare" config variable
so that git doesn't have to guess whether you are in a bare repo. So you
should also do:

  $ git config core.bare true

in the resulting repo (or just before, since your "mv" is obviously not
a git command that would care).

-Peff
