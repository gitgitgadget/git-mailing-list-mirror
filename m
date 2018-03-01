Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8931F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966836AbeCAJVP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:21:15 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39312 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966724AbeCAJVE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:21:04 -0500
Received: by mail-pl0-f68.google.com with SMTP id s13-v6so3303322plq.6
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yT9lAjNeaGsSDDTUDaY1EYaGeTWiXzZXf3p2kkXeAxA=;
        b=EkAxgUZy00jZl8Vzvr+MmIf09NI4OooAsqA5xWw2RW9dsIchyA/1A9ycBvqxtX9clI
         K9Lytl/skduPXqjKEhOd7SHtuYH9BTMGDKO/niWst1hKdP6+UN9yls8RBhjkM35gTvcL
         gqCXoex5Y52HYIQm+WbP/4xSmKIX24fsTKETFwtbIKCqhIdNm2RHpHS13iY/8s8o4j8T
         eQKIozipIGxgqr4Tgx9/VSRyhCkMIw/Cg53Z+d05k6l+ifwBOYE2WeKVcoczyymYVC3s
         KGxkuhVn8B2q68TZZipSzLRB4GQHCdSGvp3GhJHyT6VNaT1F4Pfk2h5HuhXx7lFn84aH
         GO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yT9lAjNeaGsSDDTUDaY1EYaGeTWiXzZXf3p2kkXeAxA=;
        b=LMwIFK6rAHiPkyzy8EuWz/7rHe9CrFmwNUc5eYZNsszHAfRfmpyfUsv1aICRtP7KDu
         c06+kEQqRla6iOAIWZVBOIp/Qfi/ik64bp+t0O7X8UMtZXQkZDas1osOw+HQbmQ4gwO8
         NZNkMF+sGllP3F6tB1Np+zznKCa8bQ4jxi8g7t9cfWGkOcSzsOSROCQ8mc4Fw6FddMTg
         TYX48gn/vqw0qokIyuaNJ89+/AlyhSKPR42kqVaq/zi/4E5P0MQT/ir7gdM05bPkMi9r
         b1WDMjenu12fPUPfshigSOFE6FCir0JALvcPoi+Q55yHjFp7gu+imbbyupBUFAQIEdXv
         E8mQ==
X-Gm-Message-State: APf1xPC3nf3j8g3GDvwbgHqyVnI9iZAoe4AFYkPS/sEn5eIkEprk73li
        fyLDi7ARn19MRPr2AX+ssug/aw==
X-Google-Smtp-Source: AG47ELt2gafnGZVtpZMWZRdmEAk+a6H60fBoNVL8rVtdSXfpdSHWDw1Bomu/fyRZXkibcdjoulKw+g==
X-Received: by 2002:a17:902:7e4a:: with SMTP id a10-v6mr1286914pln.207.1519896063764;
        Thu, 01 Mar 2018 01:21:03 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e19sm5764641pga.8.2018.03.01.01.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:21:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:20:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 0/1] Avoid expensive 'repack -ad' in gc --auto
Date:   Thu,  1 Mar 2018 16:20:45 +0700
Message-Id: <20180301092046.2769-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180228092722.GA25627@ash>
References: <20180228092722.GA25627@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The series [1] I just sent helps reduce pack-objects memory footprint
a bit. But even then it's still a huge memory hog. So this patch makes
a special treatment for gc --auto: avoid it completely.

The trick here is not new (pinning the largest pack with a .keep
file). It's just never done automatically. I think this is a good
thing to do, provided that gc --auto estimates memory usage more or
less correct.

And "git gc --auto" should run even on weak machines because it's part
of regular repo maintenance. You can't tell people "You can't work on
linux-2.6.git repository because your machine has too little memory".

The only thing left I think I should do is to use an external rev-list
to free up some more memory. But let's see how the first patch goes
first (documents and tests are missing, I know).

[1] https://public-inbox.org/git/%3C20180301091052.32267-1-pclouds@gmail.com%3E/

Nguyễn Thái Ngọc Duy (1):
  gc --auto: exclude the largest giant pack in low-memory config

 builtin/gc.c           | 125 +++++++++++++++++++++++++++++++++++++++--
 builtin/pack-objects.c |   2 +-
 config.mak.uname       |   1 +
 git-compat-util.h      |   4 ++
 pack-objects.h         |   2 +
 5 files changed, 128 insertions(+), 6 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

