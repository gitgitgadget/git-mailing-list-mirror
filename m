From: linux@horizon.com
Subject: Re: as promised, docs: git for the confused
Date: 10 Dec 2005 05:56:09 -0500
Message-ID: <20051210105609.9994.qmail@science.horizon.com>
References: <7v7jadwfdj.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 11:57:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1El2P5-00055i-DI
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 11:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVLJK4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 05:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVLJK4U
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 05:56:20 -0500
Received: from science.horizon.com ([192.35.100.1]:39751 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965032AbVLJK4T
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 05:56:19 -0500
Received: (qmail 9995 invoked by uid 1000); 10 Dec 2005 05:56:09 -0500
To: junkio@cox.net, linux@horizon.com
In-Reply-To: <7v7jadwfdj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13444>

> I do not necessarily agree with this claim that merging is the
> whole story about index.  As the steps in the hello/example
> tutorial demonstrate, index is used to build up what you will
> commit incrementally, and you can use this facility to view your
> changes incrementally.
> 
> Your workflow could be like this:

(Good example)

> This is sometimes very useful, and I suspect your comment about
> "commit -a will take care of everything, so you do not need to
> know about update-index" is coming from your ignoring this
> aspect of update-index.

Well, yes and no.  I'm quite aware that the index can be used that way,
but I'm less certain it's a good idea.

I have often wished for a very lightweight "snapshot" feature that I could
(say) put in a Makefile at the end of every successful compile.  I don't
want to share those snapshots with the world, and I'll delete them next
"real" commit, but they'll help me recover if I fumble-finger something.

Think of it as an undo feature.  (With, of course, additional features
like the ability to see diffs between various stages.)

You can use the index as a one-level undo feature in a similar way.
Or maybe, since it's manual, its like hitting save from an editor.
Either way, the fact that it's only one level means that I have to
think about what I'm throwing away when I use it, which is somewhat
annoying.


Add that to the fact that it's unlike other version control systems
(including cogito) which go straight from the working directory into
the history, and I thought it better do downplay it.

Certainly I think that people will *usually* just "git-commit -a" to
commit their current version.  Edit, compile, test, commit.  Except in
unusual cases, I want the commit to reflect what I just tested.

Using git-update-index in the meantime is an optional extra.
