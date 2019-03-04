Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB0720248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCDPds (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:33:48 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:33151 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDPdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:33:47 -0500
Received: by mail-ed1-f51.google.com with SMTP id c55so4605155edb.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xUHVxI4JleWndaG5xZHDnTobA/INCZv/BDtq29QfCw0=;
        b=R21jwqmg4Nns1iSnFhQlTg4FYXl9UJ44sMDLKHx2TtlRUp90Re/PlDRA9j3GtUgJg4
         HkkTNFR7aCCFtS59aPOT/ndSmYbX8GqvnNM6vC9NkOgSC7/iRvIlmU0vsu8ypbES5x5o
         OPuHsIzkGT0wrjgWzGWfjCC78b8GMG3f7ChHy0jYJFjzWZEI3rdYfidgmlnpY9++cA4L
         Ntna1KHv7X7MTpLqkMhf+xMYoJA44Fep3QJhP+VAcjP7CJUx+qzA116djjTq6LynE6bE
         024XfmUfYFcFKX5rVQDeM+9YtOShUa/9eQNa1f7TYkf5C/tr1EYVeUqbGyNzq1eVw1qg
         00Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xUHVxI4JleWndaG5xZHDnTobA/INCZv/BDtq29QfCw0=;
        b=Nxi6Q81H/IpafPeLzqaYzyGPBBDC4Fi1LtoSPQD5ZdWiRzkeIaytCmvfd5PdeO6kte
         L/e3MuhJtQaZq3qSnYkCCwSBeGrvFMYd0DsdG5kmAcUowrdwM1aANLQfdkgSg3vSWlNm
         pywiJQoZwrK/3fsQZ2QTymrzjmrmj9NGzfrSauogzSzSPPeTG6GRiB11kehNZj4DGGze
         yHw355ZcFTnMFAXqs2nNHnCFXPlrawg8SuS8yhHN/DlaAU7Oh9H3KU/UeM/XcDZcbbJf
         2MCm88CHCIS71zZ0zR6Cr31suR9N7JgQ2AWHvfy2H6hldJ7RLReRthfuiOkyRhM9GRvi
         0oxw==
X-Gm-Message-State: APjAAAWbRXdoX+U/yIP5S8pYlGfwby2PDtkofvjiA6/E0YRJ5sPtgOND
        VKrJw93tyD+wgS/uM/7/5XcrJmDX
X-Google-Smtp-Source: APXvYqzcPQ/nBOFauR+JbVkmLWroqUAopHpbxx/kSc536Y58hp29zynKGO35BHD6dwXNvXwq3p3xkg==
X-Received: by 2002:a17:906:4ec6:: with SMTP id i6mr13392863ejv.56.1551713625860;
        Mon, 04 Mar 2019 07:33:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16sm2151541edx.89.2019.03.04.07.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:33:45 -0800 (PST)
Date:   Mon, 04 Mar 2019 07:33:45 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2019 15:33:43 GMT
Message-Id: <pull.156.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Anonymize URLs in error messages and warnings of git-remote-curl
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have just noticed locally that certain errors (in my case, a stale entry
in /etc/hosts) use the un-scrubbed URL in the error message when dying.
Let's scrub them.

Johannes Schindelin (1):
  curl: anonymize URLs in error messages and warnings

 remote-curl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-156%2Fdscho%2Fmore-stripped-usernames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-156/dscho/more-stripped-usernames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/156
-- 
gitgitgadget
