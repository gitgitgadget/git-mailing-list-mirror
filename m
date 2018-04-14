Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D57E1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeDNTUA (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:20:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34533 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbeDNTT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:19:59 -0400
Received: by mail-wr0-f193.google.com with SMTP id d19so15849208wre.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4oq5l/zj8x67KFSbm/fr61cM5zS29VeTquuj3DiKLU=;
        b=ANX3RkNPA55JhXOqR+JH1TCMPYSBOvh6541sYpAw+PdsSEYhFc+295s3amrXCAKeSD
         O+fzgs+04yHnShotnZicKbP8BXOEY1qcGZFJG98IVxm+Jhiu6bxAyT81i0NkItxcjphM
         hqHYzGfxUUy5ReUHo6XJlw5yYZzVfqWIIDHeJ71LRwnkOFCWNFijcSuO3eCeciQFTyAY
         C0wryZNbZBc2q1zzPQQZMxDZp+XRhwXmhqUIjMuBPyyQaey5x55uh2lPfIQkgd0CENxT
         9GyeUPOynEr8pxsxKswEIDsUSyfPAZ2b3fhZOvhMbgISTv8vJYHX7wZt11XXzQWsbIOn
         qySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4oq5l/zj8x67KFSbm/fr61cM5zS29VeTquuj3DiKLU=;
        b=HE2X8ScJPC97YeaEpK5Xlz8EhWYe3uaKU7KZS+4urlQhGRuowPpLXsGs10ca38ZfaW
         qUSNIhqb1anoTVhGgAKoynIFuF+A3aHzkNvM3LRXiJ3Kd7N8rqD9J6gPsAP8IX2lOn7U
         SaOQIUiOkyrvV5fOvpfEkTdliVUaSK5NRt8czDaROlIVwb9TdKrgZnaGm7oZ2YRmJU9C
         YZLng1yrbQJqEgjlOwdAm5Qn4RX4YCxGxFu6dWujQxrxYqP2o5eY3nIjid/PmhVjt7Ja
         y/x1ElWpfXYhhl64DDlv/yRbuOFu3BVGjqWteLgp1bIFZ9FT4dsubozQJdRloJ3K1CKC
         7m0g==
X-Gm-Message-State: ALQs6tAX5/3rxqJG0K0qUEXWFmZdQoh/TgHsMzkKbaMeZayUNknj7daZ
        8xiePvBuK3JH+sRmak7O/A4A6eGn
X-Google-Smtp-Source: AIpwx49q0HWrVdPwTr4iq5904yyaS4nFmos8CSIr4+iDKgUE0ES1t5B/vP1GBvLRK7c5sUakQTZeyQ==
X-Received: by 10.28.118.3 with SMTP id r3mr6821202wmc.90.1523733597631;
        Sat, 14 Apr 2018 12:19:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 31sm8610644wrm.68.2018.04.14.12.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 12:19:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/4] Make DEVELOPER more more flexible with DEVOPTS
Date:   Sat, 14 Apr 2018 19:19:42 +0000
Message-Id: <20180414191946.30674-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a v4 and replacement of gitster/nd/warn-more-for-devs. I'm
sending this with Duy's blessing.

The first two patches are the same, except for one trivial
s/faimily/family/ typo fix.

The third patch in gitster/nd/warn-more-for-devs ("Makefile: add
EAGER_DEVELOPER mode") is gone, instead there's now a DEVOPTS
option. The 3/4 and 4/4 add a way to turn off -Werror & the -Wextra
suppression, respectively.

Duy was right in [1] that this is a much better and extensible way of
doing this than my "Makefile: untangle DEVELOPER and -Werror" patch.

Most of 3/4 & 4/4 are just tweaked from git@github.com:pclouds/git.git
pclouds/more-warnings and combined with my previous 4/3 patch[2].

I changed the "no-suppression" name in Duy's WIP patch to "extra-all",
and "gentle" to "no-error". I think those are cleare,r and leave
things more open to future expansion, e.g. if we'd like pedantic-all.

1. https://public-inbox.org/git/CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com/
2. https://public-inbox.org/git/20180331164009.2264-1-avarab@gmail.com/

Nguyễn Thái Ngọc Duy (2):
  connect.c: mark die_initial_contact() NORETURN
  Makefile: detect compiler and enable more warnings in DEVELOPER=1

Ævar Arnfjörð Bjarmason (2):
  Makefile: add a DEVOPTS to suppress -Werror under DEVELOPER
  Makefile: add a DEVOPTS to get all of -Wextra

 Makefile        | 31 +++++++++++++++++++----------
 config.mak.dev  | 42 +++++++++++++++++++++++++++++++++++++++
 connect.c       |  2 +-
 detect-compiler | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 11 deletions(-)
 create mode 100644 config.mak.dev
 create mode 100755 detect-compiler

-- 
2.17.0.290.gded63e768a

