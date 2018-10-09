Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45CE1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 11:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJITPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 15:15:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45268 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJITPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 15:15:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id v18-v6so1401885edq.12
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTNP7BAT2nD4D3j6AlZV4HR4MoaRHvnZXgS9XpeRgj0=;
        b=BUFpSUvtYMFN4WQln5f6GYhpg6jVZJkWqdBx9jlYmi1jpwIplb4HqKjUMjUc+nldLL
         J9tZJ5bGhlMTXKK7WB7LiCW6kwgzDZaOjfHGEN+zk200x3PeYSY0BunmwQyFvlxRg6MC
         oHqvHcGYcG8HmmERtvg6vnVd+jCxK8XZfvC2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTNP7BAT2nD4D3j6AlZV4HR4MoaRHvnZXgS9XpeRgj0=;
        b=ReQiNn3xOo2Cc/ZYIIOUnzUqZj7BpojHtl1qqfdLNbbrJ0FCPh3lR8YDwv/EETh9Ne
         ak1763CWP3+vO2LJKiLccjpJr03V56R2N1KIy/xyXTpSMyVuIrhzzAGCcqj6oHPrMG1A
         xyjTl0Vuhg2qWhOBVQmmc3ZHaqSaxDE4iWc21lIqmirASIXM6oILTB2KeMy3MkjJpQkj
         3ugjE7yOesKUTaJPJvZ5EoEAK6YL9lNg/hH7UTMAzzBu4L5zSnIORv1Xnj7WgFIWCIU/
         UPNhVmGcvTnvZvWUYE8IehNbD3EmpJMbPDkzqyBG8rmY7poDO11CbzhK3Ly1X7CoZeEX
         RADA==
X-Gm-Message-State: ABuFfohciKPrj1DIPcPJEJCu4+VEBmOjMh2Q3g08L6xzbIWGPcEkILn8
        cxb4j23TDfWrEOF4gMg86/rNhR6Bf10=
X-Google-Smtp-Source: ACcGV61EHqqTxL591q98XS3dWZQ0Aa4PXNmycXGlnzibDLifbbxsH8flG37W4zF/vyK0JZYoTxOnlQ==
X-Received: by 2002:a17:906:1c45:: with SMTP id l5-v6mr28183739ejg.118.1539086353642;
        Tue, 09 Oct 2018 04:59:13 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id o4-v6sm3522556ejx.30.2018.10.09.04.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:59:12 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 0/3] alias help tweaks
Date:   Tue,  9 Oct 2018 13:59:06 +0200
Message-Id: <20181009115909.16648-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
References: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2: Added patches 2 and 3, made "git cmd --help" unconditionally (no
config option, no delay) redirect to the aliased command's help,
preserve pre-existing behaviour of the spelling "git help cmd".

v3: Add some additional comments in patch 1 and avoid triggering leak
checker reports. Use better wording in patch 3.

v4: Reword commit log in patch 1.

Rasmus Villemoes (3):
  help: redirect to aliased commands for "git cmd --help"
  git.c: handle_alias: prepend alias info when first argument is -h
  git-help.txt: document "git help cmd" vs "git cmd --help" for aliases

 Documentation/git-help.txt |  4 ++++
 builtin/help.c             | 34 +++++++++++++++++++++++++++++++---
 git.c                      |  3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.19.1.4.g721af0fda3

