From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Rebase performance
Date: Thu, 25 Feb 2016 17:31:04 +0100
Message-ID: <CACBZZX7rVAdzfCm=0FdrCXSx8a2=a8n7pjq1ZSW-V3fzmaSGWw@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 17:31:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYyp7-0007H2-TB
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 17:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933125AbcBYQb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 11:31:26 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36292 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbcBYQbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 11:31:25 -0500
Received: by mail-qk0-f170.google.com with SMTP id s68so21294018qkh.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 08:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2NdXGj2IEikJfsJsVfelQyvsg8WkGvcTvwkqFHpimFo=;
        b=h/Sw/alLZssWA3089z2cI1Pj/HgspaXtfiJPlmqzOaC3isxeyEL2nsN6DDy1GQdWW0
         vcf2hIE9tsOEgLhfN39RNPqNIy2haTKfB1+yQrs+B3Q/EhqTCOEhlobB/PIcaySa1TGd
         df0WjZ3to6aSu8lspCt2YuARzTdXmru/uM66PJ+7LOrqVSo7jfudtPKn37hm9I2uZY5t
         yCSL2IDL4ATdDJL1ej+9KUyLyQXQSwc81hY/xA4aJ7tVR6Ow1MXwDXH7gxEtodRcQ8IO
         47Ka9QfSL/DiFVw8EZxnbu65/B20pgPG3i2/jqNe96J71mH3uPFP8ESHUpUwJQtB9XRP
         HEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2NdXGj2IEikJfsJsVfelQyvsg8WkGvcTvwkqFHpimFo=;
        b=LW1A82OJp/DjztFc2pJkPqX+cgMip0NJ5MEqHsxI6GaqtTJeEr9xROn68ukE5sYDtC
         s1994Kpgvcr/LqHFjTXUGo67YNa5q1kfvcScJTFKpKtCUMy3eLaOLphaDoE0++VrDEwH
         tx7P6vCBNBcjGHUWkTSp5HXuqnu/jo2E6qWXimzbGiTgaRiWX4KZiIJ1/dI/551dNCsZ
         XrLgLNKff3RmRwjGhltilyxtIDrcfIS8Vdx7N6NZC8Yu2suw1TfIT2GVhAA3tJ+n75V4
         LG1W9gLa/Hz2w4PUB0HeV/1zgSIhsGmA3Qx6suYVlheiA6Ar0fjnp6NJ0m28eix7z/X+
         RTpA==
X-Gm-Message-State: AG10YOQdfvBExrTaL4qGPN3Q1Y60pdJuDi1pL3qaFZpEGDqGlcm6enBDw+wv9Y+tTG5O8Lq3m8CLjK98FOsayw==
X-Received: by 10.55.203.200 with SMTP id u69mr35508932qkl.51.1456417883603;
 Thu, 25 Feb 2016 08:31:23 -0800 (PST)
Received: by 10.55.77.82 with HTTP; Thu, 25 Feb 2016 08:31:04 -0800 (PST)
In-Reply-To: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287398>

On Wed, Feb 24, 2016 at 11:09 PM, Christian Couder
<christian.couder@gmail.com> wrote:

[Resent because I was accidentally in GMail's HTML mode and the ML rejected it]

> If there was a config option called maybe "rebase.taskset" or
> "rebase.setcpuaffinity" that could be set to ask the OS for all the
> rebase child processes to be run on the same core, people who run many
> rebases on big repos on big servers as we do at Booking.com could
> easily benefit from a nice speed up.
>
> Technically the option may make git-rebase--am.sh call "git am" using
> "taskset" (if taskset is available on the current OS).

I think aside from issues with git-apply this would be an interesting
feature to have in git. I.e. some general facility to intercept
commands and inject a prefix command in front of them, whether that's
taskset, nice/ionice, strace etc.

> Another possibility would be to libify the "git apply" functionality
> and then to use the libified "git apply" in run_apply() instead of
> launching a separate "git apply" process. One benefit from this is
> that we could probably get rid of the read_cache_from() call at the
> end of run_apply() and this would likely further speed up things. Also
> avoiding to launch separate processes might be a win especially on
> Windows.

Yeah that should help in this particular case and make the taskset
redundant since the whole sequence of operations would all be on one
core, right?

At the risk of derailing this thread, a thing that would make rebase
even faster I think would be to change it so that instead of applying
a patch at a time to the working tree the whole operation takes place
on temporary trees & commits and then we'll eventually move the branch
pointer to that once it's finished.

I.e. there's no reason for why a sequence of 1000 patches where a
FOO.txt is changed from "hi1", "hi2", "hi3", ... would be noticeably
slower than applying the same changes with git-fast-import.

Of course this would require a lot of nuances, e.g. if there's a
conflict we'd need to change the working tree & index as we do now
before continuing.

Has anyone looked into some advanced refactoring of the rebase process
that would work like this, or has some feedback on why this would be
dumb or that there's a better way to do it?
