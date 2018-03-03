Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF201F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeCCPi4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:38:56 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36959 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCCPiz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:38:55 -0500
Received: by mail-wr0-f174.google.com with SMTP id z12so12978747wrg.4
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=knDQcw/4YYGv2KKiSmNCArusf+YvhFPb7mvYz5TKUKk=;
        b=OBscwgo8x6GHOnq1L2HGorrSIO4i23FmBXd/70Xlq55IH+sUWpa5NUqTMcfpSqSn+G
         5iO+tXYAK1zngtBNkpzuRpf/cStZsgVPUGyYGc9qgCXWn0a6ajQjy77nVRsq1QTO5JmQ
         VkwkC/fmzOnfh9swN0+CjsZimwklLNFG47HCahZmH5LDMvJ1x+/s96ardeHdFeo+XDnJ
         uueo/7dKsfvY12UE3ApHPOqmqG3I/SX8zNTuFtyRuty0XgASdgvW2wJSZIyzfHvll7+2
         CItSCHTD9AuGxxakeBWfDSHkE78ns+rmiFWkUCpJ/Q9btBfg+bF7QnabbeOvTgulUtn4
         AF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=knDQcw/4YYGv2KKiSmNCArusf+YvhFPb7mvYz5TKUKk=;
        b=H3i3PySI/k5afRsI+75Q7ryQK4xzwearnLJ0io/DaPIUOBnVYrKvoFc2b5ifXtJKR5
         G6KJrTOsNYQJTT0UjdfhjozGkZo2uL2Zv1pG0pXtZHjy4ay0NXcQD4hAvOemSiaHLrGH
         z1GkDz2yWvTiNmcWn2CohtXq0UBgzjIDytyhiJejJw4gEYIigQVXxMMQoo1d+YoX/YbW
         DqFIuFb4lyAO2kDGllUP9CkAi1H4cI2A3n49JzzYHeCkM3SSACUlUapRMwEMFigvYhZt
         x/BzEoRYE96rzqqkE4XP8ZJqnw5L+y+nX3vjYnBaXR1h5/aR4TPq0itIA6JCy6ocSsV2
         7sLg==
X-Gm-Message-State: APf1xPDFrJM4Cx5TE6vy5l2iwq6jmUWcnfWwBQ6Gf7s7288WkHrX3a27
        4FPRBuD5zoGyiBPFQexY7QvaxIwY
X-Google-Smtp-Source: AG47ELstTMjX2/QOSUsoEXeDsflyuAb0NmTRUaKwc/AVOdb/BQTh9PxYJmB5cLpx0/Mtr3PGz8plFQ==
X-Received: by 10.223.173.163 with SMTP id w32mr8244564wrc.204.1520091533503;
        Sat, 03 Mar 2018 07:38:53 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:38:51 -0800 (PST)
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
Subject: [PATCH v3 01/13] perl: *.pm files should not have the executable bit
Date:   Sat,  3 Mar 2018 15:38:05 +0000
Message-Id: <20180303153817.20270-2-avarab@gmail.com>
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

The Git::Mail::Address file added in bd869f67b9 ("send-email: add and
use a local copy of Mail::Address", 2018-01-05) had the executable bit
set. That bit should not be set for *.pm files. It breaks nothing but
it is redundant and confusing as none of the other files have it and
these files are never executed as stand-alone programs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/Mail/Address.pm | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 perl/Git/Mail/Address.pm

diff --git a/perl/Git/Mail/Address.pm b/perl/Git/Mail/Address.pm
old mode 100755
new mode 100644
-- 
2.15.1.424.g9478a66081

