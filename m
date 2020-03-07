Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43763C10F00
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 19:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C7020665
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 19:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="niA9EF19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGTil (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Mar 2020 14:38:41 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:39561 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgCGTil (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Mar 2020 14:38:41 -0500
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::65])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id A428B11C1D32;
        Sat,  7 Mar 2020 22:38:36 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback14o.mail.yandex.net (mxback/Yandex) with ESMTP id Knt9IsvbOo-caPCg9ps;
        Sat, 07 Mar 2020 22:38:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583609916;
        bh=zxNbNUPBrkCu7UOTm2nkof0tEMemyv8f9uBHEosfmAI=;
        h=References:Date:Message-Id:Cc:Subject:To:From;
        b=niA9EF19X+fzLzX9rB8cI+IiIYZ94RBBClXu6jH331kqf97WVh9AABex3IxVde6CZ
         h6mMkKkvVrkhgsUPzlm0JnHL+vOcq015JztrpkM5v7XMETpAmxuWfRc+oEwoq69BtV
         4H4gzG3+WrQhEURLY9KceTQWjvO6B8e0TuvwS1ik=
Authentication-Results: mxback14o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-eb6256e01f8b.qloud-c.yandex.net with HTTP;
        Sat, 07 Mar 2020 22:38:36 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
         <3165171583586403@sas1-2bf44b70450e.qloud-c.yandex.net> <CABPp-BECOarg+G-_oz83i0EuKuypJQA=wyjnfG4U0heG=0L0hg@mail.gmail.com>
Subject: Re: Git Merge 2020 slides and reproducibility
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 07 Mar 2020 22:38:36 +0300
Message-Id: <3207561583597253@iva2-fa9fd5fad11f.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



07.03.2020, 19:03, "Elijah Newren" <newren@gmail.com>:
> On Sat, Mar 7, 2020 at 5:38 AM Konstantin Tokarev <annulen@yandex.ru> wrote:
>>  06.03.2020, 18:00, "Elijah Newren" <newren@gmail.com>:
>>  > Hi,
>>  >
>>  > Had a few different folks ask me at Git Merge about slides for my
>>  > talk. I said I'd post them on github somewhere, but in case you were
>>  > one of the folks and have a hard time finding it...they are up at
>>  > https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf
>>  > and steps to reproduce the speedups I got can be found at
>>  > https://github.com/newren/git/blob/git-merge-2020-demo/README.md
>>  > (though be forewarned that the code is has lots of fixmes & ifdefs &
>>  > other problems, has awful commit messages, etc.; I will be cleaning it
>>  > up soon).
>>
>>  Hello, I've just tried your branch on my repository and it seems like it can
>>  be a salvation from all rename-related pain that I'm regularly facing when
>>  doing merges and cherry-picks! Thank you very much, I hope it will be
>>  integrated into mainline soon.
>
> Wow, thanks for trying it out. Please note that while it _might_ be
> okay to use for real work, I am not that confident that it is.

Do not worry, I've made full copy of repo before trying anything.

> There
> are a number of factors making the 'demo' label I gave it a rather
> fitting one:
>
>   * I only started using it personally on a real world repository (or
> two) about a week and a half ago. (Before then, I knew merge-ort
> didn't work.)
>   * The second real world repo I used it on uncovered a bug in my code
> that the testsuite didn't catch[1]
>   * Although I've tested with two real world repos now, that testing
> was very minimal; I was focused on getting the demo ready and
> implementing as many optimizations as I could.
>   * While the outer merge, rebase, and cherry-pick commands will
> accept a bunch of merge-machinery options and pass them along,
> merge-ort flat ignores them all.
>   * merge-ort is hardcoded for merge.directoryRenames=true, when the
> default should be merge.directoryRenames=conflict

directoryRenames=true is actually one of features which I was badly
missing and somehow overlooked.

>   * it has a bunch of FIXMEs, some of which are code cleanliness
> issues but some of which represent minor bugs
>
> [1] https://lore.kernel.org/git/911de63afa274b0791e4d4252934a5e9b0031f10.1582762465.git.gitgitgadget@gmail.com/
>
> Also...
>
>>  However, when testing my previous merges which had to be done with helper
>>  script, I've encountered case of
>>
>>  CONFLICT (directory rename split)
>>
>>  Is there any way to prevent conflict in this case if files are the same, and
>>  merge their contents if there are differences? I think it would be reasonable
>>  to assume that move done in newest commit should win, and allow user
>>  to change strategy via command line option, provide explicit hint where files
>>  should be moved, or maybe even decide it interactively.
>
> This conflict message is known to trigger in some cases where it
> shouldn't; it may be that you're just experiencing annoyance from
> that. Let me fix that issue before worrying about workarounds.

Well, in my case a directory of files was moved path A in one of merged heads
and to path B in another, so I guess it was legitimate.

Are you going to continue development in the same branch?
When do you expect it to be ready for review?
-- 
Regards,
Konstantin


