From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Terminology
Date: Sat, 6 Aug 2005 01:07:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508060041550.10873@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhdeaj05n.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508051104510.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 01:11:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1BKB-00009P-Ij
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 01:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVHEXJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 19:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVHEXJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 19:09:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38123 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262013AbVHEXHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 19:07:18 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 32F2FD857D; Sat,  6 Aug 2005 01:07:17 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1ADF29C6FB; Sat,  6 Aug 2005 01:07:17 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D8D9398DBF; Sat,  6 Aug 2005 01:07:16 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 85685D857D; Sat,  6 Aug 2005 01:07:16 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508051104510.3258@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

wow! What a long mail! But I probably deserved it, quoting that lengthy 
mail from Junio...

On Fri, 5 Aug 2005, Linus Torvalds wrote:

> On Fri, 5 Aug 2005, Johannes Schindelin wrote:
> > 
> > Tutorial says "cache" aka "index". Though technically, a cache
> > is the index file _plus_ the related objects in the object database.
> > git-update-cache.txt even makes the difference between the "index"
> > and the "directory cache".
> 
> I think we should globally rename it to "index".

Totally agree. The index is a central concept. But let's keep in mind -- 
and make future Documentation/ readers do the same -- that the index,
without the referenced objects in the objects database, is only a 
skeleton.

> The "directory cache" and later "cache" naming came from when I started
> doing the work - before git was even git at all, and had no backing store
> what-so-ever, I started out writing "cache.h" and "read-cache.c", and it
> was really first a trial at doing a totally SCM-neutral directory cache
> front-end.
> 
> You don't even see that in the git revision history, because that was 
> before git was self-hosting - the project was partly started to also work 
> as possibly just a fast front-end to something that wasn't as fast (ie 
> think something like a front-end to make "monotone" work better).
> 
> So the "directory cache" and "cache" naming comes from that historical 
> background: it was really started as a front-end cache, and in fact the 
> ".git" directory was called ".dircache" initially. You can see some of 
> that in the very earliest git releases: by then I had already done the 
> backing store, and the thing was already called "git", but the "dircache" 
> naming still remains in places.
> 
> For example, here's my "backup" target in the initial checkin:
> 
> 	backup: clean
> 		cd .. ; tar czvf dircache.tar.gz dir-cache
> 
> which shows that not only did I call the resulting tar file "dircache", 
> the directory I was developing stuff in was called "dir-cache" as well ;)
> 
> The index obviously ended up doing a lot more, and especially with the
> different stages it became much more than just a directory cache thing:  
> it's integral to how git does the fast part of a merge. So we should call
> it "index" and edit out the old "cache" and "director cache" naming
> entirely.

I quoted this entirely, for a good reason: Linus, one day you really 
should write a Wikibook about all the "small" projects you started. I 
still remember the words "I'm doing a (free) operating system (just a 
hobby, won't be big...". There's so much to be learnt about good 
engineering. And people do want to add there anecdotes to it.

> >   - the directory which corresponds to the top of the hierarchy
> >     described in the index file; I've seen words like "working
> >     tree", "working directory", "work tree" used.
> > 
> > The tutorial initially says "working tree", but then "working
> > directory". Usually, a directory does not include its
> > subdirectories, though. git-apply-patch-script.txt, git-apply.txt,
> > git-hash-object.txt, git-read-tree.txt
> > use "work tree". git-checkout-cache.txt, git-commit-tree.txt,
> > git-diff-cache.txt, git-ls-tree.txt, git-update-cache.txt contain
> > "working directory". git-diff-files.txt talks about a "working tree".
> 
> I think we should use "working tree" throughout, since "working directory" 
> is unix-speak for "pwd" and has a totally different meaning.

I hoped so much.

> >   - An index file can be in "merged" or "unmerged" state.  The
> >     former is when it does not have anything but stage 0 entries,
> >     the latter otherwise.
> 
> I think the "unmerged" case should be mentioned in the "cache entry" 
> thing, since it's really a per-entry state, exactly like "dirty/clean".
> 
> Then, explaining a "unmerged index" as being an index file with some 
> entries being unmerged makes more sense. 
> 
> As it is, the above "explains" an index file as being unmerged by talking 
> about "stage 0 entries", which in turn haven't been explained at all.

That's right. We probably should copy a bit from git-read-tree.txt, or at 
least reference it in the glossary.

> >   - A "tree object" can be recorded as a part of a "commit
> >     object".  The tree object is said to be "associated with" the
> >     commit object.
> > 
> > In diffcore.txt, "changeset" is used in place of "commit".
> 
> We really should use "commit" throughout. ex-BK users sometimes lip into
> "changeset" (which in turn is probably because BK had these per-file
> commits too - deltas), but there's no point in the distinction in git. A 
> commit is a commit.

That is, if you don't do "git-update-cache <single-file>" (which is not 
possible with some porcelains).

Apart from that: I think that it is quite important to make the 
distinction between a "commit" and a "commit object". Newbies (in that 
case, people working with CVS are newbies to the concepts of git, too) 
tend understand better what you say, if you make that distinction very 
clearly, IMHO.

