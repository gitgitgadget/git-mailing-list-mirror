From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more than one commit
Date: Wed, 2 Jun 2010 07:57:34 +0200
Message-ID: <201006020757.34186.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <20100531194240.28729.50475.chriscool@tuxfamily.org> <20100601095124.GA1033@progeny.tock>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:57:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgxX-0006M6-LD
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab0FBF5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:57:44 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46515 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab0FBF5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:57:43 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 69044818076;
	Wed,  2 Jun 2010 07:57:35 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20100601095124.GA1033@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148205>

On Tuesday 01 June 2010 11:51:24 Jonathan Nieder wrote:
> Christian Couder wrote:
> > --- a/Documentation/git-cherry-pick.txt
> > +++ b/Documentation/git-cherry-pick.txt
> > @@ -3,24 +3,29 @@ git-cherry-pick(1)
> >
> >  NAME
> >  ----
> > -git-cherry-pick - Apply the change introduced by an existing commit
> > +git-cherry-pick - Apply the change introduced by some existing commits
> 
> Maybe s/change/changes/.

Ok.

> >  DESCRIPTION
> >  -----------
> > -Given one existing commit, apply the change the patch introduces, and
> > record a -new commit that records it.  This requires your working tree to
> > be clean (no -modifications from the HEAD commit).
> > +
> > +Given one or more existing commits, apply the changes that the related
> > +patches introduce, and record some new commits that record them.  This
> > +requires your working tree to be clean (no modifications from the HEAD
> > +commit).
> 
> "Related" made me think "related how"?  "Record some new commits"
> sounds oddly vague.
> 
> Maybe:
> 
> 	Given one or more existing commits, apply the change each one
> 	introduces, recording a new commit for each.  This requires
> 	your working tree to be clean (no modifications from the HEAD
> 	commit).

Ok.

> >  OPTIONS
> >  -------
> > -<commit>::
> > -	Commit to cherry-pick.
> > +<commit>...::
> > +	Commits to cherry-pick.
> >  	For a more complete list of ways to spell commits, see the
> >  	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
> > +	Sets of commits can also be given but no traversal is done
> > +	by default, see linkgit:git-rev-list[1] and its '--no-walk'
> > +	option.
> 
> --no-walk can be a bit confusing.  I think we should try to avoid
> relying on the reader understanding it.
> 
>  <commit>...::
> 	Commits to cherry-pick.
> 	For a more complete list of ways to spell commits, see the
> 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
> 	Revision ranges are interpreted as though specified with
> 	the `--no-walk` option; see the "Examples" section below.

I put the following:

<commit>...::
	Commits to cherry-pick.
	For a more complete list of ways to spell commits, see the
	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
	Sets of commits can be passed but no traversal is done by
	default, as if the '--no-walk' option was specified, see
	linkgit:git-rev-list[1].

> >  -e::
> >  --edit::
> > @@ -55,13 +60,12 @@ OPTIONS
> >
> >  -n::
> >  --no-commit::
> > -	Usually the command automatically creates a commit.
> > -	This flag applies the change necessary to cherry-pick
> > -	the named commit to your working tree and the index,
> > -	but does not make the commit.  In addition, when this
> > -	option is used, your index does not have to match the
> > -	HEAD commit.  The cherry-pick is done against the
> > -	beginning state of your index.
> > +	Usually the command automatically creates some commits.  This
> > +	flag applies the change necessary to cherry-pick the named
> > +	commits to your working tree and the index, but does not make
> > +	the commits.  In addition, when this option is used, your
> > +	index does not have to match the HEAD commit.  The cherry-pick
> > +	is done against the beginning state of your index.
> 
> This switches between singular and plural.
> 
>  -n::
>  --no-commit::
> 	Usually 'git cherry-pick' automatically creates a sequence
> 	of commits.  This option can be used to apply the changes
> 	necessary to cherry-pick each named commit to your working
> 	tree and index without making any commits.  In addition,
> 	when this option is used, your index does not have to match
> 	the HEAD commit: the cherry-pick is done against the
> 	beginning state of the index.

