From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-name-rev: accept list of refs from user
Date: Sat, 17 Feb 2007 18:40:46 -0500
Message-ID: <20070217234046.GB6014@coredump.intra.peff.net>
References: <7vmz3ctzer.fsf@assigned-by-dhcp.cox.net> <20070217231327.GA5382@coredump.intra.peff.net> <20070217231943.GA30839@coredump.intra.peff.net> <7vr6soqs5h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZAh-0002rs-Q9
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbXBQXks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbXBQXks
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:40:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4846 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964910AbXBQXks (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:40:48 -0500
Received: (qmail 15074 invoked from network); 17 Feb 2007 18:40:56 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 17 Feb 2007 18:40:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Feb 2007 18:40:46 -0500
Content-Disposition: inline
In-Reply-To: <7vr6soqs5h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40028>

On Sat, Feb 17, 2007 at 03:30:02PM -0800, Junio C Hamano wrote:

> I was hoping that everybody would be happy once Johannes's patch
> is extended to grok more than one --refs=<pattern> options.

I don't think just having text filters easily allows something like:

  git show-ref |
    perl -ne 'print if m#tags/v1\.(\d+)# && $1 > 3' |
    git name-rev --refs-from=- $commit

But I don't know how many people will want to do something that complex.
I suppose you could mimic it with many --refs, but the syntax gets a bit
painful.

-Peff
