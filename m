From: Jeff King <peff@peff.net>
Subject: Re: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 13:42:32 -0500
Message-ID: <20091118184231.GA29999@coredump.intra.peff.net>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
 <20091118155154.GA15184@coredump.intra.peff.net>
 <aa2993680911180911o7e3af804m4ebdc20096baa609@mail.gmail.com>
 <20091118172424.GA24416@coredump.intra.peff.net>
 <m3bpizd8ua.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Hofstetter <phofstetter@sensational.ch>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 19:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NApUI-0001oo-6D
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 19:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbZKRSm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 13:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbZKRSm3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 13:42:29 -0500
Received: from peff.net ([208.65.91.99]:50394 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561AbZKRSm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 13:42:28 -0500
Received: (qmail 31476 invoked by uid 107); 18 Nov 2009 18:46:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Nov 2009 13:46:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2009 13:42:32 -0500
Content-Disposition: inline
In-Reply-To: <m3bpizd8ua.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133194>

On Wed, Nov 18, 2009 at 09:46:43AM -0800, Jakub Narebski wrote:

> > I also think "git commit" would not be the right time for such a
> > feature. The problem is not that you have this text in your commit
> > message. The problem is that the "format-patch | am" transport is lossy.
> > You would do better to have format-patch say "Ah, this is going to
> > create a bogus email address" and somehow quote it appropriately.
> 
> Doesn't mbox format have some way of escaping "From:" (or is it "From ")?
> If I remember correctly it uses ">From " or something for that.
> git-format-patch could do this also (perhaps only with --rebasing
> option).

It's for "From " lines, which are the mbox separator. This would be
somewhat different. It has nothing at all to do with the mail format
itself, but rather is about git treating the body of the message
specially. I don't think a quoting mechanism currently exists to handle
this.

-Peff
