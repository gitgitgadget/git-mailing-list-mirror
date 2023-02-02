Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F8C636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 17:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjBBRUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjBBRUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 12:20:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B10B7377D
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 09:20:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r2so2353681wrv.7
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1Qj2KhoZ2ckQGD0tiZYlB5HYM99DpRV4AoSyve8OLc=;
        b=jE1OxTWy94/QLfDZzfNjWtEma/fbyoa30PLHKWxAJEwr1vENYED8ksVQLgehjbrBKB
         EoFwwet7dtNHoYSBJgdrj1GhHMfWaXMBSL6pZmGwXMo78+IkpmLUjTc//2jgqMBbHIjQ
         607OBHcN6NZIrtof2897Iu/4px/RTojwpcZ4ydixr6qHUJI8/fj1of3DK3XnA4DRp5qJ
         mXVOhkGZX0Ju+K7m6/AiVoDshLNmOyLtDhAr+VJAU6oHtl20hKLzxj5f3BMAJ4CrWd5q
         mYwngc+69fS0tMlwVeQxcsYXWtFkLsFL2ZKI9KEJd0gECgY37lDoTvgUQUroAIX8h5/p
         Ze1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1Qj2KhoZ2ckQGD0tiZYlB5HYM99DpRV4AoSyve8OLc=;
        b=D9GoLAQ+HhdVejbxjySmmNqKNqMiH7UAXbbrQhMI1AGDnJ3wvxS4tD2KDVDoylv10s
         mDsFivyLL+ILTbIJyac8ye35cSxgu9tlsKGIZN/0qt1Ek+Uzk4tRbyEiSitTa37IKpFN
         MvrV5r7AN4m57F3rew7gC+IUWvr8iOJvfP/FTtbi1TaPHjYvf+1YtiNX1EBiHNj9O70Q
         U4BaF9zyN+utSFEPG+faaI7iIknHD/q5lhhe7dTEW+2KH5Wbmfl4B0d5QCd2kevsvN02
         syR9c5RhsYR9SxZern8o5HdcL/U+2FGZALdm46O4oEnMOYr9aCSBXusM0/PyRjUlynS2
         fc7w==
X-Gm-Message-State: AO0yUKULudUCgumlduzQExXO7zojORpKjW3xd/GkLh/0U589MzSZZYeZ
        e7hZ6WEeLdXHCGd6WdwVIbUZzFwAc/t0+5hvATw=
X-Google-Smtp-Source: AK7set9BZkM2XOOAtH9DA+L1Sy1cBprg9sV3H2h+0JpNl2hnJm7cQfoE4n6FtuMkLXXTktxGNLL+HzvOLzxR/l8TqFk=
X-Received: by 2002:a5d:4611:0:b0:2bb:8d0:983a with SMTP id
 t17-20020a5d4611000000b002bb08d0983amr202944wrq.322.1675358443787; Thu, 02
 Feb 2023 09:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com> <b9a38b83-cdfe-0389-3097-c20a699f183c@gmail.com>
In-Reply-To: <b9a38b83-cdfe-0389-3097-c20a699f183c@gmail.com>
From:   cheska fran <cheskaqiqi@gmail.com>
Date:   Thu, 2 Feb 2023 12:20:30 -0500
Message-ID: <CAMO4yUHJCWGNV7esYqC7T4HB=pv3=Z4vTfaBFzh9hAsftfnN3w@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/t4113-apply-ending.sh: Modernize a test script
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei,


Andrei Rybak <rybak.a.v@gmail.com> On 31/01/2023 21:21=EF=BC=9A
> For patches that change a single test, the subject line can include just
> the "t" and the number.  The part after the colon should start with a
> lowercase letter.  Something like
>
>      t4113: modernize test style
>

Thanks, this tip is really helpful. I will change it.


> Commit message should start with description of the existing problem
> in present tense, something like:
>
>      Test scripts in file t4113-apply-ending.sh are written in old style,
>      where the test_expect_success command and test title are written on
>      separate lines ...
>
> Then changes should be described using imperative mood, as if you are
> giving commands to the codebase.  See section "[[describe-changes]]"
> in "Documentation/SubmittingPatches" for details.

> You can also find examples of existing commit messages for similar
> changes:
>
>      $ git log --no-merges --grep=3D'modernize' -- t
>
Thanks,that is cool! I tried it and I saw a lot of examples and their
descriptions were very clear and I learned a lot


> In case of t4113, files "test-patch" and "file" are created twice.
> The second creation of the files could be either its own step
> 'setup for apply at the beginning', or incorporated into the step
> 'apply at the beginning'.
yeah,once before the first instance of test-patch and then again
before the second instance of test-patch.
I will move the second creation of the files to its own step in setup
for apply at the beginning.'

> Section "Recommended style" in t/README also has some notes about
> how heredocs should be indented.

Sure, I did not realize this.I will use "<<-" instead of "<<".

> While changing the quoting around test tiles and commands, the
> indentation with spaces could also be changed to TABs.
will do.

> If the setup code on top level of the file is moved into test
> steps, this comment and the "# setup" comment at line 11 will
> become unnecessary.
Thanks. It's easy to miss.The purpose of these tags is to distinguish
the setup and test parts of the script,
but if the file creation has been moved to a separate step, then these
tags are no longer needed.



Thanks for the reply and it is really helpful!

--
Thanks,
Shuqi
