Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9275820248
	for <e@80x24.org>; Sun,  3 Mar 2019 12:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfCCM3a (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 07:29:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38646 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCCM3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 07:29:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id g37so1187928plb.5
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 04:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l18VxC6qbEEH4Bb5Ukf0WZhoMXprZJz9hmK9Jo3lXJY=;
        b=fU+u+TZcSGgTfoJW615UCxK5aSo97y/6qacy+pUavejGOe3N23eJx/dDeC4yRUMNBd
         Y9f8NVxtoimEQhf5iDLsTFW+HTVJyPZrTZppPJlirDod3CC8qM+wAxhYOJIAZicRPBVw
         uUVO/OHFO6PZvc2JiLyjXUugmFE2IiCDCREEbNw5X1vCgog1kH0KzaYcSAPkurfaee0O
         nabuK5Xyf1L8MLd1PpoXC1lF9W5eMWniz0CWHlkvAh7DhkNYK2S8pM+N8SVgcc4+7r+C
         zv6ejpcb7ZE3nIGHtjk/nHCV1BobTtM8h3OQ0a8WbFFHubUtkxqyEvS0d2zYOK9Ygk32
         GfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l18VxC6qbEEH4Bb5Ukf0WZhoMXprZJz9hmK9Jo3lXJY=;
        b=M3rQheMGWdggPYzswJObuFAuR0gdUag0yrblx3YlgxxCeYAhmgdUdc2w0ogV8df7zU
         LKWbRMGgmye2RdNHNipCKQ1HIH1OKZYAd8SnTC8hq8U/2C7DniKA3NSMeCUNSPl+N/GO
         Y7hPkUXe4WhwlyXHmcHfJJ756N76VXLJg41KYNjjOJmbFJuLK0VHD0DU5CR5sALHhYyQ
         oAPboxLvLU8nKc1tZ1dQZvIzb3wtdDHCWxxfpIlRhx1qVt5pFLdj/xo5tgZiRk97mCsf
         71Kt+1cYfhoCWkfDvD6HdvEcfpOMsrZgCSk8R6b3eatUGH27dBievFQKChDM3CnF81ot
         iKwQ==
X-Gm-Message-State: APjAAAUJHLzMfDlcgMgcyv+OcIty31NkI3+XVYZM4VQZExVCl26eYRqc
        mkCOKdIcR23eFEhu7b/Lv0ibQI+TIBY=
X-Google-Smtp-Source: APXvYqw7Zbweh5yuJDK56efSEMGPfqVUIorSIguezfySL5iCu3a5rHEWZUFZqzYHE/CAB7d8ikA3ew==
X-Received: by 2002:a17:902:ea85:: with SMTP id cv5mr14695274plb.119.1551616169455;
        Sun, 03 Mar 2019 04:29:29 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id l5sm6861093pfi.97.2019.03.03.04.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 04:29:28 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        t.gummerer@gmail.com, christian.couder@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [PATCH 1/3] test functions: Add new function `test_file_not_empty`
Date:   Sun,  3 Mar 2019 17:58:40 +0530
Message-Id: <20190303122842.30380-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-lib-functions: add a helper function that checks for a file and that
the file is not empty. The helper function will provide better error message
in case of failure and improve readability

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/test-lib-functions.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80402a428f..1302df63b6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -593,6 +593,16 @@ test_dir_is_empty () {
 	fi
 }
 
+# Check if the file exists and has a size greater than zero
+test_file_not_empty () {
+	test_path_is_file "$1" &&
+	if ! test -s "$1"
+	then
+		echo "'$1' is an empty file."
+		false
+	fi
+}
+
 test_path_is_missing () {
 	if test -e "$1"
 	then
-- 

