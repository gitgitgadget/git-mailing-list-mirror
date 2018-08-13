Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555041F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeHMWGw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38762 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbeHMWGv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so15211758wro.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3C0Uy2LZg46xcBt8+cjgXEy6XNuiNnMQqZ3OJMDPxI=;
        b=ZafPocSSyIsO29u8lmVSJu4OgZFjWktuNleyFsIiEXlNMFDCR1Z4RTws7PrbGJoSLM
         xnHUJUNuQuc/PcoA/lizd3OqPFzSsa4L6UmKMjr1F6BMPRgh2tTYUJQkzumc5FaQOp3r
         57Z1fbHWgvaQHC+xZZfA0uHR+QM9nx9gqiA4nBR5J9KwwrbxHim6E/yvuS8mMo7ORWXz
         dzI3oqQFyune47GFreS0yV17j4aNgjw3RdqDrlwnoKtpgEunLk56mp5ontLiheq1jGN6
         bvKbZOUUXb7gB9wbYU9ppaxZ9lIkINqjeXmYRr3/FZDxe8M7oC2IvRjuILXrzCLTAC5N
         bqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3C0Uy2LZg46xcBt8+cjgXEy6XNuiNnMQqZ3OJMDPxI=;
        b=hfDrwiSJwku/mH5R62Lq5KF6K9zTPr3rc8neczn821E3MAsu0CMXcnJY+gggAv99xA
         nKNQHjk5QPpEcjkTxZFrPUShpZH3+H1YABItz4/K13jBa1nkdHDLp22Xrj/gJxKjAMi+
         1NC1MCQ5WF1JpOR79lZbzRZRnEjaAPU8YTWa1+gV/I6StQZ5NWjvFy19Da1x35UAxq1d
         EVcHwFB2+10SfuNCA4RfiL4glu2xZqBO7zo7mykULHH33tA172gT57lmWQYdyixYKYXi
         UyY5axLsidREyTo03lwlmz/4C8XBNpeBYTqgOd6tVhz3ZqspU1e0/g7qvy9SAvFbtccg
         Iyow==
X-Gm-Message-State: AOUpUlGt2odfUsNZFFoiJpnNyQYI8Fl4TPtRO17E2KDo4uF3fa7Gcm8s
        tcavrKPTnMl5ksBRgkYljmEQjj2V8Uk=
X-Google-Smtp-Source: AA+uWPz123p18l4WBapgnfJVDsECsycTmn4AeD09XeZK4LA82axaKsZ6+4d7k643xExPLUqLFe67LA==
X-Received: by 2002:adf:8161:: with SMTP id 88-v6mr11239396wrm.22.1534188195774;
        Mon, 13 Aug 2018 12:23:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/7] pull doc: fix a long-standing grammar error
Date:   Mon, 13 Aug 2018 19:22:49 +0000
Message-Id: <20180813192249.27585-8-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731130718.25222-1-avarab@gmail.com>
References: <20180731130718.25222-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It should be "is not an empty string" not "is not empty string". This
fixes wording originally introduced in ab9b31386b ("Documentation:
multi-head fetch.", 2005-08-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pull-fetch-param.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index c579793af5..f1fb08dc68 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -33,7 +33,7 @@ name.
 it requests fetching everything up to the given tag.
 +
 The remote ref that matches <src>
-is fetched, and if <dst> is not empty string, the local
+is fetched, and if <dst> is not an empty string, the local
 ref that matches it is fast-forwarded using <src>.
 If the optional plus `+` is used, the local ref
 is updated even if it does not result in a fast-forward
-- 
2.18.0.345.g5c9ce644c3

