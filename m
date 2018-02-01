Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7C41F404
	for <e@80x24.org>; Thu,  1 Feb 2018 13:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeBANCa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 08:02:30 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42510 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeBANC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 08:02:29 -0500
Received: by mail-pl0-f68.google.com with SMTP id 11so3450264plc.9
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 05:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MGBRR0KZtQj7eGHuZ1wJyAD5iTwWsOCAIMWGXSm5Qm0=;
        b=TtuPSHHXpyEHQMHkaMqHXXo2VNxJPb6B5+vKIe9nvpTP2NAOrgX0ftPR7pavAp9tvk
         LzIJm3vDlZhqVtbvj7ZNNDnxzPdK/IqAyesH2Rm5XlekFaCZ8uyBHHpB6efeb9J252mo
         d5OuUxFF4zmD69VgvIyvkFnJZ3uOHdyWeq53JS5ZNuJUFnKGLmpbBb3ZDRDdC6sZfvt5
         r763bRzQPaqCCb79tGHqPuy0bxhJ6HippB9QRrB3DmiMvcqGSTwBywGuXL8BOK2R8b67
         DG5GJo8Em3t2VmsqlWNr9hKp4TfNUvdX+oaTO3todhMGtnSdETu9O4qJ4vxeI6K/8OuO
         vagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MGBRR0KZtQj7eGHuZ1wJyAD5iTwWsOCAIMWGXSm5Qm0=;
        b=pCdZHsawO/+JS8gpiqZnraIMTNh38bBfbml1EfkjVYWmWQzXeQaijrmTSlJb+optfB
         3vBsEOEMc7sZW7BA8y3cAkwM5/LU/eMKHCDnZsR1ZcclS/cfMuw0UFRfQ5THmu/J+ag4
         rZ5apJrTQ+GK/R72k0iAYnGthZGHA89vJnyDvD6mJG6P8KspG8H2rKpAzJVGX1JO87Xp
         yF0ZP44zrrf9PEwo5CgZ5WoC08nN4lO/Fm/dYQjPx6O3sC+I7I8BYBgQxjbnviH5ySwr
         IZBYHcD5qUJ8Sm9mYSwhGNk5RI5HSwxuGnGy+lo6BnpsXh79hPkvK7jrCna95qcbD92w
         S2Gg==
X-Gm-Message-State: AKwxyteQ+t5uJREPyNQJaEMW3MMXsU4X+Z48yPrDb8yV2cDaN3nSpLj0
        eIiRlzBhaeDlnBRmcU1Gpwd2wg==
X-Google-Smtp-Source: AH8x225Ubp0Lf5C8HjENFFM7e0uOSBA9clfnLTLH4llGCkrcgtmIym0C0wOGE/ViSNh05VBSuuSnsQ==
X-Received: by 2002:a17:902:4383:: with SMTP id j3-v6mr31212633pld.320.1517490148371;
        Thu, 01 Feb 2018 05:02:28 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id r14sm45457711pfa.136.2018.02.01.05.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 05:02:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Feb 2018 20:02:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
Date:   Thu,  1 Feb 2018 20:02:19 +0700
Message-Id: <20180201130221.15563-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2 [1]:

- goes back to my original version (yay!) where the extra info
  is appended after the path name. More is described in 2/2
- --compact-summary is now renamed --stat-with-summary and implies
  --stat
- 1/2 is just a cleanup patch to make it easier to add 2/2

[1] https://public-inbox.org/git/20180118100546.32251-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (2):
  diff.c: refactor pprint_rename() to use strbuf
  diff: add --stat-with-summary

 Documentation/diff-options.txt                     |   8 ++
 diff.c                                             | 101 ++++++++++++++-------
 diff.h                                             |   1 +
 t/t4013-diff-various.sh                            |   5 +
 ...pretty_--root_--stat-with-summary_initial (new) |  12 +++
 ...tty_-R_--root_--stat-with-summary_initial (new) |  12 +++
 ...iff-tree_--stat-with-summary_initial_mode (new) |   4 +
 ...-tree_-R_--stat-with-summary_initial_mode (new) |   4 +
 8 files changed, 113 insertions(+), 34 deletions(-)

-- 
2.16.1.75.ga05e3333b4

