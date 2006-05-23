From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Current Issues #3
Date: Tue, 23 May 2006 23:58:15 +0200
Organization: At home
Message-ID: <e500hd$vpr$1@sea.gmane.org>
References: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605220216310.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 23 23:58:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fietb-0004yp-6s
	for gcvg-git@gmane.org; Tue, 23 May 2006 23:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWEWV62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 17:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWEWV62
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 17:58:28 -0400
Received: from main.gmane.org ([80.91.229.2]:16316 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932107AbWEWV62 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 17:58:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FietL-0004vk-0L
	for git@vger.kernel.org; Tue, 23 May 2006 23:58:16 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 23:58:15 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 23:58:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20644>

Linus Torvalds wrote:

[...]
> But with the above, you can fairly naturally do:
> 
>  - "git pull" 
> 
>       No arguments. fetch the remote described by the current branch, 
>       and merge into current branch (we might decide to fetch all the 
>       remotes associated with that repo, just because once we do this, 
>       we might as well, but that's not that important to the end 
>       result).
> 
>  - "git pull <repo>"
     (i.e. re-clone)
>       fetch all remotes that use <repo>. IFF the current branch is 
>       matched to one of those remotes, merge the changes into the 
>       current branch. But if you happened to be on another unrelated 
>       branch, nothing happens aside from the fetch.
> 
>  - "git pull <remote>"
> 
>       fetch just the named remote. IFF that remote is also the remote 
>       for the current branch, do merge it into current. Again, we 
>       _might_ decide to just do the whole repo.
> 
>  - "git pull <repo> <branchname>"
> 
>       fetch the named branch from the named repository and merge it into 
>       current (no ifs, buts or maybes - now we've basically overridden 
>       the default relationships, so now the <repo> is just a pure 
>       shorthand for the location of the repository)

Fetch into curret branch, or specified by branch configuration, then current
if unspecified?

>  - "git pull <repo> <src>:<dst>"
> 
>       same as now. fetch <repo> <src> into <dst>, and merge it into the 
>       current branch (again, we've overridden any default relationships).
> 
> but maybe this is overdesigned. Comments?

It all means that within <repo> annd <remote> names should be unique
(to know if we use "git pull <repo>" or "git pull <remote>").

Perhaps it would be nice to have

 - "git pull <repo> *:<dst>"
 - "git pull <repo> <src>:*"
 - "git pull <repo> *:*"
and
 - "git pull <repo> <src>:<dst>:<to-merge>"

as easier to remember options. Of course what is the remote branch related
to <dst>, and what is local branch related to <src> would be in
branch/remotes/repos configuration.

BTW. what about --use-separate-remotes option support?

-- 
Jakub Narebski
Warsaw, Poland
