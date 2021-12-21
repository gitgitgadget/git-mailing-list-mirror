Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A3BC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 09:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhLUJCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbhLUJCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 04:02:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36551C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 01:02:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so5947187wrb.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 01:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=fpur/AoC75qy+8Eg2stLSyzDfPk7FAOdG+TmqFpV1vY=;
        b=mTgKl3ewZwu3NLNuNohlWUlrjvRU31w3FKFPbow5NEzWx9qy1mXvaW3CEQ6abNQnLW
         Op5p9wgCiGSZYxP1wV2rGAm23loothxqb1XEcMyETQlMKefGNRAg37DM0odz4Lb6Jti8
         7EjS/ksji4EcjUIEXjyAGK6khkaoKo4xKbkBlsgGtQjfhwD/ZCTRmpCuCMk2nXC1IJqs
         8Vk+MY1xZSOc4Sy1VWSS/peju8UaqwiT7U35Ouf67fqIRwS3gzQ6p8DduellnjdIW3kw
         BK1YznDNbcUU+oopycA6sM0IC31fPpbEsbnjuoTfPN/Ie59+2LienEkso9KXvXEPYhdo
         g5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fpur/AoC75qy+8Eg2stLSyzDfPk7FAOdG+TmqFpV1vY=;
        b=KqfO+7+Me42chhGE2OrIPIgSWh/N659r4Lwt/muTHu9oyKkUMderIETrRPGcvOb/Nz
         sakVEJX9tk/iKituDYa2jyvoQZPHnowm+ACAL9w4EpIQV2UnelHUlBp8VDlmgolPtRnZ
         QOmKMXk6sJAngJVE1piHiS7gqXl0+GS8cYKko199fPRgomk0U5IC3YgIElGAIa6Jyma7
         KzFxnuCaQdqJuEudp7HH1gwiPzrAQVmvrESn9QPV2kkwN1tvsDi/4uSLH4a0ZK5UAagM
         Ru4JZVE9Lp4fBbLV1/v6JNdo6CXqRq3Q+B+36QMhu54J3SqAtMuoaGejCP/4dE+9TKHm
         C0nw==
X-Gm-Message-State: AOAM532KoiU1my8cKx5qtzq5LgNesBYuD6IURx++91lJxzOWD8zvMb5Q
        jY2WKe8/TgagAMQ2mAtcTPdCr5mRe9Yk+/VP0DflEj60
X-Google-Smtp-Source: ABdhPJxhe3X/CGK1bvpdLmRUGfD1iEfi70DjhYHSFNzyQO9qqZABF37n8ioWm4lq4ZukxF0iPhg6NrfaTUQN7J9NYeg=
X-Received: by 2002:a05:6000:144a:: with SMTP id v10mr1740246wrx.357.1640077339558;
 Tue, 21 Dec 2021 01:02:19 -0800 (PST)
MIME-Version: 1.0
From:   Rafael Kitover <rkitover@gmail.com>
Date:   Tue, 21 Dec 2021 09:02:09 +0000
Message-ID: <CALHxfhKPfJVrVJ0A7iSUzbZT8n1sVgUbzBCt2CegFd9W88O+GA@mail.gmail.com>
Subject: Feature request: diff options for commit --verbose
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I open the editor for commit --verbose, I'd like to use -b
(--ignore-space-change) as a diff option, other people may like other
diff options for this.

Currently, I do not see a way to do that.
