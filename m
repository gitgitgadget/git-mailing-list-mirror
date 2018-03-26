Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D151F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbeCZHY5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:24:57 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36280 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeCZHY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:24:56 -0400
Received: by mail-wr0-f174.google.com with SMTP id d10so17763145wrf.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BEzWC+Nx/sRzQOoOJhV1JXdROwvlW7nzznjarU5Y35U=;
        b=AP5rXqmc1qLhUN0IquJbt1zQwROekuzWR/xVlGrbg0q4ZIgKNk1byKl2JEKZJFrANJ
         qTB1LeQfzfsVkkFpnVL4Qv6jah3cmRBL1lgem303ihnWV3+ky/8WG+dHJTAnsjC1fPmT
         7gCkZkg5gq2F6kZhEVd/IkhKAwGf5zvDcF+pFLOKMvO1/FpbAHDotfdCi850Qygofab6
         0+MyFHzRjlA4Gx9uvGz1HER1X0+Fxv5bO/G3lkwRikZRLihLYhUg2ePs3eZHcHgBgWyi
         xtD+ZJ6SyA+dGXlGL9UxoVr4Be4ZyQtkUg7BBwVEYgpXrtLCs2Sjw+947n8BoTNbIyMM
         qbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BEzWC+Nx/sRzQOoOJhV1JXdROwvlW7nzznjarU5Y35U=;
        b=hXk5q04zhGbrymAVkBS3kQu52S9SHq45C+NgLlFZYBdP8VY39E6jl9nbQaJ6TL54uS
         tAUXDj8B0hfyrdzvaSB2aLxD31wFbEoU3rIIEj8iIBtirVZil4Gdjbl2LvH96MMJbDZ7
         NZx9LdeK9Aks9IrEBRx64WNkODHOFdB0uqAuAIK7KilDG+JkiulrJ6Ro++lM+M9j4YpS
         qgGD7e0Sysn0oe5BuuW9k/nwInrLJ6JbVghB6ptwgMjPvaoi7d1NVFVASK/UMoYgpD1e
         Gm/E5iGfgJdQEPeZXzozn3GARawalHKooFp11wYdMPsIe9S6DKQe4GdFLbqXqRhHw1dr
         BtJw==
X-Gm-Message-State: AElRT7FSKjv6i3C5QT5SZpGMGGf0mxVFpE471wCujmqCOssBjc2luoXT
        9jL1eb+qmPDcq26tEOq+tKNRy20/
X-Google-Smtp-Source: AG47ELv5iLjW/5xFB2jGGFzrr+PfcAkxIjucwAW/UDSCkQPqoFU0dc7rfGsMri6unEauiO3s+7aPrw==
X-Received: by 10.223.166.102 with SMTP id k93mr31656920wrc.231.1522049094509;
        Mon, 26 Mar 2018 00:24:54 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u8sm2820922wmf.2.2018.03.26.00.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 00:24:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 0/2] perf/aggregate: sort results by regression
Date:   Mon, 26 Mar 2018 09:24:29 +0200
Message-Id: <20180326072431.30771-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc1.36.g098d832c9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small patch series makes it easy to spot big performance
regressions, so that they can later be investigated.

For example:

$ ./aggregate.perl --sort-by=regression --subsection "without libpcre" v2.14.3 v2.15.1 v2.16.2 p4220-log-grep-engines.sh 
+5.0% p4220-log-grep-engines.2 0.60(0.58+0.02) 0.63(0.59+0.04) v2.14.3 v2.15.1
+4.5% p4220-log-grep-engines.10 0.67(0.64+0.03) 0.70(0.67+0.02) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.5 0.58(0.57+0.01) 0.59(0.59+0.00) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.6 0.58(0.58+0.00) 0.59(0.56+0.02) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.17 0.58(0.57+0.01) 0.59(0.56+0.02) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.1 0.60(0.58+0.01) 0.61(0.60+0.01) v2.14.3 v2.15.1
+1.6% p4220-log-grep-engines.13 0.64(0.63+0.02) 0.65(0.63+0.01) v2.14.3 v2.15.1
+1.5% p4220-log-grep-engines.9 0.67(0.66+0.01) 0.68(0.67+0.01) v2.14.3 v2.15.1
+0.0% p4220-log-grep-engines.14 0.65(0.62+0.02) 0.65(0.63+0.02) v2.14.3 v2.15.1
+0.0% p4220-log-grep-engines.18 0.58(0.57+0.00) 0.58(0.56+0.02) v2.14.3 v2.15.1
-1.5% p4220-log-grep-engines.13 0.65(0.63+0.01) 0.64(0.62+0.01) v2.15.1 v2.16.2
-1.5% p4220-log-grep-engines.14 0.65(0.63+0.02) 0.64(0.60+0.03) v2.15.1 v2.16.2
-1.6% p4220-log-grep-engines.1 0.61(0.60+0.01) 0.60(0.58+0.02) v2.15.1 v2.16.2
-1.7% p4220-log-grep-engines.5 0.59(0.59+0.00) 0.58(0.55+0.02) v2.15.1 v2.16.2
-1.7% p4220-log-grep-engines.6 0.59(0.56+0.02) 0.58(0.55+0.02) v2.15.1 v2.16.2
-1.7% p4220-log-grep-engines.18 0.58(0.56+0.02) 0.57(0.55+0.02) v2.15.1 v2.16.2
-2.9% p4220-log-grep-engines.9 0.68(0.67+0.01) 0.66(0.64+0.02) v2.15.1 v2.16.2
-3.4% p4220-log-grep-engines.17 0.59(0.56+0.02) 0.57(0.55+0.01) v2.15.1 v2.16.2
-4.3% p4220-log-grep-engines.10 0.70(0.67+0.02) 0.67(0.66+0.01) v2.15.1 v2.16.2
-4.8% p4220-log-grep-engines.2 0.63(0.59+0.04) 0.60(0.57+0.03) v2.15.1 v2.16.2

Since V1, the indent issues have been fixed and the name of the option
has been changed to --sort-by=regression (from --sortbyregression) as
suggested by Junio.

Christian Couder (2):
  perf/aggregate: add display_dir()
  perf/aggregate: add --sort-by=regression option

 t/perf/aggregate.perl | 70 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

-- 
2.17.0.rc1.36.g098d832c9.dirty

