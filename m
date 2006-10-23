From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 11:34:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231124170.3962@g5.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <200610231953.19605.jnareb@gmail.com>
 <Pine.LNX.4.64.0610231103460.3962@g5.osdl.org> <200610232021.55625.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:35:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4dn-0003nY-UP
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWJWSe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWJWSe4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:34:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965008AbWJWSez (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 14:34:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NIYKaX029967
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 11:34:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NIYIi9001037;
	Mon, 23 Oct 2006 11:34:19 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610232021.55625.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.477 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29856>



On Mon, 23 Oct 2006, Jakub Narebski wrote:
> 
> By the way, I wonder if accidentally identical revisions
> (see example for accidental clean merge on revctrl.org)
> would get the same revision id in bzr. In git they would.

git can have no "accidentally identical revisions". They'd have to be 
purposefully done, but yes, they'd obviously (on purpose) get the same 
revision name if that's the case.

You may think of tree (not commit) identity, where git on purpose names 
trees the same regardless of how you got to them. So on a _tree_ level, 
you are always supposed to get the same result regardless of how you 
import things (ie two people importing the same tar-ball should always get 
exactly the same tree ID).

But the actual commit names are identical only if the same people are 
claimed to have authored (and committed) them at the same time - so it's 
definitely not "accidental" if the commits are called the same: they 
really _are_ the same.

Btw, I think you misunderstand the term "accidental clean merge". It means 
that two identical changes on two branches will merge without conflicts 
being reported.

A merge algorithm that doesn't do "accidental clean merge" is totally 
broken. The accidental clean merge is a usability requirement for pretty 
much anything - you often have two branches doing the same thing (possibly 
for different reasons - two people independently found the same bug that 
showed itself in two different ways - so they may even think that they 
are fixing different issues, and may have written totally different 
changelogs to explain the bug, but the solution is identical and should 
obviously merge cleanly).

So "accidental clean merge" may _sound_ like something bad, but it's 
actually a seriously good property (it's really just a special case of 
"convergence" - again, that's a good thing).

		Linus
