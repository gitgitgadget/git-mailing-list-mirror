From: Owen Taylor <otaylor@redhat.com>
Subject: Re: Usability question
Date: Thu, 17 Sep 2009 07:20:20 -0400
Message-ID: <1253186420.11581.380.camel@localhost.localdomain>
References: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rob Barrett <barrettboy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 13:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoF2L-0007rA-8g
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 13:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbZIQLUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 07:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbZIQLUU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 07:20:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21752 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbZIQLUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 07:20:19 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8HBKL8t007159;
	Thu, 17 Sep 2009 07:20:22 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8HBKJf0026049;
	Thu, 17 Sep 2009 07:20:20 -0400
In-Reply-To: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128744>

On Thu, 2009-09-17 at 20:01 +1000, Rob Barrett wrote:
> When starting with git people almost always ask some variant of "how
> do I know whether this option should be prefixed with dashes or not?"
> i.e. git reset --hard vs. git stash save --patch, which coupled with
> other path, sha and treeish args make things a bit more confusing.
> 
> Not sure if this has been discussed before? If it has point me at the
> discussion and I'll go look at it -- no need to read further.
> 
> And people stop asking the question after they get used to git - but
> that's not the same as being usable.
> 
> Out of 60+ commands, most take the form
> git <subcommand> [--option]
> and a few take the form
> git <subcommand> subsubcommand [--option]
> 
> (a quick scan gives: bisect,bundle,reflog,remote,stash)
> 
> My questions:
> 1. What is the distinction that makes the 10% special enough to get
> non-prefixed options?
> 2. Is it worthwhile? Wouldn't it be better if to shoot for more
> consistency / less complexity?

I don't think anybody is going to say that it all makes perfect sense. 
One pattern is:

 git <verb>

vs.

 git <subsystem> <verb>  (gui, svn, ...)
 git <noun> <verb>       (bundle, remote, stash, submodule, ...)

Another pattern is that options don't change the verb, they just 
modify it. 

But it's easy to find exceptions:

 git tag -l
 git branch --contains <commit>
 git am --abort

I personally think it would help consistency to use the subsubcommand
pattern more and treat 'git tag <tag>' as an shorthand. If you really
want to to create a tag called 'list', you'd need to use
'git tag tag list', or maybe 'git tag -- list'.

Even with compat support for options and a general agreement that I
doubt exists, that's at best a 95% compatible change, so it's unlikely
to happen soon.

- Owen
