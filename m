From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 9 Jan 2007 11:18:32 -0500
Message-ID: <20070109161832.GA9577@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net> <20070102144940.GA23932@coredump.intra.peff.net> <7vps9xwd01.fsf@assigned-by-dhcp.cox.net> <20070102173410.GA25325@coredump.intra.peff.net> <7v1wmdure6.fsf@assigned-by-dhcp.cox.net> <20070109150524.GB10633@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 17:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4JgP-00052t-0w
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 17:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbXAIQSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 11:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbXAIQSf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 11:18:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1314 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932190AbXAIQSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 11:18:34 -0500
Received: (qmail 5631 invoked from network); 9 Jan 2007 11:18:45 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jan 2007 11:18:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2007 11:18:32 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070109150524.GB10633@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36374>

On Tue, Jan 09, 2007 at 10:05:24AM -0500, Jeff King wrote:

> There are two advantages I see to putting local branches in branch.*.merge:

Let me add a third:

There are some operations which care about who our upstream is, but
didn't necessarily just do a fetch (so FETCH_HEAD is not an option). For
example, I have a short porcelain-ish script that formats all of my
changes as patches and shows them as a mutt mailbox. If you don't
specify an upstream, it uses 'origin'. However, this isn't right if I'm
on 'next'. What I _really_ want is to say "a sensible upstream branch
for the branch I'm currently on" which is basically what "mergeLocal"
would be.

Come to think of it, mergeLocal is a terrible name, since it should
really would be for merging, rebasing, and anything else which wanted to
say "where did I probably come from?" So perhaps "upstream" would make
more sense?

-Peff
