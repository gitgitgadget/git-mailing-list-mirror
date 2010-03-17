From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Tue, 16 Mar 2010 22:21:50 -0700
Message-ID: <7vfx3zjzf5.fsf@alter.siamese.dyndns.org>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com>
 <7v634v27vf.fsf@alter.siamese.dyndns.org>
 <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 06:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrlhz-0003rK-3u
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 06:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab0CQFV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 01:21:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab0CQFV7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 01:21:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF98A2957;
	Wed, 17 Mar 2010 01:21:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jC6VNOW6cWwa
	d9ht7eD3Jd8T7uE=; b=vF+ctX7dDYTy2EDbE9l3GUY99OoO8jQyuFfC01U/GO+I
	6d2GzDI/mLKWDeZ6Ep49JMeH5kYOWLyRyInX5SwwvZcX3vY03XOBGK8PDjDEEuWO
	dJ6M4dTiCW8L5LsYy1EmUUR4LkpDnAEWkuRLzx7SpK9pFHPW2BcQ5ZxBsd2mT4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IE11Hr
	6n1uQtxQ/uTy2/ECTvzmrUaSxJIr7POQF0TSrxvj9B8lXmnd0LAa5OaXY9DXjHvd
	qfKwBAbN2+Urcmd+gOruY+dpG6cMNpmb2okpodSCHJbVXMj25GeJvxvEixG4wN8R
	Bnof0XJhISN0lKWnWoN0CgcZW8eBPveZ4rzk0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EC66A2953;
	Wed, 17 Mar 2010 01:21:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8432A2950; Wed, 17 Mar
 2010 01:21:51 -0400 (EDT)
In-Reply-To: <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
 (Erick Mattos's message of "Tue\, 16 Mar 2010 22\:10\:14 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00155CA6-3185-11DF-87CA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142364>

Erick Mattos <erick.mattos@gmail.com> writes:

> I am just trying to make you satisfied so gitsters, I mean git users,
> will have this feature as soon as possible.

Don't try to satisfy _me_ personally.  It is not likely that I am going=
 to
use "checkout --orphan" myself.  But I would not reject a new feature t=
hat
does make sense to some people, even if it is not something I would use=
=2E
I am here to help people like you help others (and to prevent people fr=
om
harming others).

I however am going to have to answer when people complain "why was this
senseless new feature added to the system?  what it does makes no sense
and does not help me."

"Nuke index but not working tree" is not something I think I can defend
and explain as sensible to these people, as I do not think it makes sen=
se
myself.  So when Ispot a design that logically does not make sense to m=
e,
I would say so and ask clarifications.  A major part of the maintainer'=
s
job is to ask questions and say "no".

> I do prefer my first design mainly because it mimics the state of an
> initial commit.  I think that is subjectively better.

You keep saying that, but I think it is misguided.  And I do not think
there is anything subjective there.

If you are starting from scratch, you would:

    $ git init newrepo
    $ cd newrepo

and that is how the state before the initial commit begins with.  You
might then do this to prepare for the commit:

    $ tar xf ~/junk/frotz-2.43.tar.gz
    $ git add .

Or perhaps you would work the other way around:

    $ tar xf ~/junk/frotz-2.43.tar.gz
    $ cd frotz-2.43
    $ git init
    $ git add .

Whichever way you work, notice that you wouldn't have any rubbish in th=
e
working tree unrelated to the "frotz" project, when the tool (in this
case, "git init") prepares the repository with a dangling HEAD and the
working tree "before the initial commit".  You either have emptiness (t=
o
which you can untar into), or you already have files that you would wan=
t
to have in the branch and no other cruft.

If you did "nuke index, leaving files in the work tree around", the res=
ult
does not resemble "state before the initial commit" at all.  The leftov=
er
files will get in the way.

The leftover worktree files will not get in the way ONLY if the user wa=
nts
to record a tree that is similar to the original branch, but even in th=
at
case they have to do "git add ."; keeping the index intact would help t=
hem
even better.

After realizing all that, do you still think "nuke only the index" is
subjectively better?

> I did it!

Sure, I am saying that then you should advertise the result as such,
without being negative.

>> Better yet, try to advertise what you are giving your users in a pos=
itive
>> way, instead of in a way that only scares users, perhaps like this:
>>
>> =C2=A0 =C2=A0After 'checkout --orphan', your HEAD will point at an u=
nborn branch,
>> =C2=A0 =C2=A0and the next commit will start a new history without an=
y prior commit.
>> =C2=A0 =C2=A0To help create such a new history that has contents mos=
tly the same as
>> =C2=A0 =C2=A0that of the original branch, the command does not touch=
 the index nor
>> =C2=A0 =C2=A0the working tree, and "checkout --orphan" immediately f=
ollowed by
>> =C2=A0 =C2=A0"commit -a" would record a tree very similar to what yo=
u had in the
>> =C2=A0 =C2=A0original branch. =C2=A0This is useful when you want to =
=2E.. [insert a
>> =C2=A0 =C2=A0summary of "going open source" example from my previous=
 message if you
>> =C2=A0 =C2=A0want here].
>>
>> =C2=A0 =C2=A0If on the other hand you want to start a new branch who=
se contents do
>> =C2=A0 =C2=A0not resemble the original branch at all, you may want t=
o start from an
>> =C2=A0 =C2=A0empty index and the working tree, with "git rm -rf ." i=
mmediately
>> =C2=A0 =C2=A0after running this command.
>>
>> The same comment applies to the documentation part.
>
> I was trying to be concise on my message.  I realize you want it more=
 explained.

Concise is good.  Negative is not.

> After the 'checkout -o -b' you are in an new unborn branch ready to b=
e
> committed.  The next commit will start a new history without any
> ancestry.  If this new branch was made to start from scratch, not
> resembling the previous one, then you should use 'git rm -rf' to get
> an empty work tree and index.  Otherwise with a 'git commit -a' you
> will have a tree exactly as in the previous branch.  So just set
> things as you want it to be and commit the new unparented branch.

I wouldn't start the description with

    if you want 'no common paths', then it would be more cumbersome tha=
n
    just this single command

if the primary workflow your chose to support with your implementation =
is
'mostly common paths'.

Look at the example I gave you more carefully.  The primary use case we
intend to support is described first.  Also it is written in much more
inviting tone, in order to help readers understand the motivation behin=
d
the feature.  IOW, "Ah, that is something I may want to do in some case=
s,
and the new feature indeed sounds useful." is what we want to hear from
the readers (the log message for reviewers, and the documentation for t=
he
end users) after they read the explanation.  The second paragraph then
mentions the less common use case for completeness.  To the readers who
understand why the behaviour of the command makes sense for its primary
use case (which is described first), it would be easier to accept that
they have to run an extra command (by the way, it is "'git rm -rf .' fr=
om
the top-level of the working tree; do not forget the dot at the end) to
clean up the working tree to a prestine state, because they would
understand the reason why the clearing is not done by default.

The same comment applies to the documentation part of the patch.  Don't=
 be
negative.  Positively explain why what you added is useful, and help th=
e
users understand why they might want to use it and in what situation.
