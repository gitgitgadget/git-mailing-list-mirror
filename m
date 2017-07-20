Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CCB1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 14:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755503AbdGTOTn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 10:19:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38262 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755495AbdGTOTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 10:19:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id 143so3708833wmu.5
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5RAxJsQwmXx/yzfGv0hyh6kDI0oddVBpR6GGTms4NeE=;
        b=jn+TvjYNmt+IgvIp1UsJ3JrAL85u0ahpTsMVJIVJWWSaBYD4ChyZotIugTBZHn3oOr
         FtTUQCQLEWKwwApzQ408QUTWU1tjXPfWXtnaW2mboKZ+jErQIpi1J4Sk1hJtAmJfKCaQ
         8ab8RxL+CKQJg3vHWA1LYtDPgRjWg4r78K54Jtlwgkrr6f0/kgrjfZhij+PrlH94tzi/
         83vc4cmee0M6DzflStmh4xRGGVLy1yM/Fd5aCXiuUYQUmmaF18o5DOnTg/PjNv0PZd8v
         GY60L0/15TgeXuIRJ8MXyRpsV5e9D1KOtxdvO/nLE1jyzll9/+JQhSMbhdcsLhwU9xWY
         KTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5RAxJsQwmXx/yzfGv0hyh6kDI0oddVBpR6GGTms4NeE=;
        b=pa5eixXG3d6412X0A0mA5LUkarRTiMNSgdiDajNdGZE9YjQyFBaMuEfjayHTQy9Iwg
         JxsnwrV8whGKbhs6ZSf/gsp8V3NKwhcJahgg8HwKaSnwjACN6ASgHlKJhxgBMrHi1efN
         KoE12QY33o1XGC2XIu1GqEudklyk2t7XwmNhUBHrmC6k6dSabDq8U4ZqWs/yAhBRYBYQ
         6pGOXdGwFQYsr9U23h14fdz+1k9+kemCvS8B9ZM5rAypO+yAifog69GzZxaTP0ZS52+q
         E8JfJogf0i0u1cWCfkK72yrOYnEQNu22rzqDZly8dcM7hr53+sfDR60+uLLMiH1DLJHY
         93Ug==
X-Gm-Message-State: AIVw110bAW1z6pRdN5XPff1QZMAQx/zpAe/AlS5hyHkoa+auFa2ZeWW7
        5OIi37mD0lRRB+91o2I=
X-Received: by 10.80.160.198 with SMTP id 64mr3078832edo.177.1500560380683;
        Thu, 20 Jul 2017 07:19:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l24sm1630566eda.11.2017.07.20.07.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 07:19:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] RelNotes: mention "log: add -P as a synonym for --perl-regexp"
Date:   Thu, 20 Jul 2017 14:19:22 +0000
Message-Id: <20170720141927.18274-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170720141927.18274-1-avarab@gmail.com>
References: <20170720141927.18274-1-avarab@gmail.com>
In-Reply-To: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To inform users that they can use the short form now. See
7531a2dd87 ("log: add -P as a synonym for --perl-regexp", 2017-05-25).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.14.0.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index 2f3879fe96..9a4c2bb649 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -117,6 +117,8 @@ UI, Workflows & Features
  * "git pull --rebase --recurse-submodules" learns to rebase the
    branch in the submodules to an updated base.
 
+ * "git log" learned -P as a synonym for --perl-regexp, "git grep"
+   already had such a synonym.
 
 Performance, Internal Implementation, Development Support etc.
 
-- 
2.13.2.932.g7449e964c

