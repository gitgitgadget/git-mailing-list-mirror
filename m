From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Sat, 04 Jun 2011 14:49:53 -0700 (PDT)
Message-ID: <m339jps1wt.fsf@localhost.localdomain>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<BANLkTinTWG7YXGKZzmH0rqtt+Ob7X+2yMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Nahas <mike.nahas@gmail.com>
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Sat Jun 04 23:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSyoM-0006eh-2r
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 23:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755Ab1FDVt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2011 17:49:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45025 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1FDVt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2011 17:49:57 -0400
Received: by fxm17 with SMTP id 17so1841646fxm.19
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=UMZg+Qb3x1CjdYewwJWl702goxxM5iGffCzXnFOdFAo=;
        b=X6AO+yMASU57v+lLILo2I0Tr3nUHX+vH8clF/NKo0I+J6B71tJnZA6M6p76NgEOQmE
         B/5D4S/9b1Zoy/mR3Tfb86cpZqnkbwWa0tE1ZMy6WM2HMyrrxau/HtuEC+lpgIhyRwL6
         pnFG0JBa+lcasotpRYZejxu8AtxzjzcLFQNmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=NVWt2YJCD3bCWEHP5Snn7Pc1FvKFrkqhUt3tjDj9rDBiRER4FAMxwECcGUOx9rz/HG
         wtt2EuQgH70xc7Tvi0GiVh8lSGk/HrvL3nXccM4VmBtcZBaQHMbGm/V6tfe/OG0T0vnG
         9k10HMfV+c3/8EZZH/nhELKGJoNpytMO1OV+k=
Received: by 10.223.61.134 with SMTP id t6mr3577718fah.28.1307224195222;
        Sat, 04 Jun 2011 14:49:55 -0700 (PDT)
Received: from localhost.localdomain (abva119.neoplus.adsl.tpnet.pl [83.8.198.119])
        by mx.google.com with ESMTPS id a18sm872504fak.29.2011.06.04.14.49.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Jun 2011 14:49:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p54LnNwH010512;
	Sat, 4 Jun 2011 23:49:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p54Ln7JR010502;
	Sat, 4 Jun 2011 23:49:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTinTWG7YXGKZzmH0rqtt+Ob7X+2yMQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175066>

Michael Nahas <mike.nahas@gmail.com> writes:

> Quick list of recommendations:
>=20
> 1. Pick aliases for the next commit and the working tree that act lik=
e
>    commits on the command-line.

No go.  This was asked for many times, and each time shot down.
Those "aliases" / pseudo-refs looks like commits but do not behave
exactly like commits.  This would increase connfusion.

See also gitcli(7) manpage for description of --index and --cached
options (and other git command line conventions).

> 2. Adopt a (semi-)formal notation for describing what commands do.

Whom it would help?  Not an ordinary user.

> 3. Move the operations "checkout -- <file>" and "reset -- <file>" to
>    their own command names

Proposed "git unadd <pathspec>..." doesn't cover all features of
"git reset <rev> -- <path>" nor "git checkout [<rev>] -- <path>".

> 4. Deemphasize the "branch" command for creating branches.

Or add "git branch --checkout <newbranch>".

>=20
> A "normal" (long) email follows.=A0 At the end are examples of comman=
ds
> in a not-quite-so-formal notation.
=20
> ------------
>=20
> I was the primary designer of the PAR2 open file format and write a
> lot of big software (application-layer multicast, etc.).=A0 I've been
> using Git for 2 months.=A0 I love it and I greatly admire the plumbin=
g.
> However, the default "porcelain" has at times been more confusing tha=
n
> enlightening.

BTW. have you read gitcli(7) manpage?
=20
> I had some ideas about the porcelain and decided they were worth
> sending to the mailing list.=A0 I ran the ideas by the two Git gurus =
who
> answer my questions and they agreed with them.=A0 I wish I had the ti=
me
> to implement them but I did PAR2 when I had time off and I'm working
> now.=A0 I apologize if any of these are repeats or have already been
> discussed to death.
>=20
>=20
> My recommendations are:
>=20
> 1. Pick aliases for the next commit and the working tree that act lik=
e
> commits on the command-line.
>=20
> By "next commit", I mean "the commit that would be generated if the
> "commit" command was run right now".=A0 "Next commit" is not the same=
 as
