Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791271F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfHXWg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:36:57 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41674 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfHXWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:36:57 -0400
Received: by mail-wr1-f51.google.com with SMTP id j16so11809169wrr.8
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Fk8cap6K5lHJn1e5UMKA08IGm1yGKSWafiCJ8F4EU7o=;
        b=OrISlS+kB0Pm2JQ6QUovMJuxYYMrpYtzOjvHieUXDcIpo61zoiDA5B1VtZUxilaydl
         rBKfoHKA/kgWhilwGBn/vm8QMNDgQOocBKG9sc8NI8RwNrc7ZPWxExARSNX2g02try4t
         heoTkQZfLhIRGfFJGQPwTLTsnvgw+ErjT13ty1ZSqTpwque8KaGp6djrZkl8X6yWosAV
         w3R5a2TaE+gaEZvFw9XNQvGhINScdzfubh+JYnhmyRTU9aFSl1lEkuPaAUBsGYS/1LSE
         /49FkYZGqq+K0rrZijwHcQQcsgxnF7W3t5vH9wLpEwb31KWw1cRAsC8Typ25eTVaPBz9
         aWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fk8cap6K5lHJn1e5UMKA08IGm1yGKSWafiCJ8F4EU7o=;
        b=tQixKrX1dRc0TLWSwDfrg9PAqHd0qOovwhDz+Q6MugxZhDFG3wbOiOizmdVMXIf3dz
         1ddrkG3lugtgzAc1p3MLstjjuFPaRNL+RkPL9N9t6peo5Bo5/cIWRGqtIPb5DLcW3RQw
         NoueBoUx5zEFxEaQqgPQR3UUQn1AuarkdhqdrL8SPdcI6zAMDf8tXSA9AlSRVc6zN+7c
         OjQmyUICYDhu+GYIWIsJFnFrT8ndf+ibtM5vfxw3+2vK1seElTN6gfzii9gBoGecgM6n
         AKi5VdFdfN1zG08N4fozlwRoL9/tZIjUph9acE1d9MitMa/5slmFpMJ7T14PdrNAG+ce
         4mpQ==
X-Gm-Message-State: APjAAAUrkqda0isCEuNedlwYxqNXd2EWpiKnimJJ4GprjHHtbnnMPuDa
        NuVzQIjbBEZBa3DzlGNkYSNx3mT6
X-Google-Smtp-Source: APXvYqx3WYS0FhUTODG/vXhXO0nX/3DE8EOtR0CMKQmFhUNPLmQ4CSNY4oRWIS7LhK768J00CbZ4Qg==
X-Received: by 2002:adf:e708:: with SMTP id c8mr13217120wrm.25.1566686215101;
        Sat, 24 Aug 2019 15:36:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a19sm21242449wra.2.2019.08.24.15.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:36:54 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:36:54 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:36:53 GMT
Message-Id: <pull.129.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Do use ALL_CFLAGS in hdr-check
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

When I was playing with the Makefile target hdr-check, it looked as if it
missed the correct CFLAGS. Without them, on Windows an attempt is made to
include syslog.h, which does not make sense at all.

This patch addresses that.

Johannes Schindelin (1):
  hdr-check: make it work on Windows

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: c65a2884eae159bad540135479bc8afe20ff62d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-129%2Fdscho%2Ffix-hdr-check-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-129/dscho/fix-hdr-check-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/129
-- 
gitgitgadget
