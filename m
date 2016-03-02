From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Rebase performance
Date: Wed, 2 Mar 2016 11:13:44 +0100
Message-ID: <CAP8UFD2=xzn=GJLHjWD0R4TpFb3JauGAHYW0nSb+B4OAoh-0Vg@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
	<CACBZZX7rVAdzfCm=0FdrCXSx8a2=a8n7pjq1ZSW-V3fzmaSGWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 11:13:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab3n0-0000V2-1W
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 11:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbcCBKNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 05:13:49 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35971 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbcCBKNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 05:13:46 -0500
Received: by mail-lf0-f51.google.com with SMTP id l83so84309824lfd.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=0bN8eKgLj6UP/uATHfeThOvFNMcwONIW+au0sBdT8So=;
        b=Bj8Nmk0M+u+QpYIyIHX/fi66hS69JEAPHEAxswXxny3P1gD/1PzIv3BaTMlK0r65SD
         exENgNLAF8TNgCp9VdP4Uf3h3KqUUAfZgs1eV18o1BeEtSQIsYwm8svPSPAUbkGx0KOv
         JjsdocvkM+USZCjjZvmX+Cj05HwB11j5hBlpOu0CuSIyouWd1gTFu7NwvwDw2tu9D7M5
         WXndfDs8fTzhClwPzxvKxahmgyUn1X5xt/nYxe6jU/sQDnL0fvgdpjSQNL37EB0wylp7
         XmvIzULwlsaigYXckYSYBJI9V0H87LwV7+gwq2+jLne5H+ltskglbVe8JS+3As9BbUA9
         bWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=0bN8eKgLj6UP/uATHfeThOvFNMcwONIW+au0sBdT8So=;
        b=YxXd2tGNdhwh+70EteMMIM7TB8Qkc2yzDFFjg0GU3eRPJutDc/5KStkzjwzORDo6L3
         CQTHyjk68AgCj7N8ng07ADIVA+pGZ2ScnOGaZo/HOdbWPxxN/x/wZ2v+D7yTkb7rW3bJ
         liaLiR8YduVzAJBgnH2zsZg7ON5GsYZ9RWoEQeKxR6Imduu2fdkQxSEvtTGW61F4gB/2
         G8o2zrQ/ptb4OsRhi9jDbpya5L6T8gUQYmmAdZfbe/PhhPjLB79H+QVo/ssvAsdkgZXX
         NkkKnadjTFtGa7u1pB5NaSjXfCdnTrQStpDsQulASrST4vSlHphF3vrtmA6UyjdcWks5
         3u1A==
X-Gm-Message-State: AD7BkJIaSgBzbmTlVRdYNRWYaOh91mNUCIp+6rRFYmODQ8BOM7t8GEgp+WRxWKO4DZ3W+c1a8rEDpEFygzmb8w==
X-Received: by 10.25.213.196 with SMTP id m187mr9976077lfg.67.1456913624444;
 Wed, 02 Mar 2016 02:13:44 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Wed, 2 Mar 2016 02:13:44 -0800 (PST)
In-Reply-To: <CACBZZX7rVAdzfCm=0FdrCXSx8a2=a8n7pjq1ZSW-V3fzmaSGWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288120>

On Thu, Feb 25, 2016 at 5:31 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Feb 24, 2016 at 11:09 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>
> [Resent because I was accidentally in GMail's HTML mode and the ML re=
jected it]
>
>> If there was a config option called maybe "rebase.taskset" or
>> "rebase.setcpuaffinity" that could be set to ask the OS for all the
>> rebase child processes to be run on the same core, people who run ma=
ny
>> rebases on big repos on big servers as we do at Booking.com could
>> easily benefit from a nice speed up.
>>
>> Technically the option may make git-rebase--am.sh call "git am" usin=
g
>> "taskset" (if taskset is available on the current OS).
>
> I think aside from issues with git-apply this would be an interesting
> feature to have in git. I.e. some general facility to intercept
> commands and inject a prefix command in front of them, whether that's
> taskset, nice/ionice, strace etc.

I started to take a look at that. It could be done in git.c but would
be a bit involved as we would have to check the config option or the
env variable that describe the prefix command early and exec the
prefixed command while disabling the config option or the env
variable. I wonder if people would prefer an env variable or a config
option by the way.

>> Another possibility would be to libify the "git apply" functionality
>> and then to use the libified "git apply" in run_apply() instead of
>> launching a separate "git apply" process. One benefit from this is
>> that we could probably get rid of the read_cache_from() call at the
>> end of run_apply() and this would likely further speed up things. Al=
so
>> avoiding to launch separate processes might be a win especially on
>> Windows.
>
> Yeah that should help in this particular case and make the taskset
> redundant since the whole sequence of operations would all be on one
> core, right?

Yeah, all the applying would happen in one process, so hopefully it
would not be moved often to another core or cpu.

> At the risk of derailing this thread, a thing that would make rebase
> even faster I think would be to change it so that instead of applying
> a patch at a time to the working tree the whole operation takes place
> on temporary trees & commits and then we'll eventually move the branc=
h
> pointer to that once it's finished.
>
> I.e. there's no reason for why a sequence of 1000 patches where a
> FOO.txt is changed from "hi1", "hi2", "hi3", ... would be noticeably
> slower than applying the same changes with git-fast-import.
>
> Of course this would require a lot of nuances, e.g. if there's a
> conflict we'd need to change the working tree & index as we do now
> before continuing.
>
> Has anyone looked into some advanced refactoring of the rebase proces=
s
> that would work like this, or has some feedback on why this would be
> dumb or that there's a better way to do it?

My opinion is that such advanced refactoring can happen on top of
libifying the "git apply" functionality, so I started to work on that.
