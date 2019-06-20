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
	by dcvr.yhbt.net (Postfix) with ESMTP id 46ADE1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFTVJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33688 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFTVJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so7728466wme.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3sXNR/uk3730rKhBr46qXt/A79m86WhaGryYWzrqL4=;
        b=VHjJwJAotmGeSgBV6kiBg08m84JXu7IsJ46GjjL5P9B7Zwlt0xQyFVcoZoE9Qa8wYH
         LefbbRhdTcuij4WCuywiRUjthwugXB6Kp8KCB1pu0ONEq3dACY0uhTNz4YnwwjGxhqek
         Py8K2suq1Pv02KQcQSPzhJ87z4XR1Hg4t+rADK7fP3QDFlzcs6Yjxc3DHs+xiZ+UNq5Z
         +QOWpkdNDqlJCz6MIej03NOrgXpWTHpmcdtIYmYLtiEO7SKjQeSnQl606GqkXGoAXqRI
         PpexzWGDu12xkMkateytin8ni3hGHqC/et0G0N0+1+Plg3doTAliZQUmNkujFhATN7d4
         hzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3sXNR/uk3730rKhBr46qXt/A79m86WhaGryYWzrqL4=;
        b=RG7TcT1kpaQKruunjoQpenNbg8h5Qw1SdEA03j/rv5xs9JqfVaG1UzujRRMt/3Odt/
         CRHhMadfpS1sjIotwD1YVnj+okKfZ8XNk/OkSWD5+lquvBGQyFF1TcOfUvuKuPFNkZL/
         c+q1AcfuGd8AiD7pdsG+hsc0Sl5DlBwR9B0Qbio2GMPAObzQMKmRBD4d9g+sLx6FWHHR
         ossq5i5f8oTeykdRAbI0vrogEoLiR7F7UZ+3cNgdqybhIrc5a/bnEpKR7bV/2xKfBF+z
         14rv/IoSaFbEfsHsbkre0Llph7ZjwHQV466FloyT50yxCd60921+EPca3rm4ioXz9kLW
         sP3Q==
X-Gm-Message-State: APjAAAXJiJbu/d0BHHQJWSFLn8jlkoyqRq9Z1CqyTWzo8UtoluzTjaJg
        OxAqXOGOV6lbeaxjXwh0X04idMt3yTo=
X-Google-Smtp-Source: APXvYqwNAFNS46+9USOyiW/pDHx8iifGCvM/gONdoIYBsMMZwiV1Nb/5yPdDwQg/cwR+cToaRgBWUw==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr934961wmm.153.1561064973486;
        Thu, 20 Jun 2019 14:09:33 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] tests README: re-flow a previously changed paragraph
Date:   Thu, 20 Jun 2019 23:09:13 +0200
Message-Id: <20190620210915.11297-7-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous change to the "GIT_TEST_GETTEXT_POISON" variable left this
paragraph needing to be re-flowed. Let's do that in this separate
change to make it easy to see that there's no change here when viewed
with "--word-diff".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 9a131f472e..072c9854d1 100644
--- a/t/README
+++ b/t/README
@@ -344,10 +344,10 @@ refactor to deal with it. The "SYMLINKS" prerequisite is currently
 excluded as so much relies on it, but this might change in the future.
 
 GIT_TEST_GETTEXT_POISON=<boolean> turns all strings marked for
-translation into gibberish if true. Used for
-spotting those tests that need to be marked with a C_LOCALE_OUTPUT
-prerequisite when adding more strings for translation. See "Testing
-marked strings" in po/README for details.
+translation into gibberish if true. Used for spotting those tests that
+need to be marked with a C_LOCALE_OUTPUT prerequisite when adding more
+strings for translation. See "Testing marked strings" in po/README for
+details.
 
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
-- 
2.22.0.455.g172b71a6c5

