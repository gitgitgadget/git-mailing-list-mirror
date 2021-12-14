Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51386C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 05:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhLNF1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 00:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhLNF1g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 00:27:36 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80DCC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 21:27:35 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bk14so26032594oib.7
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 21:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/ULUWgrElwD4gbQDXYqPPTRXiQ4VLJvccahsLt1Xas4=;
        b=Sx+ihMEhdLE8LzSxW4286Bcqd3QKQa1M7aqjnu65EBRjZDgHfvMkxXvO3nLf7uEQb3
         Pz/JnYrW1fL2FctWjUsNHS8Xxsax5t6XfX6ZDNVYbk9sCq8oZwCnyvhU8i9aIPhu24Ih
         /jZxdjCbiOFmH8m9mRUb09F7vCibwQpzfH8a4aIi/FeQrSoX81ezZrwnKYl0mz4tva34
         2IxM1+2YotQRUGKhnQ1WxXsOp7s3H2BcHJHCTFtV8OV2anpGgWpBXdQGhyZJ9UP2bnc5
         VDZwr6d7ImKrCa0UD35I5nSIXn8PUJUw7/6fbFZpJucaKw0+90J6c92hB9sKdh+2M6wm
         LjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/ULUWgrElwD4gbQDXYqPPTRXiQ4VLJvccahsLt1Xas4=;
        b=XPlbsQHVHMJx+3SeLA7LZ3676ixyeZs4kNK54cbLwgd/QST4TW1BQfWAxM2ElL6mX7
         v4YUoxPfOajj/tLOj9lNSMyhpT1UyJzhCWStt3p5V+xfXqgFi1i9iB7+xNAg9fB7iXr4
         VRdXBkChwACqwQ6wypoplwN1WdKmSFlMMvy+MJpSEoN9mTmcFewd4PXdG+oErZkXgdGu
         cVPqb/NAvD61wGT5Nj/8x/Vzv5H0ARWLkQ2TEoXvBCRq3+O6hoWmaYm1o6kAOz2+WLzW
         57n/ufrruYTWlmQJvLFHosYoOeHXeAQ8WJ6/XW7XkB/JeweJh+gdYLCe7SZI/t0Di/Lr
         yZqQ==
X-Gm-Message-State: AOAM530NrfpgLfTiCyi0FYxx5uMLKnPhmmBQCn8KtzC0e8ZJG9EOdCRJ
        YWQ9+YfSjPyvf0BFf3XbYbtSsJzWJtkpuJ1uawQ=
X-Google-Smtp-Source: ABdhPJyVhcSOu2fuWOvKRclwuUeHxgrtOF63vq6MH4xMacpp2gMp+g+983QA51NlPJ/1x8S/5N1qKLsDmxRjTN4qZww=
X-Received: by 2002:a05:6808:2392:: with SMTP id bp18mr32145105oib.89.1639459655033;
 Mon, 13 Dec 2021 21:27:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:748c:0:0:0:0:0 with HTTP; Mon, 13 Dec 2021 21:27:34
 -0800 (PST)
From:   =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>
Date:   Tue, 14 Dec 2021 08:57:34 +0330
Message-ID: <CANv3_vp_tm-dz5zphiV-NHk+QE69mjC23DmdxeOZsJ9zTNcHvA@mail.gmail.com>
Subject: =?UTF-8?B?2KfYr9ix2LMg2YXaqdin2YbZhSDYqNmI2YXZh9mGINiu24zYp9io2KfZhiDZhNmI2LHYpw==?=
        =?UTF-8?B?2YYg2qnZiNqG2Ycg2YXYrdmF2K/bjCDYp9mG2KrZh9in24wg2qnZiNqG2Ycg2YbYsdqv2LMg2b7ZhNin?=
        =?UTF-8?B?2qkgMTA=?=
To:     11898207+NAQ1S@tickets.livechatinc.com,
        =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>,
        Cmail@gmail.com, freesupervpn@mail.com,
        "GearBest.com" <newsletter@edm.gearbest.com>, git@vger.kernel.org,
        info@bischoff-guss.com, M@gmail.com,
        Mapbox <newsletter@mapbox.com>, maskvpn@hotmail.com,
        media@campaign.who.int, opencovidpledge@gmail.com,
        support@alohabrowser.com, support@zendesk.com,
        ytandroid-support@google.com
Cc:     dmca@ouo.press, programmermnone@gmail.com, sacdevgg@gmail.com,
        shmsaldynrda68@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2KfYs9iq2LHYp9qpINmF2qnYp9mG2YUg2q/YsNin2LTYqtmHINi02YjYrw0K2Ygg2LDYrtuM2LHZ
hyDYtNmI2K8g2K7Yt9in24wgNDAzINiv2KfYr9mFDQo=
