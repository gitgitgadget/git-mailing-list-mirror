Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BB31F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbeLQWlG (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:41:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34446 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeLQWlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:41:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so13981624wrw.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lXy4IaysRPnmF+2J1O5zRaIZP9iLHPksUfPQxVusLQ=;
        b=jcSoOrPmiuWiLj4NwwHCoBenrHujZLH54rR4wyyn/8t2La2tOmQwBKS4QikG3mDC2v
         7hYKueZrGxVdMAo98BNpF/cO/O3nMytpKIHf6TWM5DGPqeBSE0AYJOSRA0cQyR8Bmxpa
         IzJdt4cu4r5jOj9ZwO1SETt7MSY2U1xuOzm7R3KFfThl4wI/BaP+f+N8spJIR9Hg3s5v
         1Cjlxe6kRZO0rkiEkx47HGgk7KXJ3AkqAWMsT5b7x/j5vi7dFGSO+QVl/ggLfZ/iaI2f
         /7GdvxEU9RbZ6bcXoWj0EVWTYEDbtEmHMsX2JnFv/HME9a27v8KPKRcQePGqG91jkjC6
         D0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lXy4IaysRPnmF+2J1O5zRaIZP9iLHPksUfPQxVusLQ=;
        b=hss4/Hayj8GIFUjBBL3Y+e2pJzhykjO9AdwMGudY9QrPJkqvdvJn1ei8J3O/XqSndc
         nGbicb9rMD8wsIGz23jzbSLhnGZ4p8NcPh1W5bBxi79uOtgVezOlaCQiQk8brsDNrlC1
         B2SkPn6F5ae9Uww4aBwdYZ/OQkTjrmslQN4QhSBSdsTiAB8TrsdFxcsbhHuj3PyoYLEV
         I7hYXfF7N2Lvg/ziaMllVmYi7hFaLrCbLe2AdA6A4XeFo9a9SauusaG9XV8fOTDIjrb6
         TlTxmrkeLeEJSiHNZjIFM7rCFoAMv/CuzjhUtM/EYfaQBYcj0o1IpLN1zXc/NRDI4NQ4
         GmjQ==
X-Gm-Message-State: AA+aEWZ/suSgweawKUoyPQJY1IBignlJFoIWAc8F5W5IPkYEFQvgX2Je
        keI4W9n6WNqBK4B3ZsSHBtYMs7k6PS8=
X-Google-Smtp-Source: AFSGD/WihN/4fb2D0OL17aYairX9A9Zzrl2/cJASOxQ6YUE2Z0BxEoOgBJDzZ19qVSpGKaIh6DVwRg==
X-Received: by 2002:adf:be8b:: with SMTP id i11mr12881032wrh.235.1545086464129;
        Mon, 17 Dec 2018 14:41:04 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm2208199wre.64.2018.12.17.14.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 14:41:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] protocol v2 fixes
Date:   Mon, 17 Dec 2018 23:40:50 +0100
Message-Id: <20181217224054.4376-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181213155817.27666-1-avarab@gmail.com>
References: <20181213155817.27666-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v2 of this series conflicted with Josh Steadmon's work when merged
in "pu". That's still outstanding, see
https://public-inbox.org/git/87h8ff20ol.fsf@evledraar.gmail.com/

Then my just-sent
https://public-inbox.org/git/20181217221625.1523-1-avarab@gmail.com/
conflicts with even more things in it.

So I'm dropping "GIT_TEST_PROTOCOL_VERSION" for now until things
settle down. That can land after all this protocol activity settles.

No changes to Jeff's patches since v2, for Jonathan's no changes to
the C code, but I added a test which I extracted from the
GIT_TEST_PROTOCOL_VERSION=2 work.

Jeff King (3):
  serve: pass "config context" through to individual commands
  parse_hide_refs_config: handle NULL section
  upload-pack: support hidden refs with protocol v2

Jonathan Tan (1):
  fetch-pack: support protocol version 2

 builtin/fetch-pack.c  |  9 ++++++---
 builtin/upload-pack.c |  1 +
 ls-refs.c             | 16 +++++++++++++++-
 ls-refs.h             |  3 ++-
 refs.c                |  3 ++-
 serve.c               |  9 +++++----
 serve.h               |  7 +++++++
 t/t5500-fetch-pack.sh | 22 +++++++++++++++-------
 t/t5512-ls-remote.sh  |  6 ++++++
 upload-pack.c         |  4 ++--
 upload-pack.h         |  4 ++--
 11 files changed, 63 insertions(+), 21 deletions(-)

-- 
2.20.0.405.gbc1bbc6f85

