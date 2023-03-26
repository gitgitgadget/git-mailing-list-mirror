Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE07C6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 17:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjCZRV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCZRV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 13:21:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D2A4693
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:21:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5416698e889so129419247b3.2
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679851286;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTYTC1lCAYP83UnxPHmTALbsreDwz/BwfCFVEfMrpeo=;
        b=QN/T4ZithvIiu14rTbsa7jrJtMCuIOq4UUt04gdRASnnL6i0P9M/aW5tzN4glwSKRE
         Pl2S3gZ+CzG+QAioLkN5y/JuOYyBt7MBkdr2rxNChP7UP0u7GlKB8y8jrmmUG55cvgki
         +R2PhmzqtWcRUEi8sH4bsQ7Aa9tYdUEWncsHwtAHgU7jpJbwFccJmemg+UoB9zn1XZxe
         HT/jrR+H5q9HcZFIh1vuL1vE8ys5A6TgLAHtePgdj6JDJxQSbRTzhdOny49E8rAKSEDt
         dp7rPfv9jdeU+9U6SghUkJwMXhCj3quuWP8HTgeyKb7JrEkiS5mVmY4rYyZnXZaRLYYo
         hNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679851286;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTYTC1lCAYP83UnxPHmTALbsreDwz/BwfCFVEfMrpeo=;
        b=bGCD3CftuqFqg3uHeVRlX/86CJH2JI6GQ83C6WFm/bCsA/UeF2tXdIQf23rPCL9+Wa
         8Sw4dIdn01mq/YTIUp8Bem2Eo9VNcNqx0iv5OXFbmFEtoM82G5ueo/Xttj0croHhnCW0
         6jfivIDt70/osOwwEZsHU5CRNlYSg4dWS7xJs8L4Er3r/sq/ZB4gGLaoTeGLjoMtVeq4
         Pe29sM5egiuSu3ijkgjWbQnZoupSwjzoHAaLK2rUwGZSoGA2J9EAaDcxOXVDedPjiY7X
         d2V5HRRfr/H2tRkyKrc5cfHP0DAeT9+tGmJcVGcxN4lsrDP1Zd8QkW5wCkFajAG3qelt
         ocJQ==
X-Gm-Message-State: AAQBX9eW7uJm/1Yk+UNeAQ2WCU3cUUmODEwzkp9LeFJGpt+N31u08WRZ
        bA47dG+CQAeqyihhKLCEmdw+Zzk75wYVoMt5YOoYNX+hxHM=
X-Google-Smtp-Source: AKy350ZhVzbAYBL/8TA9k6j4XH43SsT7uvwDFc7NLkbtWLXsC83ULlXOREnLd2NMrio/vwSeiaH+eUadpdzILf2smEc=
X-Received: by 2002:a81:4516:0:b0:541:9b2b:8240 with SMTP id
 s22-20020a814516000000b005419b2b8240mr3946859ywa.6.1679851285913; Sun, 26 Mar
 2023 10:21:25 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Kovacsics_R=C3=B3bert?= <kovirobi@gmail.com>
Date:   Sun, 26 Mar 2023 18:21:15 +0100
Message-ID: <CABPkNKk8PS_Ct1Wr5Us15ZO6MPmCfZMFOwXsQomSh+cnN2Ygtg@mail.gmail.com>
Subject: --autodrop and drop!
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I really like git's autosquash, it's super useful, especially with git
absorb. I use them while the MR/PR is in draft state and then do a
clean-up when it's ready to be reviewed. I sometimes also make commits
which shouldn't make into the final MR, so I was wondering about
adding the `drop!` equivalent (maybe with `--autodrop`, or just also
under `--autosquash`, but I'm leaning towards the former as sometimes
I might want to clean things up while still keeping the temporary
commits).

An example of where this is useful is when I'm making changes to the
CI, so I will be running more CI pipelines than usual and end up
caring about the speed of it. So I make a `drop! Ignore other CI jobs`
commit.

If it's something reasonably easy for me to do, and someone thinks
it's easier to put a couple of bullet-points on how to do it than do
it, then I would be happy to try and implement it myself*

*I cannot promise timeliness, effort as/when I have the energy, but
since I'm the one who cares about this feature I don't think that will
be a problem.

Thanks,
Robert
