From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 18:09:30 -0500
Message-ID: <CAMP44s1N=xy2B-YkCLC67pX_EVqAziGWyN1qkrs0Sq=o2jL6Sw@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
	<7v8v35cnp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 01:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufedj-0008N5-3B
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 01:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759824Ab3EWXJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 19:09:33 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:61930 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759757Ab3EWXJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 19:09:32 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so3847397lab.19
        for <git@vger.kernel.org>; Thu, 23 May 2013 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ktaok8zEYowPFlJxLEk9SiPRdX7j6AYzTl/M0Cf4Zx8=;
        b=cKCULHW1Jyc5h5lPyke+mx+CtvGA+tEnZHc1BttYDPanqvLPypo/Iu+s/KOnBs/xm7
         wsA4mKFK742Rb2WjOPw2glyeYddEp6Xo/kEXynVljh3tYgf7iz5rVnv0ZuR1qHxeYnh6
         c0fe5cJNv1PWQjSVqaFpFuEqsTSBKlQ7voYg0G/66mNPW9rHNlcAaGE/H8jeF2+43AcE
         oN1akUZyxNVZ8GldppGM05k9J7Z+IGdp4/IByJ46Ztj6GA/8ZnbUL7rSvFCij/vX1ytO
         7dGL5rxDJzLtn1LbUYZ9UMBThWy9zK7mJfoRHmzHk4QHTM7ek10pDTqo8iP8ascvDtMw
         Bexg==
X-Received: by 10.112.167.229 with SMTP id zr5mr7548520lbb.7.1369350570968;
 Thu, 23 May 2013 16:09:30 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 16:09:30 -0700 (PDT)
In-Reply-To: <7v8v35cnp0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225316>

On Thu, May 23, 2013 at 5:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 23, 2013 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> John Keeping <john@keeping.me.uk> writes:
>>>
>>>> This isn't about "swap parents", it's about helping people realise that
>>>> just "git pull" isn't necessarily the best thing for them to do, and
>>>> that they may want --rebase.
>>>>
>>>> So I was asking if it would be sensible (possibly in Git 2.0) to make
>>>> git-pull pass --ff-only to git-merge by default.
>>>
>>> Unless your primary user base is those who use Git as a deployment
>>> tool to always follow along the tip of some external repository
>>> without doing anything on your own on the branch you run your "git
>>> pull" on, defaulting it to --ff-only does not make much sense to me.
>>
>> A lot of people do stuff, but the rebase it.
>
> If I am parsing the above properly, I think that is only saying that
> "pull --rebase" makes sense for people who do real work, which I am
> not disagreeing.

You claimed that 'git pull' (--ff-only) only makes sense if the
primary user-base doesn't do any work on it, but that's not true; they
can do a 'git rebase' after such pull (or a merge).

We don't have to assume our primary user-base wants to do full fledged
merges, in fact, such assumption would be wrong.

>>> If the proposal were to make pull.rebase the default at a major
>>> version bump and force all integrators and other people who are
>>> happy with how "pull = fetch + merge" (not "fetch + rebase") works
>>> to say "pull.rebase = false" in their configuration, I think I can
>>> see why some people may think it makes sense, though.
>>
>> That makes perfect sense, because the people that are not familiar
>> with Git more often than not end up making merges by mistake, and the
>> ones that are familiar with it can easily configure it to do what they
>> want
>
> Yes, in theory.  The transition needs a major version bump, but it
> is doable (with unknown level of resistance).

Isn't that what wer are discussing here?

>>> But neither is an easy sell, I would imagine.  It is not about
>>> passing me, but about not hurting users like kernel folks we
>>> accumulated over 7-8 years.
>>
>> I've worked in the Linux kernel, and in my experience the vast vast
>> majority of kernel developers don't do merges; they send patches. It's
>> only the lieutenants that might do that, and although there are a lot,
>> they don't surpass the 200, and they most definitely know how to
>> configure Git to do what they need. And even then, most of them don't
>> do merges, but create a linear history for Linus to merge.
>>
>> So the only one who does really rely on merges is Linus, I think he
>> would have no problems configuring Git.
>
> That is not something I can agree or disagree without looping
> somebody whose judgement I can trust from the kernel circle ;-).

See section 16) in Documentation/SubmittingPatches, notice how the
whole section is written with Linus in mind. Some maintainers do have
sub-maintainers that send pull requests to them, not Linus, but they
are the minority. But most definitely pull requests are not for the
general population (except in a few very rare exceptions maybe).

-- 
Felipe Contreras
