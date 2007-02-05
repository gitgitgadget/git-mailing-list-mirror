From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 08:26:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702050814380.8424@woody.linux-foundation.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 17:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE6fm-0007Oe-9K
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 17:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXBEQ01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 11:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbXBEQ01
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 11:26:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48491 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932099AbXBEQ00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 11:26:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l15GQMQ5016304
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Feb 2007 08:26:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l15GQLtu024016;
	Mon, 5 Feb 2007 08:26:22 -0800
In-Reply-To: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.378 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38758>



On Sun, 4 Feb 2007, Junio C Hamano wrote:
> 
> * git-whatchanged
> 
>   This has been identical to git-log with different default
>   options.

Somebody should at least document the differences before it's depracated.

I think git-whatchanged ends up being equivalent to

	git log --full-history --raw -r

but I didn't really check if there's something else.

Same goes for "git-am". I use "git-applymbox", and I'll happily switch to 
git-am, but I'd like somebody who knows to document the differences when 
it gets deprecated. I use "git-applymbox -u", and I guess I just should 
change that to "git-am --utf8".

> * git-p4import, git-quiltimport and contrib/gitview
> 
>   These have seen almost no activity since their appearance.  It
>   could be that they are already perfect and many people are
>   using them happily, but I find it a bit hard to believe.

I think they're useful to keep around, if for no other reason than as 
starting points for others.

That said, I probably agree with your other examples:

> * git-diff-stages
> * git-lost-found
> * git-local-fetch, git-ssh-fetch and git-ssh-upload
> * contrib/colordiff

Although the git-ssh-fetch thing might be useful if you try to fix a tree 
that got corrupted and is missing an object (the native git protocol won't 
help you, since it assumes both trees are complete, while the stupid 
object fetching can pick out individual missing objects, I think).

That said, I don't think anybody would really ever fix their trees that 
way. It's more likely that you'd just fetch the whole repo and add the 
missing objects that way (ie do a clone, copy the pack-file, and repack 
the resulting mess to get a nice clean and working repository again).

		Linus
