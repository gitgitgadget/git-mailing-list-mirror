From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Sat, 4 Jun 2011 21:00:33 -0400
Message-ID: <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<BANLkTinTWG7YXGKZzmH0rqtt+Ob7X+2yMQ@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 03:03:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QT1kK-0005YJ-OR
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 03:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab1FEBAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2011 21:00:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57741 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab1FEBAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2011 21:00:35 -0400
Received: by bwz15 with SMTP id 15so2564876bwz.19
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mcfeM+cJ4zz/Ae7sarS1/Ta26Icz/Yc2UqaKNenIQxs=;
        b=E9ro3hafeMgP7dDETw9f+LKGgIanNibHYJyHYX7KHvOYxca7lTzypHlBVwfUxKJBRg
         c7iGZXN2FtJsxyW3p+ObFpfecSUQ3x8EEtoQArJJPHWVYkVvs8FHb5LcDYTVxJCNJvtw
         dba6k45MhMkCpROBzcb+YMJwaseCJem7BLnMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Qb41sAjvsiDAYU1/Qbr6M/rM/r8GvgtCndf0Qw/z7Ll5HGmvhQPwCUGm23E1StRESO
         Iy5AkunL1Y5bM7d7ezalJWqslqlWoGyX483HF4FMO0MaNcHIA8oiw3XdgwWN9RVAteCH
         5Zu4Dadt/0Ykoh+4/7T9h1s4FHMgncpYe8vys=
Received: by 10.204.116.134 with SMTP id m6mr3420288bkq.7.1307235633663; Sat,
 04 Jun 2011 18:00:33 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Sat, 4 Jun 2011 18:00:33 -0700 (PDT)
In-Reply-To: <m339jps1wt.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175068>

Thanks for your reply, Jakub.

On Sat, Jun 4, 2011 at 5:49 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Michael Nahas <mike.nahas@gmail.com> writes:
>
>> Quick list of recommendations:
>>
>> 1. Pick aliases for the next commit and the working tree that act li=
ke
>> =A0 =A0commits on the command-line.
>
> No go. =A0This was asked for many times, and each time shot down.
> Those "aliases" / pseudo-refs looks like commits but do not behave
> exactly like commits. =A0This would increase connfusion.

I'm glad it was discussed.  I think users would know that those
commits were special (they are writeable after all), but I'm sure more
informed people than I made the same arguments.

> See also gitcli(7) manpage for description of --index and --cached
> options (and other git command line conventions).

Thanks for the pointer.  I've now read it.

>> 2. Adopt a (semi-)formal notation for describing what commands do.
>
> Whom it would help? =A0Not an ordinary user.

I think it would help experts in discussing exactly what happens.  For
ordinary users that are hitting an intricate case (or don't know
English very well), it would be good if there was something that would
tell them mathematically what occurs.

>> 3. Move the operations "checkout -- <file>" and "reset -- <file>" to
>> =A0 =A0their own command names
>
> Proposed "git unadd <pathspec>..." doesn't cover all features of
> "git reset <rev> -- <path>" nor "git checkout [<rev>] -- <path>".

I'm confused.  How can it not cover all the features?  I'm just
suggesting renaming the command.  From "git reset -- <path>" to "git
unadd [--] <path>".  (And renaming "git checkout -- <path>" to some
yet-to-be-named other command.)

>> 4. Deemphasize the "branch" command for creating branches.
>
> Or add "git branch --checkout <newbranch>".

Would that operation be the different from the existing "git checkout
-b <new branch>", or just another way to write it?

>> A "normal" (long) email follows.=A0 At the end are examples of comma=
nds
>> in a not-quite-so-formal notation.
>
>> ------------
>>
>> I was the primary designer of the PAR2 open file format and write a
>> lot of big software (application-layer multicast, etc.).=A0 I've bee=
n
>> using Git for 2 months.=A0 I love it and I greatly admire the plumbi=
ng.
>> However, the default "porcelain" has at times been more confusing th=
an
>> enlightening.
>
> BTW. have you read gitcli(7) manpage?

I have now.  I'd swear I've read close to 30 manpages but never
heard-of/noticed that one until you mentioned it.  Thanks for the
pointer; it's good to have --index and --cached clarified.

>> I had some ideas about the porcelain and decided they were worth
>> sending to the mailing list.=A0 I ran the ideas by the two Git gurus=
 who
