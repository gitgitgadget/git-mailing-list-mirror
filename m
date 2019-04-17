Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF8920305
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbfDQOdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:33:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44069 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbfDQOdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so2146747wrv.11
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=8H3fsUqU94DOicsjySVKxiyLP7tOZ/UTCRSTVhkz8M8=;
        b=AalxDBU0wjmLJhEJRQMs/Lex36LVNxdtB8I6xM3JDzzu/oQGE8ybT69dCNGzBjvRkL
         0EsTIkyp+94rNtaJS9Yioo6OpLnYf8eVPYq08aBHXUDQUrlpCYqCjQq+GbkEpv3mjdTI
         Zx/keDFFC84F0JGDzn2fm7XDKOJw4lY4lz6HPEHZZMyt9RcVo7UsqOIhTEJ6Dnhqlj1y
         3qEppesPj/V/jIQ2nWbHS1kuajzmzsBlAo8h45TMebVHZ78bgAv/rYU06JaF48rJ2e9T
         Zf7zp7bhi1K2dCx1Z3A7diohVGWUbukJhpWLm3kw+cbS6kcdcJvBLEWbYV0UEuPiyXEV
         qirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=8H3fsUqU94DOicsjySVKxiyLP7tOZ/UTCRSTVhkz8M8=;
        b=kyThGN1FmKcaAkbM/oFaVvN9PxsRIF1ghs3DzBnDeg9MhFE2a4OTVKBOcXrsvW1h02
         t5v2J6HdUBu441t1F7vcmmW4qDgmei/tzDUtforJQMI0V8I332VK9UkurfdYh+6wuc40
         70z/NxrTTITAtslIC6jL+w/LJh3H4Nv7U9ZWLDAXvGzcyoSDygRatV48CPAtPCm8igdo
         QfkZjlOiPldz1r8sAfzVwkXWgSd5KcIFnziAcnfknGXSqv1pd1hpy6qs85W3Een+y8BR
         0hsj2spqtTajGehp6TRAbFUcEsJrKurvG9/7+V6HDDRozyUr/HvggA6iK22Ztxb2VhIh
         pDHw==
X-Gm-Message-State: APjAAAVSXcyrTEbz1q6i/ztcmLEvIbYME7BXhdPREH+Tcl/2CXlewFKB
        ohpzdVrcsRNDezjW8TLbyOIOoKCzGn0=
X-Google-Smtp-Source: APXvYqyBeF+uYeyFsmvy0FMLrVNGSNTwgo9D/nrJlfS9YbHr/qwcxyQ7A18uPn4/11sHTuhQL6F4Lw==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr10203501wrw.68.1555511580263;
        Wed, 17 Apr 2019 07:33:00 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:32:59 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 03/12] rebase: rename write_basic_state()
Date:   Wed, 17 Apr 2019 15:30:35 +0100
Message-Id: <20190417143044.17655-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417143044.17655-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This clashes with a function in sequencer.c

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 239a54ecfe..0b1a193a8e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -245,7 +245,7 @@ static int read_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
-static int write_basic_state(struct rebase_options *opts)
+static int rebase_write_basic_state(struct rebase_options *opts)
 {
 	write_file(state_dir_path("head-name", opts), "%s",
 		   opts->head_name ? opts->head_name : "detached HEAD");
@@ -640,7 +640,7 @@ static int run_am(struct rebase_options *opts)
 	}
 
 	if (is_directory(opts->state_dir))
-		write_basic_state(opts);
+		rebase_write_basic_state(opts);
 
 	return status;
 }
-- 
2.21.0

