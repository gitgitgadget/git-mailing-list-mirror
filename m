Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA8CC433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 05:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22FB64E61
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 05:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBVFIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhBVFHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 00:07:52 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F7C06178A
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 21:07:12 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id s3so3067197qvn.7
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 21:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sgO0xPbwjegkktK14Gr8SUusAtSVD1E0JSz2+p5sf+A=;
        b=PlQRj8uldM1w12JHhn9Vys6e1rergrmhprRcWoldlUS/B5drOlPyaX7gxrT6NWStjd
         gD5C7BJyUQoKwtAzmazbRVAH26q5mlg+NProYrioboavBAept0a4OTRwNDpIKwy5QEXL
         gY09UWZtnTmo84HaBL9lmsvwHpJNY8fFL1XP36mPPVJs0xg3DOM2ZofqIZrY++mTA5Sd
         PAFI+WdQxVG4kAyez/oJIyNSjdJjcCkreYY58oNSWx9rxRzarTogCDhBcFt7Ji2YtFl2
         myb6CImMHETPgxE7yYeAcogEaQvR/CJwtnE6On4m/F64Ga8V0Nb6W1gWeEvrbjUZpk/G
         IDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sgO0xPbwjegkktK14Gr8SUusAtSVD1E0JSz2+p5sf+A=;
        b=aVyfI76MJ5NBxVFHDr11lFpymQ8aX3qbGKdcTzYPEiUgiaoL9mhQEY+6cZzjp/8kNh
         XLS4rRKkLSuLSrXnua5XD8tPM99NuEqKq9x0kK0tVJrVBZKrK/bBBOiROTj8fhtAEyEv
         bDUIp4xQhZLHhzSfVkPywUYZhQBDen23Nwj0QjyGE2pWmk3rA0T7bL7L7/3HldSgODsn
         9iXOaVb7vMWmECPKk5gyJoxsoEMxirP2zkhIV/YczPuAsN99MXF3rH6u2eboXhmZsv0g
         e11rYbCWO2g11WU+uf+tB8WKQMEumfavlULFjQXuM/nSjwO6/5P2FgKe5A4qFYbaN9EU
         /o3Q==
X-Gm-Message-State: AOAM530CxWB0Ipn/1NAOgty9J0rIazjp/7BR/INILhZNp5v5MUbCIapa
        dxFvXD4xj7JCGsI21rOWZqdgOeyomuXdOKQ4fIstSceu
X-Google-Smtp-Source: ABdhPJyhBCd5/jiPzFSfchHgx4n7oaduEFow0C/SLOuTsmcy2+cBJBbY2NUk88YyZUc9YvcRjmO2UAke7nHJMssUEcM=
X-Received: by 2002:a05:6214:c65:: with SMTP id t5mr19485299qvj.19.1613970431131;
 Sun, 21 Feb 2021 21:07:11 -0800 (PST)
MIME-Version: 1.0
From:   Adam Sharafeddine <adam.shrfdn@gmail.com>
Date:   Mon, 22 Feb 2021 07:07:00 +0200
Message-ID: <CAAxrY9yjTKV8-K0AmO4fBmtDrSB4KkN_xKOMmtSb-dvixJNaEQ@mail.gmail.com>
Subject: Wrong configuration variable mentioned in git-push documentation
 (examples section)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

In the file Documentation/git-push.txt under the EXAMPLES section,
specifically under
`git push origin`::, remote.origin.merge configuration variable is
said to configure the
upstream branch for the origin remote, when in fact it should be
branch.<name>.merge,
where <name> is the name of the local branch at which HEAD is
currently pointing to.

Here's en excerpt:

> `git push origin`::
>         Without additional configuration, pushes the current branch to
>         the configured upstream (`remote.origin.merge` configuration
>         variable) if it has the same name as the current branch, and
>         errors out without pushing otherwise.


I'm still learning Git so I thought I would share this with you (I got
confused reading
the examples). Maybe I'll learn something new or/and correct the
aforementioned error.

Regards

--
Adam
