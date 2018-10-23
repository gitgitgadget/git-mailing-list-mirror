Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29D21F453
	for <e@80x24.org>; Tue, 23 Oct 2018 09:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbeJWSDM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:03:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35856 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbeJWSDM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:03:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so390623pfg.3
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptOB6fHv5S7NlLC2m4Y7Z3AB4Goq3kUjcrmDCneKW3Q=;
        b=eobMTv2Sq0mfa4t29Kjyak5zvrv0wP/nvhjDH9GcTXQmqS55ePzAQiSHHS6jg4V9M/
         ILz7/GAAh+KemvrrCCGos24XRZeiIHjssAA1eG5HslGemvWl9h0G3kSF5Cz5VUqcLPQO
         GtYxik33eTuY/estAgIYRppK97HG3okDf/tRrppbTshCpNBM6lL8Uo8KbKgTHyYooE+d
         oBX7DcBvbTjTuunIooY7BP3BwTWGvUy+LNmGUSue6SUBIZssmZB8/epqD8Hr1SWxRVg9
         BYOVDQdCqPqLFcMkEr5JKrwyOT+WfnOh94XVoaBZ/iLpzTIWI6y7icERNc1il0xZaUwL
         458w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptOB6fHv5S7NlLC2m4Y7Z3AB4Goq3kUjcrmDCneKW3Q=;
        b=ti5q4fxla/KnPmadfaiY2ysq1E2jsNiJWq4oCs0ATvXZ4LZLjasOgfkamTw9f9gLAu
         TEta+Fo8Cksx3TfWEkKIDUCWupqMNCy5yM+9PiFphVcYtGYVQzSizT6Wy+WrebJ1dnqH
         x/DuRIEXT/BarCx+bIZZjZKULwWrfnbgJ9iUCvyFNbhnTBjvXZWB4Lpb0OVyN4HpeBmQ
         JLycMQnd/C0dqZqg3aguBUmvyFgKla1vTHTfQ3uqOArSwr9EschWf13abso66r3V3BR9
         whwtDhxtVmxuDvLK7QOfTbUKQgePCLgJaFTsHsPTJdVvs83tFpOla8uNDLZ4Zcyazxjo
         04FA==
X-Gm-Message-State: ABuFfoh87vlbLQPbQFqsXy4RasIMvLUaHn+11aOcJrxW00Bf2o2qecMl
        U3kxyIoo0FmJXeIYnPWuqG+6faGGW74=
X-Google-Smtp-Source: ACcGV610TGEGeuLOAS9asYhB7bcCv9InrzHaDTyMhpVNlOw983qYkrLtyDj9FDfMNoRP/G3SbBqFiA==
X-Received: by 2002:a63:f252:: with SMTP id d18-v6mr46419601pgk.2.1540287634461;
        Tue, 23 Oct 2018 02:40:34 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 74-v6sm3636857pfx.182.2018.10.23.02.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Oct 2018 02:40:33 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, gitter.spiros@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] test: avoid failures when USE_NED_ALLOCATOR
Date:   Tue, 23 Oct 2018 02:38:56 -0700
Message-Id: <20181023093856.78944-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

contrib/nedmalloc doesn't support MALLOC_CHECK_ or MALLOC_PERTURB_
so add it to the same exception that is being used with valgrind

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 44288cbb59..2ad9e6176c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -143,7 +143,7 @@ fi
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
-   test -n "$TEST_NO_MALLOC_CHECK"
+   test -n "$TEST_NO_MALLOC_CHECK" || test -n "$USE_NED_ALLOCATOR"
 then
 	setup_malloc_check () {
 		: nothing
-- 
2.19.1