> the index.=A0 The index is a _file_ that serves multiple purposes.
> (Think of it's state during a conflicted merge.)=A0 But the index doe=
s
> usually hold the files that change between HEAD and the next commit.
>=20
> For the alias for the next commit and working tree, I suggest "NEXT"
> and "WTREE".=A0 Creating these aliases will make the interface more
> regular. It will remove oddities like "diff --cached FOO" and replace
> them with "diff NEXT FOO" and mean that "diff" and "diff FOO" can be
> explained as "diff WTREE NEXT" and "diff WTREE FOO".
=20
This idea ws proposed multiple time on git mailing list, and every
time it was rejected.

The problem is first, that you make INDEX / STAGE / NEXT and=20
WORK / WTREE *look* like commits (like pseudo symbolic refs), while
they do not *behave* like commits.
=20
"git show HEAD" looks differently from "git show NEXT" or "git show WTR=
EE".
Neither the index now working tree have a parent, or author, or commit
message.  The index (staging area) can have stages, though you sidestep
this issue by handwaving it away.  Working area has notion of tracked,
untracked ignored and untracked not ignored (other) files.   Etc., etc.

BTW. both index and worktree have their own "aliases", namely ':0:'
for index (stage 0), and ':' or ':/' for top tree.


Second, it doesn't solve issue of needing --cached and/or --index
swiches completely.  Those pseudo-almost-refs hide them for "git diff",
"git grep", "git ls-files", perhaps "git submodule" where we *read*
from index, but not for "git apply", "git rm" or "git stash" where
those swicthes affect *writing*.

> 2. Adopt a notation for describing what commands do.
>=20
> I am sure in developer discussions there are descriptions of the
> "commit" command as something like:
> =A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
> =A0=A0 NEXT =3D HEAD

Basic algebra fail

  HEAD + (NEXT-HEAD) =3D=3D NEXT

Besides "git commit" creates commit from state of index, no diffing or
patching is involved.

> Where "-" creates a patch between versions and + applies a patch.=A0 =
Git
> already has some operators like "^", which refers to the parent of a
> commit. Those are useful for defining things like "commit --amend":
> =A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
> =A0=A0 NEXT =3D HEAD

Which is again not true.
=20
> Having this notation and using it in the man pages will make the exac=
t
> nature of the operation clear. (Right now, it takes a lot of reading
> to figure out what happens to NEXT with the various command-line
> options of "reset".)

It's not that difficult: only "git reset --soft [<rev>]" doesn't
affect index.

Hrmmm... how this notation would explain differences between=20
"git reset --hard", "git reset --keep" and "git reset --merge"?

>=20
> Currently, to understand what commands do, I use "A Visual Git
> Reference", which has been extremely valuable to me. Kuddos to Mark
> Lodato for it.
> http://marklodato.github.com/visual-git-guide/index-en.html

Unfortunately manpages cannot really include images.  Well, there is
some kind of obscure graph description language for manpages ('dot' or
something like that), supposedly, IIRC...

>=20
> [I've included git commands in a not-formal-enough notation at the en=
d
> of this email.]
=20
NEVERTHELESS some kind of semi-formal notation might be useful.
=20
> 3. Move the operations "checkout -- <file>" and "reset -- <file>" to
> their own command names
>=20
> This is my biggest and most important suggestion.
>=20
> "checkout -- foo.txt" copies foo.txt from NEXT to WTREE. Similarly,
> "reset -- foo.txt" will copy foo.txt from HEAD to NEXT.

  "checkout HEAD -- foo.txt" copies foo.txt from HEAD to NEXT and WTREE

  "checkout HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT and WTR=
EE
  "reset HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT
=20
> These are operations to designate/undesignate files in the next commi=
t
> and should be grouped with others like them: "add", "rm" and "mv". (I=
n
> fact, the man page for "reset -- <file>" even says that it is the
> opposite of "add"!)
>=20
> When these file-based operations are removed from "checkout" and
> "reset", the purposes of those commands becomes clearer: "checkout"
> changes HEAD to a new branch and "reset" moves the current branch
> pointer to a different commit.=A0 These operations may share code wit=
h
> the operations "checkout -- <file>" and "reset -- <file>", but they
> serve different purposes from the user's perspective and the user
> should have different names to refer to them.
>=20
> As for naming these new commands, the "yet-another-porcelain" renames
> "reset -- <file>" to "unadd", which I like very much.

Well, that goes counter to reducing number of commands, but I quite
like this name.  Though "unadd <revision> -- <file>" looks a bit
strange...

>=A0For the other, my best suggestion is "head-to-next", but I'm sure
> someone can do better.

I'd rather remember that "git checkout" is about checking out
something to a working area.
=20
>=20
> 4. Deemphasize the "branch" command for creating branches.
>=20
> I assumed that the command "branch" was used for creating branches.
> After all, that's how it is done in the "gittutorial(7)" man page.

It _is_ used to create branches.  But perhaps we should update
gittutorial(7) (and check users manual)...

> However, after reviewing all the major commands, I find that it is th=
e
> _last_ way I want to create a branch. It creates a new branch, but it
> doesn't switch HEAD to the new branch!

"checkout -b" is just shortcut for "branch" + "checkout".  Very
convenient one, that is...

>=20
> The commands that should be emphasized are "checkout -b <name>",
> "commit -b <name>", and "stash branch".=A0 These make sense in normal
> git usage. The "branch" command has its uses but it is not usually th=
e
> way you want to create a branch.
[...]

> ----
>=20
> These are just some commands written in a not-quite-formal notation.
> This notation doesn't handle a detached head, adding directories, the
> state after a conflicted "stash pop", etc.=A0 Still, as it is, I thin=
k
> it's very informative to users for getting the gist of what command
> does.
>=20
> "add foo.txt"
> =A0=A0 NEXT:foo.txt =3D WTREE:foo.txt

What about "add --intent-to-add foo.txt"?  What about "add <directory>"=
?
What about resolving merge conflicts?

> "rm foo.txt"
> =A0=A0 delete(NEXT:foo.txt)
> =A0=A0 delete(WTREE:foo.txt)
> "rm --cached foo.txt"
> =A0=A0 delete(NEXT:foo.txt)
> "/bin/rm foo.txt"
> =A0=A0 delete(WTREE:foo.txt)

O.K.  Note however that "git rm foo.txt" on conflicted entry would
clean up conflict.

> "mv foo.txt bar.txt"
> =A0=A0 WTREE:bar.txt =3D WTREE:foo.txt
> =A0=A0 NEXT.bar.txt =3D WTREE:foo.txt
> =A0=A0 delete(WTREE:foo.txt)
> =A0=A0 delete(NEXT:foo.txt)

O.K., but what is important are atomicity and safety checks.

> "checkout -- foo.txt"
> =A0=A0 WTREE:foo.txt =3D NEXT:foo.txt
> "reset -- foo.txt"
> =A0=A0 NEXT:foo.txt =3D HEAD:foo.txt

Those are not the only modes.

> "commit"
> =A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
> =A0=A0 NEXT =3D HEAD

   HEAD + (NEXT-HEAD) =3D=3D NEXT

"git commit" doesn't apply patches.

> "commit --amend"
> =A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
> =A0=A0 NEXT =3D HEAD

  HEAD^ + (NEXT-HEAD^) =3D=3D NEXT

"git commit --amend" works correctly even if HEAD is a merge commit!

>=20
> "checkout FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)

No such requirement.  It's all about which files differ between HEAD
and FOO.  If you start working on some file, and decide that you
should have made the change on different branch, "git checkout FOO"
allow to move to FOO branch... assuming that changed file has the same
contents in HEAD and in FOO.

End there is "checkout -f" and "checkout -m".

> =A0=A0 WTREE =3D FOO
> =A0=A0 NEXT =3D FOO
> =A0=A0 HEAD ::=3D FOO // changes the alias of HEAD to refer to FOO

And this is supposed to be easier to understand?


> "stash save"
> =A0=A0 STASH =3D new(new(HEAD+(NEXT-HEAD))+WTREE-NEXT)
> =A0=A0 NEXT =3D HEAD
> =A0=A0 WTREE =3D HEAD
> =A0=A0 push(STASH)
> "stash pop"
> =A0=A0 STASH =3D pop()
> =A0=A0 WTREE =3D HEAD + (STASH-STASH^^)
> =A0=A0 NEXT =3D HEAD + (STASH^-STASH^^)

???

[...]=20
> "cherry-pick FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)
> =A0=A0 HEAD =3D new(HEAD + (FOO - FOO^))
> =A0=A0 NEXT =3D HEAD
> =A0=A0 WTREE =3D HEAD
> "rebase FOO" is basically a iterated application of "cherry-pick"

Ordinary rebase isn't.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
