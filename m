Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CA61F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeG1E3i (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:38 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:36928 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeG1E3i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:38 -0400
Received: by mail-it0-f74.google.com with SMTP id r10-v6so7166166itc.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qLjm1oAbKlhyLW1PtFDY7HQxUWCnwZnF+WJwJce7NnQ=;
        b=f9zZfMk89lsTjljWosSESHfd3hLxmma7ZjFjoSbp0Di3ZKPtL0TaizAnrtiJdhvbpR
         bZtXJfMSebL0zqkyta6S0RmYz/aW3OYhGTlRpa91pVwJZGjwfm3MjWQ5ss0K5+3Gun5l
         Xd7BRiJHSy7ZGCEx0kdiD/v03yAOcNfvJKn2koc/gvWfAbVZpxqtPnCnLbuclB/CRTP/
         0BJkdP5hzhpaT0HDctV2RVTKPiTEhZ2RU89GtKeg1pkRVKRxfbFLtfmhjgmpl9r1sFQ7
         IufJ+6cT9r0MJ2kefzL2DJ+1gpdV81ZAvsZ4bbzodqKeIJAVWp9EmO03TE0eKCFIRsMR
         z1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qLjm1oAbKlhyLW1PtFDY7HQxUWCnwZnF+WJwJce7NnQ=;
        b=XNdgVNQ7U94dZArlrm2+7JqhnUAbtFYgFpIeNjUqUhN97xCUsuNnsfmSBhvgHu/4sZ
         V1NPpUNSTdzAg4FWuAzun8Z0TKH1xnmbERTZEQ59s8+hZXK9sUNYagKSWvjhA3Ibelnl
         CgknYxXzO6lItLq+Ze72ZOrRi0CLMdpEg0HepHdiFwgjuYhPq88Xo1Rgnz+yvBT6+dic
         snaHMQQ3KpKkw8aWcNADQMFI1Ag5haLxFBbfkXc8Qv/LgoMDbzRP/D7YDKorojWzdPob
         tQXV4NofzCZO17nX62+8Uf9p57Cu5G9P3SUn0+kU09zpM1lWm19+mGWsvR0nugM6ztt4
         HUhg==
X-Gm-Message-State: AOUpUlGlXBesk0tj6ZN05MCNdlt7djS+eMHpTpWei3XJrNu/2ycrUvgc
        pez0S1q7mrmCLKBCpOemrcg2mKQeDM6N9ZgNipeyHi5PV5JSe7SylS7xpgnAYytrvveFhe4kY11
        dcfruUfHXrRRr1UqUEPXIrze6YhX3pozDhxFU3JumHFBj3rkJQI99zhU53z/K
X-Google-Smtp-Source: AAOMgpf4Y5MAgzl33Irvay3+qHKKoX73NDqLAz2lq0W4AeNMI+IB6scggksO/ZuyUq1CbU9dBcAcY2SoZwhl
X-Received: by 2002:a24:ed87:: with SMTP id r129-v6mr4100746ith.32.1532747093128;
 Fri, 27 Jul 2018 20:04:53 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:40 -0700
Message-Id: <20180728030448.192177-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 0/8] Add color test for range-diff, simplify diff.c
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on origin/js/range-diff (c255a588bcd) and is also available
via
  git fetch https://github.com/stefanbeller/git ws_cleanup-ontop-range-diff-2 

This adds some color testing to range-diff and then attempts to make the code
in diff.c around emit_line_0 more readable.

I think we can go further bit more (by e.g. cherry-picking 
"ws: do not reset and set color twice" found at [1]), but that would be feature
work. This series doesn't change any existing tests!

[1] https://github.com/stefanbeller/git/tree/ws_cleanup-ontop-range-diff

Thanks,
Stefan

Stefan Beller (8):
  test_decode_color: understand FAINT and ITALIC
  t3206: add color test for range-diff --dual-color
  diff.c: simplify caller of emit_line_0
  diff.c: reorder arguments for emit_line_ws_markup
  diff.c: add set_sign to emit_line_0
  diff: use emit_line_0 once per line
  diff.c: compute reverse locally in emit_line_0
  diff.c: rewrite emit_line_0 more understandably

 diff.c                  | 94 +++++++++++++++++++++++------------------
 t/t3206-range-diff.sh   | 39 +++++++++++++++++
 t/test-lib-functions.sh |  2 +
 3 files changed, 93 insertions(+), 42 deletions(-)

-- 
2.18.0.345.g5c9ce644c3-goog

