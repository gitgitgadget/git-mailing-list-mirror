Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E401F404
	for <e@80x24.org>; Thu, 28 Dec 2017 10:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbdL1Kbp (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 05:31:45 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:45697 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbdL1Kbo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 05:31:44 -0500
Received: by mail-vk0-f54.google.com with SMTP id o16so24358452vke.12
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hF3EJ400hAAbbwD+bqhpke33Dn64pUDeOIPw4MpbV2M=;
        b=SiPnT9dVj9yQTYD/p6GZ/8EXv3dL0kMuRXaov+Ff7ptbY9EY/3R/6IOxJ4rK6C/4bO
         JqdOJH7x82tjfx08DEnIKap39vnzkjuC+SabIVYG/FQ9Z9YosHh51M/Eb9PnvMXzchi9
         l4wBoNgPo084URhvCSkJRYa+J84jF+GowcPQVGOpGMCYFzyEG8ewgx+Yld4PGRdmMg44
         0oWNZft3EciHdXuRu8R+TWw8I3Xpb5ZuKMQCzQKpXpAI8thvPmkdppOl+JXKx6hULVaH
         GFydx3KmTUyNrZptWHRPCXfEVjtehNy5zBL9NQYqPnjp9I280OcvHHIrGxcUVPK9pYHa
         4Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hF3EJ400hAAbbwD+bqhpke33Dn64pUDeOIPw4MpbV2M=;
        b=DqA+S9GpRRe4jZBgU3L3VWhBMGL3JKYIBRyd9yUFV6lJOPYp408p13PmOvj17kKkzv
         dBZfBmVhZcjxXv/RB7NByyowfrsTiZ8hJajd5W5umFvMGLX+BCDGDw70BB3iK5mzcccW
         a6D8XbO1VGsHjJhC0rin/XUPE6mv5NHUKeRxjkoK1REaDYrLotSazBqPY1iQk8F10B/c
         RGcDC4L8idBImqw00LgkhYrmG6Vw5K+vLlYUDJO3EhVOiG4LfWb8IXK0yiGEjRFI01+z
         lA3JIPRqNZpz8I6shuge7hwtTAfjzHMrKe/qYQwshfAAmQHFCSWzIHyZ6PJIPcNTl1mw
         N60A==
X-Gm-Message-State: AKGB3mLFYsY/NBGFGAYnxzDrP6ykoPidWRt5r3p6C/CdVoTm1SwZFmYA
        Yooc+O69REIf6tHA5wfEdTF5ELBRWlocUVgjdus=
X-Google-Smtp-Source: ACJfBosekDG+QQhUx/FKV6hsVU930p5gLLUQJhqElzBTnyK4X/p6FD6AWdp0AyTWpcxPS9FPGtejvMflokcvUQNh57E=
X-Received: by 10.31.94.14 with SMTP id s14mr29629499vkb.6.1514457103205; Thu,
 28 Dec 2017 02:31:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.46 with HTTP; Thu, 28 Dec 2017 02:31:42 -0800 (PST)
In-Reply-To: <332E6163-C09C-426F-80BE-084D6D6D5AD0@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com>
 <332E6163-C09C-426F-80BE-084D6D6D5AD0@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 28 Dec 2017 11:31:42 +0100
Message-ID: <CAM0VKjmCodQgmTa8bjEc02N99cPjrFdp4rFGF3yQOA-VMer4hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 8:35 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 27 Dec 2017, at 17:49, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:

>> Using an ever-growing flat text file might seem like asking for
>> trouble on the long run, but it's perfectly adequate for this purpose.
>> Contributors' topic branches are short-lived in general, so this file
>> won't grow large enough to cause any issues.  Grepping through several
>> tens of thousands such lines is sufficiently fast, so not even
>> git/git's forever living integration branches will cause scalability
>> issues with the current rate of ~1 push/day for a couple of decades.
>> And even if we reach the point that this file grows too big, the
>> caches can be deleted on Travis CI's web interface.
>
> One more thing:
> Maybe we could delete "$HOME/travis-cache/good-trees" if the file
> has more than 1000 lines *before* we add a new tree?
>
> Or we use something like this to cap the file:
>
>   echo "$(tail -1000 $HOME/travis-cache/good-trees)" > $HOME/travis-cache=
/good-trees

Well, there is always something new to learn.
I was aware that things like 'cmd file >file' don't work, because the
shell opens and truncates 'file' before executing the command, so 'cmd'
will open the already empty file, but I didn't know that 'echo "$(cmd
file)" >file' works.  Thanks for letting me know.

However, this is subject to the portability issues of the shell's
'echo', i.e. try

  echo "$(cat git.c)" >git.c

with Bash and Dash.  Bash produces the exact same contents, but Dash
turns all '\n' in help and error strings to real newline characters.

Now, Git's object names will never contain such characters, and most
likely $TRAVIS_JOB_{NUMBER,ID} won't ever do that, either, so this is
not an issue for this 'good-trees' file.  Still, I think it'd be better
to stick to using a good old temporary file:

  tail -1000 good-trees >tmp
  mv tmp good-trees

> I agree that the "always growing problem" is not a big one
> but an approach like the one above would avoid any discussion
> for sure.
