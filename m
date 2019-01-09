Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8212A1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 19:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfAIT6u (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 14:58:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43266 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfAIT6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 14:58:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so8291482eds.10
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 11:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qA6m5dfzNDJ8h0r6nflrpjk0KFktX0G0hsZAnHi/zlY=;
        b=nXck0qpZJn+BjCWTAZol/gx6HHOXpdYA9SafEjBtNd4Gpy3VupMsg4PzeWuXSAImSx
         JdZWnp83hRfzK7rQsNfIaQwS9ZskaVYypUSPy2iKY4V9CFV5wy/3TyACj+mLN5lSKscr
         muYam4EMmkUxZznt7HSfg2EJerUTo4J0k9jXM28TMeqSfDKWtwuejgrUDSyerYk2NrP1
         YAuokurvnUSPAhL+KGtZKMR9hLdg9BNUcHMmjy5IYKe0+pZvHYkyr+uNEVsZcm/z4ZTs
         SAPEJUe81goon2Yf4EBVcniIs4q3K0IOLc1cF/6IexbLGjdhJhmdmLqX8mVfks28ud9d
         O0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qA6m5dfzNDJ8h0r6nflrpjk0KFktX0G0hsZAnHi/zlY=;
        b=H2QX3oQqkyCK71iBdr7iy3t1huhv3YboFO4RHg0rm0A7KR4PzZEOY9elDnDfuHnQbr
         ErbK4YuWc3E3mk0z5OVSPw8hN47CWfmEUd/nusmaGWBaJOgH1jP2DpOnGfseLjdIrico
         2+H+/FF4hIR7/czywr399V23ySIqtIiIfvMqtdg8xW+AbPPJ2EGtK4wUmTtATCXNHzXl
         XkEeCt8NbKTXA5PmYulmvNrKBcwCFFgcfvVtCd8B2v7yqeu8Rg/gkv+GPAtMk+CEfBbt
         IT+Z6M4mDNgcPf4Mf4Pw8Q146EtJQfZ/ur94IcFPg5Mp/l+tQwWuFf3h7A9ZIG9DPFJ0
         bl2w==
X-Gm-Message-State: AJcUukcAbgNXoSc4qpZDkj1QmX7HVr6JGeoC3/51b1NbbFSpHi0SSKxl
        w7Mr0oLwEnjWzcN10DCxpw6X0c9p
X-Google-Smtp-Source: ALg8bN693B1Hz2XFKHvkzwHkDzxBsfFIjSR8Hr/HDS1qBBKIZahQb7TkSm/q/ziIjaV/aAt3lVveYg==
X-Received: by 2002:a50:e8cc:: with SMTP id l12mr7002178edn.117.1547063928487;
        Wed, 09 Jan 2019 11:58:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j31sm1317058eda.46.2019.01.09.11.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 11:58:47 -0800 (PST)
Date:   Wed, 09 Jan 2019 11:58:47 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 19:58:46 GMT
Message-Id: <6de539101ee3e528ef3713bb518e0e307b31a382.1547063926.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.106.git.gitgitgadget@gmail.com>
References: <pull.106.git.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] git-show-ref.txt: fix order of flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the explanatory text uses the term "respectively", the order of
flags is important.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-show-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index d28e6154c6..ab4d271925 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -37,8 +37,8 @@ OPTIONS
 
 	Show the HEAD reference, even if it would normally be filtered out.
 
---tags::
 --heads::
+--tags::
 
 	Limit to "refs/heads" and "refs/tags", respectively.  These options
 	are not mutually exclusive; when given both, references stored in
-- 
gitgitgadget
