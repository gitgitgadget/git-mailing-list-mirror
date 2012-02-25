From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Improving merge messages for 1.7.10 and making "pull" easier
Date: Sat, 25 Feb 2012 10:27:55 +0100
Message-ID: <CACBZZX7rejo-fXdLp9SNU=KpVs+1gk=ux=aEqJcN38B+pXi2tQ@mail.gmail.com>
References: <CACBZZX5UVq9k7jvSy3m+yMVj7_JbfLp8ugFWf2gGFdMz_8GPEA@mail.gmail.com>
 <7vy5rsyq9w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 10:28:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Dvw-0001dT-9J
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 10:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab2BYJ2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 04:28:22 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58438 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755438Ab2BYJ2S convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 04:28:18 -0500
Received: by lagu2 with SMTP id u2so3700799lag.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 01:28:16 -0800 (PST)
Received-SPF: pass (google.com: domain of avarab@gmail.com designates 10.112.85.199 as permitted sender) client-ip=10.112.85.199;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of avarab@gmail.com designates 10.112.85.199 as permitted sender) smtp.mail=avarab@gmail.com; dkim=pass header.i=avarab@gmail.com
Received: from mr.google.com ([10.112.85.199])
        by 10.112.85.199 with SMTP id j7mr2566716lbz.26.1330162096703 (num_hops = 1);
        Sat, 25 Feb 2012 01:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZMfzJ254lyPqazpdKKVvCuhPifRyLAfnPGiVDZMCNQ8=;
        b=wCFATUgckSOjYwYHMWyvYU6QcKnmlpAbZT97Nv3bpVpZ+OBLP/+KWE2Z/I2txNl9GD
         giLySGlis8kStRdZgWqEK7nBWYvsJcllWCvJTYKJldoweT3wt3cPtwKW1Q1munKvQVKo
         qdn8N46SwuT2xU8zgk3pZdXyfXFrl6bqefkO8=
Received: by 10.112.85.199 with SMTP id j7mr2120094lbz.26.1330162096598; Sat,
 25 Feb 2012 01:28:16 -0800 (PST)
Received: by 10.112.102.101 with HTTP; Sat, 25 Feb 2012 01:27:55 -0800 (PST)
In-Reply-To: <7vy5rsyq9w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191513>

On Fri, Feb 24, 2012 at 20:39, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Firstly (and as a more general thing) I think we should add a mentio=
n
>> of "git merge --abort" to the message, just saving an empty file is
>> not sufficient to fully clear the merge state:
>
> Makes sense, but the new message does not quite parse.
>
>>> "Lines starting with '#' will be ignored, and an empty message foll=
owed\n"
>>> "by 'git merge --abort' the merge.\n");
>
> Perhaps s/the merge/aborts &/ or something.

Yeah, it needs better wording.

>> Additionally, perhaps it would be a good idea to:
>>
>> =C2=A0* Detect if the user didn't run this explicitly but implicitly=
 from a
>> =C2=A0 =C2=A0"git pull". We could pass some env var along or another=
 option
>> =C2=A0 =C2=A0(e.g. --internal-from-porcelain=3Dpull) and add this:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0You've merged implicitly via a "git pull"=
, if you're just
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0updating some local work in progress to k=
eep up with upstream
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0you may want to use "git pull --rebase" i=
nstead (or set the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pull.rebase configuration variable) to re=
base instead of merge.
>
> Won't this message be given to _all_ users of "git pull", even to the=
 ones
> who already have decided correctly that "pull" is the right thing in =
their
> situation? =C2=A0With a new advice.* settings to squelch it, perhaps.

Yeah, I'm not sure it's a good idea to add it given that.

>> =C2=A0* Explicitly check if we're merging an updated upstream into t=
he
>> =C2=A0 =C2=A0work-in-progress topic,...
>
> It might be a worthy goal, but how would we detect it? =C2=A0A few ex=
amples
> that we shouldn't give an unhelpful advice with a false positive are
> merges into:
>
> =C2=A0- The 'master' branch used by people who use Git as an improved=
 CVS, when
> =C2=A0 they do an equivalent of 'cvs update'. =C2=A0Merging the updat=
ed 'master'
> =C2=A0 from the central repository into their 'master' that contains =
their
> =C2=A0 work that may or may not be ready to be pushed back is how the=
ir
> =C2=A0 project works. =C2=A0It is a norm for them to make such a merg=
e, even though
> =C2=A0 more experienced people may prefer to see the history of their=
 project
> =C2=A0 kept cleaner by suggesting their project participants to use t=
heir own
> =C2=A0 topic branches.
>
> =C2=A0- Integration branches like my 'next', when it gets a merge fro=
m
> =C2=A0 'master'. This is "merging an updated upstream" but is done in=
 order to
> =C2=A0 keep the promise that 'next' would contain everything in 'mast=
er'.
>
> And what alternative would we offer? =C2=A0If we were to suggest "reb=
ase", we
> would also need to consider the topic of the other a-couple-of-days-o=
ld
> thread to detect which part of history is no longer subject to rewrit=
e.
>
>> I work with a lot of inexperienced git users and a lot of them are
>> going to be very confused by this change. I still think it's a good
>> change to make, but we could do a lot more to mitigate the inevitabl=
e
>> confusion.
>
> What exact change are you talking about with "this change"? =C2=A0Ear=
lier you
> had a chance to edit the merge log only when it needed your help reso=
lving
> (hence you did a separate "git commit" to record it) but you had to "=
git
> commit --amend" (or start with "git merge --no-commit") to edit the m=
erge
> log if it did not need any help resolving conflicts, but now you do n=
ot
> have to. =C2=A0Is that the change you have in mind?

Yes, or more explicitly if you do:

  git commit
  <your upstream moves forward>
  git pull

You'll now be presented with an editor asking you to enter a merge
message, whereas before it just silently created a merge commit.

> I would like to know how that would lead to an "inevitable confusion"=
=2E
> Admittedly, the original without any "# Please do X" comment, the use=
r may
> wonder what is being asked of him when he sees the editor for the fir=
st
> time, but I thought Thomas's patch took care of that issue.

I mean that people who use this babytalk subset of git and have been
doing so for months/years without having editor dialogs pop up every
time they pull are going to be confused when that suddenly starts
happening.

>> One thing that would help these users in particular would be to have
>> some easy to use replacement for their frequent use of "git
>> pull".
>
> After this part, I think you shifted into a different topic.
>
> I have mixed feelings about "rebase your unpublished work and keep it
> always a descendant of the upstream" workflow you seem to be advocati=
ng.
> It _might_ deserve a bit more visibility, but I do not think rewordin=
g
> this message done during "merge" is the place to do so.

Yeah, agreed.

>> They don't often commit their work (because of git inexperience) so
>> rebasing will error out because the tree is unclean.
>
> That is a *good* thing, isn't it? =C2=A0There lies the perfect opport=
unity for
> them to train their fingers to commit first and then rebase.

That's true, anyway I'll submit an improved patch for adding --abort
to the current message. I think the other suggestions either aren't
doable or weren't appropriate.
