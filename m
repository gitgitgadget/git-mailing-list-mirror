From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [PATCH] fix many comment typos
Date: Sat, 2 Jun 2012 19:39:38 -0700
Message-ID: <CAE1pOi0sq-+1gAK1wrnjNqNY3bWGGAHDeW6879mdh4wLUbX_Og@mail.gmail.com>
References: <8762baf8do.fsf@rho.meyering.net> <7vmx4lz5bm.fsf@alter.siamese.dyndns.org>
 <CAE1pOi0g1UCebpWGP6FpH0-RbUBxyoWMj_XT7=gNudHrztx0+g@mail.gmail.com> <7vipf9z0gz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 04:40:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb0jg-00072v-DS
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 04:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758233Ab2FCCkB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 22:40:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51274 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab2FCCkA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 22:40:00 -0400
Received: by yhmm54 with SMTP id m54so2372273yhm.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 19:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VKflDWmUyJDpurKzZE25f/mm8xBwzeONRltqxfN5gCs=;
        b=yPfeadvwd/ile9+1NV8SA1+KtnjBXbrlyRggko/BZO7mXQmWStiRyiE0k3qOTnWHRX
         FZ7TwDyBR+UN0Xvm+O0Lm5H9ITWKmzOtIe321kenezKyiktkJzfWkKxmXeFvcFoZqFT6
         v8HBpHqxQBtSopSQWEH4iq0Pqd74LdqhLvtA4LWeOaACusDppDYtflmrCmhkMgFuhBCc
         +cSefBZlA7WKmIP/kJtDspzL7Uoh/GtdNWzsNzr6HTs90jYLtmBsY5lfPUWvKweYiJ4I
         SC62YbbCfeHzRpUjIw15PpFtWaCyiFmS8xnNxde/4HoKRkV/yW0YRPjI6pTolSd2uwax
         c6hA==
Received: by 10.236.109.196 with SMTP id s44mr2919266yhg.35.1338691199561;
 Sat, 02 Jun 2012 19:39:59 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Sat, 2 Jun 2012 19:39:38 -0700 (PDT)
In-Reply-To: <7vipf9z0gz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199066>

On 2 June 2012 17:46, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> On 2 June 2012 16:01, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jim Meyering <jim@meyering.net> writes:
>>>
>>>> Use http://github.com/lyda/misspell-check to identify many typos.
>>>> Culprits identified and fixed automatically using these commands,
>>>> converting diagnostics to single-quote-safe sed -i commands:
>>>>
>>>> git ls-files|misspellings -f -|perl -nl \
>>>> =C2=A0 -e '/^(.*?)\[(\d+)\]: (\w+) -> "(.*?)"$/ or next;' \
>>>> =C2=A0 -e '($file,$n,$l,$r)=3D($1,$2,$3,$4); $q=3D"'\''"; $r=3D~s/=
$q/$q\\$q$q/g;'\
>>>> =C2=A0 -e 'print "sed -i $q${n}s!$l!$r!$q $file"' \
>>>> =C2=A0| grep -vE '\.po$|pt_BR' > k
>>>>
>>>> Filter out s/seeked/sought/ false positives (they relate to cg-see=
k):
>>>> =C2=A0 grep -vE 'seeked' k > j && mv j k
>>>
>>> ??
>>>> diff --git a/Documentation/RelNotes/1.5.4.4.txt b/Documentation/Re=
lNotes/1.5.4.4.txt
>>>> index 323c1a8..83453db 100644
>>>> --- a/Documentation/RelNotes/1.5.4.4.txt
>>>> +++ b/Documentation/RelNotes/1.5.4.4.txt
>>>> @@ -21,7 +21,7 @@ Fixes since v1.5.4.3
>>>>
>>>> =C2=A0 * "git send-email" in 1.5.4.3 issued a bogus empty In-Reply=
-To: header.
>>>>
>>>> - * "git bisect" showed mysterious "won't bisect on seeked tree" e=
rror message.
>>>> + * "git bisect" showed mysterious "won't bisect on sought tree" e=
rror message.
>>>
>>> ??
>>
>> http://en.wiktionary.org/wiki/seeked
>
> Here is an advice to Hilco. =C2=A0*THINK*
>
> I hate people who try to be clever by just quoting without saying
> anything, especially when it is very clear they didn't think the
> issue. =C2=A0It is irritating.

Ouch.

You highlighted two changes that were both about "seeked". Your
comment just said "??". I can think but I can't read your mind. :-)

> That description in the 1.5.4.4 release note is stating a HISTORICAL
> FACT that the command in 1.5.4.3 gave that exact message. =C2=A0What'=
s
> the point of changing it in the name of typofix? =C2=A0It is irreleva=
nt
> if the word was misspelled; the whole point of the entry is report
> what was the problem the release fixed.
>
> What was strange to me, which is why I marked these two places with
> "??", is that Jim specifically filtered out false "seeked" positives
> in his procedure, but still the above somehow slipped in.
>
> That discouraged me from applying the patch, as it means I have to
> eyeball the whole thing to make sure that there aren't similar
> unintended changes.

That makes a lot of sense. My apologies for irritating you, that
certainly wasn't my intention.
