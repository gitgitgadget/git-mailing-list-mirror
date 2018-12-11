Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD3C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 14:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLKO6K (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 09:58:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39017 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKO6K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 09:58:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so7248806pfc.6
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FFFUw2PeRo3tm9Lyc9TYOfXn9L7dMGw97YYE6C9i6aI=;
        b=VoWPeZsroBj4jMDG8rnKQrC81hPngcUEp9mpgmSmgidD1nm6gUv+vUhMsP9yiEEOLl
         WrCltECwnA+JsupjQq+PBuFJXxfwInhxETJ5fyTYXfpoDRFtscXd6mdth0ghfcR9MrZz
         IVKgxHBTt0c2OmF77zi7Quv5wqCuh6bKuL/HOG5auRvvn/2n+Q5kHCMkeXv1ZWCTHSpo
         PFBkLkghQ8vbhwonniRYzpQV7/HXHsS5oGu4e3OM+dR8IAtM0lb50Zaj6CNnTlKC+N7X
         xof1a+6jbeVViyX6kp1+brZ3Em0pHByVOIC3I/tcSncl5xpT1obgMtOUBszOj4jlW+2w
         iWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FFFUw2PeRo3tm9Lyc9TYOfXn9L7dMGw97YYE6C9i6aI=;
        b=t3EqlUzuMzMZ+LGxoCwS39r2AReioa1Z9ISRY2hfroKEUQRe09st1xGiz0Uu/VXH3S
         YdRDZ3Wdcd+z55xZJoWKGiULbej3eI4Yppvvic6+uG2Tm8a+2AKcTwzpCjEE61Rjwyse
         qyF+0n1Wz4+gi1COURwdPDHgv9J+gDQ1BHwZ3QzL3XCFIRW0gbCNolplHDDGressonQo
         N2J8dbfUwTXY2q7l5yLijxNRPwPGcGIz24i7YraBI/mSnIQ2/PxtC+gXzCFu34PuQc4M
         tOyKvDa4eptlL9mHMKUo7rnm0N7egQpLzcsGPr2/8d2IWQS+h+yKwqbyg0keJmRFdHaU
         gJXg==
X-Gm-Message-State: AA+aEWaDfD5OyMXCE4ztm2q+GVWr+NN+RqR4d4Kir4efkKUPCBN0os+V
        rB9HX8RCrXDx1BsTSNSIgcmkKeoe
X-Google-Smtp-Source: AFSGD/W6Q2Kx+9Q9mLN6A23cavXS0CbuhOOA8B9aGwIlaFNExP1VuJ4qYGlGfMgDAFRDSmssYLai6Q==
X-Received: by 2002:a62:59c9:: with SMTP id k70mr16500630pfj.243.1544540289417;
        Tue, 11 Dec 2018 06:58:09 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id w11sm17196886pgk.16.2018.12.11.06.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:58:08 -0800 (PST)
Date:   Tue, 11 Dec 2018 06:58:08 -0800 (PST)
X-Google-Original-Date: Tue, 11 Dec 2018 14:58:04 GMT
Message-Id: <pull.97.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fix git help -a with long alias names
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

The code added in 26c7d0678324 (help -a: improve and make --verbose default,
2018-09-29) that intends to print out aliases in addition to commands failed
to adjust for the length of the aliases. As a consequence, if there was any
alias whose name is longer than 18 characters, git help -a tried to print an
insanely large number of spaces, one at a time, causing what appeared to be
a "hang".

Let's fix this, and while at it fix a style issue that I saw on the way as
well.

Original report at https://github.com/git-for-windows/git/issues/1975

Johannes Schindelin (2):
  help.h: fix coding style
  help -a: handle aliases with long names gracefully

 help.c | 10 +++++++++-
 help.h |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-97%2Fdscho%2Ffix-help-a-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-97/dscho/fix-help-a-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/97
-- 
gitgitgadget
