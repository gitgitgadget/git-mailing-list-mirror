From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation on git-checkout --ours/--theirs improved
Date: Tue, 16 Jun 2015 08:41:02 -0700
Message-ID: <xmqqzj3z64q9.fsf@gitster.dls.corp.google.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
	<1434372447-51230-1-git-send-email-simon.eu@gmail.com>
	<1434372447-51230-3-git-send-email-simon.eu@gmail.com>
	<xmqq381s91gz.fsf@gitster.dls.corp.google.com>
	<CAO8d5Bbi8LHHP0nnYwv=_Qr6KZCJmFPTq5ut2KzeSKJ-i0RZNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Simon Eugster <simon.eu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 17:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4szA-0006e5-CW
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 17:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbbFPPlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2015 11:41:08 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34665 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769AbbFPPlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 11:41:06 -0400
Received: by igboe5 with SMTP id oe5so58074725igb.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=JEY8lfF9KexJFPOJlPH0rCMahWrs8X2ZpxKhXMUCuj0=;
        b=T6/RSq/CKVXy2/h1bGzRLvN/Q1e7fB/IX/b3flOqaeGnfJiYSsNUsmM4p/H3WmUXcr
         aymYzuJUzcVes0keqPw5un/X7iWkiyggLvW0P8/l+W58W+gS1HLgEvm9OqHEk8yGKHUt
         Ctbv6uwKiZ/IPd4krAcjDPS01hE+hsNNv+1CdqTl2oGUV38sZ01zdsrI2ca1U4oj4PCZ
         lpqZzR/9ewstxzzt4rnVf5Jkx/0VgjUnR12LWRszCSgriZ2S83VzdZccz1hn7A/HR95d
         kOByhBI/B+lsu3BML9T1LQ97QXanOwB0XgFJz4I3DCv6rGOsGea5uOTCjDw50DQkOaUb
         aWfg==
X-Received: by 10.50.4.66 with SMTP id i2mr28823169igi.40.1434469265502;
        Tue, 16 Jun 2015 08:41:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6c2b:219c:23d9:cf91])
        by mx.google.com with ESMTPSA id b73sm746088iob.25.2015.06.16.08.41.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jun 2015 08:41:03 -0700 (PDT)
In-Reply-To: <CAO8d5Bbi8LHHP0nnYwv=_Qr6KZCJmFPTq5ut2KzeSKJ-i0RZNg@mail.gmail.com>
	(Simon Eugster's message of "Tue, 16 Jun 2015 09:03:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271771>

Simon Eugster <simon.eu@gmail.com> writes:

> 2015-06-15 22:10 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>>
>> "Simon A. Eugster" <simon.eu@gmail.com> writes:
>>
>> > ---
>>
>> - Lack of explanation as to why this is a good thing.
>> - Lack of sign-off.
>>
>> Why is there still 1/2, if its effect is wholly annulled by a
>> subsequent step 2/2?
>
>
> Sorry for that, still trying to find out how git send-email works.

I do not think "git send-email" is involved in that process in any
way.  The problem is you made the updates on top of the previous
one, without squashing.  You fed two commits, instead of a squashed
one commit, to "git send-email", and the command obliged and sent
them out.

>> > +During merging, we assume the role of the canonical history=E2=80=
=99s keeper,
>> > +which, in case of a rebase, is the remote history, and our privat=
e commits
>> > +look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need =
to be integrated on top
>> > +of =E2=80=9Cour=E2=80=9D work.
>> > ++
>> > +Normal merging:
>> > +------------
>> > +local ---------abC                  <-- canonical history
>> > +                 | git checkout --ours
>> > +                 v
>> > +MERGE ---------abC
>> > +                 ^
>> > +                 | git checkout --theirs
>> > +origin/master ---Xyz
>> > +------------
>> > +Rebasing:
>> > +------------
>> > +local -----------Abc
>> > +                 | git checkout --theirs
>> > +                 v
>> > +REBASE --------xyZ
>> > +                 ^
>> > +                 | git checkout --ours
>> > +origin/master -xyZ                    <-- canonical history
>> > +------------
>>
>> I can see that an arrow with "canonical history" points at different
>> things between the two pictures, but other than that, I am not sure
>> what these are trying to illustrate.  Especially between abc and
>> xyz, why does the former choose abc while the latter choooses xyz?
>> Are these pictures meant to show what happens when the user says
>> "checkout --ours" during a conflicted integration (whether it is a
>> merge or a rebase)?
>
> I tried to create a picture which shows the difference of ours and
> theirs when merging vs. rebasing, but apparently it did not turn out
> well, and I will just leave it away.

I'll wait for several days to see what other people would say, if
they care to comment on this.  Maybe they can come up with a more
intuitive picture, or maybe they say textual description is
sufficiently clear that we do not need an illustration.  I dunno.

Thanks.
