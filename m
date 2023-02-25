Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA5C64ED8
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 00:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBYAKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBYAKe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 19:10:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E361658E2
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:10:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf635080so15378427b3.23
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3BoQ+MnU4Syx4I+oY16zLfTR32fMdVpAuak2RxyhSuc=;
        b=CBJyiEgscm5fk08L20WaPNpuGlJsiH12Ao0/irOwBeRyTUK1s3ZVw/AfmpE6W2tO1o
         YzNjkXQgnB5hqiaCsDgqsdWdf2KLnsuRKbZapW28gqS6qkplsU5drOW6siSnE3lQhXxD
         u8nMeu1rdvwQFz6x7gDwiygvvqLB7x3QFM4kg5sbpbBBWYIbYL79i4zLxZDOBS1l+xQj
         GALnMfkmyV9GYR8nNMGV8SdjHjz5vYwzFEj9qmcyoZrJ5WFMGsgDwr6t87qF5HG1Ic+0
         BPKtq38Kt4sYIzPkZQSt2ST+y3dKE5nOJhcWTgSBVO/v4Ty3OtS8Ta4MSNsvfR1MSQMM
         umvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BoQ+MnU4Syx4I+oY16zLfTR32fMdVpAuak2RxyhSuc=;
        b=INc/8wwMfwY8eWcALkhffAM+G86N1taTRnyuXYa++nb/Gapse1l4YoqPE5myfDnbal
         pyVd4ofpqBOdwWqJ7CjzQ+ZKvx6B5AYVvOD40yFFnwYltCh7/kD7xMiwVeb5U6CO8muR
         Fu+PgOs5g5RvL3Wri3bMh3qs6tgSCWwDIMz/IA10Mc00Qv3pX3+UvoU4TB2Bl6ycMbUt
         1Hy3TX0y8WI7/C88zL8Am5lfFVlge85dvXbZDINtGMa6oA2M5Mds3/TTkvK+gFaEsJXI
         5Ap2hbB+bw9OB91aire5AmsEvPlQMW0eRjll6bCpeYh8fR50MLLqEwGZBBwZgYznLoNE
         BCaw==
X-Gm-Message-State: AO0yUKU8aY/kAg+l/JIy0AkmqDe72ltuCBNh0lN2NDfOFCNWDxOAEMDs
        3AY2HeDD0meLuF/aEqOEodRQTBQYur/EtYaXiOvs
X-Google-Smtp-Source: AK7set8LW44C0Gq6bocFlH7lQtljiya8VuWTN089H+VEsyTutGe8KTuaBedqrF4VNSx9hQ6C+LZVCZPVX4dBeWqW7Kly
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:60fb:bc56:6979:1f96])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ed0c:0:b0:a09:314f:a3ef with
 SMTP id k12-20020a25ed0c000000b00a09314fa3efmr4607325ybh.12.1677283825605;
 Fri, 24 Feb 2023 16:10:25 -0800 (PST)
Date:   Fri, 24 Feb 2023 16:10:23 -0800
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230225001023.2047457-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 00/17] Header cleanups
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> This series cleans up headers a bit, trying to remove excessive dependency
> on "cache.h". I created this series a while ago, but decided to clean it up
> and submit it due to Emily's recent thread and suggestion that this might be
> helpful to their efforts[1].

[snip]

> [1] Search for "Extremely yes" in
> https://lore.kernel.org/git/CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com/

Thanks, the series looks good. I especially appreciated the separating
out of alloc.h and moving function declarations to the .h of the same
name as the .c file their definition is found in.
 
