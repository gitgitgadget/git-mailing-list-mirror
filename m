Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE71BC10DCE
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 19:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36D9206D5
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 19:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJkj4sUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCHTR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:17:58 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:44995 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCHTR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 15:17:58 -0400
Received: by mail-vs1-f48.google.com with SMTP id u24so4708347vso.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=59grH3iyN0bQeIn9psiLb+NmzKbvIZ4G80oCUE3EHrk=;
        b=nJkj4sUhlab+3ccjeUCYUHXwEv6nQg29g/Kd/HSytipokssFaf0W5D1Pcc7YrUrm7i
         HXl04tYFELjbMFPobp3iyADibWb27OkpvMyLTGrq55tiXto8why+1I2YpsEfeEFT8ivV
         fs8ZcoyAKIiosY4Hy/sxDl4OzdfqyVEPmEUf5lC76+B0ixA6vTeILVli//FLMPZAU9s5
         IqgvlfrE5j7yoShFs8Hb3NuPrPmMEgcP0Q8dF1sLTlSq84DnzlR5odm7h23gdVKGlR7z
         V1lqD2HoSGYGVHVAVQ92LEL7SrqndwRilKx9fadjaIKxY2zVnLzhF1NEwS1SiEILDnKN
         b5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=59grH3iyN0bQeIn9psiLb+NmzKbvIZ4G80oCUE3EHrk=;
        b=f6krhNdewB29yXRf027KfpGdxN0s1jEg+Xh/6Qi8z27H2u3XYdMMSRpJjIW572Dubv
         CFShmPvg5/OaEAm98x1+hUuJ4IavEdAtWTSHeycazvatvfn7Uhinh3ko5thN5Kpe51Y3
         XE2DRaVj6fwItasfYfw7PU0ohgbSGQbgEq2vTnVn4Rggin6gvXPSZsawmQoDC5yTcQd0
         2F3x6aYYonIxbERPsVMSQ3h64k5MAnFQOh/ZfyM0xVp7uDiQgM5Dn1luUqw9rMSQnwNz
         AghjBrqO/kFgCD+aqUgVfOYEq8zUPEGIMG+GKvWJKMu8PgIZGXuRwxN0O6b/t4sGDVnP
         WV2Q==
X-Gm-Message-State: ANhLgQ2a8BnTyzeHPqx3uBtXYAPdbIdibtTMy2T3aP7JmidGaSdHudv2
        flZJfv25CA/NXu4paNkTJFrwy8VGNh5EqGm9zj5rgLjO
X-Google-Smtp-Source: ADFU+vvsKe0qZKMP4VJN3jeRGhv/Fsl4bVKrLbl6irUOIpf0mziUgb4mFhnoDtSqgf6SHQ5/4SlwThn1CnwfxKLUawk=
X-Received: by 2002:a67:e98e:: with SMTP id b14mr8219448vso.106.1583695077205;
 Sun, 08 Mar 2020 12:17:57 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5aSp5Yeg?= <muzimuzhi@gmail.com>
Date:   Mon, 9 Mar 2020 03:17:46 +0800
Message-ID: <CAEg0tHTMHD1+3QaSe3Z+ymRKvOkbHnVqv-Xp2xhOT56SoHTmwA@mail.gmail.com>
Subject: Documented option "--deepen" is unknown to git-pull
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Option "--deepen" is documented in online doc of git-pull, Sec.
_Options related to fetching_, see
    https://git-scm.com/docs/git-pull#Documentation/git-pull.txt---deepenltdepthgt
But executing "git pull --deepen=100 origin master" returns
    error: unknown option `deepen'

More tests show option "--deepen" is known to git-fetch but not
git-pull, although the doc of git-pull says
    git pull runs git fetch with the given parameters and calls git
    merge to merge the retrieved branch heads into the current branch.
    https://git-scm.com/docs/git-pull#_description
which suggests that every valid option of "git fetch" would also valid
for "git pull".

Is this a documentation or an implementation problem? (I use git v2.25.1.)


muzimuzhi