I put the following:

-n::
--no-commit::
	Usually the command automatically creates a sequence of commits.
	This flag applies the changes necessary to cherry-pick
	each named commit to your working tree and the index,
	without making any commit.  In addition, when this
	option is used, your index does not have to match the
	HEAD commit.  The cherry-pick is done against the
	beginning state of your index.

> >  +
> >  This is useful when cherry-picking more than one commits'
> >  effect to your index in a row.
> 
> 	This is useful for cherry-picking multiple commits
> 	to produce a single new commit.

I don't think any change is really needed here, so I left it as it was.

> > @@ -75,6 +79,38 @@ effect to your index in a row.
> >  	cherry-pick'ed commit, then a fast forward to this commit will
> >  	be performed.
> >
> > +Examples
> > +--------
> 
> These are a little repetitive.
> 
> > +git cherry-pick master::
> > +
> > +	Apply the changes specified by the commit pointed to by master
> > +	and create a new commit with these changes.
> 
> git cherry-pick master::
> 
> 	Apply the change introduced by the commit at the tip of the
> 	master branch and create a new commit.

I put:

git cherry-pick master::

	Apply the change introduced by the commit at the tip of the
	master branch and create a new commit with this change.

> > +
> > +git cherry-pick master~3..master::
> > +git cherry-pick ^master~3 master::
> > +
> > +	Apply the changes specified by the last 3 commits pointed to
> > +	by master and create 3 new commits with these changes.
> 
> git cherry-pick ..master::
> git cherry-pick ^HEAD master::
> 
> 	Apply the changes introduced by all commits that are ancestors
> 	of master but not HEAD to produce new commits on the current
> 	branch.

I put:

git cherry-pick ..master::
git cherry-pick ^HEAD master::

	Apply the changes introduced by all commits that are ancestors
	of master but not of HEAD to produce new commits.


> > +git cherry-pick master\~3 master~2::
> > +
> > +	Apply the changes specified by the fourth and third last
> > +	commits pointed to by master and create 2 new commits with
> > +	these changes.
> 
> git cherry-pick master~5 master~2::
> 
> 	Apply the changes introduced by the fifth- and second-generation
> 	grandparents of master to HEAD as new commits.

I put:

git cherry-pick master\~4 master~2::

	Apply the changes introduced by the fifth and third last
	commits pointed to by master and create 2 new commits with
	these changes.
 
> > +
> > +git cherry-pick -n master~1 next::
> > +
> > +	Apply to the working tree and the index the changes specified
> > +	by the second last commit pointed to by master and by the last
> > +	commit pointed to by next, but do not create any commit with
> > +	these changes.
> 
> git rev-list master -- README | git cherry-pick -n --stdin::
> 
> 	Apply the changes introduced by all commits on the master
> 	branch that touched README to the working tree and index,
> 	so the result can be inspected and made into a single new
> 	commit if suitable.

I think "--reverse" is needed after "rev-list" and cherry-pick has no --stdin 
option. So I put:

git cherry-pick -n master~1 next::

	Apply to the working tree and the index the changes introduced
	by the second last commit pointed to by master and by the last
	commit pointed to by next, but do not create any commit with
	these changes.

> > +
> > +git cherry-pick --ff ..next::
> > +
> > +	If possible fast forward to the existing commits already in
> > +	next but not in HEAD, otherwise apply the changes specified by
> > +	these commits and create new commits with these changes.
> 
> git cherry-pick --ff ..next::
> 
> 	If history is linear and HEAD is an ancestor of next, update
> 	the working tree and advance the HEAD pointer to match next.
> 	Otherwise, apply the changes introduced by those commits that
> 	are in next but not HEAD to the current branch, creating a new
> 	commit for each new change.

Ok.

Thanks,
Christian.
