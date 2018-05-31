Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B7C1F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeEaTxV (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34273 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753983AbeEaTxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id q4-v6so3980526wmq.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOly7nmEsQY8QRNU4Sre/ERzbADW7ADfLWW6G7L8T9g=;
        b=PY6JZQgqSDaPj0aBBTnGRelmkJvoDJ7Hrwmrov5tvl9yO+w2HZcV5azGaEiwbLJLna
         p9bRCwaWLELv7J9ZOUC5NhTD5poMU1EVg75Huj+RAE1tt79Vx4a1PwMa+Yrf6uoE3XVV
         RP264ScEsTwGTBByASkN0u1j1P3x8oazE7gQo55FZ5Nd+iMh8qQyJpA+YdpRq2//f85h
         6HY4Oa/zr9HAGZx8dg8T70xJ/kPOeUSeQvq/ODMXoagNDUGyh/h/uP6wpmAXbi7Wqmwg
         KqUHgP/Pj1EMoBfIifxbtEO86XZPlXHpMS1Vd91TeqgRnZH/zPWKMQadzINw4k0ugl1P
         j6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOly7nmEsQY8QRNU4Sre/ERzbADW7ADfLWW6G7L8T9g=;
        b=X1WLHAjw8jzXBPDQiAJX1CP59gv3psLT7bqz0HoJgVNfGfr86ruKbVYwa/J8ugMFJ6
         o4Qlnbuk3sHGgTluTSA9JKW/5f9ucB+LyRJjjCmHK2ujPzzklM9xwv1EZNpR4SZtdEev
         v6yBK9k3CT7oYp0C1M2S58ZBpashqEQKXHTNaUY6BFX8yPsobGvsDrl+Y/W5eIfdcyoB
         siT7a/6N2DecOjNMJ6Pe5oI9fJTfkSOYN306w+HGTk9n6HcYwcWFkzEzf5I0gM3S3CzH
         +5gUKZx5nnzkHSCIRtMsBT9TKnz2cgfSKa6i47+8qWNXSKbbEdod8Im2EOulwUP1k2nb
         mmCQ==
X-Gm-Message-State: ALKqPwfNNVc3xHR2NIEuyvbiuckcS+BDDoXpMJwR6GI/xCh3ywptokQg
        ICrrxobUNwtMLvFY07WkLXo3xvuN
X-Google-Smtp-Source: ADUXVKKkmeMNbSG7/jr+ahRIuswCXnHq14DPsxQOtdQ+fup7mbCuRoImnwhjnAejOgLdMgkVPmZdiA==
X-Received: by 2002:a1c:d546:: with SMTP id m67-v6mr825936wmg.117.1527796398966;
        Thu, 31 May 2018 12:53:18 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/9] ambiguous checkout UI & checkout.defaultRemote
Date:   Thu, 31 May 2018 19:52:43 +0000
Message-Id: <20180531195252.29173-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 started as a simple bug-fix for this one-part series, but since
it's not going to make 2.18.0 at this point I thought I'd do some more
work on it. Comments on patches below:

Ævar Arnfjörð Bjarmason (9):
  checkout tests: index should be clean after dwim checkout

Tests that would have revealed the bug in v3.

  checkout.h: wrap the arguments to unique_tracking_name()
  checkout.[ch]: move struct declaration into *.h

Boring moving code around.

  checkout.[ch]: introduce an *_INIT macro

Make checkout.h have a TRACKING_NAME_DATA_INIT for its struct.

  checkout.[ch]: change "unique" member to "num_matches"
  checkout: pass the "num_matches" up to callers
  builtin/checkout.c: use "ret" variable for return

Refactoring with no changes yet to make subsequent changes smaller.

  checkout: add advice for ambiguous "checkout <branch>"

Even if checkout.defaultRemote is off we now print advice telling the
user why their "git checkout branch" didn't work.

  checkout & worktree: introduce checkout.defaultRemote

It's now called checkout.defaultRemote not checkout.implicitRemote on
Junio's suggestion. On reflection that's better.

Improved tests for git-worktree (similar to the dwim checkout tests
improvements earlier), and the the documentation for git-checkout &
git-worktree.

I'm omitting the tbdiff because most of it's because of the new
patches in this series. Better just to read them.

 Documentation/config.txt       | 26 +++++++++++++++
 Documentation/git-checkout.txt |  9 ++++++
 Documentation/git-worktree.txt |  9 ++++++
 advice.c                       |  2 ++
 advice.h                       |  1 +
 builtin/checkout.c             | 44 ++++++++++++++++++++------
 builtin/worktree.c             |  4 +--
 checkout.c                     | 37 +++++++++++++++-------
 checkout.h                     | 16 +++++++++-
 t/t2024-checkout-dwim.sh       | 58 +++++++++++++++++++++++++++++++++-
 t/t2025-worktree-add.sh        | 21 ++++++++++++
 11 files changed, 203 insertions(+), 24 deletions(-)

-- 
2.17.0.290.gded63e768a

