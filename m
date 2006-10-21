From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 18:59:02 +0200
Message-ID: <200610211859.03420.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610211608.18895.jnareb@gmail.com> <845b6e870610210931r19aaaac3y3dfd0d9c4af8ed40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 18:59:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbKBa-0006PW-8E
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993138AbWJUQ65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 12:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161502AbWJUQ65
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:58:57 -0400
Received: from qb-out-0506.google.com ([72.14.204.232]:23630 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161498AbWJUQ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 12:58:56 -0400
Received: by qb-out-0506.google.com with SMTP id p36so278899qba
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 09:58:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GPAcDspCx9BC/eBCChvjjBmawhKyWNBForOsoNcomIyFpdIlTKcwRvDB8eMLwcbgYKHOQ2y1XjXo3ZU5nl3ZPEcIiwEmww/mThBk3nR+zwtby1jyKtmipmxshWGSLKTxfHMuVeJEJhSNL7YxE58mwzsk7N7E3huFK5ZtRt7hsNA=
Received: by 10.67.119.13 with SMTP id w13mr4086789ugm;
        Sat, 21 Oct 2006 09:58:54 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 39sm89697ugb.2006.10.21.09.58.52;
        Sat, 21 Oct 2006 09:58:53 -0700 (PDT)
To: "Erik =?iso-8859-1?q?B=E5gfors?=" <zindar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <845b6e870610210931r19aaaac3y3dfd0d9c4af8ed40@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29637>

Erik B=E5gfors wrote:
> Jakub Narebski wrote:
>>
>> There _are_ terminology conflicts. For example bzr "branch" is rough=
ly
>> equivalent to one-branch git "repository";
>=20
> Agreed.
>=20
>> bzr "repository" is just
>> collection of branches sharing common storage,
>
> Agreed

What is worse (in comparing git with bzr) that there are no exact
equivalents. For example bzr "branch" is something between git
repository (clone of repository) and git branch. Bazaar-NG "repository"
is something like multi-branch git repository, but also like collection
of git repositories sharing object database.
=20
>> which is similar to set
>> of git "repositories" with .git/objects/ linked to common object
>> repository (storage area) or appropriately set alternates file
>> (although that is not common usage in git, and for example you would
>> have to be carefull with running git-prune); bzr "lightweight checko=
ut"
>> is equivalent to nonexistent "lazy clone"/"remote alternates" discus=
sed
>> on git mailing list but not implemented because of performance
>> concerns; bzr "normal checkout" is I think similar to git "shared
>> clone" (but shared clone is limited to repositories on the same
>> filesystem); bzr "heavyweight checkout" is roughly equivalent to
>> one-branch-only "clone" in git or cg (cg =3D Cogito).
>=20
> This is wrong. There are two kinds of checkouts
> lightweight.. and "normal/heavyweight".
>=20
> I think you are getting this a little wrong, and I think the reason i=
s
> that you are thinking of repositories, while in bzr you normally thin=
k
> of branches.

As I said: conflict of concepts. And perhaps philosophies.

> For example, I think (correct me if I'm wrong) that if I have a git
> repository of a upstream linux-repo (Linus' for example).  I guess
> I'll use "pull" to keep my copy up to date with the upstream repo? If
> I then would like to hack something special, I would "clone" the repo
> and get a new repo and that's where I do my work.  Is that correct?

Not exactly.

To work for example on Linus' version of Linux kernel you clone upstrea=
m
linux-repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
-2.6.git
Working area is associated with repository in Git, not with "branch" li=
ke
in Bazaar-NG. In default configuration 'master' (main) branch of cloned
repository (in the case of Linus' public repo it is the only branch)
corresponds to 'origin' branch in your repository.

Now you can work on 'master' branch, putting your changes there. git-fe=
tch
will update 'origin' branch to the current version of 'master' branch o=
f
cloned repo; git-pull will additionally merge into 'master', i.e. merge
new changes into your work.

Now if you want to hack something special, that you prefer to use separ=
ate
branch for, you don't need to clone repository anew (although you could=
,
using --local --shared to reduce cost of cloning) but it is enough to
create new branch in your repository. You can very easily switch betwee=
n
branches using the same working area (in bzr it would probably mean=20
"branch checkout" to the same directory).

> In bzr you never (well...)  clone a full repository, but you clone on=
e

It's a pity... for example you usually want to have access to both
stable ('master') and development ('next') branches, perhaps
also to fixes ('maint') and beta stage development ('pu') branches.
In bzr it is a bit work (to correctly setup "repository"), in git
it is one command.

> line-of-development (a branch).  So "bzr branch"  is always a
> "one-branch-only "clone" in git or cg".

More or less.

> "bzr checkout" is a "bzr branch" followed by a setting saying
> "whenever you commit here, commit in the master branch also".

Git doesn't have exact equivalent here. For "bzr checkout" on
the same system, it is similar to setting common object repository;
for remote "bzr checkout" it might be approximated by hooks which
would push changes to remote repository (although we would have
to implement some transaction/journal framework).

> "bzr checkout --lightweight" is a way to get only a snapshot of the
> working tree out of a branch. Whenever you commit, it's done in the
> remote branch.

Yes, but with "bzr checkout --lightweight" you get also pointer
to remote branch where to commit changes. Git doesn't have something
like that, at least not for remote remote branch; mostly because of
poor performance or need for fast and constant network connection
to source branch.

--=20
Jakub Narebski
Poland
