Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276CC1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKNQfy (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:35:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38265 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKNQfx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:35:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so6647353wmk.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeKJmHFGsuAd9LGmbLfADOOKqr8m06dO+YXuIjx7n/E=;
        b=DRRk2gG6mwK926gtz6nq9lyFXJePEnvVHKfyhmxY4OabtAwEPjIq1KyR1EaljmGscy
         0Y3OGUcRjt+MR6Mu8TTmhC2Mlmj77KmS5p1rAZlyGutcASwqx52rSls9wLd4AnB4tZvv
         pgR748NEqwpGpknADkdK0AmbLlX8rrp+s4IKALcai9vfkGiJJ2zDCnFczZ6EO554Kh9B
         gbvQTRa22PSvuEZmNMXtj5zGQxdAqx96T+GHfeS/oA9Qd2XMjHQ+2g7LVCpYmEhyXz1A
         /KrCBhBK30Ql71iAjY+l//G4AkWBTk2BQcXsjOv4NWSN4KO39MC8W14GTsJ8BmaJZRV1
         6dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeKJmHFGsuAd9LGmbLfADOOKqr8m06dO+YXuIjx7n/E=;
        b=uiuGho4W9Bre4ipjWF1in87dI7xSRbhTcLBNU/8SFSjYS1VbscIA56AEJWL9Grnrx8
         otMH+IhFJx3WRIpFKm4h1fLs3jzWif8Mfb+obVDdI4mG6kYUaLMOESTKM1EWFV1/mE15
         i4L0H+8/H48l55OSlA2Z4poJThCGGcJdlJBXZYhcIvLE/9KUeo9UaUl8+mjrTjvk+49D
         2qsV3t9Wzb/rdqEp7dqeHLsELJmHy1UNENT3X183QrtRSL4jjwFRYXJR/v6rCrVnRmDk
         Jjqjj3beS9gC39L0puCLsvFxAw70HllFH8MfwsnCfzvSLpMkf0oIi2xxMnrPrrEwALXa
         Oy5g==
X-Gm-Message-State: APjAAAVEcVruu59Tc4rTWg/WCtgoRKSNjvEbSGvk/EByztBpcQPcvw7N
        e1qJxjVNgc1ewGojG/eAEjxJFCIOBYdvpg==
X-Google-Smtp-Source: APXvYqxYbCd0bKEb4GQpVpT1GSP7oC3qBWwGLHhj8GvZvXbx0RVlUkov6KG5tOwmtHuo7+a8pqI8iw==
X-Received: by 2002:a05:600c:295:: with SMTP id 21mr8423802wmk.43.1573749351700;
        Thu, 14 Nov 2019 08:35:51 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id h124sm7429008wme.30.2019.11.14.08.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:35:51 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        predatoramigo@gmail.com
Subject: [PATCH 0/3] rebase --edit-todo --exec
Date:   Thu, 14 Nov 2019 17:35:46 +0100
Message-Id: <20191114163549.7648-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've wanted this feature for a long time, and now with rebase working without
forking rebase--interactive (thanks to Phillip Wood for working on that), I
finally got around to implementing it.

It still needs validation for arguments. Right now, I have two ideas:

  1. iterate over original argv and make sure its just '--exec's with its
     arguments.
  2. check all other vars in options[].

Andrei Rybak (3):
  rebase: prepare cmd before choosing action
  rebase: extract add_exec()
  rebase -i: allow --edit-todo with --exec

 Documentation/git-rebase.txt  |  3 +-
 builtin/rebase.c              | 63 ++++++++++++++++++++++-------------
 t/t3404-rebase-interactive.sh | 32 ++++++++++++++++++
 3 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.24.0.windows.2

