Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A8C677F1
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjAHSSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 13:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjAHSRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 13:17:44 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFCF2E8
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 10:17:43 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4a263c4ddbaso87343807b3.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 10:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xAEcRU57R2HsP+fvzi30b4DdMB6luLF5U9dj80D3eHY=;
        b=AJWmtEavTmWa6MU9SPwuR58hvSek0TJowOe0FemxiN4osRihfHe321EXnRr5iHFxTR
         jd8TusecVi1nG2nkOMS0z3u8ZzvB2kHlE0H+bRPWAVF1TxVgy7tkd/7dttE4umiRhYxl
         NiyAfedLzlH43TZNLI6fX5GEuTJvJyOa+iY8AusIR1JySrVNw1aF7/ze8KCCxgWmhZ1T
         9uFDhj+kTqSlswUAKBbwS3rmDYDYyvbveVr49m7fhEC3lJKe97x0TYgtwagHOkPoNizr
         8Ego+iG2Xn8Q6YZPWlc2NYhb13jIPVRGhojFlRV92SEW0MyIacnpyjL9GT5Onl3hIytR
         bjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAEcRU57R2HsP+fvzi30b4DdMB6luLF5U9dj80D3eHY=;
        b=BwDE1gX+xO/7kEr8nPeWEAJdJ9iWfh75uEubVySaH2QzucehQxnYJJ6uzjakLRyB28
         R99pVIjGdujeLBFxThKY7idR//6Oj8gQ0Xv0IEJrEKVBwfCCI5FjI3FMdhv1nc+egmMQ
         Ex54WF6ZA8ySVLKAbYV0t15Lz1rtNkqjuDDh1L92cbdqQGZNUMnP/dFx1q65/NsSTOUS
         H/tER8cAIYMvT9/0t4BfM1nh1MM/X7386rF3RBj99nIPKOxkXLGH9mM2XNRDVsDqGfuu
         FpLHCbSI10GczHAprUynwyPqnuCcEciCCFqh6ntGFYdT3DWqwPL61WIqCGe7acWKCUhj
         E0AA==
X-Gm-Message-State: AFqh2kqb9TxrIADSVphmsRWCSZwIDNziDSZTZoAUXqomqhS6C3G8pfmJ
        OHeKuhAR9PyPHq87/n5+RnLdso8DBDSiY3onkmvwmiW2YKY=
X-Google-Smtp-Source: AMrXdXvb/12FzlRbKVEpthZHc6c9IaXq6nMiee4u38GS+eFcVcKBOW+K+pLteGohdhv+d4eibgM/wqPMfMwOpitFthU=
X-Received: by 2002:a0d:ddcf:0:b0:370:4b5e:cb52 with SMTP id
 g198-20020a0dddcf000000b003704b5ecb52mr1465199ywe.157.1673201862353; Sun, 08
 Jan 2023 10:17:42 -0800 (PST)
MIME-Version: 1.0
References: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
In-Reply-To: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 8 Jan 2023 19:17:31 +0100
Message-ID: <CAP8UFD2huFgTjB1hNGyGnMKPONOG6ZV-wvxWkTaz-iZNfxrhJA@mail.gmail.com>
Subject: Re: Github actions failing
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Jan 8, 2023 at 11:07 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Hi,
> So I wanted to send the next patch after review.  All the tests pass
> when I run them on my PC but I get something like the following error
> when I test from my git branch
> >
> > + git checkout -b signed
> > 2283 Switched to a new branch 'signed'
> > 2284 + echo 1
> > 2285 + git add file
> > 2286 + test_tick
> > 2287 + test -z set
> > 2288 + test_tick=1112912113
> > 2289 + GIT_COMMITTER_DATE='1112912113 -0700'
> > 2290 + GIT_AUTHOR_DATE='1112912113 -0700'
> > 2291 + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> > 2292 + git commit -S -m initial
> > 2293 error: cannot run gpg: No such file or directory
> > 2294 error: gpg failed to sign the data
> > 2295 fatal: failed to write commit object
> > 2296 error: last command exited with $?=128
> > 2297 not ok 338 - test bare signature atom
> What could be wrong?

There is the following in the above log:

> 2293 error: cannot run gpg: No such file or directory

so maybe gpg isn't installed on the test system.

It looks like the test you added doesn't have the "GPG" prerequisite. Compare:

-> test_expect_success 'test bare signature atom'

with:

-> test_expect_success GPG 'show good signature with custom format'

There is a "GPG" prerequisite in the latter but not the former.
