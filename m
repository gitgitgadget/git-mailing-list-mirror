Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE271F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfJESqm (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 14:46:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53897 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbfJESqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 14:46:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so8745605wmd.3
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aC9Ne6XQ0mges8PJliAP1u7F/ivnCrtDDqyqGukTPLs=;
        b=mVuSrJrZgjfg2ewZ8TOxJk+ywstLIQrRb/ZBC07F6uo04NfHJKiTKOVQnoruIKnCmG
         QX3X+YPtYgd9/Pol8jMa/h9M8evEgn9Gn4aAv3twjo3bjezrgxnzIFYI2oXxJkhNpKQR
         3/0rZOiP/jddE62e4VJrHUkdRJFun18wPNe2FVxTw680jv8FU8f8SOrfmYHMY/eP5ygz
         ikhELV66lZW8+GYnlu23L9fGOFngDIZqFdLmxQWolUjabPoQ9SDWmHqyFlDtF9Gs8NB7
         UBWA7RE4CzZAGuINBFNuxGfEmM8tZXRt7cZ2TNsutU3NpHaXs4g5uQQe1L18qtqi9IqI
         tv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aC9Ne6XQ0mges8PJliAP1u7F/ivnCrtDDqyqGukTPLs=;
        b=SUhhoGfcu728Ml0lLrYa0EI2sXfVetxqAIZGyw99RFfje+Zc6q0xvIXTLWNcwi4Ncm
         Dwg4C4ERSr36bluroVt84RfakKp/CljDCkQO8neHMcRQQvdCqsJvbBOBZDRdxO+NLytD
         9aOeIgPtHhJQMa+T8qFCHR6h2TcTjj/FXue9r/E9ovBRc81aIiUlMq6xyOz1zSupRDVN
         OHWHGErhhfu8Mr3tMc3JB2cg3KnORlJ23LJgwCdTzWAsWjrSz/wxhEIbtmvh65Ne5d1e
         sKMOqBxO0UR96MfMaPCHeS47u641WDZ/2n1t1tmoFkxFQFDpX3V/mlVhts4FG9zUCjnp
         LJ+A==
X-Gm-Message-State: APjAAAUEVY5L5hwEyQ6YBSLHY3djxXMvGNhw2N9IpZ/fp4/dLWBkWMPp
        GomMomD337LfznEwGkf3UBdAoz8K
X-Google-Smtp-Source: APXvYqzyiFIC3LwGkxjZy/3nNrm6YYbkgwfknqSqYo0ejmfiH3bCDf2hpEw+ygX5E35Z4b9QQ5md4Q==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr14483454wmi.106.1570301199799;
        Sat, 05 Oct 2019 11:46:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm17594096wmh.27.2019.10.05.11.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 11:46:39 -0700 (PDT)
Date:   Sat, 05 Oct 2019 11:46:39 -0700 (PDT)
X-Google-Original-Date: Sat, 05 Oct 2019 18:46:37 GMT
Message-Id: <pull.369.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.369.git.gitgitgadget@gmail.com>
References: <pull.369.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] fetch --multiple: respect --jobs=
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I saw with sadness that pd/fetch-jobs went nowhere, and read in the most
recent What's Cooking mail that it was even dropped.

This is my attempt to resurrect the idea (although without the overhead of
trying to support a first-class UI to control submodule and multiple-remote
fetches independently, of which I was a rather outspoken opponent).

To make things a bit safer, this patch uses the --end-of-options marker, and
is therefore based on top of jk/eoo.

Changes since v1:

 * The regression test now passes even under GETTEXT_POISON.
 * The needles used in the regression test are now more indicative of the
   code producing them.

Johannes Schindelin (1):
  fetch: let --jobs=<n> parallelize --multiple, too

 Documentation/config/fetch.txt  |  10 +++
 Documentation/fetch-options.txt |  13 ++--
 builtin/fetch.c                 | 124 +++++++++++++++++++++++++++-----
 t/t5514-fetch-multiple.sh       |  11 +++
 4 files changed, 137 insertions(+), 21 deletions(-)


base-commit: 67feca3b1c45a51b204253039139b46cc07e145f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-369%2Fdscho%2Ffetch-jobs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-369/dscho/fetch-jobs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/369

Range-diff vs v1:

 1:  818936f1e0 ! 1:  93a155a000 fetch: let --jobs=<n> parallelize --multiple, too
     @@ -267,9 +267,9 @@
      +
      +	test_must_fail env GIT_TRACE="$PWD/trace" \
      +		git fetch --jobs=2 --multiple one two 2>err &&
     -+	grep "2 tasks" trace &&
     -+	grep "one.*128" err &&
     -+	grep "two.*128" err
     ++	grep "preparing to run up to 2 tasks" trace &&
     ++	test_i18ngrep "could not fetch .one.*128" err &&
     ++	test_i18ngrep "could not fetch .two.*128" err
      +'
      +
       test_done

-- 
gitgitgadget
