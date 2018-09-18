Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EDE1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 05:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeIRLSv (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 07:18:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39565 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeIRLSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 07:18:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so1106112wmq.4
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 22:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3iU0yC6gdthH83kJA7NQArnHGIMpF118iD8tIa2sB0=;
        b=AyCMlH0BaDZW/4VKMRS9DniH11/BdWQQyNh78CAWjBrz5wlEJSnT54is6/5SnAIL8D
         3JdsEghedYVur5OZMGLxJxga07+8R5nIUSzHnMXlx7rTnIZgpp3u5+kwEEbcsbXIFUMR
         Nb9REu+BgHtMIExx6ucZbSFN6WgDwSxN88dMrSPIMhmbBK4MNu5AYbzOzRNT/tdGvjYS
         tJPMOWSVaEOVl9pa6cPDWAPnsYOCHg/UZdhWlRj+tQGBVBMxs4HHc1r6AExHwfbMEXDf
         shK0oXBGgNLJxCRhWWG1ofS0LsD1Q+Vs2e9vL1q20hXtEKbmbtKFd6D8qkRAIcW87MNL
         KaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3iU0yC6gdthH83kJA7NQArnHGIMpF118iD8tIa2sB0=;
        b=ceeK7OU1JacemzzuttR3p9UIuBZOPlK2JHZEfAm/mdJn6ySiG9B905pahkmviu3L1v
         JsSNnYZfpH1JfL1jznlnfFKblzzR4ShN0AEcRqo01LSP0LWQyqPG+OyJcUsIKI4LObQW
         S/9BHLL6r1CLi2B+R3EkP4RkwfyIdkvG+AHF97MbDEgpbpRBl7gCRHB23OzfUxKMq/OZ
         wGheFgFARdhqyX8CrqPXRF1mUK8LIHN/1MBqmkRKC5NrY9JOeaZTPecSKXzWzIOqXhHg
         qz/dnqvab2E9nzinKdPFATrmxPsqfGAWkioCQ7XJLYflZmiM9SZx6xXv3tcH1CwvX31p
         Ay2Q==
X-Gm-Message-State: APzg51CUztS/R689cyvXeLCFqzh7zd1yER0XfelyBnP7uhIWERTkEPVJ
        bxPnwsITHNjNL5plxqmQtQHcXG10e88=
X-Google-Smtp-Source: ANB0VdYxDSFV3BVflH7eisM5RiinMAu6ODFnvFaPht7yISOZZG1TkoG3voPFnEquQ1zI7LwPkJqDuA==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr14424830wmo.84.1537249671591;
        Mon, 17 Sep 2018 22:47:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 132-v6sm881398wmd.13.2018.09.17.22.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 22:47:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] doc: fixups for ab/fetch-tags-noclobber
Date:   Tue, 18 Sep 2018 05:47:37 +0000
Message-Id: <20180918054740.24180-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Of course I only noticed these after the series had landed in
master...

Ævar Arnfjörð Bjarmason (3):
  push doc: add spacing between two words
  fetch doc: correct grammar in --force docs
  fetch doc: correct grammar in --force docs

 Documentation/git-push.txt         | 2 +-
 Documentation/pull-fetch-param.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.0.rc2.392.g5ba43deb5a

