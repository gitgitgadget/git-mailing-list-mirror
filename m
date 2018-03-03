Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57071F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbeCCPjB (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:01 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36604 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCCPi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:38:59 -0500
Received: by mail-wr0-f193.google.com with SMTP id v111so12961396wrb.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZX1ahtWDOzX7swPTKEa5Ker2JVPDaN0VtjqasD6QGjI=;
        b=ObnyQ1Xl1MALokUG/Z31wjorh/AQ+2U4HTa0LPBsBwrgnrAQ3W7MRu1HWgNWfoM3qL
         XguWmKexMFJQ+fXuW3EX/ZAsCmBPJUrQKVKhLb/miL/HQ7Swsun5m78dbXbVsrnL99H1
         M1S6Qn+hgpt9+UAnhlGYV++28jFvzMT8f0GjjGJXGIk2LKRyOlfDosQywvVql7HkNmeJ
         x5h94qpJPJAiaSrqDEpQcSjH09ubgJ/jEO429LzgMuskRRzVeol7us2Tni8ksJC5uPY8
         FLV+olhH8I3+Oxnthf8AlsgIDLi5Lk9Gy8EkTAUtR3UpxT6HwONC4tpj8i80uhF7FUEg
         95IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZX1ahtWDOzX7swPTKEa5Ker2JVPDaN0VtjqasD6QGjI=;
        b=gK2duCm+0x3GaxsoW7ivXhfrZqzg/G7Y8BA7UpCa8QOKMK1ZPrLzLh31QItZkdp/7D
         vMAKGOQyz9jUVCI7W4lMzw3/5MrqGK7SftzHomD9HFRFTrGcwEJuFmAxjz1JWc5zb9UG
         qGWGvPeGZOTE01pYTM97mjzKAIIvClDCbAX8xuQUMWqpPgqWtaejdhb/4xwaQVnG2+Ja
         20xk/urvqvpxUt64duXjIHRsEbdz4p+bd7h3iJJ6WLyBJpB3hu4mBJnZ3839CavzxPBu
         ZTbxFFRkmkU5KZmfiRBPnCRrcyTmQ+f4IrXSNAtPFxkoYt8YeM62gacY4gaFaGQMB36m
         naUA==
X-Gm-Message-State: APf1xPA3nW49M1uS9rC731OB2nI+NYH5Z9/6PTxQkxFBIUEtb+KTFQz1
        lU/99piITznMj9FaKhdHp3gqeYgv
X-Google-Smtp-Source: AG47ELuh6vvI4epgBpRMweDzhtUF+0Xrv8hxORyxQcOZl3jZvgItB/OdNCwrLqApdid4g6gX/5R0gQ==
X-Received: by 10.223.195.147 with SMTP id p19mr8309842wrf.224.1520091537495;
        Sat, 03 Mar 2018 07:38:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:38:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/13] Git.pm: remove redundant "use strict" from sub-package
Date:   Sat,  3 Mar 2018 15:38:06 +0000
Message-Id: <20180303153817.20270-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180303153817.20270-1-avarab@gmail.com>
References: <20180303153817.20270-1-avarab@gmail.com>
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Perl the "use strict/warnings" pragmas are lexical, thus there's no
reason to do:

    package Foo;
    use strict;
    package Bar;
    use strict;
    $x = 5;

To satisfy the desire that the undeclared $x variable will be spotted
at compile-time. It's enough to include the first "use strict".

This functionally changes nothing, but makes a subsequent change where
"use warnings" will be added to Git.pm less confusing and less
verbose, since as with "strict" we'll only need to do that at the top
of the file.

Changes code initially added in a6065b548f ("Git.pm: Try to support
ActiveState output pipe", 2006-06-25).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm | 1 -
 1 file changed, 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 9d60d7948b..99e5d943af 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1692,7 +1692,6 @@ sub DESTROY {
 # Pipe implementation for ActiveState Perl.
 
 package Git::activestate_pipe;
-use strict;
 
 sub TIEHANDLE {
 	my ($class, @params) = @_;
-- 
2.15.1.424.g9478a66081

