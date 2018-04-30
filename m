Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E52215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeD3WHq (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:07:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36911 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeD3WHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:07:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1so16622537wmb.2
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGmFajFmZd+YY9TMj5kkiWwwum02KIxayYi+tlz2Yfw=;
        b=jU0LTpmIjaF1UTv/2AXiDkiXah3WcPfCPV9zhVTzFom4YvMaoNbU8Q3FniUcYfYoxc
         5fYutY9ZzRV/BxnW8ILS49eiIUFv4pVwv7ji8h5qveOEXan8X1LpHcvzLd5pr54rRsY/
         QTVtAf2Rofh0K0zS11QeCCXqddCzBwoXdnyxYCsjt1UOwvoctCdqW/DTuRw7g6Buwdx4
         Hw6imY4hrhPlq2CG2NQ9IKEK6W/ISfr8cXHKeHkK6fyICi8Api4YfqAs8s7L9VZ9DnPq
         L4jLlHeverUlfUafsMcJBaxaInFhiSjxbK66XhHJaZgklUd96vdUXbb8GmDbjol9PbCd
         /DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGmFajFmZd+YY9TMj5kkiWwwum02KIxayYi+tlz2Yfw=;
        b=OpD0t73QvG0xkPKoNYsL6CxBH2/Is6/390XO9ugNhqTG6mbA+vKqLb4VPRdMlr7Hcz
         C4LCJ0o8raIKP2qyZtZWz7yedKt42PSP+vZ5pVWBMpQi4BxcOXvdkQN8V0XQncypF3NM
         cGTKZ12ghE+4dCnJVpTZyeyUCwO/N2SCLjwtp3CPpPAQlihNxcMjZemT0lVdXJRtOoXL
         f+c2jCq1puuAL7868EJ+epGzBKQ5nn+DRKrvJ1owwBtJVyCXeb4Ot5eCmDBMKhZzM/lp
         sWdIR6EeLthMnDHHk/ydfx5PUS+ARGd4awRl0gzXdNf8M6FFZ7UhTo6UQE7RtjfmjXGN
         tb9w==
X-Gm-Message-State: ALQs6tBv8ZvG1lDqjYYlSi1hFDrqmyf3+5K6AthmYmVxB41+qv/emNzh
        rf7fBJuE8R5voA8GU4sSt4u+UGGD
X-Google-Smtp-Source: AB8JxZoLo2zUOKffhyEy2IetN/2CtQ4H3YixetTwD3m/WeZ37jZE686uxB67+EdVFJ4wqvLlfk1ShQ==
X-Received: by 10.28.48.70 with SMTP id w67mr8089145wmw.47.1525126063958;
        Mon, 30 Apr 2018 15:07:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:07:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/9] get_short_oid UI improvements
Date:   Mon, 30 Apr 2018 22:07:25 +0000
Message-Id: <20180430220734.30133-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started out just wanting to do 04/09 so I'd get prettier output, but
then noticed that ^{tag}, ^{commit}< ^{blob} and ^{tree} didn't behave
as expected with the disambiguation output, and that core.disambiguate
had never been documented.

Ævar Arnfjörð Bjarmason (9):
  sha1-name.c: remove stray newline
  sha1-array.h: align function arguments
  sha1-name.c: move around the collect_ambiguous() function
  get_short_oid: sort ambiguous objects by type, then SHA-1
  get_short_oid: learn to disambiguate by ^{tag}
  get_short_oid: learn to disambiguate by ^{blob}
  get_short_oid / peel_onion: ^{tree} should mean tree, not treeish
  get_short_oid / peel_onion: ^{tree} should mean commit, not commitish
  config doc: document core.disambiguate

 Documentation/config.txt            | 14 ++++++
 cache.h                             |  5 ++-
 sha1-array.c                        | 15 +++++++
 sha1-array.h                        |  7 ++-
 sha1-name.c                         | 69 ++++++++++++++++++++++++-----
 t/t1512-rev-parse-disambiguation.sh | 32 ++++++++++---
 6 files changed, 120 insertions(+), 22 deletions(-)

-- 
2.17.0.290.gded63e768a

