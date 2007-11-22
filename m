From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path
	to patch
Date: Thu, 22 Nov 2007 06:24:06 -0500
Message-ID: <20071122112406.GA12913@sigill.intra.peff.net>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <20071122091356.GD7153@sigill.intra.peff.net> <7v8x4q7gns.fsf@gitster.siamese.dyndns.org> <887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAAV-0008U8-HM
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbXKVLYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbXKVLYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:24:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2620 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbXKVLYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:24:08 -0500
Received: (qmail 22658 invoked by uid 111); 22 Nov 2007 11:24:07 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 06:24:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 06:24:06 -0500
Content-Disposition: inline
In-Reply-To: <887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65798>

On Thu, Nov 22, 2007 at 11:44:54AM +0100, Wincent Colaiuta wrote:

> So I don't think the proposal to add "-p" (jump to "patch" subcommand) and 
> "-a" (jump to "add untracked" subcommand) are a very good idea, seeing as we 
> already have builtin-add for adding entire files.

I agree that "git-add -i untracked_file" is a bit useless. I think it
might be more useful if you could split the one giant hunk (which
git-add--interactive does not currently allow) into smaller hunks, and
then just add parts of them (so conceptually treat it like it had been a
tracked file with empty contents, and go to the patch menu). Of course,
there is currently no way to usefully split a hunk that has consecutive
added lines, so that would have to be figured out, too.

So I think it is not so much "this other thing is useful right now" as
"do we want to paint ourselves in a corner for making it (or other
things) useful later on?" And assuming that having arguments means
"start the patch menu on these files" doesn't leave room for changes
later.

-Peff
