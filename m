Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC7D208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHHSNp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:13:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45793 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHSNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:13:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16-v6so1476570edq.12
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wrvVVrQN+ZlUTT1g2let4jrSP2hBmIGhySY5GlgpfYM=;
        b=Y+YCdCzwt58RUzhgd++lEwTnFuKlOu6CabHa5lU8COmtECZfjurgdoXZ762W7a5Q4c
         AlGUzrb/cc83Y6P+ide5JtyK1FtF8qSkbR4JwGDVZ+VFXuG8u1p3kQPULA/4wH2uOOWh
         bIBE39OpHJ7rgDYTd65FgV2skKUHxihBR0Cf+Ocsvv8WKlQxbSU+MYH2oTmJeZrAi9XJ
         VbzxlG+Loj+3tPyz1uW/9c4kTMJh54OUilhHwNWMq646QLf70xg6lZ0fdVVIWfObh7jN
         XVLK4jAhw25V9NdCLR1WgwKvwyVxHaI0yb2yUuRHDh0ZRJgLP7H/Xdt5D9JqVrh+hX7P
         BKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wrvVVrQN+ZlUTT1g2let4jrSP2hBmIGhySY5GlgpfYM=;
        b=EUAjAmFgyZBsVGIgiUHVFxyF4CDTz3DkE94o108sZyG6DHjiSaEMG2KlfY8i4qp/qE
         emNCgSC3UVAn+HqOLHquD+CoshuvJc9OYyP/IpWkyXD0RQpYl5XOqFKE5MZ5i1lv3TPo
         FTihIR6Y1HUvXe+T/M7jewZdvvbRj9Qsn9h5DxfVwiOZGL896yWulEsyyKFIHl4Fg2Lw
         /4BOX4wVbuz/Qzv7YeIS21FOd31AFYKHb1CUhB5godA666nEQt/AWzPXr+Lez71stkkZ
         1rM+hdtaKqYdRQjO/titBZ4S8CmJNHbn5OlC3kF4Ep5loUaJUNcuvf0hyjpXtGCLAml7
         kd3A==
X-Gm-Message-State: AOUpUlEq44eT90GhwZoqBuapbEtDfLMOQpnZnI+1lzn9AeitDThk2Oxz
        cN2y/3r3xYpTDgdJdxAZP9ZwMUDs
X-Google-Smtp-Source: AA+uWPx42i63xP5JgO1qKGjBiRs1jL7zRUlUP+Gl/XLuTTMGy54/iBIm5faGYvBvmtqD2+C9hpRztQ==
X-Received: by 2002:a50:b642:: with SMTP id c2-v6mr3958474ede.288.1533743608212;
        Wed, 08 Aug 2018 08:53:28 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id j23-v6sm2564430edh.29.2018.08.08.08.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:53:27 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH 0/1] default to builtin rebase
Date:   Wed,  8 Aug 2018 21:38:01 +0545
Message-Id: <20180808155302.23814-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since, all the conversion of shell script version of `git rebase` is done
as can be seen from the previous patch series, now we can default to the
builtin one. The builtin rebase can now handle every task done by the
original shell script `git rebase`. So, in this patch series, we turn the
builtin rebase `on` so that the rebase operations can be handled it by it.

This patch series is the continuation of
(https://public-inbox.org/git/20180808153635.19944-1-predatoramigo@gmail.com/).

This is the sixth and final patch series for a builtin "git rebase".

If you like to view the development branch, you can view
(https://github.com/git/git/pull/505), where I have kept my commits up to date
and leveraged Travis(there is sporadic failures in t5520 for macos gcc and
isn't due to my patches) for extra testing other than my system.

These patch series are built on top of each other, i.e. they depend on this
order.

Pratik Karki (1):
  rebase: default to using the builtin rebase

 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.18.0
