Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F732C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 20:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiANUZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 15:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbiANUZK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 15:25:10 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EB0C06161C
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 12:25:09 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso11414097otr.6
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 12:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KwXmEVx1xa1gHxAulDWE/ymnqq22UzHwIXHACQHRR8k=;
        b=I6gm9aZIi0JQTji0t28uCBJjffBBUnx8PSuHaZ4agYg9OdOt4AZaJCsKRNHK73A9ty
         AVPeinFQaz3z++tKJMBxE00UmKSTe31Hqrrhsw4JwbVASKu0VSLAXGJ4svo3icqlrQt6
         CbcQXDF5kcyBGp+BN0WdqtJ2nDAKbEeJ1gK6A8Jp+aCOM+H3QljBPOQrsTXTqv4nTmCR
         1TWjQFZH9BrZqeUsxEhr2MW7Fgj/aVfgOKA0pVUQR5jyDhgV+K4oQD++ITj4gwS29bGb
         P4l2CBMOLsfYRfVKYu59LobOiWvsIQAQZc3WIBeAcxeikp7MK3AGjjKnA1NL5ta0AW8C
         rqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KwXmEVx1xa1gHxAulDWE/ymnqq22UzHwIXHACQHRR8k=;
        b=4T2H8SM6KM/OX3RwmM7WYqMkeLvYjECVs/v7TzsxaHm/9KFi11RSDXBKxBYgsiE1Tg
         isLIcO/lEzAi23PJSXukqdCJKFhr1+KeHv+Qqmx/z5DxqoXPdiFHIlwco+opqGygranN
         zUJCdvHnfEzkm7qOTnnNuB7yrA0GC4+nK/3Olf6R8NNV68OL2L7JwN+geBfFV5HV1ErN
         kNeyzDuyY0UyUlJKKZiAKcxhmmJEpquq55OUdF14W4L4Forljjj24fzRbUR9YS10zkWe
         ZjvoTVrqJ075GXYa3g7V8qn+HHNbcoDq687uc6dzM5GOMzJYZhzClZEXR2CU8f/EWjGN
         mwJg==
X-Gm-Message-State: AOAM533YgYEAW/anlSSuPjfi7qb6R9//ztQV1g9nYlAcYB7whHOYKj3+
        b14PwOJyhdoOXUL6N7D4GEmP+n8i7pHUfvGoZHyb1B4YlPQ=
X-Google-Smtp-Source: ABdhPJwVRMShu5S6LCXHSolqycQSX53eiUO9vVZ37XEHtsu0D9J4qSqUu0gC3PhO2sAmg+ahsKUrA6WOrlWQ3J2LAYQ=
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr8131957otn.285.1642191908898;
 Fri, 14 Jan 2022 12:25:08 -0800 (PST)
MIME-Version: 1.0
From:   Glen Peterson <glen.k.peterson@gmail.com>
Date:   Fri, 14 Jan 2022 15:24:58 -0500
Message-ID: <CA+LnoU=MwKiyY6+MUWUj=SpgGrg2RVabNY_vtBbBicAsW2ZzjA@mail.gmail.com>
Subject: `git commit` with the `--author` option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for git!  I use it hourly.  It is orders of magnitude better
than vcs, cvs, subversion, clearquest, sourcesafe, and a number of
others I have used, but can't remember right now.

I was excited to see the `--author` option on the `git commit`
command, thinking that I could use it to set arbitrary authors for git
commits.  Reading the docs, I expected to use it to, "Specify an
explicit author using the standard A U Thor _author@example.com_
format."

It seems from stackoverflow and this list that git won't do that
unless you have an author specified in your config somewhere (`git
config user.email` and `git config user.name`)?  Links to sources
available on request (your system rejected my first email).

Does the email you set in the `--author` option have to match the one
in your config, or can you set it to anything once you have a random
user.email in your config?  Is this option just for choosing between
pre-configured emails?

I think this option would be much more useful if it worked without
also setting your git config.
