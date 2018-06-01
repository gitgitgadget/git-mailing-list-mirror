Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9471F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeFAVKi (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:10:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36611 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeFAVKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:10:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so22179342wrm.3
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=qaMpgkPrngQJxnOm0kydO2QF6X4QVGU3rF2qPfW5u8af9IyfuH7XFUfH9ESeL759Og
         JrSIoWXcs+1O+gI06zM8Vi4hwcquaXFtkDiE5eX914k0N9IoBbydmGC5Muh87kwWAmuO
         OCqkfEExGKG8Qn/jHgGz/9jd+1Ry1ovFJiDlsvVKLFngaSRm4mieYsubfbUY7qKsg+42
         /iHYKnQSH7UA7MCu9x7U3Awbjo/d4hGUHcw4QUQQdFX+DGPdEoxlGdzrHe0aie0mLR/P
         KfeXexuQwbbfXN3gGp1+3kuup5TtSsCpbTShdOS+Zcn1xNsoiZ+DVpPe4qgMb62Cm8rq
         ZPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=JDnDVxWQDJxz55hD3Su2LeqgDSpeXckHgSxxIlfn+s4xh9qsNh2UO23skmvZ1G90ck
         D7ZO0fjEXKm8YU7Gi8HfTBolO9pC907Zm/x8Bxa6OxfDjF3uBpBeY1fgXlsptDIES5HY
         NCPGZdpoCRkP8EILDCxYVdBlYGG4ji+rT4/3iiAmNc+REtZ/doP2emkGg/VqKZWnIUfR
         0n+wdc7Ytn0wKetj0buPXw1cTgSi7/S54XDD9ipbPe2V5cuOUVd+hj2TysW/tASzX6Eg
         +XeptxKk7wiYVGvFqSiYGoTZuzCE+abPoMbpgoy2gwv9fHpc4+S6JQPR7A5L0cOxGYnN
         uAZg==
X-Gm-Message-State: ALKqPwdSKc6unquSPTOudEUA8n6sRzrvRHoq53KlE/EehordPVDexfwZ
        sqLYmx5aGwsuWkCjMh5jvuv/4h3X
X-Google-Smtp-Source: ADUXVKK+Ts2LR5TqU+0jeg+HHxWkZo8WSxFHr6vYCB7gwtdWrrE6Utl3Q6UhO/iqOvArpoicv/6HLw==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr9747116wri.124.1527887434077;
        Fri, 01 Jun 2018 14:10:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k126-v6sm3516235wmd.45.2018.06.01.14.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 14:10:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/8] checkout.h: wrap the arguments to unique_tracking_name()
Date:   Fri,  1 Jun 2018 21:10:09 +0000
Message-Id: <20180601211015.11919-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The line was too long already, and will be longer still when a later
change adds another argument.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checkout.h b/checkout.h
index 9980711179..4cd4cd1c23 100644
--- a/checkout.h
+++ b/checkout.h
@@ -8,6 +8,7 @@
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-extern const char *unique_tracking_name(const char *name, struct object_id *oid);
+extern const char *unique_tracking_name(const char *name,
+					struct object_id *oid);
 
 #endif /* CHECKOUT_H */
-- 
2.17.0.290.gded63e768a

