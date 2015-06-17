From: Simon Eugster <simon.eu@gmail.com>
Subject: Re: [PATCH 2/2] Documentation on git-checkout --ours/--theirs improved
Date: Wed, 17 Jun 2015 16:31:45 +0200
Message-ID: <CAO8d5BYkgNgB+fV2HjrUasYi0jz9YvZGuFxKNMBbWoaONpAeUA@mail.gmail.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
	<1434372447-51230-1-git-send-email-simon.eu@gmail.com>
	<1434372447-51230-3-git-send-email-simon.eu@gmail.com>
	<xmqq381s91gz.fsf@gitster.dls.corp.google.com>
	<CAO8d5Bbi8LHHP0nnYwv=_Qr6KZCJmFPTq5ut2KzeSKJ-i0RZNg@mail.gmail.com>
	<xmqqzj3z64q9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 16:32:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5EOb-0001Pp-O8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbbFQObx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 10:31:53 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36455 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbbFQObq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 10:31:46 -0400
Received: by wgzl5 with SMTP id l5so38722982wgz.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=12uS7pA7foBl+Jn79X3DWg4EHBovPg4nzjGK34dgBKQ=;
        b=umoFfoUDHR71oBAou0jiSI5lXKCPb51PmMAOtTleJAamhch1EkkUYJjElmtcdNdfpw
         grkysfd4tnr9QH73noF9qxPfCMpOlxFKYjIE+cAAMXVhKEgeld1iatncei6eLwG/Jqwe
         MP9iH+T/B+t+tPicMLhGDkLyiwq5hzZlCAdEOXQ7FkyWu7MJAdFKfQrDHFIMvPBtdAEa
         3093Wq/oiuuVVqr28ox+t7yL/Yna0UDkHMDyon+Psy97WMLj2lAhnsQ98TokjC7Rb158
         NjFC/BWGgLOnL+NQ/x8zCmbVrVajGc4vzVAqIA55kp0eod3va/UiBHyo0US5KC8z8Edx
         Ot0w==
X-Received: by 10.194.84.179 with SMTP id a19mr6277989wjz.29.1434551505371;
 Wed, 17 Jun 2015 07:31:45 -0700 (PDT)
Received: by 10.27.134.86 with HTTP; Wed, 17 Jun 2015 07:31:45 -0700 (PDT)
In-Reply-To: <xmqqzj3z64q9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271850>

2015-06-16 17:41 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Simon Eugster <simon.eu@gmail.com> writes:
>
>> 2015-06-15 22:10 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>>>
>>> "Simon A. Eugster" <simon.eu@gmail.com> writes:
>>>
>>> > ---
>>>
>>> - Lack of explanation as to why this is a good thing.
>>> - Lack of sign-off.
>>>
>>> Why is there still 1/2, if its effect is wholly annulled by a
>>> subsequent step 2/2?
>>
>>
>> Sorry for that, still trying to find out how git send-email works.
>
> I do not think "git send-email" is involved in that process in any
> way.  The problem is you made the updates on top of the previous
> one, without squashing.  You fed two commits, instead of a squashed
> one commit, to "git send-email", and the command obliged and sent
> them out.

Yes, I somehow expected the two commits would be added to the same
email because I provided the Message-Id, and yes, I could just have
squashed them.

>>> > +During merging, we assume the role of the canonical history=E2=80=
=99s keeper,
>>> > +which, in case of a rebase, is the remote history, and our priva=
te commits
>>> > +look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need=
 to be integrated on top
>>> > +of =E2=80=9Cour=E2=80=9D work.
>>> > ++
>>> > +Normal merging:
>>> > +------------
>>> > +local ---------abC                  <-- canonical history
>>> > +                 | git checkout --ours
>>> > +                 v
>>> > +MERGE ---------abC
>>> > +                 ^
>>> > +                 | git checkout --theirs
>>> > +origin/master ---Xyz
>>> > +------------
>>> > +Rebasing:
>>> > +------------
>>> > +local -----------Abc
>>> > +                 | git checkout --theirs
>>> > +                 v
>>> > +REBASE --------xyZ
>>> > +                 ^
>>> > +                 | git checkout --ours
>>> > +origin/master -xyZ                    <-- canonical history
>>> > +------------
>>>
>>> I can see that an arrow with "canonical history" points at differen=
t
>>> things between the two pictures, but other than that, I am not sure
>>> what these are trying to illustrate.  Especially between abc and
>>> xyz, why does the former choose abc while the latter choooses xyz?
>>> Are these pictures meant to show what happens when the user says
>>> "checkout --ours" during a conflicted integration (whether it is a
>>> merge or a rebase)?
>>
>> I tried to create a picture which shows the difference of ours and
>> theirs when merging vs. rebasing, but apparently it did not turn out
>> well, and I will just leave it away.
>
> I'll wait for several days to see what other people would say, if
> they care to comment on this.  Maybe they can come up with a more
> intuitive picture, or maybe they say textual description is
> sufficiently clear that we do not need an illustration.  I dunno.

A better picture would be nice.
And regarding the textual description, are you going to commit your ver=
sion?
