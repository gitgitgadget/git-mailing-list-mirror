From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 22:59:00 +0800
Message-ID: <a7e835d40610200759h49859a20k8a409fe34f68630a@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <200610201151.13199.jnareb@gmail.com>
	 <a7e835d40610200342ibc56fd9t542a60230ebe0020@mail.gmail.com>
	 <200610201517.26702.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:59:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gavq2-0005Cg-2K
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992639AbWJTO7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992633AbWJTO7E
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:59:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:19237 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932261AbWJTO7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 10:59:03 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1450775nfe
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 07:59:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nZwZS0/Fwgp5i2uA09rPc1Y5oQsjIX90jegGVYk+ASXPGk5wPfAZwDRLTLV/S/87zYBPy7+03Nvdfe3r+7g9K/xx1biJkoIT+s6GgCBkhrObHOoToxUU+so/TKPwOt92+v6cuZA1IVrN6ddi0XjSO2tITxmwXVa3Rp1YzRoCJN4=
Received: by 10.82.120.14 with SMTP id s14mr549657buc;
        Fri, 20 Oct 2006 07:59:01 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Fri, 20 Oct 2006 07:59:00 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610201517.26702.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: a8302b3eb8b97ffe
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29485>

On 20/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
> James Henstridge wrote:
> > With the above layout, I would just type:
> >     bzr branch http://server/repo/branch1
>
> With Cogito (you can think of it either as alternate Git UI, or as SCM
> built on top of Git) you would use
>
>    $ cg clone http://server/repo#branch
>
> for example
>
>    $ cg clone git://git.kernel.org/pub/scm/git/git.git#next
>
> to clone _single_ branch (in bzr terminology, "heavy checkout" of branch).

My understanding of git is that this would be equivalent to the "bzr
branch" command.  A checkout (heavy or lightweight) has the property
that commits are made to the original branch.

> But you can also clone _whole_ repository, _all_ published branches with
>
>    $ cg clone git://git.kernel.org/pub/scm/git/git.git

I suppose that'd be useful if you want a copy of all the branches at
once.  There is no builtin command in Bazaar to do that at present.


> With core Git it is the same, but we don't have the above shortcut
> for checking only one branch; branches to checkout are in separate
> arguments to git-clone.
>
> In bzr it seems that you cannot distinguish (at least not only
> from URL) where repository ends and branch begins.

I guess this highlights that the two tools optimise for different workflows.
> > This command behaves identically whether the repository data is in
> > /repo or in /repo/branch1.  Someone pulling from the branch doesn't
> > have to care what the repository structure is.  Having a separate
> > namespace for branch names only really makes sense if the user needs
> > to care about it.
> >
> > As for hierarchical names, there is nothing stopping you from using
> > deaper directory structures with Bazaar too.  Bazaar just checks each
> > successive parent directory til it finds a repository for the branch.
> >
> >> The idea of "branches (and tags) as directories" was if I understand
> >> it correctly introduced by Subversion, and from what can be seen from
> >> troubles with git-svn (stemming from the fact that division between
> >> project name and branch name is the matter of _convention_) at least
> >> slightly brain-damaged.
> >
> > I think you are a bit confused about how Bazaar works here.  A Bazaar
> > repository is a store of trees and revision metadata.  A Bazaar branch
> > is just a pointer to a head revision in the repository.  As you can
> > probably guess, the data for the branch is a lot smaller than the data
> > for the repository.
> >
> > You can store the repository and branch in the same directory to get a
> > standalone branch.  The layout I described above has a repository in a
> > parent directory, shared by multiple branches.
> >
> > If you are comparing Subversion and Bazaar, a Bazaar branch shares
> > more properties with a full Subversion repository rather than a
> > Subversion branch.
>
> Oh, that explained yet another difference between Bazaar-NG (and other
> SCM which uses similar model) and Git.
>
> In Git branch is just a pointer to head (top) commit (hence they are stored
> under .git/refs/heads/) in given line of development. Git also stores
> information (in .git/HEAD) about which branch we are currently on, which
> means on which branch git puts new commits. Nothing more (well, there
> can be log of changes to head in .git/logs/refs/heads/ but that is optional
> and purely local information). In Bazaar-NG you have to store (if I
> understand it correctly) mapping from revnos to revisions.
>
> By default (it means for example default behavior of git-clone, if we don't
> use --bare option) git repository is _embedded_ in working area. We have

