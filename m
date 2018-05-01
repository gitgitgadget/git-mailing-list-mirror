Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3355C215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbeEAMHZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52107 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbeEAMHX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4so17475107wme.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oD/yQIKEPHO6sC/z/WLfExbMajfxTU4lrQ5Ts2mGSig=;
        b=EL+tqu+D5Zuv+EUIEenXH4uRtDdywJbb8oOtkc6AHB4hljo/LE7oUFX3rvA+HA9hw3
         xTu9uT0gG1FncEhUrKtcw8wejEHGcO5DVoF+BP/f6If6q2+UaHtYUTdN+4C9Djd5daFe
         htotgFHnGzEg+WhwDJrPxavu8PBmidPaHdKI/62RlIo4Vi1CGys7dzNnu4Grzl7sAjsg
         i97VRQ69nSPiU3AtiqqWP2KPuu3mjCRJLhlKMAB7DGU3t7LV6n9zAKIHBRwksJ1pQRNA
         b7zcbVxJbAoEG3xphCIKK0btBBaFL/pu3iftdmbTLM9wGuXru9ozUE2mjiV5kCSTlmnw
         tv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oD/yQIKEPHO6sC/z/WLfExbMajfxTU4lrQ5Ts2mGSig=;
        b=OrSY/4zZnjXLUeK5vpRGjq1FX5LqpBDW/eekj608a14Kub7UPGE2rY5gOyaJ9QwTRb
         yjrOI0L5eLYMZLPxBnuQxmgBoVJA+UpDBbZKr5tuKJ3JENLPyt7E1vmYhz9J87CwI7+6
         EzA2EOcxoMvrb9WtCms3/xQRpF3zuAo+ZZwgY5D6MEprgPzQ4ldLFu7XiXlmB6M2909z
         qnbxRAakLPbsOirs0vJ4fj5Yg6iOr1dlwhOB1JAFdwQP0X/jPyBMCEiDRdG2wQMy6LvI
         i5BvL/x/kDms4hnDV/JL800w/Eal+TZ/tjiKaZngX6AJRLYKX1+ZzxWPX/0v/dLn3PwQ
         yb/A==
X-Gm-Message-State: ALQs6tA7XA+H6FUG58mJvQJtoG8+m6BCH+kgEqG54WIBkMFZfdAopKkp
        PY52OcNlJR1sxcmFOkTkwQuZpbIp
X-Google-Smtp-Source: AB8JxZrskilMJWk9Tc6P4ptuHAusM/0PzOM8ERNmnJzir+c/XvdjHaq4sJO9su90djSp6afy/ZZjLA==
X-Received: by 10.28.155.206 with SMTP id d197mr9548748wme.44.1525176442380;
        Tue, 01 May 2018 05:07:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/12] sha1-array.h: align function arguments
Date:   Tue,  1 May 2018 12:06:41 +0000
Message-Id: <20180501120651.15886-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The arguments weren't lined up with the opening parenthesis. Fixes up
code added in cff38a5e11 ("receive-pack: eliminate duplicate .have
refs", 2011-05-19).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-array.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1-array.h b/sha1-array.h
index 04b0756334..1e1d24b009 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -17,7 +17,7 @@ void oid_array_clear(struct oid_array *array);
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
 int oid_array_for_each_unique(struct oid_array *array,
-			       for_each_oid_fn fn,
-			       void *data);
+			      for_each_oid_fn fn,
+			      void *data);
 
 #endif /* SHA1_ARRAY_H */
-- 
2.17.0.290.gded63e768a

