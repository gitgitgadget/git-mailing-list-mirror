Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4988C1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 13:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbeCKN03 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 09:26:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45595 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeCKN00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 09:26:26 -0400
Received: by mail-wr0-f193.google.com with SMTP id h2so5792945wre.12
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rT3TTNerzZEzjMWVlB1hHHVun5yH4FtUGzNQrn/24Hc=;
        b=J1rPMP2FKoUxNklfkRhx8lVB1jrCcH/jY41bgyf/6rSu8zfRRhxyY+reje6SDeX7d0
         dh7uD5AUooqxCT2Hx3c/Kwmrt42KvZpL01NvkyjXB67kDB1sWOGyTWAyE5H0nRQV7yNA
         uLncVRSFIaoRChS/+1BjA2jy3wkAB8PFMtD9mBL5Im2YdVYndcGCI1VB3jyTOZnV3aoY
         C8Lz3C0SsSWnzZ2F8SgC/sZEqx1fjkVIEGfrNZB8AyEVugHkAghqY73+PMJIpklURvZ6
         PVfdGBWvZk2a4lz/Zu2kuYB0NVM+B7lpEZ5WgO2EJcGuMQiqTjdw3nY5YsekwqMJpnr3
         qXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rT3TTNerzZEzjMWVlB1hHHVun5yH4FtUGzNQrn/24Hc=;
        b=IXqb1jNeV8f+enyUg+N2GxwMsIlhAV1ca/ahNvZ33MGnzQL5lE2/h1lMIFpxvw9xhD
         Ol7H+9uQfj1XdMcq6khaImTp3tCmiPbn1rou75WOqs3U6v1jq/Jq1I6OkRgQIuSfyeV2
         1432kFvANPj5BVcLmWi3Kd8b9VPX7uEizLDPQFLTptgDw1h9zH+kvYNWx95R2hhZvNwe
         yc5WBDoFM0KA4x1gsfDZgn7aJjDGzyCy4kyR82LPbAC6iDGolxN1yKm9fWhMLbFrpONL
         Xl6jlr5ARFgqkWtKP58KEzlwXW9KKJ02OuM1vXXJs/BsKRlgfJEs+WzvPyIa6C3hH6Ex
         9vLQ==
X-Gm-Message-State: AElRT7GTQWrI19hTWXwMk+KcKd2EohJ/yNLFd/REbmU7ZmCKHaXvo+de
        QCt5fhsa1xTOCAwqaXvGbSLiOYeC
X-Google-Smtp-Source: AG47ELsiNoidL/J6sGeoiRUnWpoKAhNARx5i8ocANHNmCqaNdi6lIeQSbPWqhivma/jGr1dnLGb2Eg==
X-Received: by 10.223.196.211 with SMTP id o19mr3666964wrf.256.1520774785200;
        Sun, 11 Mar 2018 06:26:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d23sm3868563wma.20.2018.03.11.06.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 06:26:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] configure: detect redundant --with-libpcre & --with-libpcre1
Date:   Sun, 11 Mar 2018 13:26:08 +0000
Message-Id: <20180311132609.32154-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180311132609.32154-1-avarab@gmail.com>
References: <20180311132609.32154-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --with-libpcre option is a synonym for the --with-libpcre1 flag,
but the configure script allowed for redundantly specifying both.

Nothing broke as a result of this, but it's confusing, so let's
disallow it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index 41ceb2ac81..d1b3b143c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -280,6 +280,10 @@ AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre1]),
 AC_ARG_WITH(libpcre1,
 AS_HELP_STRING([--with-libpcre1],[support Perl-compatible regexes via libpcre1 (default is NO)])
 AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
+    if test -n "$USE_LIBPCRE1"; then
+        AC_MSG_ERROR([Only supply one of --with-libpcre or its synonym --with-libpcre1!])
+    fi
+
     if test "$withval" = "no"; then
 	USE_LIBPCRE1=
     elif test "$withval" = "yes"; then
-- 
2.15.1.424.g9478a66081

