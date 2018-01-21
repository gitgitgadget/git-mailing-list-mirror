Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D57F1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756782AbeAUADg (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37642 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeAUADd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so10194690wmv.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PCR2gIkwChHUheuuCU0tW0teeyQsRQVAIS43VywTn64=;
        b=dRXswVTEyfQx7licaez98JDFqCbKDKxDPw/S2MgkVM8NgEoKUIvm9P00LmOiXgfXQP
         vfHXpuI1KOjU3LurGgqzavrJtVAfC9Pc9So82QM9VAr53cu/0Thp0gEjkpPyfbGlwOfP
         aR5UhGr78ewqGkghGre5Kl2ALzblI2u85MStEQYh63YjMz7mLpNBACEvnRKtB8CVFkQe
         JNTmC/iMoEKcnpHS2KHc1FdBR6ZztHu46Yvdlm3tW0XPc7c62RiH/THx1/ARbEF5dOdJ
         VXvAg+Wwx6h1tS+PX0otR5+7pMRbnxaE7Qpe17ST7NpY2fL9fSxNPbc3WfiylQHgBkw0
         9KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PCR2gIkwChHUheuuCU0tW0teeyQsRQVAIS43VywTn64=;
        b=esDlIbAspS6WHMxBMeO4C7reBlptZu3qTcB/5EoHxwhZYdDAvKYFsFodJ/Sgu6hImv
         pwsI4OGTHV6kYKxNUeNCdBjBHt58xKHyfqClZJDCBBhw8ReNyp8y6NLXEhDWVKwitCHH
         UQKdVLJY1XT20kh3luYR2+EKn+rPgeMNShyLZ7KS+IRUywbxyhkEVenJKUF2yowvFL8K
         1MOdq9AWsdaZWXFSwwI7dXQIICKvCxa0Rb3qW+3VvyDcycbTk7M9s4iVCB9x6ny5HVjQ
         Om9HdNDzOViT+5WNed9ISh1NHjnvp9WREgp4764UDaasAk8CT8H3lsI+zM97D/dUlLBH
         xH8w==
X-Gm-Message-State: AKwxytcD7w069YAIVspYCjiZY+SvsaQoSwGx52TeLWO6SMDGI8a7szUc
        l9PHuE/uyPuOWGaXAyLeeWbNfc8v
X-Google-Smtp-Source: AH8x227sPM4OlfirUlzKZaGIBUcdql3VBteX4TwfaCu9dhPC2BQwmVDMlRYW7P4eRY6TjKSZrj7iaw==
X-Received: by 10.28.241.14 with SMTP id p14mr1831241wmh.20.1516493011516;
        Sat, 20 Jan 2018 16:03:31 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/12] fetch tests: double quote a variable for interpolation
Date:   Sun, 21 Jan 2018 00:02:56 +0000
Message-Id: <20180121000304.32323-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the $cmdline variable contains multiple arguments they won't be
interpolated correctly since the body of the test is single quoted. I
don't know what part of test-lib.sh is expanding variables within
single-quoted strings, but interpolating this inline is the desired
behavior here.

This will be used in a subsequent commit to pass more than one
variable to git-fetch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index fad65bd885..542eb53a99 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -578,7 +578,7 @@ test_configured_prune () {
 			set_config_tristate fetch.prune $fetch_prune &&
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
 
-			git fetch $cmdline &&
+			git fetch '"$cmdline"' &&
 			case "$expected_branch" in
 			pruned)
 				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
-- 
2.15.1.424.g9478a66081

