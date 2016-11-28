Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5F51FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbcK1Jhe (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:37:34 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33061 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbcK1Jhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:37:32 -0500
Received: by mail-pf0-f196.google.com with SMTP id 144so6202372pfv.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YzRlL9ycEEDqtsoXEfjTzO+6dvp0AOD5KYB2T3J+/+M=;
        b=I0NCgoXl4Wi/X62UoD+U1G/bA8kxtWyoZlB6uFqCRwoi2Bbcz8jfNavGI1GaKDWMtL
         GC8e8jeBp6UTkFpmomKLvZw/kShKoQfLklE1b4DafL19SdWkl2EvGO7T/JfQX4qvMNgZ
         +Y27TvJOe10V/j4Ux2Rprg2ZIB3MptVsc3q+eYpEM+y4gYw7SG77wt9jELRmvOPKBCa4
         7u+VV307miccfDi7qSc5nFaDmrhaJHb5vSKch93Fae3OoWbM0hXCJQlzGWkrDwVoSnW+
         IURUpNStqo6x6nfkdGgHU9ekd29HEhqkD0qB0irxAcVar6VDOyLigWX8fdD0/a9O+YOs
         wFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzRlL9ycEEDqtsoXEfjTzO+6dvp0AOD5KYB2T3J+/+M=;
        b=VOkiEAs/uLA+uCWmTtPFb/4P0cs5xiYqICQg9U+uKohYYtS2YUWiQbDGHUPEcF8ET4
         +0xxDlcRIoK8B1oA7a+aEN7P0PRB86SJLHVyGnMFleRZFxpKxEO28MGQ5FgWLpnJrpLt
         uIM3He03frNu5C/aJMS7Rp/e8N6syznA32RygwDJ+I9dJLDy4V/23judsxwCSG57YaE0
         P/xxgdC9TLb/51mEh7eSsJPXour36vj/3aiS2TbPrgPtHCZQCByq5TXFPsoq1WKZzQEa
         wtgBxFMGvG3/LC45gtpNNNGtUcfmuMOyo5qs8pYhXGPG04fn7dGsUpKZRlY3jEaTbTj0
         LHXg==
X-Gm-Message-State: AKaTC006PUEV4UqTjimgFajbFWQoQ9oZHZ/yYidCS2oYmUURuLJrxTKrgsntHOIjHLSbSw==
X-Received: by 10.84.130.5 with SMTP id 5mr31465946plc.69.1480325840048;
        Mon, 28 Nov 2016 01:37:20 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id v1sm67877219pgv.33.2016.11.28.01.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:37:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:37:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/5] nd/worktree-list-fixup
Date:   Mon, 28 Nov 2016 16:36:51 +0700
Message-Id: <20161128093656.15744-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161122100046.8341-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version

* changes get_worktrees() to take a flag, and adds one flag for
  sorting.

* adds tests for both the 'main worktree always present' and the
  sorting problems.

* reworks 3/5 a bit, keep changes closer, easier to see the cause and
  consequence.

Nguyễn Thái Ngọc Duy (5):
  worktree.c: zero new 'struct worktree' on allocation
  worktree: reorder an if statement
  get_worktrees() must return main worktree as first item even on error
  worktree.c: get_worktrees() takes a new flag argument
  worktree list: keep the list sorted

 branch.c                 |  2 +-
 builtin/branch.c         |  2 +-
 builtin/worktree.c       | 14 ++++++++------
 t/t2027-worktree-list.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 worktree.c               | 42 +++++++++++++++++++++---------------------
 worktree.h               |  4 +++-
 6 files changed, 74 insertions(+), 30 deletions(-)

-- 
2.8.2.524.g6ff3d78

