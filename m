From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sun, 14 Mar 2010 17:46:35 -0300
Message-ID: <55bacdd31003141346t408c276ak507b7c289cf17679@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org> <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com> 
	<7v8w9whd3g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 21:47:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NquiE-0007Pv-Eu
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 21:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233Ab0CNUq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 16:46:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44047 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757483Ab0CNUq5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 16:46:57 -0400
Received: by gyg8 with SMTP id 8so1096809gyg.19
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=K4I0c41qMQ918Da5cE06eU7LR0AO0mUcxujxn3edJQE=;
        b=S9QaFsJzKDGRyJIzt4xeyTq328xymJmA2pwQsPTK+H05HEM34MEF+puxKDWRrNjOPE
         qPQUT9Oy6XQcmNSR4Vl04/IKEnMtUJtML58Q+9o9K0LmL5FI3ssK7W7DaquVrm4r7rCD
         wnlRg3Hppo6M7PCvNSmKnK7rarcNCD+RIjybI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TDwvQRy/VKpg+HeubphlCgoWIjDo0gjQ9p1c1+9QiEpfLu+pZqXScesI/la+uwM/1l
         ZBtT2yIhFc0zq9YkeRHch1LwBo2JihP3QZrFjXjhizPEFimaNXCy1dRc5EUIxD3d8PgV
         vakdLqx7F2DeVXE/BFHv8q7iyZck52edrkMDQ=
Received: by 10.101.155.38 with SMTP id h38mr2861250ano.131.1268599615076; 
	Sun, 14 Mar 2010 13:46:55 -0700 (PDT)
In-Reply-To: <7v8w9whd3g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142154>

Hi,

Sorry for writing much again in reply.

2010/3/13 Junio C Hamano <gitster@pobox.com>:
> I was referring to this from the latest version:
>
> =C2=A0 =C2=A0Sometimes it is necessary to start up a new development =
branch of code
> =C2=A0 =C2=A0intended to be merged in the near future to existing bra=
nches but which
> =C2=A0 =C2=A0actually does not relate to them.

That is one from some reasons to start a new empty, unparented,
unrelated, without ancestry branch.  An example which is not
considered good enough by your opinion.

I am not trying because I don't feel myself good enough to convince
you of anything.  But I will try to give you more examples at the end
of this reply.

To be more general the text could be:

Sometimes it is interesting to start an new unparented branch for new c=
ode.

