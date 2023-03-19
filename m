Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C6C76195
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 11:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCSLfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSLfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 07:35:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCA21F5D7
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 04:35:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o2so2321099plg.4
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679225733;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JjrmqcjMXnPr7ubjH70/T3aWaX5pYHuxPtGOctyeT7U=;
        b=fRq8Tj/y0GoJ4oleuItlplFTwMOEcErrFu9ApC6B04Ib3gPRpfNAWJWKNwN+W2Rsz1
         Qs+M8BJ+DD2CrUQ1BejmKHjtP0UY+LDBSf5Fit7zjYspqykTGsHiIW3ZhCvdJkTFiXUK
         aevbKpZQu4CIqGyUVqQKqM2/mMe7x1koy+bQwXh4N+GRDxLyl/775XjKG1Jnw6+G+GSy
         NTjFAt85S3oFLx/I7iJc5CG7rkAohMUhzv/S9YQvE9xEhY5R7i0TyQ6/ar7r4gknyYoD
         9jJNoas/2BsrrfO+OFJ9cyqfateL25w4s8TNYYTtGSNlNn9vaMqwbPBgTF1mq0yka+oy
         tN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679225733;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JjrmqcjMXnPr7ubjH70/T3aWaX5pYHuxPtGOctyeT7U=;
        b=lQTbAQxn9x7KgZfzG40rGhJ3xtE3karndkEhK93a0Udt4tGtlz0NYP3tB3RZto/25C
         TYD/coVxQDOowJEKc4HzIYTYHcy4Lg1HohirrtK03ZDaA8dtmzP3FWKTIfE7f2tibeXG
         zoN3eumjt0IwT8Zj3eK9RHzNoQFvpFArLpkqLtWCey/vQxKRyfZzOANWdQmJ1hwQUkQg
         jNTDyWCbX6OEc+v0yhjcrup1krGkpmsBSPPnehmkIfKYJ42JhYqfYrKgY2eU2g/CxKrt
         5oUk6XKb6pZa9UGjm9AspqXwjCzJBLmI8TiTtgP0Vq88NFL107OH7tH0EsaNxdGVKcOI
         LQ1A==
X-Gm-Message-State: AO0yUKVb252+8Vug8cBxd1SRDl8nsKPpPz8hyeMkXmIJnHVMNVDTutS3
        n5tmb+1Oqncw+FL7HpxQP8zsaqlVG72jyA==
X-Google-Smtp-Source: AK7set/7wOAZ3kr7dcIrT1Ipvzef9wxcbfOY+3Ve6ohvTRYbQbOs0v2DVyExZgaHMYVB3G77oAsYcg==
X-Received: by 2002:a17:902:d0d4:b0:19c:3d78:6a54 with SMTP id n20-20020a170902d0d400b0019c3d786a54mr6887400pln.14.1679225733067;
        Sun, 19 Mar 2023 04:35:33 -0700 (PDT)
Received: from Developer ([14.254.246.167])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902bf4700b0019a60b7cc0esm4580572pls.248.2023.03.19.04.35.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:35:32 -0700 (PDT)
From:   <sang.tts.designer@gmail.com>
To:     <git@vger.kernel.org>
Subject: Bug Report with Git Bash
Date:   Sun, 19 Mar 2023 18:35:29 +0700
Message-ID: <000801d95a56$e9253f80$bb6fbe80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlaVuXGWhMGCI0IRpmPSuKqV6/TfQ==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,
I have observed a bug related to git bash at my end. Please the =
following
description.
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Please note that 'ls' command just an example, it's happening with any
command.
This is a relatively simple bug. when we double-type a command, like =
'ls'.
However, in the Ubuntu environment, the command only occurs once when we
press the top arrow to use the prior command.
It is identical when using git bash.
Repeat these steps:
Type "ls:=A0in git bash.
2. Type "ls" once more.
3. To return to the previous command, use the top arrow.
As you can see, the number of times we type the can command 'ls' does =
not
matter; it only needs to occur once.
Please be aware that the command "ls" is only an example; this can =
happen
with any command.

What did you expect to happen? (Expected behavior)
It's only need to appear once time and remove duplicated for more
convenience.

What happened instead? (Actual behavior)
It's depending on how many times we type that command.

What's different between what you expected and what actually happened?
As described above.
Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.0.windows.2
cpu: x86_64
built from commit: 8735530946cced809cc6cc4c2ca3b078cdb3dfc8
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22621=20
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program =
Files\Git\usr\bin\bash.exe


[Enabled Hooks]


--
Thanks and Best Regards!
---------------------------------------------------
Sang Truong Tan=A0

Department of Electronics
HCMC University of Technology
Phone: (+84) 977 600 563 or (+84) 908 983 574
Email:=A0sang.tts.designer@gmail.com


