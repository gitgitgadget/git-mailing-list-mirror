Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE651F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeHMWGj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so9951376wma.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vDZWsMazv/5xh54tO/x11TQXrkNotkTkrldu0IFmbPg=;
        b=YMCokNfUOC/7S7s5jIfA5bj6Y5aIf0Huw4xJEfRNrhCFruIXPqE/5kyu+SR7MjwIEN
         51c8uxgaho91jAaGq6/mw12qtL+xLvxphSHAMKFb9aRxqpCc2Wi127OmptkrmpUj87FO
         qwjINDPjgDBBcTnFJl+LWPyTPk0Z43rf4Beps+PiAskYVJwiDuH30PhRswQtK6EnXim9
         O+d9uqo/09Qh6TIgSlDrbfRyyZrCM+6aKTI3p+aGoaPkRZSTTYOqnuaMKiB6JT5yjlLN
         19Pg5J/SgLZAXuDwpseUKK0qQZe+CObbD2+EHOM3Ahy+5TrCRvlFvp2DKuHHURzdEgnY
         Qsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDZWsMazv/5xh54tO/x11TQXrkNotkTkrldu0IFmbPg=;
        b=DYBkPJGQ+RRTcglw6nEoyF51lF6gpNJwyJsjKkY2Ff53GE8ghS4QmUqQTHYaM/qzKH
         X4SiLNlnty4S2MkNNVhk/7Q7P2DEB7d+/NnD1TBspkNhrInkuMNsMoM/T6AFJ4oG3O5c
         3Jd5h3tiFhgRUw9dR1vQNHroPkCoaXKVrnUf/lu9p3KeBDgukBNdFD0PbTmL8rVGT8C5
         KusE8f9JrhgRNUJS331A44aH22d0+6Q32g1Vi++RuYLtCRHeR5YWL8Xw57PtPFs+/Yyu
         KfffPo4jF38aULEw7c8bLeCaY1l5FKt867vqWYpPMh0vYpakk39x1WlkwCEtZ8IqEHdW
         pukQ==
X-Gm-Message-State: AOUpUlHHcszMAV2ztiwB75kBKguzfqchFjpgum3pgQUwH8NFi5nTrVHh
        0oYRi3Rd7HOgwj6hLK1WF0JTvHrs
X-Google-Smtp-Source: AA+uWPzuIaT7cfzkW+/3Ii3PFOGBGxFZlJ3U4pRt9iy9cryWFWm9mc+rEUHTER0Hz0oQUYmx3j/U7A==
X-Received: by 2002:a1c:8955:: with SMTP id l82-v6mr8526603wmd.110.1534188183370;
        Mon, 13 Aug 2018 12:23:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/7] Prep for "git fetch" should not clobber existing tags without --force
Date:   Mon, 13 Aug 2018 19:22:42 +0000
Message-Id: <20180813192249.27585-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731130718.25222-1-avarab@gmail.com>
References: <20180731130718.25222-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have not had time to re-submit a v2 of my patch series to make "+"
meaningful in refspecs when it comes to tags, see v2 here:
https://public-inbox.org/git/20180731130718.25222-1-avarab@gmail.com/

Given where we're at with the 2.19 release I'd like to propose this
shortened version for inclusion in 2.19 for now. It's 7/10 patches in
that series, that purely deal with fixing some test issues and a
trivial grammar error in the tests.

This is unchanged from what's been cooking in pu for months now, so
hopefully it can be merged down faster than most, and then I can later
submit the actual meat of this series once I fix the (mostly doc)
issues with it.

Ævar Arnfjörð Bjarmason (7):
  fetch tests: change "Tag" test tag to "testTag"
  push tests: remove redundant 'git push' invocation
  push tests: fix logic error in "push" test assertion
  push tests: add more testing for forced tag pushing
  push tests: assert re-pushing annotated tags
  fetch tests: correct a comment "remove it" -> "remove them"
  pull doc: fix a long-standing grammar error

 Documentation/pull-fetch-param.txt |  2 +-
 t/t5510-fetch.sh                   |  2 +-
 t/t5516-fetch-push.sh              | 65 +++++++++++++++++++++---------
 3 files changed, 47 insertions(+), 22 deletions(-)

-- 
2.18.0.345.g5c9ce644c3

