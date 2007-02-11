From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-pull and tag objects
Date: Sat, 10 Feb 2007 19:21:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702101919520.8424@woody.linux-foundation.org>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <20070211002501.GB19656@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 11 04:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG5Ho-0000kI-Hl
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 04:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbXBKDVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 22:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbXBKDVl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 22:21:41 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36316 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbXBKDVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 22:21:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1B3LXUI002377
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Feb 2007 19:21:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1B3LW4T028257;
	Sat, 10 Feb 2007 19:21:32 -0800
In-Reply-To: <20070211002501.GB19656@thunk.org>
X-Spam-Status: No, hits=-0.437 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39270>



On Sat, 10 Feb 2007, Theodore Tso wrote:
> 
> What I would propose (post-1.5.0!) is that the policy file be local to
> the repository, and consist of an ordered list of regular expressions
> and and lists of PGP keys associated with each regexp.  So for
> example, I might have in my repository a config file which states that
> any tag that matches v2.6.[0-9]+ and v2.6.[0-9]+-rc[0-9]+ must be
> signed by PGP key 0x76E21CBB (Linus's key).

Actually, I think you can do it already.

I think the "update" hook runs whenever we're pulling a ref, once for each 
ref. It might happen just for pushing to a remote, though.

Anyway, with a hook, it's easy enough to just add exactly the kind of 
thing you are outlining, and yes, it would be repository-local.

		Linus