>> answer my questions and they agreed with them.=A0 I wish I had the t=
ime
>> to implement them but I did PAR2 when I had time off and I'm working
>> now.=A0 I apologize if any of these are repeats or have already been
>> discussed to death.
>>
>>
>> My recommendations are:
>>
>> 1. Pick aliases for the next commit and the working tree that act li=
ke
>> commits on the command-line.
>>
>> By "next commit", I mean "the commit that would be generated if the
>> "commit" command was run right now".=A0 "Next commit" is not the sam=
e as
>> the index.=A0 The index is a _file_ that serves multiple purposes.
>> (Think of it's state during a conflicted merge.)=A0 But the index do=
es
>> usually hold the files that change between HEAD and the next commit.
>>
>> For the alias for the next commit and working tree, I suggest "NEXT"
>> and "WTREE".=A0 Creating these aliases will make the interface more
>> regular. It will remove oddities like "diff --cached FOO" and replac=
e
>> them with "diff NEXT FOO" and mean that "diff" and "diff FOO" can be
>> explained as "diff WTREE NEXT" and "diff WTREE FOO".
>
> This idea ws proposed multiple time on git mailing list, and every
> time it was rejected.
>
> The problem is first, that you make INDEX / STAGE / NEXT and
> WORK / WTREE *look* like commits (like pseudo symbolic refs), while
> they do not *behave* like commits.
>
> "git show HEAD" looks differently from "git show NEXT" or "git show W=
TREE".
> Neither the index now working tree have a parent, or author, or commi=
t
> message. =A0The index (staging area) can have stages, though you side=
step
> this issue by handwaving it away. =A0Working area has notion of track=
ed,
> untracked ignored and untracked not ignored (other) files. =A0 Etc., =
etc.

I knew of some of these issues and I agree that I was handwaving them
away.  I didn't have all the answers and certainly didn't want to
appear to be claiming to have them.  I assumed that if the idea had
merit that these issues could be worked out.

That this idea has been brought up multiple times says that it does
have some merit.  But apparently not enough merit.

> BTW. both index and worktree have their own "aliases", namely ':0:'
> for index (stage 0), and ':' or ':/' for top tree.

Really?  Where can these aliases be used?

> Second, it doesn't solve issue of needing --cached and/or --index
> swiches completely. =A0Those pseudo-almost-refs hide them for "git di=
ff",
> "git grep", "git ls-files", perhaps "git submodule" where we *read*
> from index, but not for "git apply", "git rm" or "git stash" where
> those swicthes affect *writing*.

I agree with you that it would not get rid of all switches.  I never
expected it to.  My major aim was to simplify things like the "diff"
command, which I have trouble remembering the different variations of.

>> 2. Adopt a notation for describing what commands do.
>>
>> I am sure in developer discussions there are descriptions of the
>> "commit" command as something like:
>> =A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
>> =A0=A0 NEXT =3D HEAD
>
> Basic algebra fail
>
> =A0HEAD + (NEXT-HEAD) =3D=3D NEXT
>
> Besides "git commit" creates commit from state of index, no diffing o=
r
> patching is involved.

I would claim that the "state of index" is an approximation of
(NEXT-HEAD).  Also, the new Tree and Blob objects that get written
during the commit are another approximation of (NEXT-HEAD).  Neither
of these is exactly a patch applied to HEAD, but that's the intent I
was going for with my algebraic identity.  (It's not a fail; it's an
unoptimization!)

>> Where "-" creates a patch between versions and + applies a patch.=A0=
 Git
>> already has some operators like "^", which refers to the parent of a
>> commit. Those are useful for defining things like "commit --amend":
>> =A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
>> =A0=A0 NEXT =3D HEAD
>
> Which is again not true.

[Addressed below, where the "what if HEAD is a merge commit with
multiple predecessors" is mentioned.]

>> Having this notation and using it in the man pages will make the exa=
ct
>> nature of the operation clear. (Right now, it takes a lot of reading
>> to figure out what happens to NEXT with the various command-line
>> options of "reset".)
>
> It's not that difficult: only "git reset --soft [<rev>]" doesn't
> affect index.
>
> Hrmmm... how this notation would explain differences between
> "git reset --hard", "git reset --keep" and "git reset --merge"?

I don't understand what "git reset --keep" and "git reset --merge" do.
 I've read the manpage but am still confused.  One of my reasons for
suggesting a notation is so that there is a clear mathematical
representation of what the commands do.  Once I understand them, I can
make an attempt at a notation that can explain them.

>> Currently, to understand what commands do, I use "A Visual Git
>> Reference", which has been extremely valuable to me. Kuddos to Mark
>> Lodato for it.
>> http://marklodato.github.com/visual-git-guide/index-en.html
>
> Unfortunately manpages cannot really include images. =A0Well, there i=
s
> some kind of obscure graph description language for manpages ('dot' o=
r
> something like that), supposedly, IIRC...

The manpage for "git checkout" has some ASCII art of commit DAGs.
It's almost there...

>> [I've included git commands in a not-formal-enough notation at the e=
nd
>> of this email.]
>
> NEVERTHELESS some kind of semi-formal notation might be useful.

I'm glad you agree.  Do you think my not-formal-enough notation is a
good start or do you want to propose another notation to start from?

>> 3. Move the operations "checkout -- <file>" and "reset -- <file>" to
>> their own command names
>>
>> This is my biggest and most important suggestion.
>>
>> "checkout -- foo.txt" copies foo.txt from NEXT to WTREE. Similarly,
>> "reset -- foo.txt" will copy foo.txt from HEAD to NEXT.
>
> =A0"checkout HEAD -- foo.txt" copies foo.txt from HEAD to NEXT and WT=
REE
>
> =A0"checkout HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT and =
WTREE
> =A0"reset HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT
>
>> These are operations to designate/undesignate files in the next comm=
it
>> and should be grouped with others like them: "add", "rm" and "mv". (=
In
>> fact, the man page for "reset -- <file>" even says that it is the
>> opposite of "add"!)
>>
>> When these file-based operations are removed from "checkout" and
>> "reset", the purposes of those commands becomes clearer: "checkout"
>> changes HEAD to a new branch and "reset" moves the current branch
>> pointer to a different commit.=A0 These operations may share code wi=
th
>> the operations "checkout -- <file>" and "reset -- <file>", but they
>> serve different purposes from the user's perspective and the user
>> should have different names to refer to them.
>>
>> As for naming these new commands, the "yet-another-porcelain" rename=
s
>> "reset -- <file>" to "unadd", which I like very much.
>
> Well, that goes counter to reducing number of commands, but I quite
> like this name. =A0Though "unadd <revision> -- <file>" looks a bit
> strange...

I agree, that does look strange.  I think it would be the far less
frequent usage, but still strange.

>>=A0For the other, my best suggestion is "head-to-next", but I'm sure
>> someone can do better.
>
> I'd rather remember that "git checkout" is about checking out
> something to a working area.

Now that I've separated these two usages of "checkout" in my brain,
"git checkout <branch>" is all about changing to a different branch.
That files in the working tree change is just incidental to moving to
the new branch.

The manpage paragraph for "git checkout -- <file>" has in bold that
this usage "does not switch branches".  So, for me, it's a completely
different usage and should be a different command.

I wish I had a reasonable name to suggest for the new command.

>> 4. Deemphasize the "branch" command for creating branches.
>>
>> I assumed that the command "branch" was used for creating branches.
>> After all, that's how it is done in the "gittutorial(7)" man page.
>
> It _is_ used to create branches. =A0But perhaps we should update
> gittutorial(7) (and check users manual)...

Thank you.

>> However, after reviewing all the major commands, I find that it is t=
he
>> _last_ way I want to create a branch. It creates a new branch, but i=
t
>> doesn't switch HEAD to the new branch!
>
> "checkout -b" is just shortcut for "branch" + "checkout". =A0Very
> convenient one, that is...

Yes, it's my primary way of making a branch now.

>> The commands that should be emphasized are "checkout -b <name>",
>> "commit -b <name>", and "stash branch".=A0 These make sense in norma=
l
>> git usage. The "branch" command has its uses but it is not usually t=
he
>> way you want to create a branch.
> [...]
>
>> ----
>>
>> These are just some commands written in a not-quite-formal notation.
>> This notation doesn't handle a detached head, adding directories, th=
e
>> state after a conflicted "stash pop", etc.=A0 Still, as it is, I thi=
nk
>> it's very informative to users for getting the gist of what command
>> does.
>>
>> "add foo.txt"
>> =A0=A0 NEXT:foo.txt =3D WTREE:foo.txt
>
> What about "add --intent-to-add foo.txt"? =A0What about "add <directo=
ry>"?
> What about resolving merge conflicts?

Good points.  These are all interesting cases that a fully developed
formal notation should make sure to address.

>> "rm foo.txt"
>> =A0=A0 delete(NEXT:foo.txt)
>> =A0=A0 delete(WTREE:foo.txt)
>> "rm --cached foo.txt"
>> =A0=A0 delete(NEXT:foo.txt)
>> "/bin/rm foo.txt"
>> =A0=A0 delete(WTREE:foo.txt)
>
> O.K. =A0Note however that "git rm foo.txt" on conflicted entry would
> clean up conflict.

Yes.  "git add foo.txt" is also used to resolve conflicts.

>> "mv foo.txt bar.txt"
>> =A0=A0 WTREE:bar.txt =3D WTREE:foo.txt
>> =A0=A0 NEXT.bar.txt =3D WTREE:foo.txt
>> =A0=A0 delete(WTREE:foo.txt)
>> =A0=A0 delete(NEXT:foo.txt)
>
> O.K., but what is important are atomicity and safety checks.

I think it's best to assume every operation is done atomically.
(Right?)   I'm not sure how to denote safety checks or prerequisites.

>> "checkout -- foo.txt"
>> =A0=A0 WTREE:foo.txt =3D NEXT:foo.txt
>> "reset -- foo.txt"
>> =A0=A0 NEXT:foo.txt =3D HEAD:foo.txt
>
> Those are not the only modes.
>
>> "commit"
>> =A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
>> =A0=A0 NEXT =3D HEAD
>
> =A0 HEAD + (NEXT-HEAD) =3D=3D NEXT
>
> "git commit" doesn't apply patches.

Agreed.  I addressed this above.

>> "commit --amend"
>> =A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
>> =A0=A0 NEXT =3D HEAD
>
> =A0HEAD^ + (NEXT-HEAD^) =3D=3D NEXT
>
> "git commit --amend" works correctly even if HEAD is a merge commit!

Another good issue.  A formal notation will need to specify how to
deal with cases of a commit with more than one predecessor.

>> "checkout FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)
>
> No such requirement. =A0It's all about which files differ between HEA=
D
> and FOO. =A0If you start working on some file, and decide that you
> should have made the change on different branch, "git checkout FOO"
> allow to move to FOO branch... assuming that changed file has the sam=
e
> contents in HEAD and in FOO.

Okay.  I will have to think about how a formal notation can denote that=
=2E..

> End there is "checkout -f" and "checkout -m".
>
>> =A0=A0 WTREE =3D FOO
>> =A0=A0 NEXT =3D FOO
>> =A0=A0 HEAD ::=3D FOO // changes the alias of HEAD to refer to FOO
>
> And this is supposed to be easier to understand?

"checkout" is a very simple command to describe in English, so the
mathematical description will be more convoluted.  I don't (yet)
understand some of the variants of "git reset" even though they are
written in English.  I'm hoping a formal notation will make them
easier to understand.

>> "stash save"
>> =A0=A0 STASH =3D new(new(HEAD+(NEXT-HEAD))+WTREE-NEXT)
>> =A0=A0 NEXT =3D HEAD
>> =A0=A0 WTREE =3D HEAD
>> =A0=A0 push(STASH)
>> "stash pop"
>> =A0=A0 STASH =3D pop()
>> =A0=A0 WTREE =3D HEAD + (STASH-STASH^^)
>> =A0=A0 NEXT =3D HEAD + (STASH^-STASH^^)
>
> ???

"stash save" makes two new consecutive commits: one equal to NEXT and
another equal to WTREE.  (This is "STASH" above, with my
unoptimizations.)  I don't know where the SHA of the final commit gets
stored, so I just created push() and pop() commands.

Rereading the man page, the commit containing WTREE has two parents.
This notation doesn't have a way to denote that.

> [...]
>> "cherry-pick FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)
>> =A0=A0 HEAD =3D new(HEAD + (FOO - FOO^))
>> =A0=A0 NEXT =3D HEAD
>> =A0=A0 WTREE =3D HEAD
>> "rebase FOO" is basically a iterated application of "cherry-pick"
>
> Ordinary rebase isn't.
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>

Jakub, thanks again for taking the time to respond.
