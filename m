From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/4 v2] Allow detached form (e.g. "git log --grep foo") in 
	log options.
Date: Wed, 28 Jul 2010 15:03:11 +0000
Message-ID: <AANLkTikdy9W=mQ0RqGFRPXktTeqvFNrhipqgbVEbJzBC@mail.gmail.com>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
	<1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTikzL-sgysKD+0CZ100xHWZro=-hDgDgUL2Pb3yw@mail.gmail.com>
	<vpq8w4vhmkj.fsf@bauges.imag.fr>
	<AANLkTi=TRzn-QWduEYH7qO-4=a-nGqCGSMkZCGn2iB=W@mail.gmail.com>
	<vpq39v3670o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 28 17:03:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe8AJ-0000oy-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 17:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab0G1PDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 11:03:14 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59985 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab0G1PDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 11:03:13 -0400
Received: by pxi14 with SMTP id 14so937194pxi.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6PsQXE1dyJZoHpFUaxCN9QbZ1Icn0I84GBavqaXy+p0=;
        b=vv9m2OfXw/Sht81fnlHiGnYFHb+SlvrVrz+GU/UgikorW7TFXqcOk7VP1dnWz7IJFy
         NtPfzzphkOaY/x23thrWfEFDKltg9GdBZAligPUj6UlDr7zXcf5qXNi7or5GUFmtO91C
         kmtwLysPjTFh/E9swX5rMv8PmKyZ+yh4XOhqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ChNLOkXcuc1DaC33ts8xg4wProPhutU5v9HcF9QqfRB4eybx52NGoQcZ9TzSuL4M6/
         VujKtdHOUNvUYr0RMkyHmtDps3+M6dFBXvHR5lKK7xEDgZzuDAeHptdToRedm60MPDr3
         VPbv9b+X90aQ7gCnqM/gsPTtoZyBiBUrRjxdc=
Received: by 10.142.177.6 with SMTP id z6mr12069344wfe.204.1280329391955; Wed, 
	28 Jul 2010 08:03:11 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 08:03:11 -0700 (PDT)
In-Reply-To: <vpq39v3670o.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152095>

On Wed, Jul 28, 2010 at 14:00, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> DISCUSSION in git-commit(1) and gittutorial(7) mention 50 characters
>> explicitly though, and a lot of tools that present commits in short
>> form use that as a soft limit, e.g. gitweb and github.
>
> Where does github have this limitation?
>
> On http://github.com/git/git/commits/master, I can see messages like
> this:
>
> git-read-tree.txt: acknowledge the directory matching bug in sparse c=
heckout
>
> 76 chars-wide, untruncated.

A lot of applications do it in their public timeline, e.g. at GitHub:

    http://github.com/mirrors

Although their limit seems to be closer to 65 characters now, but I'm
fairly sure that it was 50 before. It's also overflowing my screen now
as a result.

>> I'll submit a patch to SubmittingPatches citing the 50 char soft
>> limit.
>
> git$ git log --format=3D'%s' | wc -l
> 22700
> git$ git log --format=3D'%s' | grep '................................=
=2E.................' | wc -l
> 9392
>
> Almost half of the commits already there do not comply with this
> supposed rule.

It's not a rule, just a soft limit. Anyway, I just mentioned it
because the subject ended with a full stop. Which indicated that you
hadn't spotted that bit in SubmittingPatches, and might want to know
for future submissions.

There's also a quickly decreasing long tail after 50 characters.

    $ for i in {50..70}; do git log --format=3D'%s' | egrep ".{$i}" | w=
c
-l | tr '\n' ' '; done && echo
    9391 8847 8341 7838 7338 6840 6379 5915 5456 5018 4585 4184 3779
3418 3045 2751 2434 2153 1871 1655 1438

(Use Extended Regular Expressions, your "." key will thank you >:)

> I'm fine with rewriting the subject, but the claim that commit
> messages should be <50 chars is just not reasonable and has never bee=
n
> applied to git.git.
>
>> I only saw two test_expect_success additions in your v2 series, mayb=
e
>> I missed one.
>
> I'm putting the diff for the t/ directory below to sum up the tests
> added.

Thanks. I missed 2/4 because I only grep-ed for the test harness
functions.

>> Not for everything it seems, but the coverage is pretty good:
>>
>> =C2=A0 =C2=A0 http://v.nix.is/~avar/cover_db_html/parse-options-c.ht=
ml
>> =C2=A0 =C2=A0 http://v.nix.is/~avar/cover_db_html/test-parse-options=
-c.html
>
> You're precisely illustrating my point: these coverage results are
> about parse-option, not about the places where it is used. For
> example:
>
> git/t$ git grep -e '--message'
> git/t$

*added to my list of stuff to test*

> =3D> git commit --message is not tested, at all (but git commit -m
> obviously is).
>
> In my case, I didn't gcov it, but I think I've got 100% coverage on
> the helper functions (short_opt and diff_long_opt), just not 100% on
> the places where they're used.

I just mentioned the coverage as an aside (and probably shouldn't
have. What I mainly meant is that it would be easy to regress on
option parsing in revision.c in the future because e.g. nothing tests
both "--abbrev foo' and "--abbrev=3Dfoo".

>> Anyway, here's how you can easily get almost complete coverage at
>> almost no cost for this series, first make a t/lib-log.sh like this:
>>
>> =C2=A0 =C2=A0 #!/bin/sh
>>
>> =C2=A0 =C2=A0 log_expect_success() {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc=3D$1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 text=3D$2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_expect_success "Phony test with att=
ached options: $1" "$2"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mocked=3D$(echo "$2" | sed -r 's/([A-Za-=
z-]+)=3D/\1 /')
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_expect_success "Phony test with det=
ached options: $1" "$mocked"
>> =C2=A0 =C2=A0 }
>
> You should check whether "$mocked" =3D=3D "$2" to avoid useless re-ru=
n.

Yeah, it's just pseudocode. Assigning to desc and text and not using
them is also pretty useless. I didn't even run it, but I'm delighted
to find that it at least compiles and executes.

>> I can submit something like that later if I get around to it,
>
> Go ahead, I've exhausted my git time budget ;-).

Maybe I will. Anyway, like I said this patch looks just fine. I mainly
just wanted to note that it was under-tested (but that it should go in
anyway, IMO), if for no other reason than as a future note to
myself. Or anyone else wanting to improve our test coverage.
