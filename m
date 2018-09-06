Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B95F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 02:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeIFHVc (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 03:21:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53657 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFHVc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 03:21:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so9851465wme.3
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSYEpw234Oeq944Nh4wL1ZDLw9LZUCEmzhlX25LwhBM=;
        b=iKfpIb/8DnYGInFKGtAJXB28S6y17JWrI7A/l6+z4AcU+4ml1I3llm+jE+WNJjaIMf
         0jGFVD85G1Ce5SromQ2VRxxCQd5d/Z6IdKN5hU0yQk0T5pfjFP1V02iy0JTZSz8k9a/f
         4S67mFJPE1vgcJHpQP9gTOEzhuBrgXVY2QZtl7+cUWGZZrDJzDDfvLmhe3lvAZnBiwW5
         1bC5VKuRZ64C65va+cd1Y2eYXJ0C2tC39I6cm16TJ4fBFimJssQkpuOfOnf4/YB87Z63
         2yvd7++AierExSBJHvLFIKSK7FO7MeaIbp75LWNRkrlYXT6gR6/98ZdExye2Le329ZPT
         aQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSYEpw234Oeq944Nh4wL1ZDLw9LZUCEmzhlX25LwhBM=;
        b=BS3R8rkhJByHP2Ko8feNt0bSkNvoFspVmYCt2qWXXjvdT7q3nsNXPvleLZ7VsQrPCH
         a12wXz+5voH/5cgAZEpEXEkWzY+rTpJUTKC7diPs/kkG4YUXPG5qAIKQ2sSbXxK7tbvI
         e0CYlfKB1fxXf2WZaQVYIjGCjHj1ZoDTjSQAQ3+HmMTXe6GnXsTNUxujyhmZfCdMZZUe
         CEVJKW/2dtaa2mnyIMSBEqTrWbFhX9fXQcCcvjvTrLGypJBISYpRHxGmImS0L43Ebad4
         PDU36EgXPJqih62Th5uXpVoB9f3ymhOz8LRn0hi7M2Hl9feRHffRTz9RmE1kOTLre5WI
         lOHA==
X-Gm-Message-State: APzg51CPIL8cUNAGAQKVtA4vXWR3HjW3dnbb62s1JSfYttLmgp75xJGK
        DRmEBClLXYG2UrLvNBxYAIdD3MSROXc=
X-Google-Smtp-Source: ANB0VdbcV7ldzDlZo1KA8aEmBcI7UIKGNIgJJvNdp3W32XQT9IaiwMehUMtFma0V5gAm/kDwXrGwiQ==
X-Received: by 2002:a1c:9f41:: with SMTP id i62-v6mr600031wme.87.1536202105035;
        Wed, 05 Sep 2018 19:48:25 -0700 (PDT)
Received: from localhost.localdomain (x4db1b35b.dyn.telefonica.de. [77.177.179.91])
        by smtp.gmail.com with ESMTPSA id y10-v6sm3979999wrl.87.2018.09.05.19.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 19:48:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] t1700-split-index: drop unnecessary 'grep'
Date:   Thu,  6 Sep 2018 04:48:06 +0200
Message-Id: <20180906024810.8074-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.188.g56c5ee2db1
In-Reply-To: <20180906024810.8074-1-szeder.dev@gmail.com>
References: <20180906024810.8074-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'disable split index' in 't1700-split-index.sh' runs the
following pipeline:

  cmd | grep <pattern> | sed s///

Drop that 'grep' from the pipeline, and let 'sed' take over its
duties.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1700-split-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index b3b4d83eaf..be22398a85 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -57,7 +57,7 @@ test_expect_success 'disable split index' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	BASE=$(test-tool dump-split-index .git/index | grep "^own" | sed "s/own/base/") &&
+	BASE=$(test-tool dump-split-index .git/index | sed -n "s/^own/base/p") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	not a split index
-- 
2.19.0.rc0.188.g56c5ee2db1

