From: Petr Baudis <pasky@ucw.cz>
Subject: Re: questions about cg-update, cg-pull, and cg-clone.
Date: Mon, 2 May 2005 21:58:46 +0200
Message-ID: <20050502195846.GC20818@pasky.ji.cz>
References: <20050430005322.GA5408@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 02 21:53:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSgy8-0006qa-H7
	for gcvg-git@gmane.org; Mon, 02 May 2005 21:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVEBT6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 15:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVEBT6v
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 15:58:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55216 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261743AbVEBT6s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 15:58:48 -0400
Received: (qmail 29688 invoked by uid 2001); 2 May 2005 19:58:46 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050430005322.GA5408@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 30, 2005 at 02:53:22AM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> 'cg-update branch-name' grabs any new changes from the upstream repository and
> merges them into my local repository. If I've been editing files in my local
> repository, the update attempts to merge the changes cleanly.

Yes.

> Now, if the update is clean, a cg-commit is invoked automatically, and if the
> update is not clean, I then have to resolve any conflicts and give the cg-commit
> command by hand. But: what is the significance of either of these cg-commit
> commands? Why should I have to write a changelog entry recording this merge? All

You might want to write some special notes regarding the merge, e.g.
when you want to describe some non-trivial conflict resolution, or even
give a short blurb of the changes you are merging.

If you don't know what to say, just press Ctrl-D. The first line of the
commit always says "Merge with what_you_are_merging_with".

> I'm doing is updating my tree to be current. Why should I have to 'commit' that
> update?

If you are only updating your tree to be current, you don't have to
commit, and in fact you don't commit (you do so-called "fast-forward
merge", which will just update your HEAD pointer to point at the newer
commit). You commit only when you were merging stuff (so-called "tree
merge"; well, that's at least how I call it to differentiate it from the
fast-forward merge). That means you have some local commits over there -
I can't just update your tree to be current, sorry. That would lose your
commit. I have to merge the changes into your tree through a merge
commit.

> Now I look at 'cg-pull'. What does this do? The readme says something about
> printing two ids, and being useful for diffs. But can't I do a diff after a
> cg-update and get the same result? I'm very confused about cg-pull right now.

cg-pull does the first part of cg-update. It is concerned by fetching
the stuff from the remote repository to the local one. cg-merge then
does the second part, merging the stuff to your local tree (doing either
fast-forward or tree merge).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
