From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Tue, 16 Mar 2010 22:10:14 -0300
Message-ID: <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com> 
	<7v634v27vf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 02:15:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrhrN-0002os-2A
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 02:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163Ab0CQBPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 21:15:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49661 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab0CQBPi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 21:15:38 -0400
Received: by gwaa12 with SMTP id a12so100611gwa.19
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NEDJeDPfLwzff+FCvWQT6+ljVgD3NFAv2eFgXNZ6P0Y=;
        b=OqSoKdmC93uXBaIkjApgxvS+2NQ8IqyZymXEBGywqJYS1h/RoJfsTru58u54iWSMXc
         oDTtchirWBbUTZgaAOVQWnxhDDy4UREZvXtqO5WKmylpvl1/9vS8wFKK2ARD6LZ8kjRg
         pK+i8aCu1Tq60cpEefyCk/jxx005aTglRmCZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ocKsobTH9jjxYAQwStkICc88dutE4h1nytViF+Q6A1gIUfGruDN7FG74rqVwBcxGqF
         uKBKaLeTXAEJ/WBuJb3LKiuKbdnn+LWdGJbBYR2jA2LnuRGkhsp5TN54a/GwLSDRt9Yu
         ID0/Dza9W8lVmzFdVArBE5jnco+RqGxDI3x2o=
Received: by 10.150.63.4 with SMTP id l4mr136875yba.611.1268788234085; Tue, 16 
	Mar 2010 18:10:34 -0700 (PDT)
In-Reply-To: <7v634v27vf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142362>

Hi,

Junio, you are the leader.  And I really don't want to bother you with
my opinions.

I am just trying to make you satisfied so gitsters, I mean git users,
will have this feature as soon as possible.

2010/3/16 Junio C Hamano <gitster@pobox.com>:
>> After the 'checkout -o -b' the new branch is not saved until committ=
ed.
>> Before committing you should 'git rm -rf' anything which is not goin=
g to
>> take part in the new branch and change the work tree and index the w=
ay
>> you want it to be since they remain untouched as before checkout
>> command.
>
> This paragraph makes the patch incoherent. =C2=A0It talks as if "no c=
ommon
> paths" is the majority case, and everybody inconveniently has to perf=
orm
> an extra step that shouldn't be needed if the implementation were don=
e
> right. =C2=A0If "no common paths" is indeed the assumed primary targe=
t, why
> doesn't the implementation empty both index and files in the working =
tree
> so that users don't have to do so themselves?

I was NOT trying to scare with my message.  That paragraph was meant
to let people who would need to do something ("no common paths") know
what they will need to do.  I think it is good enough because "mostly
common paths" people will be happy too by knowing that everything is
unchanged as they want it to be.  So I haven't thought about scaring
at all.  I thought it was good indeed!  :-)

> My _only_ complaint was that your version that _only_ emptied the ind=
ex
> without touching the working tree made things difficult for everybody=
,
> both "no common paths" people and "mostly common paths" people.

Just to clarify my point-of-view about the design:

I do prefer my first design mainly because it mimics the state of an
initial commit.  I think that is subjectively better.

You have been asking me to make one of the two possible work flow uses
you pictured as favored so things will be already set to them.  No
further commands to them.

I did it!  As a matter of fact the "mostly common paths" people were
favored as you have noticed your inclination to it before.

As I told you, I just want to make you happy so people that needs the
feature I am working on could have it as fast as possible.

And if one of the possible work flows have to be favored then I do
agree with you about "mostly common paths" as the best choice.

But the point is that the other group will need to do further commands
anyway so I would keep my previous design because of the resemblance
to an initial commit: work tree full and nothing added to the index.

But I mean it!  I really want to satisfy you.  So this was the last
time I talk about my preference.

Therefore let's find out what you want me to do so we can finish this
production cycle.  I don't want to bother you anymore.

> You need to at least qualify the above paragraph with something like =
"if
> you want to create an unrelated branch whose contents do not resemble=
 the
> original branch at all, then you should ...".
>
> Better yet, try to advertise what you are giving your users in a posi=
tive
> way, instead of in a way that only scares users, perhaps like this:
>
> =C2=A0 =C2=A0After 'checkout --orphan', your HEAD will point at an un=
born branch,
> =C2=A0 =C2=A0and the next commit will start a new history without any=
 prior commit.
> =C2=A0 =C2=A0To help create such a new history that has contents most=
ly the same as
> =C2=A0 =C2=A0that of the original branch, the command does not touch =
the index nor
> =C2=A0 =C2=A0the working tree, and "checkout --orphan" immediately fo=
llowed by
> =C2=A0 =C2=A0"commit -a" would record a tree very similar to what you=
 had in the
> =C2=A0 =C2=A0original branch. =C2=A0This is useful when you want to .=
=2E. [insert a
> =C2=A0 =C2=A0summary of "going open source" example from my previous =
message if you
> =C2=A0 =C2=A0want here].
>
> =C2=A0 =C2=A0If on the other hand you want to start a new branch whos=
e contents do
> =C2=A0 =C2=A0not resemble the original branch at all, you may want to=
 start from an
> =C2=A0 =C2=A0empty index and the working tree, with "git rm -rf ." im=
mediately
> =C2=A0 =C2=A0after running this command.
>
> The same comment applies to the documentation part.

I was trying to be concise on my message.  I realize you want it more e=
xplained.

What about that:

After the 'checkout -o -b' you are in an new unborn branch ready to be
committed.  The next commit will start a new history without any
ancestry.  If this new branch was made to start from scratch, not
resembling the previous one, then you should use 'git rm -rf' to get
an empty work tree and index.  Otherwise with a 'git commit -a' you
will have a tree exactly as in the previous branch.  So just set
things as you want it to be and commit the new unparented branch.

> By the way, I wouldn't mind if you believe "no common paths" is the
> majority case; if that is the case, then the code and behaviour would=
 be
> different, and the presentation would say something like this:

I agree with you in choosing "mostly common paths" as the target since
you have decided to target one.

Before I send another patch version could you please tell me your
position about my new explaining text up there.  I will wait for your
reply before sending a new patch version.

Best regards
