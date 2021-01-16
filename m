Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7903AC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 10:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6982151B
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 10:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAPKkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 05:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbhAPKkW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 05:40:22 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D95C061757
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 02:39:42 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id p14so14293514qke.6
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qKXzVbn0ShsSkeyAvdcqfdcA6pVE3YfycAU0XnyuPYo=;
        b=b5KQI33EMSXKlB66b+rKTUgmMhqyacoga6RTGYAQdBShVJjnGKYa8g1guMA0aPjmQC
         Y8hiDQQbsiRLmQxz5cvILeNfoyeB3I8Lnp4jYpskDQer4rW3IcoL0wTncMwSeMRQ68XG
         A2ceu1LU4ni6++df4p9cppVwSV/eh+9dt1JR8VOBEEF9ZxfFyTKddZO4UWe1wHqLq2wE
         cLLmzHND98KhiYi7lTzwelhRcLm2cWKQ6JkPpLkaNMvTNhFh0eTR455NZfPt9agFSDvi
         H7u3cNOZZvbh1PsLG1dfdj4LCt3v5K16fAnR06shEf79IGjuwC4lUDBAg9KgfC8jb789
         ay9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qKXzVbn0ShsSkeyAvdcqfdcA6pVE3YfycAU0XnyuPYo=;
        b=X/Bcm/ZzmeZUwTpqydThz+DuEHufEjmu5BHwpvtXeVHQ+3CrffryKMD4c62jAJ0qkl
         6Eha3BJUA4bHCpmyAggXmCA+MLhnS6zu4aGPJdhl5Vxow5ZLMlElrCpGDrC5KjiiHTvF
         uN5NRMBcXAHKhwahiPmeudmiZvtyhufCYvl8DgKt4D2U2J553+Gpc91oC1W//4CV0aWy
         hRGBhjtODprzIA0AgnGyEGzKmX7JEcwAbPJ+x4mwVTNc8Pn7kLdvhbfctb0FnIwqP5Nw
         3hpIk8dUeI4Y2R40RtD5+rff1mt9bPImJZ7lIxzwenc9YKi4f+3ydE9k3Vc44yprazyN
         x+Uw==
X-Gm-Message-State: AOAM530R2Mha+fHcDdowbvYuUiebKrtDAouVLVugOWwqMGWbRSFFXWUt
        cmt3Fj3qSrgPNa+KG7JtANJd/tu+gtLyWXFlB/l5HzyR9GpgVw==
X-Google-Smtp-Source: ABdhPJx3Oh5/o6NR0zKv4eRxd2yTNWTbGM29qHhOpgAzfbQU4694LBLKeawX1CoCL10obRzcRxA/DutKonrylMLeP0M=
X-Received: by 2002:a05:620a:f92:: with SMTP id b18mr16580454qkn.146.1610793581509;
 Sat, 16 Jan 2021 02:39:41 -0800 (PST)
MIME-Version: 1.0
From:   Chuck Ricketts <chuck.the.pc.guy@gmail.com>
Date:   Sat, 16 Jan 2021 04:39:31 -0600
Message-ID: <CAHS-jcAxNgZq4UNxyooftPn_nA_935THGdNHGk65UKURfkoTmA@mail.gmail.com>
Subject: Repository of repositories without submodules?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am cross-compiling many Arch packages with small changes made
locally in order to better suit a cross-compiling environment. That
being said, I've got a directory of single-directory git repos that I
would like to publish my changes to.

I ran into more than a few snags trying to figure out how to do this.
Firstly, no matter what, if git sees a directory in the repo with a
.git file or folder, it automatically classifies it as a submodule --
no questions asked. Of course, as submodules the contents aren't able
to be pushed (so far as I can figure out, anyway) because, I presume,
the assumption is that they're able to be retrieved at an alternate
location.

In my project, this leads to a few issues:
1) My local changes will not be pushable without pushing the whole
origin repository upstream to another location. I guess I could try to
strip down the history to only a few files to make it more manageable,
but in the end there might be a hundred or so different repos.
2) The changes I have made are very small, especially when compared to
the size of the repositories that those changes are based on --
pushing the origin repo upstream is potentially wasteful even given
options from #1.
3) Using the submodule method I would have to originate every
subdirectory as a separate cloneable repo just to get them organized
into a directory structure that makes sense. Of course, each repo is
going to have to be managed separately, which adds tremendously to
project overhead if it's a public repository (which I plan it being).
Of course, that's no to mention the potential nightmare of having to
keep those submodule references updated.

In my eyes, it would be so much simpler to tell git "Hey, I know these
are repositories, but just ignore that, mmk?" This way I can still
manage each folder as a separate repo for merging upstream changes,
etc. and I don't have to deal with any of the other issues.

I bypassed this issue by bare cloning all of the separate repos into
an ignored subdirectory. Then, I used worktrees to check them out to
the locations where I want them. And, finally, I had to use some shell
scripting hackery to create and destroy the .git file in each of the
subdirectories as I move around so that when I go to add files for
commit git doesn't think it's a repo and treat it like a submodule
against my wishes.

I mean, it works, but it doesn't seem like a good, correct, or
especially sane way to go about it. Surely I've missed something?

Chuck Ricketts
