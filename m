Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6CD20248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfDASwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:52:22 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34463 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfDASwV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:52:21 -0400
Received: by mail-ed1-f46.google.com with SMTP id x14so9277779eds.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vdwaa-nl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqmZeoVSEh1/CzkIIxV/bmQQ07RnyOviDKVNGvo33NE=;
        b=EYXXFCIZ7088yv3uEL4RbRcFmHvvYycExv3gFpDKcQSL3UrPJ+OQnOuhHWPXtuBTgJ
         a7S4wtqKA8UKAn9XElHGlTxOsqDrOLz8UZj/oRgBLaEy2yBPgvcG2Ke5Ikuc13tePFB7
         bz1DhD8NadxAed7+eorGkNwyNyQF3OrIyIxZyogIG4dTfAgA+aOQWFvqIstByM1N/iyS
         f4V55p1dOpQaxqO9C/zL6dURKGpukjNkiQRKN+BKslfKucZAq6sh2CC1Nh9ERvxV82aw
         fye4sG9mxJf75zzbA60EzvwWNDbenUxfg54CPl2AJhl1eQilCmn5+UgJb8RtkCOhWsvC
         RO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqmZeoVSEh1/CzkIIxV/bmQQ07RnyOviDKVNGvo33NE=;
        b=b8nLNucj3IM7W4xO0ndLnLa7j01BoBbFlt6UFgjQ8s0CnMFPq+6IQSiSapGa4L/10N
         4zTAE3cCM0qdhq7HX32PeIe0cNiKhCfyvaYSr1iQ9qzZ/VwvNEnetJkPmZyTVd4mt5ez
         pv5jw1qVyaD029o19prLp9TlX1gfXHssKWVN2PuV+mF5ZkOAIS9Mu4wn7omr3RTyWjDy
         MgG6XvlE0VCC07ts1JqCzdBzIe86C8I2KD6n4S67l/2Y1pCXpjJM6vropfn/whptWxLL
         ZvkaXwDoDnHc1rA7WeGu1RIzNRJhpLlRcKlWt3Of3vVlEJbJNV2U1C/q4C/aFFcpF+3g
         LD3Q==
X-Gm-Message-State: APjAAAWUwv0DZZpuzgJrxWJEqQ2j/Cnx+d/nvO69ETmEKJz9FtlB7Ke+
        CF3Lc7iZPPlOs+QvuZ2jXxO2rc3774Ozpg==
X-Google-Smtp-Source: APXvYqx8aZJTtAWLmwTsgITeD659+riqETXpNqb+RgOnGSxUvJoxk974R4w5K0oWctH+/EBVAqtdJQ==
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr41705839edr.29.1554144740108;
        Mon, 01 Apr 2019 11:52:20 -0700 (PDT)
Received: from localhost.localdomain (83-84-17-34.cable.dynamic.v4.ziggo.nl. [83.84.17.34])
        by smtp.gmail.com with ESMTPSA id y2sm3422574eda.11.2019.04.01.11.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:52:19 -0700 (PDT)
From:   Jelle van der Waa <jelle@vdwaa.nl>
X-Google-Original-From: Jelle van der Waa
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
        Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH 2/3] contrib: hg-to-git: has_key is removed in Python 3
Date:   Mon,  1 Apr 2019 20:52:07 +0200
Message-Id: <20190401185208.17031-3-jelle@vdwaa.nl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401185208.17031-1-jelle@vdwaa.nl>
References: <20190401185208.17031-1-jelle@vdwaa.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jelle van der Waa <jelle@vdwaa.nl>

has_key was deprecated in Python 2 and finally removed in Python 3 in
favor of 'foo' in bar.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 contrib/hg-to-git/hg-to-git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index f898d6f23e..d504624c63 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -155,7 +155,7 @@ def getgitenv(user, date):
         else:
             hgbranch[str(cset)] = "branch-" + str(cset)
 
-if not hgvers.has_key("0"):
+if "0" not in hgvers:
     print('creating repository')
     os.system('git init')
 
@@ -163,7 +163,7 @@ def getgitenv(user, date):
 for cset in range(int(tip) + 1):
 
     # incremental, already seen
-    if hgvers.has_key(str(cset)):
+    if str(cset) in hgvers:
         continue
     hgnewcsets += 1
 
-- 
2.21.0

