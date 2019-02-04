Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26437211B5
	for <e@80x24.org>; Mon,  4 Feb 2019 18:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfBDStD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:49:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32980 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfBDStC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:49:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so1132084qtp.0
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqGUbDGvscki3VVKPD/MvEdPkS9qT7fmhSuIamdVHgk=;
        b=rLBPc4tICyXUSjQR2A0qM70ZyV+1cg5LEmd+ndEX8o2klmQt7qIQJyWFB4oOLdh5Xi
         4lnScJwA0NuYfE1mfjpQ5TvE4duqOwgT2ZhPjs2+BCnkxjkSOOLtvV0HkKEwWvM06M99
         IAiXDLSY3Pw4mg+1Eiaw9LtwQDDC6pTOGULMEIIgGIqFGqdUs6/bx1MMsJLSnVnS2S88
         peQkeOnBtFtlDbMr48xnMKkx+IqsqpY2xbUKYlkVLh+dhgmWd9qdo5Alx8qIzOJxDqZd
         lvTwaQ6V8xRYTHw1YpLQfkS1tULoFT2uB7OLBI0Ns/jTv+eV8GPzZi95AeyVmiEvSMUP
         6m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yqGUbDGvscki3VVKPD/MvEdPkS9qT7fmhSuIamdVHgk=;
        b=IGNoqpuSu0mS7maOsiFACkK6e/XSVuRVrRxvWJ0XZ4GZv5hwj7SjWUBoSIR3OYVr1C
         7TjPgvNGq6p+LmYHBzok9l1UlSd+CyX0WIhXecdeCQ3dSmKpTH+5gT46kY9SmnjI2ITD
         O1nyhjTiyy8jEK2oAqDDSP4Fs/q3Zsoio60AQ1R01cV/eQ7BvlkMdNxwRNwVPPO++YFQ
         UFJAqp+jyBhNvBidOXHPaTokEa7a0bpzlg9C0h5pgDTDCK0gVI1iZUQzWLUiQT1ETI1T
         ob86LJuvYch4htu0TPV48GZy4uqzzntb7/HE9qfH2T2n4GUARLhs1Jce63EUhugBG7N1
         008w==
X-Gm-Message-State: AHQUAuZJh61hkyY1Gg2N39sp33OsWVDZvrd2RJhPjJaVmQa8Dol3688H
        fWu++NTfGw2qPJAOZIGUsAtnOKF9
X-Google-Smtp-Source: AHgI3IbOfWcITk21933YleoXi0COtmivo5+lU/DAioftfDR0lmMAlJdJB5CT0fWluNaaPI8m+We3Zg==
X-Received: by 2002:ac8:674b:: with SMTP id n11mr667799qtp.104.1549306141546;
        Mon, 04 Feb 2019 10:49:01 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id w42sm1821695qth.61.2019.02.04.10.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:49:00 -0800 (PST)
Received: (nullmailer pid 10088 invoked by uid 1000);
        Mon, 04 Feb 2019 18:48:59 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH v5 0/1] config: allow giving separate author and committer
Date:   Mon,  4 Feb 2019 12:48:49 -0600
Message-Id: <20190204184850.10040-1-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*** BLURB HERE ***
This update adds back the reference to the EMAIL environment variable.

William Hubbs (1):
  config: allow giving separate author and committer idents

 Documentation/config/user.txt | 23 ++++++---
 blame.c                       |  3 +-
 builtin/am.c                  |  1 +
 builtin/commit.c              |  3 +-
 cache.h                       | 13 ++++-
 config.c                      |  4 +-
 ident.c                       | 92 ++++++++++++++++++++++++++++++++---
 log-tree.c                    |  3 +-
 sequencer.c                   |  5 +-
 t/t7517-per-repo-email.sh     | 74 ++++++++++++++++++++++++++++
 10 files changed, 197 insertions(+), 24 deletions(-)

-- 
2.19.2

