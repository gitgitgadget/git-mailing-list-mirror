Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2051F406
	for <e@80x24.org>; Fri, 22 Dec 2017 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756346AbdLVQBP (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 11:01:15 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43081 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbdLVQBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 11:01:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id n138so22607097wmg.2
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8fdqeYSjOO6yqX7Kho4/X+1hlLlQhJ6ZbLGczWlAbTc=;
        b=rqjeTNGFQI+A5D1R39D89ZaED1NE17UGaKdewB2UDU1rqolLfCZezplb9tzDuXQ5br
         6CInaaAxaKpD+cGiOAhmah3zwowZtf4a0JpFGNQ4DYp9yf93oEubxRK+/grRS7jwOa9l
         fyjFfPD/JFcZQWQjpWHaYAnshw4ZxhC0CBWz8oMjgU99P8W0jAmYw3UrpiiaBllvTWDH
         QI07B93ZefvSiYGyyvp/XT0SivbEev31RFIbmchXsvhdQRUNhxmlSRrfCyh/BQggg1/w
         vl4wE4yss6s18yTg5TDHOvXcUEOlywK66F2azqj1jkfPZXYOI882AfY/glI1Tr3QYjZD
         IgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8fdqeYSjOO6yqX7Kho4/X+1hlLlQhJ6ZbLGczWlAbTc=;
        b=IcsVu6f3XjAWtT+ffjmZcWxAoJ03kHGADSIoyW0I+ewNTMtXlPpj0E5WapQZWAykM9
         qVnLSOmMJBiSqn9d+ETSokKvgXVh36zyJmO0sf3xjbFYL4xLcJ4UIkPBMYBhVVMJMDzK
         53mKmY0QDQIc84dgVOxxEorTlPEOga85cTGbAwpriVRckUwJe3c5gGq+rvOJaqRGWj24
         1J59+Zuj7S0a1NYhOH2KUx0MnA6MjvIHGyoQNFKaj6xyF3dja/QQXoys6phhsW9GA1jZ
         5YKRMKvvxA2QyL9kWWmVXN+evZ9QDT2zQmABXOJXgx4EbiNh1Q2exKdb8ysL2W1XIVgm
         iZhQ==
X-Gm-Message-State: AKGB3mKmq50rSwAec/CXD0Rs4XwL5RCig/uZQjI6sQ0je5NREHudTAPp
        gLv6P39T1CD4sMgPf7ApgsK8nI8D
X-Google-Smtp-Source: ACJfBotNYIprBci+A3yY5Rfi95cw5fRRm2qXKFfwXr1im6k1wM7ppjL7JHODZCFnGS4j+Rt/voyz9Q==
X-Received: by 10.80.161.37 with SMTP id 34mr15468071edj.15.1513958470985;
        Fri, 22 Dec 2017 08:01:10 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g45sm20886254eda.88.2017.12.22.08.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2017 08:01:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] commit doc: document that -c, -C, -F and --fixup with -m error
Date:   Fri, 22 Dec 2017 16:00:55 +0000
Message-Id: <20171222160056.10102-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171222160056.10102-1-avarab@gmail.com>
References: <20171222160056.10102-1-avarab@gmail.com>
In-Reply-To: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document that providing any of -c, -C, -F and --fixup along with -m
will result in an error. Some variant of this has been errored about
explicitly since 0c091296c0 ("git-commit: log parameter updates.",
2005-08-08), but the documentation was never updated to reflect this.

Wording-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-commit.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 8c74a2ca03..3fbb7352bc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -144,6 +144,9 @@ OPTIONS
 	Use the given <msg> as the commit message.
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
++
+The `-m` option is mutually exclusive with `-c`, `-C`, `-F`, and
+`--fixup`.
 
 -t <file>::
 --template=<file>::
-- 
2.15.1.424.g9478a66081

