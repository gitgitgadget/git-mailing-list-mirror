Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400731F404
	for <e@80x24.org>; Sat, 24 Feb 2018 14:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeBXOKI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 09:10:08 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39156 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeBXOKH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 09:10:07 -0500
Received: by mail-pl0-f67.google.com with SMTP id s13so6613318plq.6
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 06:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8neB6umLA1RZDpwKhomarUxAIzdpKqgoAqa7wQu/Txw=;
        b=rI1AyOpT8HA7rSLblD+uWmgnWxofw46FNoO8nY4hMAq4H2ep4FG9tG0bfsbgqJG2zf
         mvVdMkSXqsAKPLAaz54tbBxTNeK9nFPhTMP8Sf5CEYBuMk3gTh8gXdDmsG+Ar6jBI8hZ
         /ZgKZ91cYn4MnbPQxe5suG0APCN0WEjoiph/XsJBIn+BE5r3FXQAdLXARRUCSUcJMb6T
         E7giIggH2eEVVjYfBJUmRECPlRPdAUE8eae7LJgragt9gR/WmRpzwoR22aFIu5/NqXfd
         bqwIp4kTZY29qrgputJFj3YQL6sCwYUx79YK+6h2MW0hQr6UHn9U2noruMahzZ+FYpA4
         B5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8neB6umLA1RZDpwKhomarUxAIzdpKqgoAqa7wQu/Txw=;
        b=mTs0+RA9TCVXwdwNIHvSIoJKFVG8cq13aEX+FOLpWo5EPs4WTkKyKHS5UdRuXbSCan
         k8ktCCAbLM2r+LRR1eJbp75sB9Pjx8IhbhkXzcSDPhXlDQbVgRGUvwwNT8HoQHeVIuzw
         slpUeor0SCOirN3Ot/Rv3UvQXLLvbi29mpL5kLHBx3vWHs1V3mKnhBwTc97cJe+Uws/8
         fvdfJdOHUxXupSuwBHwLIP4c5Gr78pmGyLn7OwDwpgtKXdmo8KDEvWaLS3jQqFb9du7/
         iPkz927uhhomYlLKqvZ2smWVtI/+Ugn4grMzkgz38iG4irNBg3rS5oTaLRJ+8viIDV3W
         N43Q==
X-Gm-Message-State: APf1xPDZZhrNrl2CSxs5nHgGKyHva/Uhbfo5aXR1lPvUtA0777q8jKAd
        /i7PRKH/IKHOqXuj+KwdNSCvcg==
X-Google-Smtp-Source: AH8x225EHJw6M1xOJIdUDrx8trOlkZbXqcZ0Ods/Ind1YJaOHbIMUmBXzGqa3MUFNdAetdkyfINsXw==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr4884095pls.267.1519481406881;
        Sat, 24 Feb 2018 06:10:06 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id x9sm7200488pgc.81.2018.02.24.06.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2018 06:10:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 21:10:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 0/2] diff: add --compact-summary (aka nd/diff-stat-with-summary)
Date:   Sat, 24 Feb 2018 21:09:57 +0700
Message-Id: <20180224140959.25402-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224140509.25061-1-pclouds@gmail.com>
References: <20180224140509.25061-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... and v5 fixes the commit message of 2/2 where in v4 it still
mentions --stat-with-summary instead of --compact-summary. Sorry.

Nguyễn Thái Ngọc Duy (2):
  diff.c: refactor pprint_rename() to use strbuf
  diff: add --compact-summary

 Documentation/diff-options.txt                |  8 ++
 diff.c                                        | 96 ++++++++++++-------
 diff.h                                        |  1 +
 t/t4013-diff-various.sh                       |  5 +
 ...ty_--root_--stat_--compact-summary_initial | 12 +++
 ...-R_--root_--stat_--compact-summary_initial | 12 +++
 ...tree_--stat_--compact-summary_initial_mode |  4 +
 ...e_-R_--stat_--compact-summary_initial_mode |  4 +
 8 files changed, 109 insertions(+), 33 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
 create mode 100644 t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode

-- 
2.16.1.435.g8f24da2e1a

