From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 6/6] t/README: A new section about test coverage
Date: Sat, 24 Jul 2010 23:17:18 +0000
Message-ID: <AANLkTim7v199lMKNEhOALx_38ChIIgvD4oERQJU5SNdv@mail.gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
	<1280004663-4887-7-git-send-email-avarab@gmail.com>
	<20100724212542.GA5610@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:17:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcnyJ-0004Qy-AD
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab0GXXRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:17:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61363 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0GXXRT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 19:17:19 -0400
Received: by iwn7 with SMTP id 7so1524609iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tjYV8tcyG8Er6S767T4Kx5Mj+ptrtAuXA6/ZUp59JTQ=;
        b=sSYsNzuWg0xig0KzQfuCyO5vP3HkKTgiJ+0Ly5CqY4/KRmzAyXFPUmwgqZwCZZ9Oul
         wXNQXOynpRFE5Xj7kokaTmIQT7+ZtQ87zgRWCkSWEeJjyOE5U8feTRjhpenvp+8B/0iO
         y5+ROagga3EaFvW0bRidwYq0iJogpEzXYm9As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UcEHdqGny+sFkfoT7BVF+BvTGQqsXC8fGvh+hd6GJE7+6Fe/r5Bur3vkEyU36cs5yb
         6YvpZk8pud4DW6ZYfRoeZd55dYNXa9iXiNCf9YgjltP3TB//QnrNcrhr8taaJcQgzfCR
         xGg0GWKXKXThqrQtRoCdtt4JEKJKQTu0vkowU=
Received: by 10.231.176.74 with SMTP id bd10mr6261131ibb.38.1280013438534; 
	Sat, 24 Jul 2010 16:17:18 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 24 Jul 2010 16:17:18 -0700 (PDT)
In-Reply-To: <20100724212542.GA5610@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151685>

On Sat, Jul 24, 2010 at 21:25, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Document how test writers can generate coverage reports
>
> Very neat!

Thanks for the review.

>> --- a/t/README
>> +++ b/t/README
>> @@ -267,6 +267,9 @@ Do:
>> =C2=A0 =C2=A0 =C2=A0 git merge hla &&
>> =C2=A0 =C2=A0 =C2=A0 git push gh &&
>> =C2=A0 =C2=A0 =C2=A0 test ...
>> +
>> + - Check the test coverage for your tests. See the "Test coverage"
>> + =C2=A0 below.
>>
>> =C2=A0Don't:
>
> I have a moment=E2=80=99s hesitation reading this, because I suspect =
test
> coverage checking would be most useful if test authors were _not_ to
> pay too much attention to it.
>
> Imagine that the git test suite is almost perfect, so it checks all
> the important behavior of git, including edge cases (yes, unlikely,
> but bear with me for a moment). =C2=A0Then the test coverage data wou=
ld be
> very useful indeed: it would point out code that is not actually
> needed for anything.
>
> However, if new authors make 99% coverage a goal while writing
> tests, the result will be lots of useless tests that check
> behavior no one cares about and less useful coverage information.

What I was going for here is that you should try to make sure that the
code you're adding is covered by tests by running the coverage tests.

I.e. if I add a new function "blah" to git-whatever which is
implemented by the "do_blah" function checking if every line of
"do_blah" is covered is an excellent indicator of whether that code is
being exhaustively tested, as opposed to just superficially tested.

In most cases a low test coverage counts is telling about the overall
quality of the tests.

But, the wording can probably be improved. Do you have a suggestion
for the above intent compressed into a sentence or two? I can't come
up with anything right now.

>> @@ -508,3 +511,40 @@ the purpose of t0000-basic.sh, which is to isol=
ate that level of
>> =C2=A0validation in one place. =C2=A0Your test also ends up needing
>> =C2=A0updating when such a change to the internal happens, so do _no=
t_
>> =C2=A0do it and leave the low level of validation to t0000-basic.sh.
>> +
>> +Test coverage
>> +-------------
>> +
>> +You can use the coverage tests to find out if your tests are really
>> +testing your code code. To do that, run the coverage target at the
>> +top-level (not in the t/ directory):
>
> In other words, I would rather the rationale here read:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0You can use the coverage tests to find cod=
e paths that are not being
> =C2=A0 =C2=A0 =C2=A0 =C2=A0properly exercised yet. To do that...
>
> I think it is great if people write new tests that do not exercise
> their own code but instead explore related behavior.

That wording is better, thanks.

> That said, with or without any of the changes implied above,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.
>
