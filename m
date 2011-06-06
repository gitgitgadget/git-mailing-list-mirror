From: Scott Chacon <schacon@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 6 Jun 2011 10:42:47 -0700
Message-ID: <BANLkTi=KZN3g4s9jHSgYcPHA4eM+2U3g4w@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 19:42:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTdpG-0001IL-5T
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 19:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab1FFRms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 13:42:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42283 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618Ab1FFRms convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 13:42:48 -0400
Received: by gyd10 with SMTP id 10so1555712gyd.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+wn5iFUgXVCj1j+8jds66YXvgvCZsgO/ieI6ey9Kulg=;
        b=NiIALdZDzY8KNzv9MQ6VVsfS67GJfVVr+/Sq5Vss6OiWN6gytFZu75nwVC2mYN5cXq
         XioYSQfoNHTx02GEj/62iLRhow8bdfB+d09FwvhBOe0rTdg7mNnhAVaEzL4lDPgdSMQ9
         jLchHgmKbnBnchOBWhHHVWuglFSjnw3mChq2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BJrvsL+O5JDoE9O0chDnD0PxOVPlXoZrtWw6qoF0TbP5RNHYA+bqSaDKtyTPQfKUn+
         2l7UmFvgXjjiJ/Xp6+o1XYPlOkMHwV++XjJbpY3wbhV1gTfYYX0dLOXgS1yv/SpkdzAp
         8Eqfe8jbKHbl36YHiYAgrHGzTGY6CKHtxB2ks=
Received: by 10.236.173.40 with SMTP id u28mr5072083yhl.229.1307382167188;
 Mon, 06 Jun 2011 10:42:47 -0700 (PDT)
Received: by 10.236.36.1 with HTTP; Mon, 6 Jun 2011 10:42:47 -0700 (PDT)
In-Reply-To: <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175139>

Hey,

On Mon, Jun 6, 2011 at 9:14 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>>> That is why I asked what the user experience of "git show NEXT" as =
opposed
>>> to "git show INDEX" should look like. So what should it look like d=
uring a
>>> "pull" that did not finish?
>>
>> If NEXT is to mean the result of a commit in the current state, and =
the
>> current state would or should not allow a commit, then trying to acc=
ess
>> that pseudo-commit should error out with a helpful message.
>
> What "helpful message"? I asked for the user experience, not handwavi=
ng.
>
> Do you mean to say that the error message would teach the user that t=
he
> current state is not something you can create a commit? What message =
would
> that give the end user? =C2=A0I am hoping the following is not what w=
ill happen:
>
> =C2=A0Q. I tried "git show NEXT" because I wanted to see what the nex=
t commit
> =C2=A0 =C2=A0 would look like, but I got an error, saying NEXT is not=
 known as I
> =C2=A0 =C2=A0 haven't resolved a conflict.
>
> =C2=A0A. Yes, the message is correct.

I'm not sure why this wouldn't just list out the index tree, having
some message for entries that have more than one stage.  Like a
porcelain-ized version of 'git ls-files --stage', maybe in this case
with a warning at the bottom that a subsequent commit command will not
complete.  Even something similar to what would happen if you ran
'commit' right then:

  fatal: 'commit' will not be possible because you have unmerged files.

> =C2=A0Q. But then how can I see what the next commit would look like?
>
> =C2=A0A. You would say "git diff HEAD NEXT".
>
> =C2=A0Q. Ah, that is the same as I always do before making a commit t=
o see what
> =C2=A0 =C2=A0 I have added so far look sane. Thanks.

Why would this look sane? I would think this would say "* Unmerged
path <file>" just like 'diff --cached would do.

>
> =C2=A0 =C2=A0 ...after 2 minutes...
>
> =C2=A0Q. Sorry, it does not work. I get the same error, that says NEX=
T is not
> =C2=A0 =C2=A0 known yet.
>
> =C2=A0A. Ok, you would say "git diff HEAD" the old fashioned way. The=
 person
> =C2=A0 =C2=A0 who thought NEXT would be useful didn't think things th=
rough.

I think the point would be that "git diff HEAD WTREE" would give you
this same output and if you had the basic concept of these three
important areas of Git that you could be explicit about what you
wanted to see or compare rather than having to look up the specific
special case that will show you what you want. Consider these very
common scenarios from a new user perspective: you want to see what is
changed in your working tree but not added yet, you want to see what
is added but not committed, you want to see the sum total of all
changes since your last commit and you want to see what the index
currently looks like.

Here are the commands currently:

a) diff
b) diff --cached
c) diff HEAD
d) ls-files --stage

Here would be the commands with the proposed pseudo-trees.

a) diff NEXT WTREE
b) diff HEAD NEXT
c) diff HEAD WTREE
d) show NEXT

It seems to me to be more guessable and straightforward for new users.
 But, yes, I assume there would be some difficulty in supporting it
everywhere.

>
> =C2=A0Q. Now I am seeing a diff between the conflicted state and the =
previous
> =C2=A0 =C2=A0 commit, I think I can get to where I want to go from he=
re. Thanks.
>
>
>> Another option is to make NEXT/INDEX mean a tree (:0:). I have not
>> thought this through (and have not made a suggestion, accordingly) b=
ut I
>> do see a problem in the UI. (I don't think we need to change the
>> existing ui in that respect but can amend and improve it.)
>>
>> Anyway, it's rc phase :)
>
> Rc or not rc, just repeating a fuzzy and uncooked "idea" around phone=
y
> ref-looking names that will end up confusing the users, and selling t=
hat
> as if it is a logical conclusion to "we want to give an easier to
> understand UI", without presenting a solid user experience design tha=
t is
> convincing enough that the "idea" will reduce confusion will not get =
us
> anywhere, especially when it is sprinkled with ad hominem attack at m=
e.

I think I'm the only one that mentioned your name so I apologize if
you saw that as an attack.  I was not saying you are unreasonable in
not changing the UI all the time, or that you are unreasonable for not
liking the NEXT/WTREE - there are certainly cases I'm not considering.
(For example, I'm more concerned about things like 'git commit-tree
NEXT' or 'git rev-parse NEXT' if the index is in a weird state - it
obviously has to be special-cased and I would assume only usable at
the porcelain level, possibly only by 'diff', 'show' and 'grep'. It's
the implementation I'm mainly worried about, I feel that the UI would
be pretty straightforward in all these cases.)

Re: the ad-hominim stuff, I was simply remarking that the
'reset'/'checkout' debate has been had several times and there is
precedent for it being a non-starter.  I also see and understand the
argument from you and Linus about that, I just happen to disagree with
it. It was not meant to be an attack.

Scott