> Let's give you an example of the depth of thought and clarity of
> description of the workflow I am expecting from anybody who claims "t=
his
> is a useful feature to help _some_ workflows" by taking an example fr=
om
> git.git, because it is one project that both of us are familiar with =
and
> there is a readily available example in it. =C2=A0It has disjoint mer=
ges from
> gitk, gitweb and git-gui. =C2=A0The history up to such a merge 5569bf=
9 (Do a
> cross-project merge of Paul Mackerras' gitk visualizer, 2005-06-22) l=
ooks
> like this:
>
> =C2=A0A---o---?---o---o---X---* linus
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B---o---o---Y gitk
>
> Note that with this merge '*', two histories merged did not share any
> paths at commit X and Y.
>
> Did you have this kind of "no common paths" merge in mind when you wr=
ote
> the proposed commit log message? =C2=A0IOW, if we pretend that Paul s=
tarted his
> gitk work and he "intended to be merged to Linus's branch but which d=
oes
> not relate to it", would that be a good example of what you are tryin=
g to
> achieve?

I am not trying to achieve anything.  I am already doing what I want
myself.  I am just trying to let people achieve what they want without
a hack.

I think you haven't checked those, so PLEASE:

Git SCM Wiki:
http://git.wiki.kernel.org/index.php/GitTips#How_to_create_a_new_branch=
_that_has_no_ancestor

Git Book:
http://book.git-scm.com/5_creating_new_empty_branches.html

Anyway your example is a good one if you are the one which controls
the branch flows and know you will be doing the merge eventually.  It
fits then on my explained case.

> =C2=A0 =C2=A0Side note: The other two "disjoint" merges we have are a=
lso this kind
> =C2=A0 =C2=A0of "no common paths" merge. =C2=A0Nobody who was involve=
d in the branches
> =C2=A0 =C2=A0that resulted in them prepared his branch with --orphan,=
 by the way.
> =C2=A0 =C2=A0They started out in independent repositories, because th=
ey were by
> =C2=A0 =C2=A0definition independent projects and these were "cross pr=
oject merges",
> =C2=A0 =C2=A0as Linus put it.

They were not foreseeing the future but and if they were the only
developer and could project what they would need?

> I'd grant you that we could say that these histories did not start in=
 the
> same repository using "checkout --orphan" because it was not availabl=
e.

That's it!

> Did you have this kind of "mostly common paths" merge in mind when yo=
u
> wrote the proposed commit log message? =C2=A0IOW, if "checkout --orph=
an" were
> available to Paul, would you have recommended him to use it, add his =
gitk
> script to the tree, and start his history at commit B which he starte=
d
> from commit '?' from Linus's history? =C2=A0But you are again nuking =
the index
> so Paul would have had to add the files back with "git add", while be=
ing
> careful not to add untracked files, or run "git read-tree ?" to popul=
ate
> the index back to the original state.

He would use it easily.  No difficulty at all.

I think the problem here is a matter of opinion: you think removal
should be automatically followed.  Like 'git checkout -ob NEW_BRANCH'
followed by 'git clean -df'.

I don't.  I think the user can do it or not by himself.

I am not trying to convince you.  You rule.

>> I am not wiping the tree by default because I am not deciding for
>> people if they are going to use anything from it as a template (even
>> the directory structure only).
>>
>> I am not trying to make decisions for the user. =C2=A0I think he wou=
ld be
>> capable of deciding it himself. =C2=A0That is my way of thinking so =
I
>> normally prefer to advice, alert, inform not to impose.
>
> You may think that you are supporting both, but in reality, you are
> supporting neither by making both cases equally inconvenient. =C2=A0T=
he only
> thing you are gaining is a way to weasel out of issues experienced by=
 the
> users by saying "I didn't remove anything from the working tree, so i=
f you
> want to add them, you can, it is up to you", while ignoring the issue=
 that
> (1) if the user wants "no common paths", cleaning working tree become=
s
> cumbersome and error prone, and (2) if the user wants "mostly common
> paths", adding back to the index becomes cumbersome and error prone.

Really?
(1) git clean -df
(2) git add WHATEVER

It does not look cumbersome or error prone to me. :-1

> As I already said, I do not think "mostly common paths" case should b=
e
> encouraged to begin with. =C2=A0As far as I know (and you can guess b=
y now that
> I know reasonably well about git), you do not gain anything by not ha=
ving
> the ancestry link between '?' and 'B', except that it would make conf=
lict
> resolution at '*' extremely difficult. =C2=A0There is only downside w=
ithout any
> upside in "mostly common paths" disjoint merge.

I do not have to guess: you are the man.  I know you know everything ab=
out git.

=46irst of all, I do respect you a lot.  Not only by all your knowledge=
,
or your commitment, or by Git's creator confidence upon you.

But more than all because of the hard work you have been giving to
this project.  Time and effort are very rare commodities to be wasted
these days.

The problem here is not what you know.  It is not about you.  It is
about what Git should become to ease user's life. It is to pay
attention to common as well as to uncommon needs.

The first reason for Git was to be the Linux kernel SCM.  That was
already achieved perfectly.
Git should freeze then?

Being good is not a reason for not becoming better.  I am trying to
make it better by filling a gap.  I have started my contributions by
filling needs I had which were not fulfilled.

We are not encouraging anything.  We are just letting people do what
they want to.  Having an empty new branch to start with is something
some people want to do.  Please do the google search I told you
before: "new empty branch git".

And finally, remember, merge will be easy because unparented branch is
mainly for unrelated work.  User will solve problems if he wants any
exotic stuff.

> That leaves only the "almost no common paths" case. =C2=A0As we have =
already
> seen in git project, the end result is indeed very useful. =C2=A0It u=
sed to be
> that people had to download and use gitk independently before Linus's
> cross project merge, but after the merge, the project gives the core =
git
> and gitk comes with it. =C2=A0So you could argue that "checkout --orp=
han" would
> become useful if you adjusted the code like I suggested in my review
> comments (run an equivalent of "git rm" without "-f" from the top-lev=
el
> and make the HEAD dangling to the new branch, only if the "git rm" st=
ep
> succeeds), and document clearly that is the intended workflow for the=
 new
> feature to support.

The end result will be very helpful indeed.

You are thinking as a maintainer of a huge project with a lot of
merging.  This new function is indeed not very useful to you.  But it
is to people running different work flows.  Most of all when they are
running small projects and when they have full control of the
repository without a lot of clones widespread.

> Now, do not take the above as a personal criticism. =C2=A0The only th=
ing the
> above discussion may be showing could be that your description was no=
t
> clear enough to tell me that the workflow you had in mind to support =
was a
> third one, different from the above two, and that your implementation=
 may
> support that untold workflow very well. =C2=A0Take the above as an il=
lustration
> of how you present the workflow your new feature intends to support, =
and
> how you choose your design and implementation to support that workflo=
w
> well.

I am not taking anything personally.  I already know your way of workin=
g.

But I have descripted what I wanted to.  When I showed the
debianization case to picture it, that was something I did.  Even
though you don't think is a good way to do it.

This new function satisfies a lot of needs because an empty new branch
is needed some times and the way to get it nowadays is too unnatural.

That is why you could figure out some uses yourself even with exception=
s.

> So let's hear it. =C2=A0Until we clear the design issues, there is no=
t much
> point in talking about coding styles and implementation.

As I see what you need is some examples of how useful this new option
will be.  I am going to show some but take in account that I am
inventing those.  Trying to conceive uses which you would think is
useful.  And that I know I would probably fail.

I know what for I had hacked to create orphan branches myself.  But
those personal experiences will not be good examples to you.

But I can foresee there will be a lot of uses even if I can not
conceive them all right now.

All said, now let's exemplify, starting with the cases I told you in
my last email:

* Do some parallel development:
Recreating the wheel: unix shell softwares.
  $ vim grep.c, ...
  $ git add .
  $ git commit -m grep
  $ git checkout -ob sed
  $ vim sed.c, ...
  $ git add .
  $ git commit -m sed
=2E..

* Working under unrelated parts before merging the start point of the
new software.
- You start with branch A with sources to draw math functions.
- Then you start orphan B with sources to calculate math curves, their
areas, ...
- Later you organize them and merge the start point of the new software=
=2E
- Now you are ready to publish and to call for community help.
  $ vim draw.c, ...
  $ git add .
  $ git commit -m 'Drawing implementation'
  $ git checkout -ob math
  $ vim math.c, ...
  $ git add .
  $ git commit -m 'Complicated Math implementation'
=2E..

* Recreate history.  It is not published yet so it is not being widely
cloned and people just want to have a good repository before
publishing;
You start A--B--C--D then you realize that A and B is not necessary
and that you should have started directly by C.
  $ git checkout C
  $ git checkout -ob GOOD
  $ git add .
  $ git commit -C C --reset-author
  $ git cherry-pick D
  $ git branch -D OLD_BRANCH

* Adding files which is not meant to be part of anything in a temporary=
 fashion;
Adding notes to yourself.
  $ git checkout -ob notes
  $ git clean -df
  $ vim note
  $ git add .
  $ git commit -m Notes

* Have different approaches starting different sources from those
software versions until you
 find out the best one.
You are going to start a software which you don't know if a good
algorithm would be to do some factorial by recursion or not.
  $ vim recursive.c
  $ git add .
  $ git commit -m recursive
  $ git checkout -ob normal
  $ vim straight.c
  $ git add .
  $ git commit -m normal

This email is being made in chronological order.  I know you have
already sent another one but I have chosen to reply this one before
seeing the new one.  I will reply that one after sending this so
please forgive me if I am talking about something you later
reconsidered.

To finish this email I am going to make a 'cheat sheet' to show the
new functionality:

Branch_A
|
You realize that you need a new empty branch.
|
Is the work tree clean?
|                          |
Yes                     No
|                          |
git clean -ob Branch_B -------Undo?-------Was the work tree clean befor=
e?
|
|         |
|                                                                     Y=
es    No
|
|         |
|
|         git add .
|
|         git commit -m temp
|
|         |
|
+--------+ git checkout Branch_A -f
|
         |
|
         git merge --squash Branch_B
Do you want to use anything from the work tree?          |
|                         |
         git reset
Yes                    No
    git branch -D Branch_B
|                         |
|                         git clean -df
|                         |
Change the work tree the way you want it to be.
|
git add .
git commit
|
That is it!

Thank you very much for the patience to get till here.  I know it is
hard reading much but I realize that all this subject have to be well
explained otherwise I will be repeating the same in a series of
emails.  I have already did repeat on this one.  ;-)

I hope all this effort will be worth-full.  Thanks again for your time!

Regards
