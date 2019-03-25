Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C032B20248
	for <e@80x24.org>; Mon, 25 Mar 2019 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfCYUXl (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 16:23:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35296 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYUXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 16:23:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so11779783wrp.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AM4Sf2fKuv7J2h4fIiJuTJT7uVoCk8oXI74SJXFw/L8=;
        b=IIux2pzZEeCn7tUskFbsTFTLzPNynjHBZPJ+d3M4244/EuQcihIjsRK7zaYTnJ724I
         +zWLI/XsbVuq8dinxsUmkRVt8tXHqtHi95LqRgpoT2jz4rmmWM0q1G1zN/sjoSzJPiTV
         83wJbrUJG8tuk8vFmEiwTH2L/yBXWECl9BuyiYwUGGk8qR39XuF48Tht0aTPffJtBMl7
         WBpm+2/IFTE9YZEcbi6tUQJ6DNJuXBNwGn6mbx6J1+i/J35Tcg/nCWIDIswP439tHQlV
         CqwTfPo33dntQtVI2HocPr4g5mDx6PqcddSpEH2Y/kk7/0iuPS1fodqR7GGG+ygHeTZE
         kgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AM4Sf2fKuv7J2h4fIiJuTJT7uVoCk8oXI74SJXFw/L8=;
        b=SeUTLVyt61qT3UKQMGBXGJXD8zYT+y/YGkz/iFKsprpzuGjU7hTP7NnW5HGccuZOVh
         BFKWPjgICN4gSjzolzwCpz7Hqum3g2rrHbDeDXZAKYJ5RS3zYKNKdClkc7dL8Nlvtw+d
         dYdLHDos0g5gZ9uoysreXnIMqJC//9coER82Wu+wNlCAn0cB/vHg046MUkUSaXk7T1MM
         6fsMQnafbrLsW8/OEPm5kPLMS/ISyaU/GgsTewafMbcCpJP4aLT0J58ovZlGnikCQbjj
         mu12UKrMk9QMwaR/9VtTKaNp6p27JdeH76ogpIYoIeqDKu9lr1X80MVzqlDeUuJ1ZR+5
         fSVg==
X-Gm-Message-State: APjAAAVoPFY42gwbwukk9jrkPYiyTLR9t5e0KDnfw5xM11YgKL72YDZm
        ov1b4ET16Bv6b6wXnaF1FguehM3m8fo=
X-Google-Smtp-Source: APXvYqyzJj4GP+jPU9DoqSZcy6l6AOdyTUjehldmTwwBA6Bvv1ze9Zk7zgjzIqmtMBc/4hoesavveQ==
X-Received: by 2002:adf:ebc8:: with SMTP id v8mr16995742wrn.172.1553545418918;
        Mon, 25 Mar 2019 13:23:38 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q26sm16506904wmc.6.2019.03.25.13.23.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 13:23:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] allow for configuring option abbreviation + fix
Date:   Mon, 25 Mar 2019 21:23:27 +0100
Message-Id: <20190325202329.26033-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on Johannes's just-submitted
https://public-inbox.org/git/pull.167.git.gitgitgadget@gmail.com/

Some of this in my 1/2 could obviously be shortened if the
"GIT_TEST_ABBREVIATED_OPTIONS" name was used by default, but I'll
leave it up to discussion whether it's worth it to go for the route I
took here, and if so to rebase the whole thing or not.

While I'm at it fix a bug I noticed a while ago in 2/2 related to the
option abbreviation being silly and tripping over itself over an
aliased option.

Ævar Arnfjörð Bjarmason (2):
  parse-options: allow for configuring option abbreviation
  parse-options: don't emit "ambiguous option" for aliases

 Documentation/config/core.txt | 12 ++++++++++++
 builtin/clone.c               |  4 ++--
 parse-options.c               | 22 +++++++++++++++++-----
 parse-options.h               |  2 ++
 t/README                      |  4 ++--
 t/t0040-parse-options.sh      | 27 ++++++++++++++++++++++-----
 t/test-lib.sh                 |  6 +++---
 7 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.21.0.360.g471c308f928

