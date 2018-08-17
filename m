Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA94E1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeHQXs6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 19:48:58 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:38488 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeHQXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 19:48:58 -0400
Received: by mail-yw1-f73.google.com with SMTP id q141-v6so6729248ywg.5
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=xwx55FP4moe6ty/xrJcPVP3rRckP3hv0Un/b6nmQzpY=;
        b=ZASG6nUx2Xzo0MxhuHnK++yIHaNv5oHZ67NhJBKEGeBH6LgFbfGfK7xXTaIM6+YqLu
         /vw9iZowKSQhvFGO/b6JTjBNe3Or2BMp9iNaPdlr756BiFcN+jlCZfVmdB1mPlqy/HXp
         swETf5Yia3wc3DVdnpBGKCM7o96PXcnHyQEsp92f30nYmkNF9+JNghV9RSGSppeYGcny
         6qBMmIQMz4FQxP/8zu4nKAHbynQA77G48bNerr56boklYilAxOzoaUF/m9ncpswcwLad
         irhcZW0xpGWaR+c3ZOw1D0tgZWctdG6nFNm0v9q8pOgMbIwZSclbmiyN9j7/4kDFeYEG
         JeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=xwx55FP4moe6ty/xrJcPVP3rRckP3hv0Un/b6nmQzpY=;
        b=dh2uMmGYDX8vTKdX5dH/6vq8BidcNj0khSmHevB+ITQqisupxR2DqNb4AiNR7Krbls
         0P/Z3O3zblvmqfvzC/T9e0cFndmfihtPvNq06HP2svmbKUOmCMiNidJZJmdzgWC7EbLl
         YUwqLbxvkFZfGDS0eMTPQdbxpnNVsAphU/QHZq4+SFkrb5Dj5/nI99/jqhWweFP0/w2G
         Hw4VfLy0I/8/JzpPps+JOLV6F27DzrlLrETUF0XjunUBmUkZALsS66YYw8QI/nZfO9Nd
         MdhOEwF3MyIjBEignVc6XMGTEkCjG/eV3jlncY7eWOkqX9iFqDkkpXV2rVhutj55e/0f
         U1Pg==
X-Gm-Message-State: AOUpUlGZVqoCEkEqQ/aHAoiZUo0k4vHctfMQxe0y67psRfx98ZKUkCO6
        cwoUFxyk6vQ1oBemEbGuTmHEkyHRLmIW
X-Google-Smtp-Source: AA+uWPw3CR8JOSpcNjwD1baSRuMpUre+Xdvup9oSx2O+/eAxqOWIzbYRFUOKO/XXEBAqc6vFMCJYp0mfDaC9
MIME-Version: 1.0
X-Received: by 2002:a25:d6d8:: with SMTP id n207-v6mr11084446ybg.55.1534538646921;
 Fri, 17 Aug 2018 13:44:06 -0700 (PDT)
Date:   Fri, 17 Aug 2018 13:43:51 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet>
Message-Id: <20180817204354.108625-1-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 0/3] Better colors in range-diff
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves colors of the range-diff, see last patch for details.
it is also available via

  git fetch https://github.com/stefanbeller/git sb/range-diff-better-colors

Thanks,
Stefan

Stefan Beller (3):
  diff.c: add --output-indicator-{new, old, context}
  range-diff: make use of different output indicators
  range-diff: indent special lines as context

 diff.c                | 21 ++++++++++++++++++---
 diff.h                |  5 +++++
 range-diff.c          | 22 +++++++++++++++++++++-
 t/t3206-range-diff.sh | 12 ++++++------
 4 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.18.0.265.g16de1b435c9.dirty

