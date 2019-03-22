Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1DA020248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCVJcG (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:32:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46953 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVJcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:32:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so1125495pfj.13
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bYRTcjzQhgi5mcF17ZixdgVdTjSMyuRPNVVDYBfjAg=;
        b=qj/zswWtPWTGZ+145QLjY6Tp1sYVv1vrBdPSX3Dknh1Di8h8SoSWmDuUko6AdM2SpK
         8QYcA9o0jCxJB7H4fqu7ZDSB7jcOM8tK27CUZ788rYZytL7quw6Atm59fWkXuI9SaUy5
         dhfVcsuFTiT6D6frI823e10h2NdCUSslGbwxKL9byJplZHRSi+P73riRsitw3pjiDq0o
         P4zceEykFIk4zmY/FbPWk1PYtPNsComuCuHEm8Xaeqtv1vBkU6xtRa+H5yI9Z2fB6mA7
         s/AdyIPW6fa+Q4Zfu3c+94EsxNTnAMX88UAEaGxVMLMfoouxoNwChQkNz4mMztUu6TL6
         O4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bYRTcjzQhgi5mcF17ZixdgVdTjSMyuRPNVVDYBfjAg=;
        b=VvyhEO8NZf7ahht9OnaqMiDb5QgD9sl9YeOP+P58RUslN65HJq5r0gCvdep3thZWKR
         Gmp3ggy08omyI2Zpye2+wU3p9Q4GHx4oVA2eMHsEELDEjUq5Na0xfv9zvvxhf4cSVraF
         k6+Y1q6zlhrLbAoSjPZ/+kL0Fzpqm6FaV+u8ciBS9JmrFd08KYUMjHsbRPKNlHMdbq85
         PkuJbqvA2J0pZZnd+jdv0rf2BDp+S4GH6HiA1I2w3INvDWqAbxdLlDjd5rEctR81RSM7
         bYjSJc/Xsgn+l7z5ALUrQYoVj+1SPxuTTrBEpQpTpolDUDThJLWSPIb6Eek/VbLVvpay
         1ssA==
X-Gm-Message-State: APjAAAUtXJU0MRPgmaKs+C5Qi4TCdED8xB2LiBMUnb8VnyHwZDhPx2JF
        E5wo+2mm4TBvttF9G23QJQelNwmDX8s=
X-Google-Smtp-Source: APXvYqzLWYPqApUp8uj4AgfR8Dj5eJkEMUt1HMzpsMLZMZaSd7ncxu2iWRWvA+SqCHlsrrq2NM6KHw==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr8755999pla.178.1553247125587;
        Fri, 22 Mar 2019 02:32:05 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id v6sm9687667pgi.90.2019.03.22.02.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 02:32:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 22 Mar 2019 16:31:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/4] prevent 'checkout -m' from losing staged changes
Date:   Fri, 22 Mar 2019 16:31:34 +0700
Message-Id: <20190322093138.13765-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the 'git switch' discusion, Phillip found out that staged changes
could be silently lost when doing 'git checkout -m'. The first attempt
[2] tries to fix it by warning and moving on, because t7201.10 would
fail if we simply die() when there are staged changes.

This round, I update read-tree to be used in that test instead of
'checkout -m'. Then we are able to die().

I start a new thread to keep spam level down for other people, and to
break free from 'git switch' thread because it's unrelated now.

Jonathan is included, just in case he still remembers something from
6a143aa2b2 (checkout -m: attempt merge when deletion of path was
staged, 2014-08-12)

[1] https://public-inbox.org/git/7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com/
[2] https://public-inbox.org/git/20190319093910.20229-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (4):
  unpack-trees: keep gently check inside add_rejected_path
  unpack-trees: rename "gently" flag to "quiet"
  read-tree: add --quiet
  checkout: prevent losing staged changes with --merge

 Documentation/git-read-tree.txt |  4 ++++
 builtin/checkout.c              | 13 +++++++++++--
 builtin/read-tree.c             |  1 +
 t/t7201-co.sh                   |  9 ++-------
 unpack-trees.c                  | 25 +++++++++++--------------
 unpack-trees.h                  |  2 +-
 6 files changed, 30 insertions(+), 24 deletions(-)

-- 
2.21.0.548.gd3c7d92dc2

