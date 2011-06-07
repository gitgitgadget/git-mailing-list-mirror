From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 6 Jun 2011 22:31:07 -0400
Message-ID: <BANLkTinE8tCRZ-HFP0uwm6odGNAxjZPXng@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DEC8322.6040200@drmicha.warpmail.net>
	<7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
	<4DECE147.3060808@drmicha.warpmail.net>
	<7vd3ir9btd.fsf@alter.siamese.dyndns.org>
	<BANLkTi=KZN3g4s9jHSgYcPHA4eM+2U3g4w@mail.gmail.com>
	<7vr576943r.fsf@alter.siamese.dyndns.org>
	<BANLkTi=yytzDrJLvVn_ZhJOiQs-rqvKi1w@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 04:31:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTm4h-0004gi-7J
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 04:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880Ab1FGCbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 22:31:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36025 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab1FGCbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 22:31:09 -0400
Received: by bwz15 with SMTP id 15so3803368bwz.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 19:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=iX83l68vIkXVmZMDYakyHAOZXnQzbo/Hi4Da0WayxY8=;
        b=p+XnIgLxSx8G7lH2SeB4QiusYcIqBJTDZ1r1Q3937on+8O/WxPA243zMqpG5RFmmyG
         0Nk3TG4o3ocO6Kmt4zY/D7spRQO7kMrq7KDb8uEd2d0bU9eCGPYD+7sGzDBcXRR0m0Da
         hQDU4x+eveqy8DdOCDW30wDqmUvbmWiDO/Lqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=NoQFDnbToTnrUqmcyb0jm1jwqqVLYyNCej7Yys2M6wJHfDDRPqweBU5moaU3e7QjLa
         YDGn6TvtBHNP5fLQOfdPzMN1h/Gw1QgzQnU1hAcJn51l7UoWD8jIzqvOiI/J9cYGlWp6
         qmNIP5rGQ3puJhdNLAXz26fimK3BsXwuRjey8=
Received: by 10.204.171.66 with SMTP id g2mr56474bkz.7.1307413867889; Mon, 06
 Jun 2011 19:31:07 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Mon, 6 Jun 2011 19:31:07 -0700 (PDT)
In-Reply-To: <BANLkTi=yytzDrJLvVn_ZhJOiQs-rqvKi1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175181>

I think NEXT and WTREE should be like tree objects, not commits, so I
would argue that "git show NEXT" should show what it shows for a tree.
 From the man page:

"For trees, it shows the names (equivalent to git ls-tree with --name-o=
nly)."


"git diff HEAD NEXT" during a merge conflict: During the merge
conflict there are two groups of changing files.=A0 Some files have bee=
n
resolved and reside in "Stage0".=A0 The others have not been resolved
and a copy resides in each of "Stage1", 2, and 3.=A0 (Which I eagerly
want to name BASE, HEAD, and MERGE_HEAD.)

My thought is that NEXT should only represent those changing files
that have been resolved.=A0 So, NEXT would be HEAD plus the files in
Stage0.=A0 So, "git diff HEAD NEXT" would print out the changes in
Stage0.

The trickier question for me is what does this make "git diff WTREE
NEXT"?=A0 Well, the resolved changes are the same in WTREE and NEXT.
The unresolved files in NEXT are the same as in HEAD.=A0 So, "git diff
WTREE NEXT" would print out the unresolved changes between WTREE and
HEAD.

What I don't like about that is that at the point of conflict in each
file, "git merge" has written the changes from HEAD and MERGE_HEAD.
So, printing the changes between HEAD and WTREE will resulting in the
changes done by HEAD printed twice.=A0 That, while understandable, isn'=
t
so pretty.


I've engineered a conflicted merge and taken a look at what "git diff
--cached HEAD" and "git diff --cached" looks like.=A0 Can someone
confirm that the current behavior is equivalent to what I described
above?


Junio asked: So what should it look like during a "pull" that did not f=
inish?

Is this the same as a conflicted merge state?=A0 (Except possibly with
=46ETCH_HEAD instead of MERGE_HEAD.)


Junio asked: "rebase -i"?

I know what this does (and love it!), but not how it works.=A0 I
certainly don't know the state it leaves things in when it's
conflicted.=A0 I'll let someone else go to bat here.


Teach a noob: What's "rc phase"?


Mike



On Mon, Jun 6, 2011 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> Scott Chacon <schacon@gmail.com> writes:
>
> > On Mon, Jun 6, 2011 at 9:14 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
> > ...
> >>>> That is why I asked what the user experience of "git show NEXT" =
as opposed
> >>>> to "git show INDEX" should look like. So what should it look lik=
e during a
> >>>> "pull" that did not finish?
> >>>
> >>> If NEXT is to mean the result of a commit in the current state, a=
nd the
> >>> current state would or should not allow a commit, then trying to =
access
> >>> that pseudo-commit should error out with a helpful message.
> >>
> >> What "helpful message"? I asked for the user experience, not handw=
aving.
> >>
> >> Do you mean to say that the error message would teach the user tha=
t the
> >> current state is not something you can create a commit? What messa=
ge would
> >> that give the end user? =A0I am hoping the following is not what w=
ill happen:
> >>
> >> =A0Q. I tried "git show NEXT" because I wanted to see what the nex=
t commit
> >> =A0 =A0 would look like, but I got an error, saying NEXT is not kn=
own as I
> >> =A0 =A0 haven't resolved a conflict.
> >>
> >> =A0A. Yes, the message is correct.
> >
> > I'm not sure why this wouldn't just list out the index tree,...
>
> You are not entitled to say "I'm not sure" ;-). I asked you to show a
> design of the user experience of "git show NEXT", as an advocate for =
the
> NEXT/WTREE notation.
>
> I'd take it that you would "just list out the index tree" as the outl=
ine
> of the user experience.
>
> >> =A0A. You would say "git diff HEAD NEXT".
> >>
> >> =A0Q. Ah, that is the same as I always do before making a commit t=
o see what
> >> =A0 =A0 I have added so far look sane. Thanks.
> >
> > Why would this look sane? I would think this would say "* Unmerged
> > path <file>" just like 'diff --cached would do.
>
> Either you read it too hastily or I didn't write this clear enough; "=
sane"
> does not refer to the command. In this story, the novice is saying "B=
efore
> I make a commit, I check if my changes so far matches what I wanted t=
o
> achieve, in other words, I check the sanity of my changes. And 'git d=
iff
> HEAD NEXT' is the command I use when I am not in this weird 'conflict=
ed'
> state. I am happy that I can use the same command".
>
> > But, yes, I assume there would be some difficulty in supporting it
> > everywhere.
>
> I don't care too much about "difficulty in uniformly implementing". I=
 am
> doubting that you can _design_ uniformly for these new tokens to make
> enough sense to help the new people. That is why I've been asking for
> concrete examples of user experience design, sample transcripts, that
> covers known corner cases.
>
> If NEXT/WTREE advocates cannot come up with one, or if that is just t=
o
> punt and say "NEXT is not defined in this case---use the traditional
> command" in the error message, I don't see much point in discussing t=
his
> further. It will end up with the same whine-fest as previous rounds.
>
