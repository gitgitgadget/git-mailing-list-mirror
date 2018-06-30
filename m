Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87151F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754307AbeF3JUm (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:20:42 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33238 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeF3JUk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:40 -0400
Received: by mail-lj1-f181.google.com with SMTP id t21-v6so9078082lji.0
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=As0gY8UaLokRNmYIMtoVlpA8He/VaBVIVSklwTSvlKI=;
        b=CCcY8CcXwy9nk6hyG3rmyIBtWxwZdzP8R26ppfjKGcvqifhwTj6DJudbvdIPCs1G6q
         N13Cz5NP3JmfFvTa6kfHQT5XpAEw53LdXUxQS3m22k0w1S7Oqzbwepah72nf9nhjiOse
         75DS6uKN35NtRyddyxhP+Y1pCSs77KLycrZaRRe1n2p/9wA9DmVUqA7mZIj4eVlMrXqt
         zAdfSqndtJQklleTJq1C5dle70WkVhutzg2FQuRG/bO0ekE4yvqsyNR0Jk1zQfRFnj0y
         BMy2xIdSzOvs/7HO2dbqHqa9TYmpiVyGtZIXITuS4kpixhERgTHFJNCgPm2ISMYvEv70
         zuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=As0gY8UaLokRNmYIMtoVlpA8He/VaBVIVSklwTSvlKI=;
        b=tqV7b2j0wzDdGy3kVQU9drJ9u5Os5l93B0UvSBB71oxODjXUwRq21D8B9nQEM0VD0e
         tTK0LgMOSSBlajp4bE1eb1UKQz04t8GWl7N2pD4E685GjwNYQcObvC4PV1tLCRV5WiCn
         lTaUVOZl5CYCIxzUgrMf2WsLLnS/FFk+qxjHAuSzTOZLnGqciCehkMTWv/2jgipZkXdc
         yRZUnxQSwlFf0ewcBTUM+VUNa/xSUUxzTlg/OT7ufOVsM+SZnQEdbjl4NQYwwDkwVWbP
         SZ6kubJFwE26NiRcma0qnFP8Yzj3hjjKij+0+M2BuN8CZuIyM/JUHqBYi1vEHfwbVs20
         QmHw==
X-Gm-Message-State: APt69E3YDp2E1SmFq/od/Gw9JLKAbsXMaTFRrxSM9rfx8nFcjW0PP8S1
        pu8ya9DcHEqlmU0jX8xaHMfOkQ==
X-Google-Smtp-Source: ADUXVKLN6z80C8H0/O4at5wxO4mP+H+je/ppre7TGTI4uA54XHFhuucMsp0S2/aTJ8UgDvRHde9vcQ==
X-Received: by 2002:a2e:1781:: with SMTP id 1-v6mr12188162ljx.76.1530350439194;
        Sat, 30 Jun 2018 02:20:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/12] Kill the_index part2, header file cleanup
Date:   Sat, 30 Jun 2018 11:20:19 +0200
Message-Id: <20180630092031.29910-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like part 1 this is also boring. I wanted to drop these 'extern'
everywhere actually, so before I touched any header file in this
series, I did a clean up first. This is the result (and to reduce diff
noise later)

Nguyễn Thái Ngọc Duy (12):
  apply.h: drop extern on func declaration
  attr.h: drop extern from function declaration
  blame.h: drop extern on func declaration
  cache-tree.h: drop extern from function declaration
  convert.h: drop 'extern' from function declaration
  diffcore.h: drop extern from function declaration
  diff.h: remove extern from function declaration
  line-range.h: drop extern from function declaration
  rerere.h: drop extern from function declaration
  repository.h: drop extern from function declaration
  revision.h: drop extern from function declaration
  submodule.h: drop extern from function declaration

 apply.h      |  23 +++++-----
 attr.h       |  24 +++++------
 blame.h      |  28 ++++++------
 cache-tree.h |   2 +-
 convert.h    |  56 ++++++++++++------------
 diff.h       | 120 +++++++++++++++++++++++++--------------------------
 diffcore.h   |  50 ++++++++++-----------
 line-range.h |  12 +++---
 repository.h |  25 +++++------
 rerere.h     |  14 +++---
 revision.h   |  69 ++++++++++++++---------------
 submodule.h  | 112 +++++++++++++++++++++++------------------------
 12 files changed, 269 insertions(+), 266 deletions(-)

-- 
2.18.0.rc2.476.g39500d3211

