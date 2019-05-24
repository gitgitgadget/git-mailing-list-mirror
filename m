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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1151F462
	for <e@80x24.org>; Fri, 24 May 2019 09:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbfEXJYw (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:24:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33762 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389787AbfEXJYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:24:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so3965204plq.0
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wnj+LGHkTWe6lOYjFjdAIIjawLIN+/+mebUFd6YFsE4=;
        b=HMGryG2WjCjgyichr7GWsLCqubQXF5RAjBIFgwkgJCVWX9KxNzb9ory5mCe/I1Nudf
         Y5XrPwStnWo3NwZrqcvDqBmPi0YFUU14x0Ik1J8j4qny+0h8jndMme6/bJfOU13G5SKv
         xq+n+jxcBEooBAZWba0YwGRSo6LLs6BN7SIyJRSsjrjIj+EBEHaNmSXar44ujzxCbAB9
         3jaLa8mG7/7SlAWyadiqZLlh3WkNh961pfv52t3oAwE6aqmuGf34/iUmSLUSgwgXdTUS
         Evd6Ww9pUuvvO3g487F0SYDCfJMYpls8wZFlZMn/GJ6MuaNW751cvieHA95RSfcNDkOy
         76mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wnj+LGHkTWe6lOYjFjdAIIjawLIN+/+mebUFd6YFsE4=;
        b=ZhulqlRPpHxcn9ddFXAhoNIndx82dF6JQErubtDSVyDmN0IXeE73SFFDjAIhOMh2Ua
         Kzqh7b+7KsBuLoFvE9E53Tq0PJGdZhq8LeJ8sAfA3P7JdtGevppcfmj2yAEY08Lxtw1F
         6AgCb4AkG3AlpA5TlLaXE785jds0sRFaSiudZB05DcGLE5ec5KJ929/mBpbI4hkiUM8+
         +cZCNgxFJOk0qbWGTJgC9nEp0eVW5qQoQ/x1Sr+Y8a2uemSvOaxQTvUo8vyrNRolWB3L
         OH9tICssxxharVNP9fr9h7e84Q9q5AzYalQNNFckYkaKgms6YNsNHAJhyi7es3ZK5TwH
         ub9A==
X-Gm-Message-State: APjAAAV/unNFH6Nht7dQHhh6XdFiLf7clTRq7OVzdHTdfijkhbNCQYmN
        b74fJznhPZ9r5JefB8GuVEyBOV5p
X-Google-Smtp-Source: APXvYqyJNNlhz39flpYw2rPYaSHrjcNTlK631OIHa1JIkxCesGfubTVsofGjYZE2Pw/aQNUV++hGxQ==
X-Received: by 2002:a17:902:bc8a:: with SMTP id bb10mr5003552plb.310.1558689890541;
        Fri, 24 May 2019 02:24:50 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id a69sm4507117pfa.81.2019.05.24.02.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:24:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 24 May 2019 16:24:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, bturner@atlassian.com, tmz@pobox.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] fix diff-parseopt regressions
Date:   Fri, 24 May 2019 16:24:39 +0700
Message-Id: <20190524092442.701-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should fix the diff tests failure on s360x. It's a serious problem
and I plan to do something to prevent it from happening again.

The second patch should bring '-U' (no argument) back. Whether it makes
sense to accept this behavior is not part of this conversion. We can
deal with that later.

The third patch also brings back a corner case behavior of
--inter-hunk-context and as a result strengthens OPT_INTEGER() error
handling a bit.

Nguyễn Thái Ngọc Duy (3):
  diff-parseopt: correct variable types that are used by parseopt
  diff-parseopt: restore -U (no argument) behavior
  parse-options: check empty value in OPT_INTEGER and OPT_ABBREV

 diff.c                                    | 10 ++--
 diff.h                                    | 70 +++++++++++------------
 parse-options-cb.c                        |  3 +
 parse-options.c                           |  3 +
 t/t4013-diff-various.sh                   |  2 +
 t/t4013/diff.diff_-U1_initial..side (new) | 29 ++++++++++
 t/t4013/diff.diff_-U2_initial..side (new) | 31 ++++++++++
 t/t4013/diff.diff_-U_initial..side (new)  | 32 +++++++++++
 8 files changed, 141 insertions(+), 39 deletions(-)
 create mode 100644 t/t4013/diff.diff_-U1_initial..side
 create mode 100644 t/t4013/diff.diff_-U2_initial..side
 create mode 100644 t/t4013/diff.diff_-U_initial..side

-- 
2.22.0.rc0.322.g2b0371e29a

