Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75AF1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 21:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfFXVRb (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 17:17:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44589 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfFXVRb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 17:17:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so11049451lfm.11
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eG9BKjJjzk2eV8DGJFYPaSMArAqbsSsyP2GNcv8jLQs=;
        b=SDQA6SnPeKK4LeKK++SZP2zvRz2Bhgy90cIB7XjAr80FcaOZL5fOMiXbYjl/HIVGjY
         Q8ToNvxI1P4JjkxQLPF6O6Tj+IMx6JwThqtskwWIMSEDX5ZmftUMz9ybGogFW1oCxhAm
         4nzX1xTr2ArUV2h+Zvlj22OGlYtKG7BvH/HK9Hm5x3zBhrYnIptQIZta15OVD+rpC4VU
         bspnsu7CT8fVQhJnGi56RLf2FFMn1V4wEzr6eH+si2871GuE1aEDPvcuAeqYQZM1xt/R
         xodDZuvTnfkS81KiHc6MYKRmTZSr3fmilkeOG0mc5LtF84dUOslJsCSENuFqezJIPHF9
         M8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eG9BKjJjzk2eV8DGJFYPaSMArAqbsSsyP2GNcv8jLQs=;
        b=NdiLniec+JlmcGnHuT0RviyUqWqljYchAiAA3c7IbX6SdhXhP5SCK4nRiizVP2DOYV
         NfBtql4GGPLyFfbhMaBdjswdmR+ovqnPvAcsUInbe1EBqm5TKX6FFPXJG3fGdN3MuYcL
         BmFYgGg+jPVE1xwQWEdzYpPcHBxdJcyB4B2AH7o4olQSQWmAeBHEVmn4tmdBfRfyiZ3F
         UtFfJZZtqdZz3y370bnEUhwFHRY4QNPmuCJiXfPLSn5bN2OO92tnCeRd3cuPnXu6Fv/J
         ADyhHQA79CtlZ71CoRJMWNvgT6TO0uWrzBIobIejkSoLqtGA074YhRMUZbj8RzMebPMQ
         jFfA==
X-Gm-Message-State: APjAAAU1/jx8DKAAR3isemYefILl8Z4ZNDgTMlR9bUEtKbe0j6Tg5mkH
        wC+7CXpEDfyF7TYG1qOl2mWtDrjH8pA=
X-Google-Smtp-Source: APXvYqz18hTjXWe5HgOV9GWcxjz2NG/XFoa2ZzOcw1f9AfgUBLLmXh8rVLxFg/LHv17/PiaKPXIwiw==
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr19382515lfp.99.1561411049374;
        Mon, 24 Jun 2019 14:17:29 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-214-150.pppoe.spdop.ru. [109.252.214.150])
        by smtp.gmail.com with ESMTPSA id z30sm1911017lfj.63.2019.06.24.14.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 14:17:28 -0700 (PDT)
From:   Andrew Yefanov <1134togo@gmail.com>
To:     git@vger.kernel.org
Cc:     Andrew Yefanov <1134togo@gmail.com>
Subject: [PATCH] Add example on how to import changes with time interval specified
Date:   Tue, 25 Jun 2019 00:17:19 +0300
Message-Id: <20190624211719.25727-1-1134togo@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andrew Yefanov <1134togo@gmail.com>
---
 Documentation/git-p4.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 7436c64a9..aac95d0a0 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -345,6 +345,9 @@ p4 revision specifier on the end:
 
 "//depot/my/project@1,6"::
     Import only changes 1 through 6.
+    
+"//depot/my/project@2012/01/01,2017/01/01"::
+    Import only changes made from 01.01.2012 til 01.01.2017. The format is yyyy/mm/dd.
 
 "//depot/proj1@all //depot/proj2@all"::
     Import all changes from both named depot paths into a single
-- 
2.20.1 (Apple Git-117)

