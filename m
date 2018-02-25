Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7D91F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeBYTq6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:46:58 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41843 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeBYTqz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:46:55 -0500
Received: by mail-wr0-f196.google.com with SMTP id f14so19057566wre.8
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZX1ahtWDOzX7swPTKEa5Ker2JVPDaN0VtjqasD6QGjI=;
        b=Ntpzou+Y9cYvYqKYNkUvIHGmasbp3E7D6yklJTVkfkXcwIVhlNYqFq6uvKclBic1FV
         kpK4a7TMhJwMjNvKKrzY/r04XW2oRNRAkTr+uwxz5/Y/Yhr2meAQpEHhoMlyXFUuMDuu
         9mPyYDaVmb3Rv4yV++m1GRgZ8UYqavOxoj7NHH7V/URrXmuKj2Ya+s4jVoGLPwm1Jp9u
         d/QQPYv4ROgC/eP4scHavxxIycBQHZ0/VzTt9UWgP4Kb8YY3K7uGII/wuFl13SYF7l79
         xRMA5OILvh0PFsty+lGTC+Few2NF/ToSP5Bmg1o/MEQB8N5WaJpOcKXzUKWmo9Fhhqx0
         z6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZX1ahtWDOzX7swPTKEa5Ker2JVPDaN0VtjqasD6QGjI=;
        b=g9BrD+6eY+WdkEUtF/80v1YyYwmk6U2BEvRGHKI5w9RxkFEACXT/YeMQwKAEUGtE0c
         87np6Xk1nYDEOJdb7gTzkv63B0xzH52PZuL2N7bK6ZRU7dys6Flp+ADyHmJ/GxEHAx7z
         ZLIQhY94EV+w9A6/76oEwN8eYxKRjHOU0gjpD3Ns0IPr8RC1ZVyG5T4kIPLLzMxV/AzI
         crKVYSDI4D84HyyScUAphjWlCl4/eN/Twv/tbY0ZyhYMI92ncyYocd7kPZBzMcLRApmX
         4g+/MXrzWEgI8Hg33gHXeY7H4SgpiJLv9dwRFi+pOOlnxp6POYnrx0pTpkmEY2dmLuRk
         /D6g==
X-Gm-Message-State: APf1xPACbhkVwuPJP0qZwwOeKjHQmo9KQeSzUZtTeFAq576uDJpjplvA
        zR9iMD+8fm19Cc4Y7lBcRzc4NXMJ
X-Google-Smtp-Source: AG47ELvuTJjV/QBcv7M4FjjA6n/Dbjkyaf7rsM8zzjcpaCIrcbDYSdu6AVA58RvY9LEJZbMkDPDuTQ==
X-Received: by 10.223.134.121 with SMTP id 54mr1568181wrw.59.1519588013429;
        Sun, 25 Feb 2018 11:46:53 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:46:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/13] Git.pm: remove redundant "use strict" from sub-package
Date:   Sun, 25 Feb 2018 19:46:26 +0000
Message-Id: <20180225194637.18630-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
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

