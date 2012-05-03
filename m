From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] [GIT PULL] ktest: A couple of fixes
Date: Thu, 3 May 2012 09:06:29 +0700
Message-ID: <CACsJy8Dd-Nwcet+jZ6bPwNoOVXgRqTPOvOLswqAa_eO5tBDxGQ@mail.gmail.com>
References: <20120502004439.965120020@goodmis.org> <CA+55aFy02d13HkfwY-TEGwu=2cd8en+_rnrnwcwixGKRmdJRtA@mail.gmail.com>
 <7v62cf6y3d.fsf@alter.siamese.dyndns.org> <1335966292.14207.40.camel@gandalf.stny.rr.com>
 <7vsjfigx23.fsf@alter.siamese.dyndns.org> <1336003655.14207.71.camel@gandalf.stny.rr.com>
 <m3havyqf17.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Thu May 03 04:08:13 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SPlSm-0000FM-HN
	for glk-linux-kernel-3@plane.gmane.org; Thu, 03 May 2012 04:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825Ab2ECCHD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 May 2012 22:07:03 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49600 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab2ECCHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 May 2012 22:07:01 -0400
Received: by wgbdr13 with SMTP id dr13so1251969wgb.1
        for <multiple recipients>; Wed, 02 May 2012 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LOFhPKh6eEF8vYstql/w7BvAbLI9bvlRTDTz6V93Uus=;
        b=ifWM5NS1lr5lO5nRYXemB6bSqcoSsprfGxQLSQxOMVNmeodX7WP+SA4Y3iAwMTblbj
         sMHNgnW93kFCu02/KeCX2rFWPBFB+fnTpQm5Kb+gj6IEnCAjSmlmBggah/r8cJKHxrR6
         DLAktrghzIDbZrKnyzg/ESvI9Y1UT96GZn1Ov1DKL7ds4L1aPvgACOLGY9sM0k4mnCOk
         cAkczFag2bLo6DNJcjaKvQ9H3jgjdqKCjzji/2gP29lrLD87zWAekmKnfBiLlv3x2Czt
         4SEFEn6+gPKkcWERFku7SN69Ee1qv7abuAL/Nx0WIiL1cZrGAdj7weQf29ZJ9VvrJr3T
         f1Ug==
Received: by 10.180.81.166 with SMTP id b6mr4700304wiy.0.1336010819425; Wed,
 02 May 2012 19:06:59 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 2 May 2012 19:06:29 -0700 (PDT)
In-Reply-To: <m3havyqf17.fsf@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196885>

On Thu, May 3, 2012 at 7:33 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Steven Rostedt <rostedt@goodmis.org> writes:
>
>> I'll throw in one more feature request, that you can take or leave (=
I
>> have another script for it ;-), something that does a listing of
>> branches in order of date. I have over a hundred branches in my repo=
,
>> and I forget which branch was the last one I was working on. So I
>> created a script called git-ls (attached).
>>
>> Here's what the output looks like:
>>
>> $ git-ls | tail
>> 681d1c4 =C2=A0 =C2=A02012-04-19 =C2=A0 =C2=A0trace/tip/perf/urgent =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tracing: Fix stacktrace of latency tracers (irqsoff and friends=
)
>> 59cfede =C2=A0 =C2=A02012-04-19 =C2=A0 =C2=A0trace/rfc/iolatency =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 tracing: Add iolatency tracer
>> 61463fa =C2=A0 =C2=A02012-04-24 =C2=A0 =C2=A0trace/tip/perf/core =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ftrace/x86: Remove the complex ftrace NMI handling code
>> e201738 =C2=A0 =C2=A02012-04-26 =C2=A0 =C2=A0trace/tip/perf/core-2 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ftrace/x86: Remove the complex ftrace NMI handling code
>> 053cef1 =C2=A0 =C2=A02012-04-27 =C2=A0 =C2=A0trace/rfc/tracing/fentr=
y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ftrace/x86: Add support for -mfentry to x86_64
>> 4a6d70c =C2=A0 =C2=A02012-04-27 =C2=A0 =C2=A0trace/tip/perf/core-3 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ftrace/x86: Remove the complex ftrace NMI handling code
>> a76c3eb =C2=A0 =C2=A02012-04-30 =C2=A0 =C2=A0trace/rfc/kprobes/ftrac=
e =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ftrace/x86: Add support for x86_32 to pass pt_regs to function t=
racer
>> 6e1b77e =C2=A0 =C2=A02012-05-02 =C2=A0 =C2=A0trace/rfc/kprobes/ftrac=
e-v2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kpr=
obes: Update header for ftrace optimization
>> a4cc5f1 =C2=A0 =C2=A02012-05-02 =C2=A0 =C2=A0trace/tip/perf/next-2 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ftrace/x86: Add separate function to save regs
>> 9bd8569 =C2=A0 =C2=A02012-05-02 =C2=A0 =C2=A0trace/tip/perf/next =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 trace: Make removal of ring buffer pages atomic
>>
>> It lists the branches in order of date of last commit.
>>
>> Again, just showing some things that I find useful. If no one else f=
inds
>> these interesting, then just ignore it. I have my scripts :-)
>
> Well, there is "git branch -v -v":
>
> =C2=A0$ git branch -v -v
> =C2=A0[...]
> =C2=A0 =C2=A0gsoc2012-wiki =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00e71ecb [gsoc2012/wiki/master: ahead 11, behind 4] =
'"Published" and "secret" commits' project
> =C2=A0 =C2=A0html =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8b94cd8 Autogenerated HTML docs =
for v1.7.7.1-488-ge8e1c
> =C2=A0 =C2=A0i18n-po.pl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 aa8ce2e [git-i18n/ab/i18n-po: ahead 1] po/pl.p=
o: Eliminate fuzzy translations
> =C2=A0 =C2=A0maint =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bf50515 Git 1.7.10.1
> =C2=A0[...]
> =C2=A0 =C2=A0t/doc-config-extraction =C2=A0 =C2=A0 =C2=A0 =C2=A0451c2=
ef [git/trast/t/doc-config-extraction-v2: ahead 2257, behind 3] Documen=
tation: complete config list from other manpages
> =C2=A0 =C2=A0test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b77178e gitweb: Separate feature=
s with no project specific override
> =C2=A0 =C2=A0todo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10c7888 Meta/dodoc: assign defau=
lt values
> =C2=A0 =C2=A0user-manual =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A04c22f3d Comments to user-manual (WIP)
>
>
> I guess that git-for-each-ref could be extended with behind / ahead
> information, perhaps as modifiers to existing %(upstream) field...

There's also a patch that adds sorting support to "git branch":

http://thread.gmane.org/gmane.comp.version-control.git/188705
--=20
Duy
