Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262F81F406
	for <e@80x24.org>; Tue, 16 Jan 2018 10:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeAPKhP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 05:37:15 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43197 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeAPKhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 05:37:14 -0500
Received: by mail-pf0-f195.google.com with SMTP id y26so1871194pfi.10
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 02:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7poYFQws2ABqIF286Uj0MhJ0lSPGqQGT8OI2SrgNW1Q=;
        b=Af5Rls/A47QFuj4AqQJhXiO8+FpGqNvIaOm4Hn/+lT7Il/2wfJ3v3lb68bd0gW+Xzp
         hKzTmHLbLqN+XiC3xTGRV9Qp3wp2Pgnz6N7+qymWwe53JuI3YqLRtZNESx7MftRhHuo+
         6ifF+0PI1KBIHnqraP2ovdh504yg8rR2A444KZNn6cCwsuQCZYa8RJcYn3MfkAs6QtLW
         5T7VncygXWt/vdKiHy6RwivJA/axSXPiB8F1dG0fuMhA2OuQK90rbHn2PjtLhiraBNc3
         Mdm59+P6pthVsgl+r/3e8N6xb8m24SSt3+JpUo9ecxlR5j2PoCi3JbcJTQEsOUimmvsN
         bqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7poYFQws2ABqIF286Uj0MhJ0lSPGqQGT8OI2SrgNW1Q=;
        b=GCOt6E9ja60eLq2rvA0LVEsv2HySOISSMJS6rx8fuiXQME4/Vux7LKy3+PWHmI/k39
         AVZeXOAUT3oXZC2rP7HECNh7h0n80jBdF1XsJhNteCfwB6sXO1XQnXOYKv//O+reDVHO
         rVrLabO5NKG2h71rWrvlKf6sMb84jaMZkelU5t5bbMY00TkixZBuJdht+Gw2N7eXqFcG
         AqSou9ZWL0+daA3Msp6NLb0Pv/4tzLEHku9sVjSRA38qAEm6bpq6chPUTxgGFBm15Z1o
         Ox6hCeiZJdduINoWU0vgpNK0Uhpek1oun9iW36YUHzA4aG3+R1pFx1AApPw+NDnKh9G9
         8Y7Q==
X-Gm-Message-State: AKwxytdRVUnj9uikenll7KAxBecOHRuQQ74TmQhRPKZ29k0+VEA1f3vV
        ZOJ4uHGqr6AUWpKjl1SzxjesQg==
X-Google-Smtp-Source: ACJfBov0+yxg+xVnzxOtsA8ukdlv7zFEvepu7LRT7lnsaPElTIu2g0MWSUDOQppWDxiFjP6deEhe/g==
X-Received: by 10.99.126.73 with SMTP id o9mr12355357pgn.429.1516099033211;
        Tue, 16 Jan 2018 02:37:13 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id d5sm3630994pfk.2.2018.01.16.02.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 02:37:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Jan 2018 17:37:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
Date:   Tue, 16 Jan 2018 17:36:58 +0700
Message-Id: <20180116103700.4505-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed --recurse-submodules was missing from git-grep complete
list. Then I found a couple more should be on the list as well and
many more in future may face the same faith. Perhaps this helps remedy
this situation?

This lets us extract certain information from git commands and feed it
directly to git-completion.bash. Now long options by default will
be complete-able (which also means it's the reviewer's and coder's
responsibility to add "no complete" flag appropriately) but I think
the number of new dangerous options will be much fewer than
completeable ones.

This is not really a new idea. Python has argcomplete that does more
or less the same thing.

This is just a proof of concept. More commands should be converted of
course if it's a good thing to do.

Nguyễn Thái Ngọc Duy (2):
  parse-options: support --git-completion-helper
  git-completion: use --git-completion-helper

 builtin/grep.c                         | 13 +++++++-----
 contrib/completion/git-completion.bash | 16 +--------------
 parse-options.c                        | 37 ++++++++++++++++++++++++++++++++++
 parse-options.h                        | 14 ++++++++-----
 4 files changed, 55 insertions(+), 25 deletions(-)

-- 
2.15.1.600.g899a5f85c6

