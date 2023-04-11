Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB16C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 18:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDKSBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDKSBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 14:01:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF8526F
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:01:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q88-20020a17090a17e100b00244b0813a68so3524078pja.9
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681236099;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=drb/HF+tAkjc0aUsHNWQzBhtRytOV1TOWaX/+Yo33Rg=;
        b=oYxXmN8CfDGccoYHEjV34UvnItsjbJ9XpbEyU8nz8wHqb8PkT52wy+TFD1RcrRDJ1l
         mE3wL9lkF5fK6RaVSziTNYvHkzvlsc5pl8BSr46Mtyd/VePvrJn30FODjvX3ukX4e+iw
         Oznl6dvZE26ETjmXfEkAwIFJID+I8USkhvSNqHr5wh4Bz5QC27MopQ+SwY341yLTy7hW
         +60whxfaP4K9FBVZMphyKP1r/e7UYBoXud2wgqRvE4hzgDaIDncGP8VCXQFmtSVohWwP
         4+pkaVF6Rn2TcAdJaG1tGOuKM04tBLV57xaTnGWkkDTkYAfpr0KBPD56m3NCIIy1GEM7
         5V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236099;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drb/HF+tAkjc0aUsHNWQzBhtRytOV1TOWaX/+Yo33Rg=;
        b=Ks7ku5hGmybPawfQ3hlO4onNpELbw36XSx3HCIvaMNSzrdznA+33kTxbQhNAAqB5be
         9hqG+pCL6G7oncThdtUyDpFEPlfU4AKL9HwXeYzfw7Nq7tZvmcNnbfaZ34ekIeWH7O7t
         mAnem/EDcEZDY4qO0OiTRgDT1k9vGWN2fa2vlnl4FtZ26Ydj3o3V/B+ewq3LEpk8pw1K
         7pYMHwsQCYwez96wJN7bndg57ItB51CnokFyo5ZGZWpj40uWxHITXXwZbbqoT+ruq8GW
         m+vEQvM3PoGFk2lvRlTFWarTTsrgbyF61AgwnCD968mRiHpnNeH70NsVHjtF+xyNWj07
         kANA==
X-Gm-Message-State: AAQBX9eO3jJRxXQtKqv83Zz4i5XzZAxy+ak2fAZHJM6i9Xh+9yvOQoAi
        vSnIqkqyMMjFsmnzUN6DevAN3oDIpegxPSiTNWN/r9M4a9EiNYwUTiKKvUIhxxoTm0c5Gi8JgoH
        eMbmIwUHeW0F29C8BLFDGvtQ2DhP9+YxCFUHtxcqKrohN4AJGV4oEvLG6Iqid2Z8=
X-Google-Smtp-Source: AKy350a3zKISp+MMHS0NXpFB7PCWi4MJ4a0Olf1wvJ7sZowBU30LxivMuByHLDbI/7ukf/oQSrsabsGkx++5YQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:f91a:0:b0:518:1d22:1d19 with SMTP id
 h26-20020a63f91a000000b005181d221d19mr2926848pgi.2.1681236099297; Tue, 11 Apr
 2023 11:01:39 -0700 (PDT)
Date:   Tue, 11 Apr 2023 11:01:37 -0700
Mime-Version: 1.0
Message-ID: <kl6ly1myjo1q.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Review Club Rescheduling (CET-friendly!)
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

Due to last minute events, Review Club will not be happening this week.
So instead, we'll schedule a session next week at a more CET-friendly
time :)

Review Club will happen next week, 18 Apr 09:30 PDT (GMT-7) / 18:30 CET
(GMT+2). Gitcal [1] has been updated accordingly, and we'll send another
announcement with the Review Club topic closer to the date.

Hope to see you there!

[1] https://tinyurl.com/gitcal
