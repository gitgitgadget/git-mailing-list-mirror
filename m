From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 01:36:47 -0400
Message-ID: <20061018053647.GA3507@coredump.intra.peff.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 07:37:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga46n-0008Rc-Vo
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 07:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWJRFgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 01:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWJRFgv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 01:36:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:46548 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751409AbWJRFgu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 01:36:50 -0400
Received: (qmail 27475 invoked from network); 18 Oct 2006 01:36:47 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Oct 2006 01:36:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2006 01:36:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29189>

On Tue, Oct 17, 2006 at 04:16:15PM -0700, Linus Torvalds wrote:

> It would be easy to send the exact same data as the native git protocol 
> sends over ssh (or the git port) as an email encoding. We did that a few 
> times with BK (there it's called "bk send" and "bk receive" to pack and 
[...]
> That said, "bundles" certainly wouldn't be _hard_ to do. And as long as 
> nobody tries to send _me_ any of them, I won't mind ;)

I never used BK, but my understanding is that it was based on
changesets, so a bundle was a group of changesets. Because a git commit
represents the entire tree state, how can we avoid sending the entire
tree in each bundle? The interactive protocols can ask "what do you
have?" but an email bundle is presumably meant to work without a round
trip.

We could always make a guess ("git send --remote-has master~10") but
that seems awfully error-prone. I assume a changeset-oriented system
would implicitly keep some concept of "I think Linus is at master~10"
and do it automatically.

-Peff
