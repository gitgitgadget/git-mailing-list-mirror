Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80AF11F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBHJEl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:04:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40971 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJEl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:04:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so1304178pgq.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OKrVEIdtHGuBbjw0txuo5PJ5Bolb0l97rR/T1Ood7I=;
        b=Drex8CJQPzIZBhY9QAD2csBQjb8upOyU+9bCOu/bZi1JnRD1Fve4CSecuRvuRqRk7N
         TNc9Tub42PzIXT14/O1ihW3mAKBzuMd+wkrUP0qY7wfbb18ItAoUpbF00HyoDyYiZs9z
         2dVesOYuS1QT2yYXcqaKSyycgmJVGTCK6olJi9mQg44Zy04VeV4bwbOFEZw6B0zX+ivm
         bwoaQGCF+phj22ZTBpiU73VFQ0vDUL+HZdjf3vKpz5zgkYAfbCGQaB9tZ5RABDjQMtnX
         bgpxiatVomIEjQRnXAR9EVQBWOF6WPSxG9Dpja2MQZdSEtPriexZrGtP87HY5ZXJhOsC
         uX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OKrVEIdtHGuBbjw0txuo5PJ5Bolb0l97rR/T1Ood7I=;
        b=qYMnXVOTeAVYq0b8SlmaS4KEGTREZHxTJfi9hf080S1HVnv3s0dbcpm3O9Ribt51yR
         UtyLqX8O/Na8xIzAvDWsQ1XBI+uDha0AZbW2iAMUGpgTLi2hA6YVVt64kq7H8u4nu83s
         ci7WgkD0FVIv7OrXebRoCCBWUlUSEsaVGJVPCejr3Zeh9ifj4p6RlKFmm1wV25FrWQ+f
         ov2uYdRxkAzCQkjhTNYYqMkfx0kxU3ZunTn7+PbtEgjXXjQVQo95+7QL6AFpjug32FMv
         BEIvsEIrO6QWXu4aM6gHhx2Ve8+CcdQd/ABBnCun5DK1Y+tUYISh8fWt3WxVtS/tegbO
         2ofw==
X-Gm-Message-State: AHQUAuaxwIWUT5gyXLH/nXE0exdg68skDZCoZcB2l7vwzxx8iiiKpVib
        PkItDKBAV9QXHbY3lMF4CBg=
X-Google-Smtp-Source: AHgI3Ib3Qg/45ZzYlWpWTmDqp7zXxnwMA5N7r+Vjhm1OxgMx4rmtuLNBg8z7nbkBZThIGGuvN6XoCQ==
X-Received: by 2002:a63:4665:: with SMTP id v37mr19630147pgk.425.1549616680463;
        Fri, 08 Feb 2019 01:04:40 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b10sm1955094pfj.183.2019.02.08.01.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:04:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:04:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/19] t: rename t2014-switch.sh to t2014-checkout-switch.sh
Date:   Fri,  8 Feb 2019 16:03:45 +0700
Message-Id: <20190208090401.14793-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old name does not really say that this is about 'checkout -b'. See
49d833dc07 (Revert "checkout branch: prime cache-tree fully" -
2009-05-12) for more information

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/{t2014-switch.sh => t2014-checkout-switch.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)

diff --git a/t/t2014-switch.sh b/t/t2014-checkout-switch.sh
similarity index 100%
rename from t/t2014-switch.sh
rename to t/t2014-checkout-switch.sh
-- 
2.20.1.682.gd5861c6d90

