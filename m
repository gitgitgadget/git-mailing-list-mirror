From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 18:43:29 +0000
Message-ID: <AANLkTil5eq2radUKvle7Ez48CDRfb8dvWcEobXzGaKNA@mail.gmail.com>
References: <20100720163822.GA8492@localhost.localdomain>
	<0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
	<7veieym3sh.fsf@alter.siamese.dyndns.org>
	<AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
	<7v1vaym27n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, jaredhance@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:51:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHuU-0004Jk-Qz
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761199Ab0GTSvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 14:51:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49471 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759100Ab0GTSvQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 14:51:16 -0400
Received: by gwj18 with SMTP id 18so2879800gwj.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B8ebPOpkFNvcMEoGNNEMjT5dNshzRnsLIy5JNciar24=;
        b=ByROtwtPzyFBeFpOZj31fwEkO0ZbLtbOKuUBSPB5JYZ3YMvU05LFoi34C0Xmy2KHzW
         TbG/jJ/2ffCmwZ08TAxqCCS4jt+i+NeTV84a/Tq0u3iL3xuGHOmxbHxMzaj9l2mK+Srr
         y4rgQJI6tXeAzCF8DP0ccp0almEYXxr4V8NH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tnm6N7zCln13i/cCs86RQJqsc1U4ud2luG/pQNX1JAKeLe7zoJj2ebJnbIJ0ZmVaTm
         M5FmDcKlgdK81DasJ1CMiYbW/lnU5MJugiILmTP2wa8JYNJGsKnr3TQbxftB6vNEGMM8
         upKkRkZ10ypr/vwmJy22FtsvgymKD5P0qU1lc=
Received: by 10.150.146.9 with SMTP id t9mr811297ybd.112.1279651410555; Tue, 
	20 Jul 2010 11:43:30 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 11:43:29 -0700 (PDT)
In-Reply-To: <7v1vaym27n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151349>

On Tue, Jul 20, 2010 at 18:34, Junio C Hamano <gitster@pobox.com> wrote=
:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Jul 20, 2010 at 18:00, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>>> =C2=A0 =C2=A0Run a git command and ensure it fails in a controlled =
way. =C2=A0Use
>>> =C2=A0 =C2=A0this instead of "! <git-command>". =C2=A0When git-comm=
and dies due to a
>>> =C2=A0 =C2=A0segfault, test_must_fail diagnoses it as an error; "! =
<git-command>"
>>> =C2=A0 =C2=A0treats it as just another expected failure. letting su=
ch a bug go
>>> =C2=A0 =C2=A0unnoticed.
>>
>> To add to that:
>>
>> =C2=A0 =C2=A0 Don't use test_must_fail to negate the return values o=
f commands
>> =C2=A0 =C2=A0 on the system like grep, sed etc. If we can't trust th=
at the core
>> =C2=A0 =C2=A0 utilities won't randomly segfault we might as well die=
 horribly.
>
> I think you are being incoherent. =C2=A0If we can't trust system "gre=
p" and it
> randomly segfaults, then a test:
>
> =C2=A0 =C2=A0git some-command >actual &&
> =C2=A0 =C2=A0! grep string-that-should-not-be-in-the-output actual
>
> would _pass_ when the command segfaults. =C2=A0I do agree with you th=
at "We
> might as well die horribly", and the way you do so is by protecting t=
he
> test with test_must_fail, like this:
>
> =C2=A0 =C2=A0git some-command >actual &&
> =C2=A0 =C2=A0test_must_fail grep string-that-should-not-be-in-the-out=
put actual
>
> Having said that, as we _do_ trust system tools to a certain degree, =
we do
> not care very deeply about this. =C2=A0IOW, I wouldn't want to see a =
patch that
> rewrites "! grep" to "test_must_fail grep".

An individual test would pass, yes. But if test or grep are
segfaulting we're going to bail out horribly eventually anyway, so I
don't think it's worth the effort to guard them with test_must_fail,
and I wouldn't write tests to do that. I'd just use !.

That's what we seem to be doing in the tests so far, i.e. test_must_fai=
l
is reserved for git commands only.
