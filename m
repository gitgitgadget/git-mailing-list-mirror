Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4271F42B
	for <e@80x24.org>; Sun, 16 Sep 2018 06:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeIPLxv (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 07:53:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36138 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeIPLxu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 07:53:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id v26-v6so10560774ljj.3
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nRAb8KB4ivml5OGIG3BoSQCchc0j43fo1x8j0CdG8gY=;
        b=M5eCclFr7HQWORSUd5Ovdt+F9l5e4v/cg//ig2BuIykzQHjYIkFmpQY0HUtMmDDSDx
         jVvati9hAH6qdK1QS0AfUSskMKm3H4Po35A8ZAS7vDzOUEwAV0McUIoTiHHFBa3MEv/w
         Yy5bR33vVeabQ8+6caXX48Rm+/QkcS7L1CvM31kC7xHiTv0y8jPpb/ooBrQIh4CfAGQA
         hks0rr7WoOKwvptTwsou8CzzaowdJ6wqsYjVhPkRQkZBCmDVYoqermBBOXb0I5t6qiG5
         kLpZeCReJ3dPrN39K0DqsFLCeEyJNdueIeCQleIhARofaL32lqfsz8V0lFEAf0fdf2MR
         Izkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nRAb8KB4ivml5OGIG3BoSQCchc0j43fo1x8j0CdG8gY=;
        b=Xss8sFCrGqDJaoMYXwjM6HTNBPq6ZNLPG0TENcvKSkovj0ZQoPcXK2zqBNR0XxClSC
         5fZ1fc/nBZ6mhguZFdx/BuPQDrBM8GJJYX7pfrlyaPvIYSvdZku1A63O+5Q89cuZLuXT
         jKcPT+UW2y1GWKP/MoBBHjSXAdXvBf8M13CHcJ/enC0+Iqga7z8RvIcGKcIBFWbUA/3H
         nous1wPFwvuj5M3F6YkpHN2mG2wCGDWy7sN/Ppq6WFjbc5pygI3IesebZ6oFChSRb09y
         FOWrz7iXWoguPUNR+/X3LG3JwC+xRQve1diC4PP0YhlpQIqafoxtidg42DEDRnR0gvpj
         acBg==
X-Gm-Message-State: APzg51By571F5QlM78hzx4Go9YBztqQShjQQisqV5qz9fKz7HrBE2NpW
        4zwf7Nbcpie/vYTAQxRCcCwjgX+Z
X-Google-Smtp-Source: ANB0VdZl0EwdcfmPvYv/ugEC/8TmZ5KCGP0sg3MqnvVNdw4GsQgQuiXh87isFoFCCFU9AY79i6cPkw==
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr11751963ljh.68.1537079517593;
        Sat, 15 Sep 2018 23:31:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l1-v6sm2108922lji.41.2018.09.15.23.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 23:31:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
Date:   Sun, 16 Sep 2018 08:31:45 +0200
Message-Id: <20180916063146.9850-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180820154120.19297-1-pclouds@gmail.com>
References: <20180820154120.19297-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is about mixing "git add -p" and "git commit -a" (or "git commit
<path>") where you may accidentally lose staged changes. After the
discussion with Jonathan, I'm going with a bit different approach than
v1, this behavior now becomes default, and if the user wants the old
behavior back, they can use --clobber-index.

Another change is "git commit <path>" is covered as well, as pointed
out by Jacob.

I will need to add some test cases of course, if this direction is
still promising. One thing I'm not sure about is whether want to
deliberately clobber the index often, then perhaps we should add a
config key to bring the old behavior back.

Nguyễn Thái Ngọc Duy (1):
  commit: do not clobber the index

 Documentation/git-commit.txt     |  11 +++-
 builtin/commit.c                 | 105 ++++++++++++++++++++++++++++---
 cache.h                          |   1 +
 read-cache.c                     |  11 ++++
 t/t2201-add-update-typechange.sh |   2 +-
 t/t4015-diff-whitespace.sh       |   2 +-
 t/t7102-reset.sh                 |   2 +-
 t/t7500-commit.sh                |   2 +-
 t/t7502-commit.sh                |   4 +-
 t/t9350-fast-export.sh           |   2 +-
 10 files changed, 126 insertions(+), 16 deletions(-)

-- 
2.19.0.rc0.337.ge906d732e7

