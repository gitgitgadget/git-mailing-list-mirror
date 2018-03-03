Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27981F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeCCPjT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:19 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:42659 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeCCPjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:16 -0500
Received: by mail-wr0-f180.google.com with SMTP id k9so12939242wre.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jZU/xvB9oCpFJ8FG1eTaaKje+Iu9zGjhvXi49mUWLVY=;
        b=OkFimIptlmQ9Qfao+mhAi/WPkeCrVNz+fEL5sVAaN26xNjFJc0q8yKsuWErhpoKrOA
         43CP2LTH24ZFA85IcbatkDeaZCVcQkH/5ecx+s9w0lEvewV3HoH0Bwo305bRZt6xq45x
         M5UA/hTo3YJK2ldEH5XkIOkaKhvB5BMSbgdkyLCGJMQukzXmpwc80Ub3ujMivnkQwq2H
         m8dTH3qtlcNZWLT68yxSFLN3AH1+QSaY4ITt8u1dTpkIZgjwWRgbJOf+RVSUx2ZM7wx2
         BCBgYwgEAaKrRsoL2rngGDJEw68AIc9cGqEhgpex64ayEwJdA2ETyLnOPrco9GirurzO
         kJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jZU/xvB9oCpFJ8FG1eTaaKje+Iu9zGjhvXi49mUWLVY=;
        b=dIDe7vu7EpGIGcs+dD3PzmaVTq3xt6Osvgwexd6uhNO528icjW9tdbWCfgQ+jnlG9m
         YK2fUSXMFh+KuAER9aCCRm41yrzSV4/GRIeLkx3w1U9YIpZV30AGz/TiNTXynomeWI7g
         ef2Bq0Kz5zE4v5na3ngH2gu+37wrB1FejzrdqrP1adHZVwVMqTssGyb8VvQ5VJus3+4z
         xGxNGqOW4+ny61BkqrNM7qmSnN6dVj4IjamZxwEovQ4hMJA21jD2SYoeztfZEWw3a/25
         ljGhX2CWYJVB7Jxha6iwXdjEGYNcsrshp/eZpD867en0Hj7dGRYn0YjosyYVM3wpn+QF
         ByvA==
X-Gm-Message-State: APf1xPCQKbsrAO43OVTXn/PUfaZ9jOddC/7oUW16muHSMpJhhhlcPuMJ
        gSZLvD7QrdYRCvz5b3mM90uR+wJb
X-Google-Smtp-Source: AG47ELsUALXyIqWZ55chPcwnapo3zBMuXTzyHxy8YPSBPkvS1FLYhpHUOkVNA/USGEmcy1EJ2wrbzg==
X-Received: by 10.223.184.147 with SMTP id i19mr7679768wrf.102.1520091554813;
        Sat, 03 Mar 2018 07:39:14 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:13 -0800 (PST)
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
Subject: [PATCH v3 08/13] perl: update our copy of Mail::Address
Date:   Sat,  3 Mar 2018 15:38:12 +0000
Message-Id: <20180303153817.20270-9-avarab@gmail.com>
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

Update our copy of Mail::Address from 2.19 (Aug 22, 2017) to 2.20 (Jan
23, 2018). Like the preceding Error.pm update this is done simply to
keep up-to-date with upstream, and as can be shown from the diff
there's no functional changes.

The updated source was retrieved from
https://fastapi.metacpan.org/source/MARKOV/MailTools-2.20/lib/Mail/Address.pm

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/FromCPAN/Mail/Address.pm | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/Git/FromCPAN/Mail/Address.pm
index 13b2ff7d05..683d490b2b 100644
--- a/perl/Git/FromCPAN/Mail/Address.pm
+++ b/perl/Git/FromCPAN/Mail/Address.pm
@@ -1,10 +1,14 @@
-# Copyrights 1995-2017 by [Mark Overmeer <perl@overmeer.net>].
+# Copyrights 1995-2018 by [Mark Overmeer].
 #  For other contributors see ChangeLog.
 # See the manual pages for details on the licensing terms.
 # Pod stripped from pm file by OODoc 2.02.
+# This code is part of the bundle MailTools.  Meta-POD processed with
+# OODoc into POD and HTML manual-pages.  See README.md for Copyright.
+# Licensed under the same terms as Perl itself.
+
 package Mail::Address;
 use vars '$VERSION';
-$VERSION = '2.19';
+$VERSION = '2.20';
 
 use strict;
 
-- 
2.15.1.424.g9478a66081

