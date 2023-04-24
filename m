Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D94C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 23:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjDXXAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 19:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjDXXAj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 19:00:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183A07AA3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 16:00:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b99f3aee8e0so106101276.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682377238; x=1684969238;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q9yFm+1f/0VtY9zks5IXJF5l0i0jl65vttIzaeNj1N0=;
        b=ItYgl8watto7Eo0AK+6UTwBYkh3/NBpMOeWftF9UkVulYY46ELE92KiRtjAjeEaA38
         7x4Ky4Z8v18DUGzSuMEArpVfdcAxHrGQRcNDSEm8e919FryHdrYN4V7+MGJs9J6e3Agt
         mAcIFToFCNWLmTfSABdf9fLLxmuTVl/kZ+zmFmAOq9vnhKO4S1dxVx0qVvwKSefI1X0h
         xaD5nJnyHon8N64HlxXKBpnZDKU8+GkMt28XiZu9MB6KvUJlfAsNIriFbcrngMI1wIJH
         076cKp8NvqEuFDfQn/2WLUmOAkoms6IYI8V2v6bSTI0LdoNzm4xYBzb34IEieUsWZ3p+
         FMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682377238; x=1684969238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9yFm+1f/0VtY9zks5IXJF5l0i0jl65vttIzaeNj1N0=;
        b=eFYFRiblkdtrhctkMP2ZHhYXmCwNlMlMlmL4emNdJAMPJTlXlbTOtAOccjugI+9UkS
         qKYw0P6SYBykPeuJAlDCGwWXKazgfQN1kXkfjj3LCZQb67byIAZsZEk3gxKE/50PZrB+
         ZEFyOl/KHHbXnyZ0Ihl4p6aPadFtOL5mm6J4JxKhNH0CkNn3LzLn+pswqt1Mb177OM+g
         1NRRDC7Ey0sfTKIogxtp/J3Em3EyczHUQxyEIx0tMKesLEYE+ZbQ4uQQ+q8j7IuJ1o41
         A9Hqq86GP0Fki2GlBdLS0YSJpw23Lnu7tnpJ2SD3cv0PkOpxPBDG51AFuVBGrsE/Xh4h
         npZw==
X-Gm-Message-State: AAQBX9c/C35f+LiZVKgLnu7UvBD8TZK/jiIgEnDPdqe2lHo4YNQ7QiuY
        JYvrqOJxz8leD6OqGnBzDYocqFhqDOTzTtNslcPZ5jDHHxp4OoiOQIHN9E6JK0UIKpma1yg52Y2
        BCTU9bUcdZ9/orW85eHrvfnLgfmQ/HpxYZzhQYr3J8xm/jV9ogvmrHYNhX+/nz5U=
X-Google-Smtp-Source: AKy350ZC9/T4h9R+00lyD+zRVblyhISeFYXPgcbB8AhpJDtW97VHEKoC2XsS0bqFrBk2PDZP69Ed3jwcrLkuUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:26c7:0:b0:b92:40f8:a46f with SMTP id
 m190-20020a2526c7000000b00b9240f8a46fmr7943700ybm.2.1682377238343; Mon, 24
 Apr 2023 16:00:38 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:00:36 -0700
Mime-Version: 1.0
Message-ID: <kl6lv8hk997v.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday, 24 Apr, 09:30 Pacific time
(UTC-8). This is the same time of day as the last session, but on
Wednesday.

You can find more info at [1] and on gitcal [2]. We run a session every
other week, but we're actively experimenting with how to make this
friendlier to other timezones so the gitcal timings may not always be
accurate. We'd welcome feedback on how we can make this work better for
folks :)

This week, we'll be discussing Patrick Steinhardt's "machine parseable
git fetch" topic [3]. Let me know if you're interested and would like to
join (off-list is fine), and I'll send you an invite.

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/git/cover.1681906948.git.ps@pks.im/
