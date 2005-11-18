From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Fri, 18 Nov 2005 09:25:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511180915560.13959@g5.osdl.org>
References: <20051117230723.GD26122@nowhere.earth> <437DDDB1.60103@b-i-t.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 00:51:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdASN-0008ME-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 18:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVKRRZz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 12:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVKRRZz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 12:25:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932287AbVKRRZy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 12:25:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAIHPlnO018762
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 09:25:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAIHPkKN020008;
	Fri, 18 Nov 2005 09:25:46 -0800
To: sf <sf@b-i-t.de>
In-Reply-To: <437DDDB1.60103@b-i-t.de>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12289>



On Fri, 18 Nov 2005, sf wrote:
> 
> I would go even further: The resulting tree does not depend on anything. A
> tree is a tree is a tree.

Agreed.

> A commit is really just the statement: "I changed the tree from state A to
> state B". After all, the commit message does not describe the new state
> (neither the old state) but does describe the changes.

No.

A commit is _not_ just the statement of change between two trees.

It's a statement of _history_ of the resulting tree. This is important. 
It's why a commit does not just point to the previous tree, but to the 
previous commit(s).

And that's really important. If you don't have a history of what has 
happened, then all the trees are just random collections of files. They're 
not a project any more.

So a commit doesn't just say "tree A changed into tree B". It very much 
says something much much stronger, which includes how you got to A in the 
first place.

The history is also what allow a commit to be meaningful. Without that 
history, you could never say "I fixed the bug that was introduced by xyz", 
which is often a very integral part of _why_ the change happened.

There are lots of changelog entries that don't necessarily make sense 
without knowing what went before them, so history is actually important 
even in a local sense - it's often what allows the explanation to make 
sense.

			Linus
