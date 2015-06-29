From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 12:55:26 +0200
Message-ID: <CAP8UFD23RTCzrv8j8Jbcx5ajMUjgVsO3P5_Fiv3Vwx5uaPwXrw@mail.gmail.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<CAP8UFD0NjExQJHQWix1+zc4_k15e3+aC5vAv=dHipg-X+2y1sQ@mail.gmail.com>
	<vpq1tgvnf2g.fsf@anie.imag.fr>
	<CAP8UFD1gWXOZHfiELZYgvGP1dA-aeaxbyaokKCut9pfWghy9uQ@mail.gmail.com>
	<vpqsi9alv1l.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 29 12:55:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9Wir-00065x-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 12:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbbF2Kz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 06:55:29 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33929 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbbF2Kz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 06:55:27 -0400
Received: by wgqq4 with SMTP id q4so137999660wgq.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jB423HqMriB4J/SoWOQZ/aXEIVmI6can9beC+KjuewI=;
        b=d6kmY82vkUvjSr+SA8ahh6JeAG/NpsdaDB442yJYHTRdfVNzmJ8D69H45c4yYdXSaU
         8Dk08kcYFceBr4R11Ue4rtYdTZOSywiDGDczyOomDwUX4n/5irCVzAVCA3j5/OW7g2ZU
         FRAfq8zQjtYjfrCI+46rKcQcrDR9OI5glGUoavJjNyfJ14EgEwPMln9c1mLEPIaiTWr/
         AiOYjRW+u7tE87pJ1zFwGb0crp9xBBvQ7b9B1+jQy7jkfoRHbID3XhRubyjgGCbNakKc
         ijN8VWx6tODJR6WdvG4snL2zjtbv9Rq08yXyP06TJJX4BoaekbCLhb+8Pb4UtnFCwZrx
         c+Zg==
X-Received: by 10.181.25.234 with SMTP id it10mr21048741wid.41.1435575326121;
 Mon, 29 Jun 2015 03:55:26 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Mon, 29 Jun 2015 03:55:26 -0700 (PDT)
In-Reply-To: <vpqsi9alv1l.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272948>

On Mon, Jun 29, 2015 at 11:32 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:

[...]

> I find it particularly frustrating that we issue the message:
>
>   "The merge base %s is bad.\n"
>   "This means the bug has been fixed "
>   "between %s and [%s].\n"

I find it a good safety feature.

> bisect is all about finding the commit where a property has changed,

That is your interpretation of this command. On the man page there is:

    git-bisect - Find by binary search the change that introduced a bug

So its stated purpose is to find the first "bad" commit. Not to find a fix.

This doesn't mean that we cannot or should not make it possible to
find a fix, but we shoudn't try to find a fix when there is doubt
about whether the user wants to find a fix or the first bad commit.

> and
> here it stops, saying "I know it's between A and B, but I won't go
> further".

You can interpret it that way, but my interpretation of this is that
the real reason why we stop is because we don't know what the users
really wants to do, find the fix, or really find the first bad commit.

>>> In particular when bisecting from two branches, the user knows that
>>> branch A is good, and branch B is bad, but does not necessarily know
>>> whether it's a regression in B or a
>>> fix in A. The fact that bisect can find out should be just "normal" from
>>> the user point of view. There's no mistake involved, nothing to fix, and
>>> nothing that went wrong.
>>
>> Well in this case, it's possible that the merge base is bad and what
>> the user is interested in is the first bad commit that was commited
>> before the merge base. We just don't know, in the case the merge base
>> is bad, what is more interesting for the user.
>
> The question asked by the user is "X is good, Y is bad, tell me where
> exactly it changed".

That's your interpretation of the question asked by the user.
It can be interpreted otherwise.

> We can't know for sure what is "interesting" for
> the user, but we can answer his question anyway.

You can answer your interpretation of the question, yes, but this
means taking risks that we don't need to take in my opinion.

If people really want it, we can still have an option called for
example --find-fix that could automatically try to find the fix when
the merge base is "bad" without displaying the message that annoys
you. It would make it explicit that it is ok to find a fix.

> Similarly, there can be several commits that introduce the same
> regression (this may happen if you cherry picked the guilty commit from
> branch A to branch B, and then merged A and B, or if you broke, fixed,
> and then broke again). bisect finds one transition from good to bad, but
> not all. It may or may not be the one the user wanted, but we can't
> know.

Yeah, but this is different as we would still find a first "bad"
commit, not a fix.

>>> I think I prefer "term" to "name".
>>
>> Ok with that. I agree that it would be more consistent to have a "git
>> bisect terms" and "--term-{old,new,bad,good}".
>
> OK, I've applied it.

Great!
