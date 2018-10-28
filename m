Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641FF1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 22:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeJ2Hgd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 03:36:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44151 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2Hgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 03:36:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17-v6so6378240wre.11
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8u2fbyvtl2xNhBjt661hpUhSeNbXSl859evIdRVFdI=;
        b=Ed6m9YTWI9mmnt0c+y3OAze5qwWmYSfVRG2cPer1VG5gBczVZNX+tD+WskgEIS/mLx
         8prmP8GwR3LrsEYr0FFJIH0d7HyND3sIb0fWl/vn08sHJEAIOq6lvzE3DShjEOyj45d3
         iARqqJVp1yoZOtwqIrDwOHqo1NxVLEKKuOxvB2CnwCpEeSEj3gWSPmyJ0Hb+p9LF54hv
         Y2SkgZelKayWcyKGw/R0haEX2MK/bucgPLXBBpFdxqGNnPO3kzSozh6iq6gsizVjwLPR
         +nfHAtbyaZz/tDVLGLc/7IQ8RcA/+TlVGRN9ymIzKPrjR2pVtjSlDyrksz++C1pFclsi
         X/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8u2fbyvtl2xNhBjt661hpUhSeNbXSl859evIdRVFdI=;
        b=tChFQR26vl9if2IrQzOKxits7xm2ZrDHpXLwrdP4A22Cv1CkEozX1IG1RYjxuWJrlu
         T51D7ETRRVDX8H+Y2WN9M+escyKCgJJMsCRmDPYnA8rSaIvTivIY98WVaSJKaWEOyeQ8
         5ty7+KkDNRn1x+W5k5hY8V2KbyY7g1HzYztsrJheSPf7BeZwIULFO0RhQdBBjHEJcTjx
         yhloDCXPR7wwRGDnF0ksTrhnrq3ndsuWOKx9FjOEcpJIZ77W0NBb6GllNuUvV7E3gBe8
         T2VEcYfR+Bs+7fIIZo22dYP+H0meW8H4ljUQ5R7w9FidXl3jNS9x1i6pFvPVKSm5GTV7
         nkdg==
X-Gm-Message-State: AGRZ1gIWp1rYcTkTfsy10MMI73p6jjkpW3NuIy0DbUp5X6x+umiA/CQv
        zanytlFXytNBdxHaHESgySigj2oZ0c8=
X-Google-Smtp-Source: AJdET5d7dhiU6VP6AdiRytgBW4YcZItx3uc9969r0V01vBN61NLiOMPsXTsyDK4F5ktWc1bnN7ThJg==
X-Received: by 2002:adf:a201:: with SMTP id p1-v6mr12487804wra.89.1540767028309;
        Sun, 28 Oct 2018 15:50:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p3-v6sm2709681wre.47.2018.10.28.15.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 15:50:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] index-pack: optionally turn off SHA-1 collision checking
Date:   Sun, 28 Oct 2018 22:50:19 +0000
Message-Id: <20181028225023.26427-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <87lg6jljmf.fsf@evledraar.gmail.com>
References: <87lg6jljmf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series implements what I suggested in
https://public-inbox.org/git/87lg6jljmf.fsf@evledraar.gmail.com/

It's not a replacement for what Geert Jansen's RFC in
https://public-inbox.org/git/ED25E182-C296-4D08-8170-340567D8964A@amazon.com/
does, which was to turn this off entirely on "clone".

I left the door open for that in the new config option 4/4 implements,
but I suspect for Geert's purposes this is something he'd prefer to
turn off in git on clone entirely, i.e. because it may be running on
some random Amazon's customer's EFS instance, and they won't know
about this new core.checkCollisions option.

But maybe I'm wrong about that and Geert is happy to just turn on
core.checkCollisions=false and use this series instead.

Ævar Arnfjörð Bjarmason (4):
  pack-objects test: modernize style
  pack-objects tests: don't leave test .git corrupt at end
  index-pack tests: don't leave test repo dirty at end
  index-pack: add ability to disable SHA-1 collision check

 Documentation/config.txt     | 68 ++++++++++++++++++++++++++++++++++++
 builtin/index-pack.c         |  7 ++--
 cache.h                      |  1 +
 config.c                     | 20 +++++++++++
 config.h                     |  1 +
 environment.c                |  1 +
 t/README                     |  3 ++
 t/t1060-object-corruption.sh | 37 +++++++++++++++++++-
 t/t5300-pack-object.sh       | 51 +++++++++++++++------------
 9 files changed, 163 insertions(+), 26 deletions(-)

-- 
2.19.1.759.g500967bb5e

