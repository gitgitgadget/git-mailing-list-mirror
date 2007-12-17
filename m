From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] include/asm-arm/: Spelling fixes
Date: Mon, 17 Dec 2007 18:12:09 -0500
Message-ID: <20071217231209.GA5558@coredump.intra.peff.net>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918889.git.joe@perches.com> <20071217195658.GB13515@fieldses.org> <1197921847.27386.16.camel@localhost> <20071217201219.GC13515@fieldses.org> <1197922971.27386.32.camel@localhost> <20071217205134.GB2105@coredump.intra.peff.net> <7vy7bt57wn.fsf@gitster.siamese.dyndns.org> <20071217230558.GD2105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Perches <joe@perches.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:15:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4P8l-00087v-Pf
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761560AbXLQXMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761158AbXLQXMO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:12:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4963 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758683AbXLQXMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:12:12 -0500
Received: (qmail 14456 invoked by uid 111); 17 Dec 2007 23:12:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 18:12:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 18:12:09 -0500
Content-Disposition: inline
In-Reply-To: <20071217230558.GD2105@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68658>

On Mon, Dec 17, 2007 at 06:05:58PM -0500, Jeff King wrote:

> > I wonder if stripping existing "Message-Id:" away just like we strip
> > away "Date:" from @xh would be a much saner fix.
> 
> That is definitely wrong if we expect to re-use the in-reply-to and
> references headers that already exist (though obviously we could strip
> out all three of those headers and re-add our own).
> 
> I don't have a strong opinion. I never use git-send-email myself, but
> was just trying to fix a reported bug.

Actually, I don't think stripping the message-id is ever the right
thing. The user put it in there for some purpose, and "ours not to
reason why" (ours but to do and die). IOW, it is not possible for us to
know what we are breaking by changing the message-id. It could simply be
the reply-to header in the following messages, or it could be the
reply-to in some message we have not and will not ever see.

Even if we assume git-send-email only ever gets the unmunged output of
git-format-patch, we do not necessarily know it has been fed all of the
patches during a single run.

-Peff