> >   - The following objects are collectively called "tree-ish": a
> >     tree object, a commit object, a tag object that resolves to
> >     either a commit or a tree object, and can be given to
> >     commands that expect to work on a tree object.
> > 
> > We could call this category an "ent".
> 
> LOL. You are a total geek.

I take that as a compliment :-)

> >   - The files under $GIT_DIR/refs record object names, and are
> >     called "refs".  What is under refs/heads/ are called "heads",
> >     refs/tags/ "tags".  Typically, they are either object names
> >     of commit objects or tag objects that resolve to commit
> >     objects, but a tag can point at any object.
> > 
> > The tutorial never calls them "refs", but instead "references".
> 
> It might be worth saying explicitly that a reference is nothing but the 
> same thing as a "object name" aka "sha1". And make it very clear that it 
> can point to any object type, although commits tend to be the most common 
> thng you want to reference. That then leads naturally into a very specific 
> _subcase_ of refs, namely a "head":

Do not forget signed tags! Strictly said, these are references to 
references which are signed.

> >   - A "head" is always an object name of a commit, and marks the
> >     latest commit in one line of development.  A line of
> >     development is often called a "branch".  We sometimes use the
> >     word "branch head" to stress the fact that we are talking
> >     about a single commit that is the latest one in a "branch".
> > 
> > In the tutorial, the latter is used in reverse: it talks about a
> > "HEAD development branch" and a "HEAD branch".

Actually, I don't think it a good idea to talk about a "HEAD branch" or 
"development branch". I'd prefer "branch".

> > I find it a little bit troublesome that $GIT_DIR/branches does not
> > really refer to a branch, but rather to a (possibly remote) repository.
> 
> Yes, I find the $GIT_DIR/branches naming to be confusing too. 

I don't know if we can hide it from the users, or if we should bite the 
apple and rename it to "remotes/", or even better "repositories/".

> Jeff has been dragging me into the "local branches are good" camp, and
> these days I'm obviously a big believer.

I think that Jeff really deserves the credit for this. Yours truly was 
convinced that one repository should hold one branch only. But I was 
convinced otherwise, too.

> >   - The act of finding out the object names recorded in "refs" a
> >     different repository records, optionally updating a local
> >     "refs" with their values, and retrieving the objects
> >     reachable from them is called "fetching".  Fetching immediately
> >     followed by merging is called "pulling".
> > 
> > In that sense, git-http-pull would be more appropriately named
> > git-http-fetch, and analogous git-ssh-pull.
> > 
> > Also, git-pull-script.txt says "Pull and merge", contradicting this
> > definition.
> 
> To confuse things even more, cogito calls a fetch "pull" and a pull 
> "update".

I really think this should be unified. Pasky?

> I personally think "fetch" is unambigious: it's just the act of fetching, 
> with no "merge" activity at all. So we should use that.

Agree.

> What to call a "fetch+merge" is a bit ambiguous. I obviously prefer
> "pull", but cogito disagrees, and you're right, "git-http-pull" and
> "git-ssh-pull" both really do just fetches.

Let's rename them before 1.0.

> But I think "update" isn't right either: to me, update would be the 
> non-merging kind (ie I think "update" implies "refresh" which in turn 
> implies a "fetch"-like behaviour).
> 
> So I'd vote for making the suggested definition official: "fetch" means
> fetching the data, and "pull" means "fetch + merge". 

This should be discussed. Obviously, I come from CVS and understand 
"update" to be what cogito says it is. But then, it is also true that 
CVS's usage of "update" is misleading, because it really does a merge, not 
forcing the user to do a commit before merge (because that is not possible 
in CVS). So basically, I agree: "pull" is unambiguous as far as I am 
concerned.

> >   - a "pack" usually consists of two files: a file containing objects
> >     in a compressed format, and an index to the first file. If the
> >     pack is uncompressed at once (e.g. when git-clone is called), the
> >     index is not necessary.
> > 
> > git-pack-objects calls this a "packed archive" first, but then reverts
> > to "pack". git-show-index.txt and git-verify-pack.txt call the .pack file
> > "packed GIT archive", and the index "idx file". git-unpack-objects.txt
> > calls the .pack file "pack archive".
> 
> We should just call them packs. An archive can be multiple packs and lots 
> of non-packed objects too. 

And they can have pack indices which do not relate at all to the central 
GIT index.

> > "type": one of the identifiers "commit","tree","tag" and "blob" describing
> > the type of an object.
> 
> Yes. Some old docs may call this type a "tag", since I was really thinking
> in not in the SCM meaning at all, but in the _computer_architecture_
> meaning, where people usually call objects with enforced types "tagged".
> 
> Ie from a computer architecture standpoint you can have "tagged memory" or
> "tagged pointers", and LISP machines are often implemented with the
> pointers containing the type ("tag") of the thing they point to (for
> example, the low two bits might be the "tag" on the pointer). So I was
> talking about "tagged objects" when I just meant that the type of the
> object was embedded in the object itself, the way tagged memory
> architectures work.
> 
> In retrospect, that naming _really_ confused some people, I know I had
> trouble explaining git concepts to David Wheeler because I used "tagged
> objects" _not_ to mean a SCM style "tag", but to mean "typed objects".
> 
> If somebody sees an old reference to "object tags", those should all be 
> fixed to say "object types".

Agree.

Ciao,
Dscho
