Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DAEC10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 23:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB152071B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 23:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjzbodTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgCJXQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:16:23 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43371 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJXQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 19:16:23 -0400
Received: by mail-lj1-f169.google.com with SMTP id r7so162808ljp.10
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 16:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TcnJORLuljdaH3L3bdhk83Zf3I9Od3WzoApeZXj3HRc=;
        b=OjzbodTYPb7qG+X664QAc7NHAY7qNhJ3WcpSDUqntzg0K/sG3YFbl8gzl49hP1ISeP
         eLn9oQ1obCbDdX9LsKP8drQ1ZxEVUCdfy5ByMFgsJTKfxmQkPLcAtKSBh6MMUTp2gLzC
         jpAXR4GDxPD5jEvrQoc62LJ6s20rNJEqphxVEE+OWpONw/WP2RFWKt2uqRfXXjhTtRl7
         4A1ZmRuy6SbeMVFcJSZPo5dG++ENz2O2upu31Whthb1Qwy414edxMXnUeSyppzBsLq8f
         E3X/eck6WmmEPG3qxEPxJ+AGFnlHzJvfeoM7S4+tloXyswgs4k4tULlzyN9fMYsjNOHH
         HsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TcnJORLuljdaH3L3bdhk83Zf3I9Od3WzoApeZXj3HRc=;
        b=LKfcQfqb/U0ScW+z8m0bf2q/C4Y/FqrORNB5MSPBrDu8sUUNl9PNzAH54txnNzKtP+
         RUpru6cBPT2ffPSGo5TzSuSBxzwcRAOK0LCrH8iZ2npTRpgtQeV2c9ndnqzC9dHSYAf7
         qc8GOI0kNZYN0zXIcF9/pwIuDj9+DZ81vdrtNkDcTSxmMxiQcsETxQEJ7jdimOb5BWI6
         u5ltVDKExLNNvwuJx/uuqJVXy8ZraU//YqgsdYCYTgOQNgbB8Cyk6kb6uRYfOshDLUIW
         Vv1UHyhARuZmwy1vTjWOFFpe020uNjX1ZGg7pjdJ+gxDSbTBugXRgEoSNAVdtmRGE9Xc
         95tA==
X-Gm-Message-State: ANhLgQ2OExwyqNqLs31VIM1RNicX1U8nhzO7/BYxJAt3hImTLrFiCLIt
        KCQ5L9+n3T9q2JIZVoPi1HZtjklGJJ1Mnel5VAs7u/dZ
X-Google-Smtp-Source: ADFU+vvbV+s6lbMM9idUj5pnbbAMTwM7JNd7UwF5j+1Mvey0RLbq6Nbqq/XPXZ8D3hCThcQovp16jOvlkXUtywuCnxY=
X-Received: by 2002:a2e:3615:: with SMTP id d21mr290461lja.213.1583882179347;
 Tue, 10 Mar 2020 16:16:19 -0700 (PDT)
MIME-Version: 1.0
From:   Christos Pappas <chrispappas99@gmail.com>
Date:   Wed, 11 Mar 2020 01:16:09 +0200
Message-ID: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
Subject: [Feature request] Give non-unique names to commits for grouping
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I suggest that we should have the option to mark each commit with a
category name, that is not necessarily unique (like 'tags') so we
could have commit groups.
For example we could:
git mark {commit_id} {name}

Then we could give special functionality to some commands based on
those "marks".
For example if we had marked a few commits with the name 'fix_typo'
git log --mark fix_typo. Show all the commits marked with 'fix_typo'
git blame --mark fix_typo Run git blame but ignore commits with 'fix_typo'


Christos
