Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4986C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 19:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353508AbhLCT4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242274AbhLCT4g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 14:56:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB4DC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 11:53:11 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so16272874edd.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 11:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kNSq1BNhvXgRUx9LCBLw32nKznZZTL5XvwLRRP1/tfE=;
        b=V2iU5WygFGyd4BYI+W2LrgycXUxAVmlpiSXxBDvO+nJmTnInIWGMJGIcanUuumBssR
         n3A5/UHCiiDBgJX7kUGHwSJ7RKw4eFwiG857NBW+LrdwwU0UhR+Yiyg8wRmrczS+wb0v
         Jn+Chb0CG23VjZtKimCW0mKuNO1Rj6FvcA+mIguOXlZJDQuIh5XhCibQQqmj0a2h9/uB
         4beNRG8mPYSeFrTB536fNTWG+wDCeIguIQvGuVp7i9e2Upv+dGuW+EpIwQ7zft4wbPK3
         +LGW056gdFY0IHRHON5Oqs03ysQJgmQCtYhkW6pYPX96ptD10gfr54ciMJGt/R3aV/ZO
         V0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kNSq1BNhvXgRUx9LCBLw32nKznZZTL5XvwLRRP1/tfE=;
        b=eugB+DWCHU/BYqT+LlvSy7+//M478bDebHiQx9D2CACqryxoaDaBAW+DKk52mx1YFE
         bLlk7kIBATqK8Sb60YzpR2ZHcSIe96wSosSQu+jj9MJ5jC5+f+WeVX5TYdUFzJOUdp0I
         ASkgDnPnZlUnZhNY7iyBWxzPaIyjq8YcZ+Q49/StZodpmJERSR7XUQ60w2LiecjlJ7VB
         b3Ow+UKut22A6b7Q8A2QEScAVtPTamj2eP8SvMRZw8QDJbBYhQksjL10PtTM9xM8V2Vb
         ihCEYAzcyd5seaKgygkYRKQeYDn40oyVYE00ebL83iXmCLCOZM7fYaOQTx4lQVful6+7
         /esQ==
X-Gm-Message-State: AOAM531usV77nwKexyfzIFvIK+gk2rdBuTimSPNjZjJUZItdzVvD9iAh
        y+qbQc6HvCguAExrrUaslLyUXOb095Edq66s0ukuzTRr7Bw=
X-Google-Smtp-Source: ABdhPJxcRdiEyljBPcBtvIkjxlgewJQBA0l1aizn2n8+VfWpq3wiZr3PQT9DoV2LiPtlc/APQa0mHmy5TuiIPIYd3Eo=
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr21873309ejh.172.1638561189751;
 Fri, 03 Dec 2021 11:53:09 -0800 (PST)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Dec 2021 11:52:58 -0800
Message-ID: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
Subject: Large delays in mailing list delivery?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Are there some rather large delays in mailing list delivery these
days?  Anyone know who to contact to investigate?  [*]

Some examples:

* Stolee reviewed v2 of en/keep-cwd on Nov 29, three days after v3 was
posted, and I mentioned v3 was current, he said that v3 had not yet
appeared in his inbox[2] (though by the time of that response, half of
it had appeared).

I periodically look at lore.kernel.org/git because of the threaded
view.  While I'm accustomed to a few hours delay between messages
arriving there and in my inbox, this week I noticed a few, among them
two examples that I immediately remember:

* https://lore.kernel.org/git/20211202030458.GA48278@newk/ from Dec 1
still hasn't arrived in my inbox.  I typed up a response, but waited
for it to show up so I could respond.  (I could use git-send-email to
respond, but that's a pain so I tend not to.)

* v7 of ak/protect-any-current-branch has not arrived in my inbox yet,
despite being posted about 2 days ago.  I read through the series and
then was going to post a tiny comment or two yesterday, but only v6
and older are in my email.


Thanks,
Elijah

[1] And what are the odds that this issue will cause this email to be
delayed in delivery to everyone other than lore.kernel.org/git, and no
one sees it, until after the issue is resolved?  ;-)

[2] https://lore.kernel.org/git/068b7faf-2ade-14a7-fee3-83fec26ae856@gmail.com/
