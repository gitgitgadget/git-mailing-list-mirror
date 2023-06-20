Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E284EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 20:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjFTUm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFTUmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 16:42:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1747210FF
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 13:42:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059e6f9c7so98579877b3.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687293765; x=1689885765;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VV6YkOHtBqcvWSiBiBDYDvTS1SS3oakQHJsHhLp5eLU=;
        b=MbG+F6V8fmw+y1GUnMdULzPo0RSN3LVWWbEbBTQA7zkdHf9I6mrOevfGDOOc4nfYzK
         GILbkDcPaTXUQN671/po3/KeYaxH1bsk/HoDVJ4y5TxZdAxdEKHlNjUIQSy1UzVWXyEo
         WqqcdShcnZK4G6WYhOfpMIaNpj5mJxIFo/8LAeZYqMOyS+HeC8eFHzcIRgc7YarF0RYC
         PCCsqtF04du6UgW+BRHlTsDyTtPC1LiyKnAO3cJUSOF4pvP1syxxl1TtXdLOZTCWHUTH
         R60AEhUipJZ3pgrqekEBxjc+LimnSpain2CtXK+jIOcacIj/3QPkMAZF+5QC3AGi+S6R
         lMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293765; x=1689885765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV6YkOHtBqcvWSiBiBDYDvTS1SS3oakQHJsHhLp5eLU=;
        b=YS44Umv+dXRK6QL4xi4IXqAgeBbN3bhZ+EgdJJ3gPaBJXnpfWZ+EE2OmTeld81AZS2
         xqqrtmDk4cndXf91dWVwEQ1NK4D6GxHOYJ5uUVChRr1Uu5wAcH1zrfNoEBe0TVeo3h30
         M2ZtGWvBXLixFF1pnI2ySfo8DQ6Cybx5xx836jgdHxpwf1ePxpO0GgqOlp1Jm0I3RD2I
         8zYUu2ve73CCguKinMEcg+3BgbvmgxfV5kEfOj/GwLummD5uzPcs9ZYnuSqEOq1dKWH0
         m3G1E7aTeiY/tiH+Hp54ZcDD7yp9T8UCO1+GvKiqbAms1nrSE+awqdHhxxyVHTSKI1F6
         e+MQ==
X-Gm-Message-State: AC+VfDzA3vjY/TAxJQW4o7gunl2sGCLIlj6gogtCccBIW2UQLHymq5bw
        iH7aVtz4thesZKoZFekmAalxVJXrCVc95xxOcwgQV2UpnPCJD/ft+fXbGGfJd4fyEGeVhmV/2kW
        6J+Ia6JOEuTR7CAY9W5GVtTBMK5TAOdcssZdIkSoxTEKiW5rCKNjHrtuS6GzIEKI=
X-Google-Smtp-Source: ACHHUZ5IjSkrf8iIio2u7baBbLS6I+hQthis1/IjJv6NoXN02oZdIt7YSuZjOmyGkcieBb0NU/pcT6wBc9ox+g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:690c:b92:b0:565:8b2e:b324 with SMTP
 id ck18-20020a05690c0b9200b005658b2eb324mr9648525ywb.3.1687293765325; Tue, 20
 Jun 2023 13:42:45 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:42:43 -0700
Mime-Version: 1.0
Message-ID: <kl6l5y7hsw58.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday, 21 May, 09:30 Pacific time
(UTC-8). You can find more info at [1] and on gitcal [2]. We run a
session every other week. Note the different time! From the feedback
we've gathered, this time works better for more people, so this will be
the new time for all Review Club sessions going forward. Also, I
apologize for the late announcement this week (Monday was a public
holiday in the USA).

This week, we'll be discussing Phillip Wood's fixes to "git rebase" when
failed picks occur [3]. Let me know if you're interested and would like
to join (off-list is fine), and I'll send you an invite.

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/git/pull.1492.v2.git.1682089074.gitgitgadget@gmail.com/
