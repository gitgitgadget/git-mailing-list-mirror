Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2C9202BB
	for <e@80x24.org>; Mon, 25 Mar 2019 10:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfCYKi6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 06:38:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41188 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCYKi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 06:38:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so1786657wrq.8
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wXXG+fWQGrEliaK9fmb9QG2rc7U9vGWprU5dlTdllc=;
        b=eD9yjbt/Lr47aOblqy9Ue6ib14n6seiHTIb0AgYV8r47LvinnWEkFwpyvr0hTBRvmR
         I/M5zW2z2O1ojBLxkBL9sdXo5QFs5k1znDK9XOKuMEepK9JyZGM+Ztwg3xrYL81LvsGZ
         BPWn9Q1+3C1PCe5Xq3/klp/SXzKXCPu4uaQ0tOhGObgH4uL7OtJ2sEnuIbOLCvJ0ggNZ
         skr2Ze9gjMO3Fa+ExERu1zurWpbDg9sARQTdfrQCfGiNG6BOJoFiqboOqrHkzOFCOxP4
         3YEpLht8Qp3TJARKGGzxPqeiafqzlp8J3IcswuGdtnBPySoD3cW28y5zmt21CRNtI8QF
         55Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wXXG+fWQGrEliaK9fmb9QG2rc7U9vGWprU5dlTdllc=;
        b=WKo1tss2y8laYma8UQ/vBc8/KBvicddGWv7jfr2ma+9X3igka8P8s0wksX4HV4LgKv
         ++Zc+AXX+JGvFGIIbhusBC5/gazXStcYuAA6baY22eGBxY3C2RpMOgCl1SYi0oNCWHl4
         bkvmn1/MFy5UuCePRb7JfRDV4W5Bxv8iXBLS1MjxQ6si6prwGPp+mbAV2ZdfkgFXdxxj
         MMpkyEJKBiPUJtUS5WESAya99N5149Li5IM9oUqWsBNlP+4Ue2Jrp9qm8id49L4Hh/if
         8cKPpJsnD7/63GVofLMfKVwNNWUvqIzop+/4nNFlsAmSacmifblYVVG5kdVhRqqwLlWB
         /8lw==
X-Gm-Message-State: APjAAAUIlpeMlHt546igk35WGzS3HgqmJoJU2xhUeiUIHVIt7Pl+T6Z8
        BlA/qWgF3E66dxzyG2NWnq0icJGcGY4=
X-Google-Smtp-Source: APXvYqz6v9udYPWsbYW5bmk2cjLO1mTbJPkNkfcE19av45QKVrNHRJ023ztSPr7pCDdP18Ryq6pPKA==
X-Received: by 2002:a5d:40c7:: with SMTP id b7mr14975644wrq.311.1553510336442;
        Mon, 25 Mar 2019 03:38:56 -0700 (PDT)
Received: from localhost.localdomain (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id q2sm23247292wrd.46.2019.03.25.03.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:38:55 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/5] Progress display fixes
Date:   Mon, 25 Mar 2019 11:38:39 +0100
Message-Id: <20190325103844.26749-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes two progress display issues:

  - When showing throughput, and the both the total and the throughput
    change units in the same update, than the previously shown
    progress bar is not cleaned up properly:

      Receiving objects:  25% (2901/11603), 772.01 KiB | 733.00 KiB/s
      Receiving objects:  27% (3133/11603), 1.43 MiB | 1.16 MiB/s   s

  - When the progress bar is longer than the width of the terminal,
    then we end up with a bunch of truncated progress bar lines
    scrolling past:

      $ LANG=es_ES.UTF-8 git commit-graph write
      Encontrando commits para commit graph entre los objetos empaquetados:   2% (1599
      Encontrando commits para commit graph entre los objetos empaquetados:   3% (1975
      Encontrando commits para commit graph entre los objetos empaquetados:   4% (2633
      Encontrando commits para commit graph entre los objetos empaquetados:   5% (3292
      [...]

Patches 4 and 5 fix these two issues, while the first three are
minor preparatory cleanups and refactorings.

SZEDER Gábor (5):
  progress: make display_progress() return void
  progress: return early when in the background
  progress: assemble percentage and counters in a strbuf before printing
  progress: clear previous progress update dynamically
  progress: break too long progress bar lines

 progress.c | 78 +++++++++++++++++++++++++++++++++++++++---------------
 progress.h |  2 +-
 2 files changed, 57 insertions(+), 23 deletions(-)

-- 
2.21.0.539.g07239c3a71.dirty

