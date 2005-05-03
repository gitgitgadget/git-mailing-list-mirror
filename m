From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: questions about cg-update, cg-pull, and cg-clone.
Date: Tue, 3 May 2005 08:22:15 -0700
Message-ID: <20050503152214.GA1704@tumblerings.org>
References: <20050430005322.GA5408@tumblerings.org> <20050502195846.GC20818@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 17:21:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSzBA-0005yF-ME
	for gcvg-git@gmane.org; Tue, 03 May 2005 17:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVECPZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVECPZ3
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:25:29 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:53155 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261748AbVECPZI
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 11:25:08 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DSzDz-0003Gj-1y; Tue, 03 May 2005 08:22:15 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050502195846.GC20818@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 09:58:46PM +0200, Petr Baudis wrote:
> Dear diary, on Sat, Apr 30, 2005 at 02:53:22AM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > 'cg-update branch-name' grabs any new changes from the upstream repository and
> > merges them into my local repository. If I've been editing files in my local
> > repository, the update attempts to merge the changes cleanly.
> 
> Yes.
> 
> > Now, if the update is clean, a cg-commit is invoked automatically, and if the
> > update is not clean, I then have to resolve any conflicts and give the cg-commit
> > command by hand. But: what is the significance of either of these cg-commit
> > commands? Why should I have to write a changelog entry recording this merge? All
> 
> You might want to write some special notes regarding the merge, e.g.
> when you want to describe some non-trivial conflict resolution, or even
> give a short blurb of the changes you are merging.
> 
> If you don't know what to say, just press Ctrl-D. The first line of the
> commit always says "Merge with what_you_are_merging_with".
> 
> > I'm doing is updating my tree to be current. Why should I have to 'commit' that
> > update?
> 
> If you are only updating your tree to be current, you don't have to
> commit, and in fact you don't commit (you do so-called "fast-forward
> merge", which will just update your HEAD pointer to point at the newer
> commit). You commit only when you were merging stuff (so-called "tree
> merge"; well, that's at least how I call it to differentiate it from the
> fast-forward merge). That means you have some local commits over there -
> I can't just update your tree to be current, sorry. That would lose your
> commit. I have to merge the changes into your tree through a merge
> commit.

Hm.

So, suppose I'm working on your Cogito HEAD. I make some changes to my local
tree and commit them to my tree, and then before I go forward, I want to grab
whatever you've done recently, to make sure we're not in conflict before I add
new changes. If I understand you right, this situation would be a 'fast forward
merge'. So what is the command I give to just 'merge' your HEAD with mine,
without requiring a changelog entry?

Alternatively, suppose I'm you, the project lead, and Zackdude has some
changes for me, based on my HEAD. I want to 'merge' his tree into mine. If
I'm still understanding you, this is a 'tree merge'. Now I give a cg-update,
and now I *want* to give a changelog entry to record the merge.  Correct?

No, I still don't see it. I don't see why I would want to add an additional
changelog entry on top of whatever changelog entries Zackdude has made himself.
It just seems to pollute the changelog with entries that are essentially
meaningless. When I read back over the logs, I'm not going to be interested in
the bookkeeping of when I merged with various developers, I'm going to be
interested in what those developers actually did to the code, and what *I*
actually did to the code.

> 
> > Now I look at 'cg-pull'. What does this do? The readme says something about
> > printing two ids, and being useful for diffs. But can't I do a diff after a
> > cg-update and get the same result? I'm very confused about cg-pull right now.
> 
> cg-pull does the first part of cg-update. It is concerned by fetching
> the stuff from the remote repository to the local one. cg-merge then
> does the second part, merging the stuff to your local tree (doing either
> fast-forward or tree merge).

OK, I don't understand this either. What is the difference between fetching the
stuff and merging the stuff? Suppose I am working on a local repo of Cogito
HEAD. I make some changes, commit them, and then I do a cg-pull. What happens?
Are my changes overwritten? Do they show up at all? Do they exist in some
nebulous ether that I will never see until I do a merge?

Be well,
Zack

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
