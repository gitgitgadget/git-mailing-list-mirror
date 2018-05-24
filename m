Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD02D200B9
	for <e@80x24.org>; Thu, 24 May 2018 11:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969273AbeEXLuM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 07:50:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40596 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969279AbeEXLuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 07:50:09 -0400
Received: by mail-wr0-f193.google.com with SMTP id l41-v6so2570870wre.7
        for <git@vger.kernel.org>; Thu, 24 May 2018 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yp+h8ZaUvArBAjPjo7JrJgt+07eV1DQivqG3wEWHReQ=;
        b=RkEj9lir1zFEWzUvBfEgHqmnDOBIcPYICtdzPwtgRUpOenUC/VcN2WP8K0pymmXF9j
         gVUAK4RIrbDzHxJfnvCtm0Zb4rjPfUl5yzK2H3KV+swmHzanbCexWdNpUTEOX5F3IX9y
         gU8Ch5XnhvvgNBMDdUfZft+EJxyJ5V+njwKJ+LVWpw2PBywrYROrP0ep42iEEikSgoll
         R3EYh4cp4VmfcZlAuFryUTpzNOAxJvITSS+rLj8WPpSqGHT715qhftjd+tHQw/ca4lOU
         RQvXsgEzbr45/oDSbVfs5wrsjgwIoO5Jqix2UOl3y5ShdJaKUdQGrT38VNUYh7MH2QtD
         KTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yp+h8ZaUvArBAjPjo7JrJgt+07eV1DQivqG3wEWHReQ=;
        b=ZVZrsGmN0NpPq2FnLbXowmB3qk+NLSYsItzuxt6szd9xFRMKNdh5nAKUAXBrj2DuSQ
         aEwxkerlTUwZtN0fxcUWtRWhVn+mTCyWqibKAW/VB+JqB1xWEf3jr1Gn/jJqevEicPZc
         vlmJ+GY1k8LjCLVkRkIfjGU9qs9GA4Pm+xzbfRto8R47xvB/rNnZ2Cl6Ra1ndjQpBXHt
         +yUCh4C1Z7zfXJCSD3j0PGdvYnf7uALekHNH/dtKHKu00LHpeHTN7m8+R0Uk2QjGF7/f
         b8DN/z/DvkwS8bBPbftA6XmaxVXTc0GNZqpXH+yN07V3et7q5t7oSwezjRh9jq4d9P6t
         EaDQ==
X-Gm-Message-State: ALKqPwdMJAqZfpW52oEcqPjHBRQF+i29BBOjXG0qnvvg1DGhNzW22DOI
        cnMNMGDJUdAywkMTZvT+GDha8pGHixI=
X-Google-Smtp-Source: AB8JxZrUUDKS8OWBtwzcvpTAajwcpdrrTJEUWfbGRoSA77PEMLUazuByeovia+xFr6+ZDnQah3QLIA==
X-Received: by 2002:adf:87d0:: with SMTP id c16-v6mr5374626wrc.246.1527162608109;
        Thu, 24 May 2018 04:50:08 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id o53-v6sm31494264wrc.96.2018.05.24.04.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 04:50:07 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 0/4] rebase: split rebase -p from rebase -i
Date:   Thu, 24 May 2018 13:49:54 +0200
Message-Id: <20180524114958.26521-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180522211625.23893-1-alban.gruin@gmail.com>
References: <20180522211625.23893-1-alban.gruin@gmail.com>
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

Changes since v2:

 - Removing `

Alban Gruin (4):
  rebase: duplicate git-rebase--interactive.sh to
    git-rebase--preserve-merges.sh
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

