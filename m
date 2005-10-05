From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Wed, 5 Oct 2005 07:30:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510042155090.31407@g5.osdl.org> <7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 16:33:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENAIH-0006tn-Ba
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 16:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVJEOa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 10:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVJEOaZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 10:30:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932632AbVJEOaX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 10:30:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j95EUI4s008025
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 5 Oct 2005 07:30:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j95EUHGP013676;
	Wed, 5 Oct 2005 07:30:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9709>



On Tue, 4 Oct 2005, Junio C Hamano wrote:

> What is your workflow after seeing that the 47th patch among 175
> patches fails to apply?  I understand you run git-applymbox
> without -q, so it immediately fails and exits there.

Correct. 

What I usually do is to just ignore the split patches, and go back to the 
mbox. Delete the ones that applied, and look at the one that didn't. Then 
I try to apply that one manually - sometimes I actually do a quick manual 
branch to a known version, apply and merge - and I think I might try to 
use the "base wiggle" patch for that. Although I would actually prefer to 
be able to try against a specific named release (not "all named tags" 
first).

Quite often, the reason it doesn't apply is that I already have that patch 
through a git merge (or because I applied that patch earlier through 
another person), in which case I don't even try to merge it, I just delete 
that email too, and just do "git-applymbox" again.

		Linus
