From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Sat, 3 Feb 2007 20:49:45 -0500
Message-ID: <20070204014945.GA18357@coredump.intra.peff.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net> <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com> <b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com> <20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net> <7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 02:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDWVz-0006Yn-Pd
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbXBDBtu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXBDBtu
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:49:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4591 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751871AbXBDBtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:49:49 -0500
Received: (qmail 23564 invoked from network); 3 Feb 2007 20:49:46 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Feb 2007 20:49:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Feb 2007 20:49:45 -0500
Content-Disposition: inline
In-Reply-To: <7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38635>

On Sat, Feb 03, 2007 at 03:01:59PM -0800, Junio C Hamano wrote:

> > Since branch.*.merge accept local ref names, there is probably far
> > more to change that what I initially feared.
> 
> If that is the case maybe we should fix branch.*.merge not to
> match the local tracking branch name.  Matching it with local
> tracking branch name when the remote name does not match was
> werely a fallback to help broken configurations confused people
> might create by hand, and has never been the part of sane
> practice at all.

I was one of the major pushers of this feature in December; however, I
think it actually can create some confusing results. See:
  http://article.gmane.org/gmane.comp.version-control.git/35789

I still think it is worth pursuing, but I have been waiting for v1.5.0
to happen before stirring up more trouble. Regardless, I think this
implementation is not the right way to go about it, and you should
revert 80c79776.

-Peff
