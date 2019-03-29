Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809C820248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfC2KkQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36059 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfC2KkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so878136pff.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnYB6iu7qRo2kM7KTEoS+sORCX0d28Pcjp28Komxn3c=;
        b=WiuXsYx6bziS3tvq3ns6r9B3KPQ+rwKW69P9D4kpAF0av0xv6zzMEnY1MXzyRD92P8
         GGDRMOb7L1G+kmJlVkx7v+jwCm0/SG1uc/7VZLQU4iAhngXxwvuFsqI1HdvuTu3a6h+w
         T0KItP2iYWehtDhaRhi/Gcd4bR5KqdnnFmb5vZym51WfgkOqVd7Z9rfSXrIX7mSIQk3S
         m3cWqkv20YEX0uA2Zezk4KY9tKH9BW0Ip3j/SYxscn3NqKIOsNIWSAmlCtjn7jInRyqK
         OUE1ughsWhGtz+na5hTufb6xoRof2hK0RBFmWUU2UNaWCG+5CmHAeYSY+Xm3uDz6FaIg
         pxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnYB6iu7qRo2kM7KTEoS+sORCX0d28Pcjp28Komxn3c=;
        b=GeHInEyOzZJ4KWHHj1ApWpIylG5bY/IYroATFAEBBpIPUcnN5lzjoSWhjajtkwPMh8
         XprC2qPAQ/psisBUqfqli/zg7PY6LNi7xQ6ayMeFPaCtkv987rS7JwO9P1jpiqz/XO4o
         2jEWCrdGaVhaVKAZooMKIihGLdOQC0O1TfJBbItVNsJ9Q9L5VBMZB/e2aH1KvTSReO4o
         SVp2SbHtsfLlTvFC0vxVt9VaGU2P3yg1oNwfL2GyDAkocVrDpCOQY8nEqJfGPVvcmyT3
         r3WGUmvXiE8yQT1yyJPxSrtMIdRgmStnV3Igi7WOm+gl0QRbDcgaVDR1m6jTVBLR7I+k
         JiCg==
X-Gm-Message-State: APjAAAXgsXQas+wytBaiKINjKI10dbF/sNaeZAGloeVwz4FdU/Jjbxgi
        3Pz5cdkWxIRmTB+vunFNAmg=
X-Google-Smtp-Source: APXvYqy2Yb9r51EFWgqv0kXsE9MaffmkVSjqtyoHkzMe6thm7SvOTQ37kZ/nTIdWpv0fBkGoHtAL6Q==
X-Received: by 2002:a63:cc0a:: with SMTP id x10mr32361599pgf.179.1553856015680;
        Fri, 29 Mar 2019 03:40:15 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id 4sm1969720pgx.68.2019.03.29.03.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:40:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 05/27] t: rename t2014-switch.sh to t2014-checkout-switch.sh
Date:   Fri, 29 Mar 2019 17:38:57 +0700
Message-Id: <20190329103919.15642-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
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

diff --git a/t/t2014-switch.sh b/t/t2014-checkout-switch.sh
similarity index 100%
rename from t/t2014-switch.sh
rename to t/t2014-checkout-switch.sh
-- 
2.21.0.479.g47ac719cd3