Two points:
(1) if we are publishing branches, we wouldn't include working trees
-- they are not needed to pull or merge from such a branch.
(2) if we did have working trees, they'd be rooted at /repo/branch1
and /repo/branch2 -- not at /repo (since /repo is not a branch).

In case (2) there is a potential for conflicts if you nest branches,
but people don't generally trigger this problem with the way they use
Bazaar.

> So repo/branch wouldn't work, because 'branch' would conflict with working
> area files. GIT doesn't follow the CVS model of separate storage area
> (CVSROOT) and having only pointer to said area (files in CVS/
> subdirectories) in working directory.

That is fairly similar to the default mode of operation with Bazaar:
you have a repository, branch and working tree all rooted in the same
directory.  If you have separated working trees and branches, then
that is because you specifically asked for it.


> In GIT to work on some repository you don't (like from what I understand
> in Bazaar-NG) "checkout" some branch (which would automatically copy some
> data in case of "heavy checkout" or just save some pointer to repository
> in "lightweight checkout" case). You clone whole repository; well you can
> select which branches to clone. "Checkout" in GIT terminology means to
> populate working area with given version (and change in repository which
> branch is current, usually).

I think you have a slight misunderstanding of what a Bazaar checkout is.

>
> How checked out working area looks like in Bazaar-NG?

The layout of a standalone branch would be:
  .bzr/repository/ -- storage of trees and metadata
  .bzr/branch/ -- branch metadagta (e.g. pointer to the head revision)
  .bzr/checkout/ -- working tree book-keeping files
  source code

If we use a shared repository, the contained branches would lack the
.bzr/repository/ directory.  The parent directory would instead have a
.bzr/repository/, but usually wouldn't have .bzr/branch/ (unless there
is a branch rooted at the base of the repository).

if we are publishing a branch to a web server, we'd skip the working
tree, so the source code and .bzr/checkout/ directory would be
missing.

In the case of a checkout, the .bzr/branch/ directory has a special
format and acts as a pointer to the original branch.  If the checkout
is lightweight, the .bzr/repository/ directory would be missing, and
bzr would need to contact the original branch for the data.


> >>> For similar reasons, the cost of publishing 20 related Bazaar branches
> >>> on my web server is generally not 20 times the cost of publishing a
> >>> single branch.
> >>>
> >>> I understand that you get similar benefits by a GIT repository with
> >>> multiple head revisions.
> >>
> >> You can get similar benefits by a GIT repository with shared object
> >> database using alternates mechanism. And that is usually preferred
> >> over storing unrelated branches, i.e. branches pointing to disconnected
> >> DAG (separate trees in BK terminology) of revision, if that you mean by
> >> multiple head revisions (because in GIT there is no notion of "mainline"
> >> branch, only of current (HEAD) branch).
> >
> > I may have got the git terminology wrong. I was trying to draw
> > parallels between the .git/refs/... files in a git repository and the
> > way multiple branches can be stored in a Bazaar repository.
>
> Yes, but using Git that way has serious disadvantages. For example
> there is only one current branch pointer and only one index (dircache)
> per git repository.

Okay.  So using Bazaar terminology, this seems to be an issue of the
working tree being associated with the repository rather than the
branch?


[...]
> But I agree that saving "old fork" info as separate branch doesn't lead
> to that much inefficiency as might be thought.
>
> But after saving "old fork" as a branch revno based revision identifiers
> change from http://old.host/old/repo:127 to http://host/repo/old.fork:127
> That is maybe minimal change, but this is change!

Well, a branch can easily have multiple URLs even if there is only one
copy of it.  I might write to it via local file access or sftp (which
would be a file: or sftp: URL).

Mirrors of branches don't usually confuse users (and remember that the
revision numbers are primarily intended for users -- if I am writing a
Bazaar plugin, I'd work in terms of revision IDs).


James.
