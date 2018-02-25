Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF261F404
	for <e@80x24.org>; Sun, 25 Feb 2018 20:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeBYUfs (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 15:35:48 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52380 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeBYUfr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 15:35:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id t3so13769669wmc.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tB2z/16Xp6ztqyzCZK9Ri9yBIJtMAx5QjZBgZKHNN6Y=;
        b=sDNJ8H/KtbhJYqjwinyUq5VaTPFvn1gc6o9kc6RsKJ4OrklJ60Xjpl7br/gGhREnZ3
         8Wyszh24jP5qJ11KGwc295KVDfApvFdAdBvh72Bgac5yUnaYh25PD/0Csq8TZbX2Tl9g
         MaRbiV3nlYX0aII11oneUxmloA4U6nfbDZE5g47CgPMopYBgu/hOIgiUrbzeVRDw6zON
         zS5eEcqU+JHWY7ipjNTp6tpUVh8GVp4Uq8/BJlnU2pJiApii9CSX/lboGsaGphQ/Ex3b
         vSa56ujV4xVJ9kH+JKTG2h1f+4d4aqXyXRaxXM7MWUsUg5lZqah1AbaOto7xuMQjcTE/
         ByOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tB2z/16Xp6ztqyzCZK9Ri9yBIJtMAx5QjZBgZKHNN6Y=;
        b=KZksOde6IVEFht6Hn//BB4fWr0BipchI9cJML3a9rodsxPHD+0RhSExus1aFVxKdXL
         z04qqy4mfkhnNvqTl2JaeAKnD8QQ9TiXsH7AsJmmBCGZCplCoawkcG+4EHATGdWYPBli
         n05K54mD8PY2+9cYvnhEBt/iddTXUSBlwnHGQ/EaqPuItLMelmuLN6tPZKNnHQfFyjBO
         hcifidqAvX3ehbmxkX2kDXKiQkfUS3YqHrMKeaxmvbNuzPhuVGqpJwAcUh5zI1r9aiYY
         0V9WM6apWd69UbeMZLLBm87/eDZHqHOO29NdeXhsWUiZlHo+gp5gXcuvO8BnA02kj6+q
         UN4A==
X-Gm-Message-State: APf1xPCOEZyufrBLEb4VVAv+0Mb7F/CDWeSvP3HaDQFQC8LrArWQYcKR
        Q9d8XYa35a925p2Un1TU51k4rqCA
X-Google-Smtp-Source: AG47ELvsHMaWeXWCjZ79hvHjpuFX0TRXQ41+eYzYhKkyDzNGXujCTQt0HJdUP7j3kcL9UufcIX4EsQ==
X-Received: by 10.28.237.19 with SMTP id l19mr6329305wmh.157.1519590946339;
        Sun, 25 Feb 2018 12:35:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 7sm6564268wmq.42.2018.02.25.12.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 12:35:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] wildmatch precompilation interface
Date:   Sun, 25 Feb 2018 20:35:35 +0000
Message-Id: <20180225203537.28318-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My recently landed wildmatch test series was in preperation for some
more major wildmatch changes.

Here's another series that prepares for bigger changes in wildmatch,
it adds an interface to pre-compile the patterns. Right now there's no
point in doing this, and it's harmless since none of the codepaths are
that performance sensitive, but down the line this'll save us time as
we'll be able to skip re-parsing the pattern each time with a better
wildmatch backend.

Ævar Arnfjörð Bjarmason (2):
  wildmatch: add interface for precompiling wildmatch() patterns
  wildmatch: use the new precompiling wildmatch()

 builtin/name-rev.c |  7 ++++++-
 builtin/replace.c  |  7 ++++---
 config.c           |  8 ++++++--
 refs.c             |  7 ++++---
 wildmatch.c        | 25 +++++++++++++++++++++++++
 wildmatch.h        | 11 +++++++++++
 6 files changed, 56 insertions(+), 9 deletions(-)

-- 
2.15.1.424.g9478a66081

