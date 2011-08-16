From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Tue, 16 Aug 2011 16:06:54 -0700
Message-ID: <20110816230654.GA21793@sigill.intra.peff.net>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
 <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org>
 <20110816222212.GA19471@sigill.intra.peff.net>
 <7vzkj9eza2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 01:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtSjY-0007k2-ND
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 01:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab1HPXG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 19:06:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56944
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab1HPXG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 19:06:57 -0400
Received: (qmail 7233 invoked by uid 107); 16 Aug 2011 23:07:37 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 19:07:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 16:06:54 -0700
Content-Disposition: inline
In-Reply-To: <7vzkj9eza2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179485>

On Tue, Aug 16, 2011 at 04:01:57PM -0700, Junio C Hamano wrote:

> > No. The point is that I _already_ did it in the working tree version
> 
> But that does not change that you have to do that twice. You may already
> have done so in the working tree, and then redo it in the old indexed
> version again.

Right. The point is that the changes are tangled, to the point that it
is simpler to recreate them on one side than it is to instruct a tool
about how to untangle them. If they weren't tangled, then I would simply
make the change in the working tree, and then "add -p" it into the
index.

It's certainly not the dominant case. I'd say I run into it no more
frequently than once every week or so. I usually end up using "add -e"
to do what I want, but it's very error prone and annoying.

> > while doing my s/hello/goodbye/ change (let's call this the "new
> > change"). And ideally I would just use "git add -p" to stage only the
> > s/word/world/ change (let's call this the "fixup"). But they're tangled
> > in a single hunk, and I need some way of splitting them.
> 
> As a way to punt from making "add -e" usable, I'd think it would be a
> workable q&d workaround, even though it feels wrong, and I would imagine
> that normal people would probably prefer the "check out to a temporary
> file to be edited" solution you wrote in your previous message.

Yeah, I think that is the sanest of the options brought up in this
thread. I'm curious if Duy had another use case, though, that made him
think of --swap.

-Peff
