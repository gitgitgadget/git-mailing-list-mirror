From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git .lock file error
Date: Thu, 30 Sep 2010 21:16:47 +0000
Message-ID: <AANLkTi=H0vhNJTT9uWYXmy=45_wrvb0xwjRSHvAETiAB@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
	<AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
	<AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
	<AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com>
	<7vbp7fhtt0.fsf@alter.siamese.dyndns.org>
	<AANLkTinFJ5rSA7Om0ZxhuqzQiqEDvJ+JoEQFpz=NDvxE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 23:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1QUn-0006yx-WC
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 23:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab0I3VQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 17:16:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56881 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756831Ab0I3VQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 17:16:48 -0400
Received: by gye5 with SMTP id 5so843812gye.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sdPQmr0xo89AF5OxHWa/aGecZe3VWE5+BxlVHv40fHs=;
        b=PTiY7ik71gHbABmekmlHUZh2rQsV+DUGU6BRsnKRdPRuZk7XClp1S8/NLWDhLHLMcs
         7NkBAzqEsyrHVlosf4iQgNq8sQUqv0hrQEpigSombpDfp96eWfftdSrrPsrrMCnL4DMF
         wfIQeDjVx9t/+FdxJ2S1ZeX5u3m7ghc9nfbaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gay6pGMZ1QGSjwF99PBQl21tEW0xwDiJ70Z2QO0/S242jW3LCJ3xQdpO1oIegWrIAz
         3cAY7djchhDoPw7Y8+VPJAXJoDF6mJbeZ5rdU3R4eS455gCXajdQVZsSWdCHW84p1Bq+
         /22GxGjmWVmyfsB/Obv5QrfV1WdutRmAFRh3c=
Received: by 10.231.167.80 with SMTP id p16mr4459090iby.119.1285881407486;
 Thu, 30 Sep 2010 14:16:47 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 14:16:47 -0700 (PDT)
In-Reply-To: <AANLkTinFJ5rSA7Om0ZxhuqzQiqEDvJ+JoEQFpz=NDvxE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157714>

On Thu, Sep 30, 2010 at 21:10, Nate Parsons <parsons.nate@gmail.com> wr=
ote:
> On Thu, Sep 30, 2010 at 4:15 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> > FWIW I think this is more readable, but maybe we want to retry on =
all
>> > platforms:
>> >
>> > =C2=A0 =C2=A0 my $fh;
>> > =C2=A0 =C2=A0 if ($^O eq 'MSWin32' or $^O eq 'cygwin') {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Try 10 times to open our lock file, =
in case Windows is lagging
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 for my $try (1..10) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysopen($fh, $db_lock, O=
_RDWR | O_CREAT);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last if $fh;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > =C2=A0 =C2=A0 } else {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysopen($fh, $db_lock, O_RDWR | O_CREA=
T);
>> > =C2=A0 =C2=A0 }
>> >
>> > =C2=A0 =C2=A0 warn "Couldnt open $db_lock: $!\n" unless $fh;'
>
> I agree that this is more readable, although I don't think there need=
s
> to be separate code sections for each OS. If it's a good OS, it will
> only loop once. You would want to die or croak instead of warn,
> though. It needs the lock to continue, right?

Yes, right. Meant to write croak() not warn() there.

>> What exactly does "Windows is lagging" mean in the above?
>>
>> Why does sysopen() randomly fail and why does it succeed (sometimes)=
 when
>> it immediately gets retried with the same argument? =C2=A0Is this a =
shared lock
>> and is used by some other processes that drive git? =C2=A0Why does t=
he issue
>> manifest only on Windows? =C2=A0If there are competing processes, wo=
uldn't it
>> exacerbate the situation to run a tight loop to try grabbing the loc=
k
>> without waiting, like the above patch does?
>
> All very good questions, and I don't know most of the answers. I know
> that sysopen() is just a thin wrapper around the 'open' system call,
> so the problem has to be with Windows somehow. It probably doesn't
> happen with other OSes because they're better at files :P
>
> I have verified (to the best of my ability) that this problem happens
> even when TortoiseGit is not running, and I don't have cheetah
> installed, and there are no other 'git.exe's running. I considered
> putting some sort of sleep() in there, but since it worked so well
> without the sleep (it only retried once at most). Fetching multiple
> revisions is slow anyways, so I don't think a 2-second wait would
> hurt, though.

Maybe this has to do with our assumptions about being on a POSIX
filesystem, doesn't Windows have different semantics if two processes
open the same file, or something?

Blah, I don't know. I'm about as clueless when it comes to Windows as
VMS :)
