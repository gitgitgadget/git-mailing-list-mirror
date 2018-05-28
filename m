Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4EC1F42D
	for <e@80x24.org>; Mon, 28 May 2018 12:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424964AbeE1Mfc (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 08:35:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44880 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422876AbeE1Mfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 08:35:30 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so20047961wrg.11
        for <git@vger.kernel.org>; Mon, 28 May 2018 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suN0GuOY26JAMlNHpGsNAtDbTbzHz/D8Mi9I63z/MRo=;
        b=QpWdBNqesyH49LC44hJ88AMMZwGG9FouV71YlOfWOXe8bL6LnOSIN/Drb7T/eGEeqQ
         /gk7SMf9F2eEdH7rBWwsOxFR8V1sJQsF/o3LOCPbyJyKAm/OW+TYaN7kSVpcKXq42EXD
         kNcQaJXV7tqEQgnkKk69Ql3Dib+jFcow6lQzNMXScA259HHiOGgRxtU2osiBcfcnViOf
         w0eR13NgrEbtkR68s/EqVcHr5O58UUEKHWIvj1FyiZyPLCWjcltSoNjGJGh7YgNeb3lt
         Pm6VvJM/BY43anKVku2c75zzkPlQuaMwjeRXJvsac6enNvlZsqm09oES0Negr/UyRmOL
         hLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suN0GuOY26JAMlNHpGsNAtDbTbzHz/D8Mi9I63z/MRo=;
        b=Rleptvfk5Ol5kAT5vT9zxwKLnahr0nO/cS9s6lUqRV+zATVhBvUMtRU7RUMWpNbHDz
         fsmdCGzwPTMa7BCPQWdbT4kqUTsIJEAaFlLMZ5ieRu0pCOV36LXTE8E5MsBgFFCo0/Ys
         e33DGeIIbLezcbrRGe5bTxIJvWxJYGEkU45mtssh0h79hXZ8aqPv3rJJa4KVilmsi8wk
         cBXXK1k5NufBOvi4TN521DxlfOeuyv98PmEKCFfJH+5OrA6rB0sDGkO3jqgvYm87kdpo
         aJh45GrnJakE+B1JkaJyWDAjkm668W840Likk8QvtBwCshsMc5+LbfojAY/fHhnvL67D
         3MsA==
X-Gm-Message-State: ALKqPwfxSEdwmCc9Vg/ZEpQ9iQhzQI0DUfV7Y8pKJcBx9TSMILGOGq5S
        szdnQMt6t5PRoBW8XZQT+IWSgwEPwTY=
X-Google-Smtp-Source: AB8JxZpCIAzJ/8w9bwu6f8DqwlHMLYN6v5CgXu9t02BCHRmZoZUd8+7uyu1XPoWt/t6pfiP7bTLRgQ==
X-Received: by 2002:adf:dfc2:: with SMTP id q2-v6mr9027172wrn.113.1527510929101;
        Mon, 28 May 2018 05:35:29 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id p5-v6sm13808895wre.83.2018.05.28.05.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 May 2018 05:35:28 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 0/4] rebase: split rebase -p from rebase -i
Date:   Mon, 28 May 2018 14:34:18 +0200
Message-Id: <20180528123422.6718-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180524114958.26521-1-alban.gruin@gmail.com>
References: <20180524114958.26521-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the `rebase --preserve-merges` functionnality from
git-rebase--interactive.sh. All the dead code left by the duplication of
git-rebase--interactive.sh is also removed. This will make it easier to rewrite
this script in C.

This patch series is based of js/sequencer-and-root-commits.

Changes since v3:

 - Rewording the commits to be more descriptive, and to respect the 72
   characters limit.

Alban Gruin (4):
  rebase: introduce a dedicated backend for --preserve-merges
  rebase: strip unused code in git-rebase--preserve-merges.sh
  rebase: use the new git-rebase--preserve-merges.sh
  rebase: remove -p code from git-rebase--interactive.sh

 .gitignore                     |    1 +
 Makefile                       |    2 +
 git-rebase--interactive.sh     |  802 +------------------------------
 git-rebase--preserve-merges.sh | 1012 ++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh                  |   32 +-
 5 files changed, 1048 insertions(+), 801 deletions(-)
 create mode 100644 git-rebase--preserve-merges.sh

-- 
2.16.1

