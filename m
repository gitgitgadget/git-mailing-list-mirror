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
	by dcvr.yhbt.net (Postfix) with ESMTP id C64621F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 00:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfJOANT (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 20:13:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52842 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfJOANT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 20:13:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so18869164wmh.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 17:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OT9oX6uOu4emCPKOAIeYytxzj7k5i6JjpWiHW1d/7PQ=;
        b=C2NLZDXnbv0fx4LU+Srxb6anXesE5ZigeZUTAla/FLokXradnuLUxoz4BCPcTR1UrX
         EVao5CI4KP7XMmLun4UrVzH47XljprzPQr3EG/iy5oO8c7fkgnFQu7lrc7qtESMbiVZS
         j1xZeEz1WjwELX/nC7B6PzoNIN1uGRQiVlb/v74U+AIo8DsYG9ELUblb2gYH7RF0iVVy
         rMHxZp0VxONtp/pdFD/rVTFM3ImYHOW/mXyDg5WQvhSqvEi69Oiln//oeU56wcXAiVEN
         mA/eWtphZfnh0KLnUCPhDRUqufwqV9uPiI+Z2T0fXkKq9wXuObVCzVTBvqT5oxZJE9Bm
         kx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OT9oX6uOu4emCPKOAIeYytxzj7k5i6JjpWiHW1d/7PQ=;
        b=ch1y3w55S0ssztM/osXmudW9eOOPMplXpFbwOYxCYVg5ojlE1+NqFLn3MJiKOftnB0
         kIWtLpFqU+CGoGOMAQY4O/wiOd0sN1xwx2G+pYf8HZmpsRd+JyeOIMTVmOCld86zvD3Y
         2CR6vg5FBJIqL3oeTmZ1Atew70gYKmVsD24GIt1H5ECTsx8LnN/4amA5DTyhanv8WE4z
         REZVW9ysERzi67A4+qxofdR57eU85APw8zvrO2H3AKozNW+IjcMAgMMJQ7hdNamS2X4D
         YrIfLbNH9V32WHUwUlUywdkHBP1golchu/wnDjNSl1dYd/bUtDWs56PGGaDa1/1Ajhmk
         33Mg==
X-Gm-Message-State: APjAAAUGGBMvvQ84aFGOhooKjo8vnF2fUd+He0E+obF7SlcYU7qPCrB2
        7HkiUZBTFWL7nIpqh0pI58oOpW8I
X-Google-Smtp-Source: APXvYqzf7BSXRd5rUk1gmMGu3wOQThxKrHzjspZl+vE8oBmapjootR32Yx3mAQMkIONI08Rum3V84w==
X-Received: by 2002:a1c:e10a:: with SMTP id y10mr16984613wmg.29.1571098397358;
        Mon, 14 Oct 2019 17:13:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm20336877wrk.86.2019.10.14.17.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 17:13:16 -0700 (PDT)
Message-Id: <pull.389.git.1571098396.gitgitgadget@gmail.com>
From:   "Eric Huber via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 00:13:15 +0000
Subject: [PATCH 0/1] gitk: Preserve window dimensions on exit when not using ttk themes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fix is intended to let gitk preserve the window pane dimensions
regardless of whether ttk is enabled or not. I'm not an expert on Tcl/Tk but
as far as I can tell, this edit works and doesn't cause problems. Please
double-check what I did.

Eric Huber (1):
  gitk: Preserve window dimensions on exit when not using ttk themes

 gitk-git/gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 70bf0b755af4d1e66da25b7805cac0e481a082e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-389%2Fechuber2%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-389/echuber2/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/389
-- 
gitgitgadget
