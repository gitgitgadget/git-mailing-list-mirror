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
	by dcvr.yhbt.net (Postfix) with ESMTP id 385C01F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0JhU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:37:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45761 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:37:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so6392498edv.12
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cjudVCzcfRsmxBl5aaEQ2KiIhPKQfsHXH1HGMhsBEHE=;
        b=Gb+ttOM/xs9bIgGwc2WQ/hUfJ8jFO2n/kXixPGFlCwqoI1JNCvWAIgM4/H4dQSkzZK
         96h3Pt7oxuYFgwfV6kDGuIaD6lSynsqgV5sA0ocThfUHhuH0bjCCItRo4U0NzWm5JkYe
         I7emBklvB3yA35uJtN11w6+GJzu/IyrtI3fPjp1FJUvnuRoZ5hYYNTYSXNuE7fmJ/QCz
         seWfxs2nwmu0F1YdCmBJKQ8jSfeVnYyQulRDKN2+fmyKFDn/nTH+SeUp247dVp96WRvL
         /LR1OriODwHRjPnnfd7KQ7ES2Xk9E4F+SgvnzJgwuhjGdXkjdTJ1+jAOtGrImtbR3daE
         pPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cjudVCzcfRsmxBl5aaEQ2KiIhPKQfsHXH1HGMhsBEHE=;
        b=O4kLtDGQb+X/L7Y+0hblLfmsc+axwwhKh0+eNmkwn46gmI7npZZOZybQrumx/Zj87F
         fYMR0TzqMty+mrhiyLeKSe4IKffmtQCupcv9XmxdSJ3JzmrlYiS0rgWQrBdCO283FJRH
         7z3cU3K4XCPiHevHVxfULs0DbzTwNraSDiKjA5Kfc50kcdagKKXB/RKl9Zv0c4d1j8zz
         NQDkWO23+JDwdV+Yr5WXKwDynijQPLRcN+DPf24ILk+GwpZXjvWPqZ9dwpe+81lXEkAq
         ArEgriZ5kMziLoQJz9jSgSTkEbaon6kIIr0TrGsIyKg/CbgiRngK2XFAPwY3l41L4Urw
         6pZg==
X-Gm-Message-State: APjAAAU0QgOexZM353Iy1zMx0JbpHGwfG4cUOBUcWoAM42qN2Ufq9CKy
        DeLnt0HriHKToUXLyD7vY1svziiM
X-Google-Smtp-Source: APXvYqwOA6TZLtkUjFpVDgeaTVGocVF00tUDfdIEkJY+rh+30ZXuZJspLCsYsE6j9tK7Jx2l6TuPSg==
X-Received: by 2002:aa7:d781:: with SMTP id s1mr2934419edq.20.1561628238223;
        Thu, 27 Jun 2019 02:37:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm560473edd.73.2019.06.27.02.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:37:17 -0700 (PDT)
Date:   Thu, 27 Jun 2019 02:37:17 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 09:37:14 GMT
Message-Id: <pull.147.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Let's use the Win32 API more precisely
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

For many Win32 functions, there actually exist two variants: one that takes 
const char * ("ANSI", meaning the current code page) and wchar_t * 
("Unicode", i.e. UTF-16, at least for all practical matters).

These functions have "A" and "W" suffixes, respectively, e.g. 
GetFileAttributesW(). The symbols without this suffix are #defined to the 
*W() versions if the constant UNICODE is defined before including the
Windows headers, and to *A() otherwise.

Let's not rely on this constant, but explicitly say what we want: we want
the Unicode versions, as they seem to be used by the ANSI flavor anyway.

Johannes Schindelin (2):
  mingw: get pw_name in UTF-8 format
  mingw: use Unicode functions explicitly

 compat/mingw.c     | 12 +++++++++---
 compat/poll/poll.c |  2 +-
 compat/winansi.c   | 10 ++++++----
 3 files changed, 16 insertions(+), 8 deletions(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-147%2Fdscho%2Fansi-unicode-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-147/dscho/ansi-unicode-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/147
-- 
gitgitgadget
