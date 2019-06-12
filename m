Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08ABD1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437905AbfFLO36 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 10:29:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42710 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437399AbfFLO34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 10:29:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so1876892wrl.9
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfgQnNNrkJX+V1K3+TBX15teqBDu/xozHSZkvUqQuXk=;
        b=b7aYUSUAKIQTcRSJNR49o+Uh0QdUeE/c0DwAa65cUBga3bsUDFb1ghUY6+97F3n2fh
         25MLVbxtRBCJ0hxaVyT1mwBZ3eVzBqQgb9eWbeLIRX3tZq3NtsPiNXSwe+xMcFxd7wiI
         Od6Pmh9Z7fE2aPTz2160MglOB7qhh7XaYEgvHymwfZ0rNQfabIE/wjnFGcmT+LXIksvZ
         sq+2X34omojwO1el3nvSDKCT2T+x+m55Pb5CSshP9N/o9qDVJNhWj73p2JaCSaSLy/fG
         bwU3xTnAFKq2a1wNTutI1xRR7kYd5htWOvHKcnEndTAHRL60a0QKJas6F7NlOaJgCxHW
         TsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfgQnNNrkJX+V1K3+TBX15teqBDu/xozHSZkvUqQuXk=;
        b=qBf9CXYYnLka88zNMuJhQzPvGTs9ocdf3+UzSmC4S4j7ES3f3zNwrf6UD7REzbBMfv
         8cIHuXE2f99kP/+bIIV8m07I6nvhTIN+qZIn/3aOfZtQhHCURIN9CHfks7MWKTIKs/tW
         fm4eAduj69KcGqqOLlixSkLArGocxipWzsEoor7k9VevggNBk4BK+Ty2rEKVZrKwUKhm
         0Xz9gKpVUP7tECbYKYgzf9yS6x6M+oUM0FvlTISFhRt12ZgXOzTK1+3rk0V+D5lCVIAO
         fKTepwYZqS+1pAdpylgHD4StTogg7jTi7IUcmFWTrfjo8LDvSpM4DVcROou/CE2Tj4LV
         l0og==
X-Gm-Message-State: APjAAAXenNoSJk4SIoyldb1Sg/hxeJUoJcSE9zdmDh56M6FvTFqFIvH6
        LBgMfAjyRwJ9mxzlguIIOKwcfjZ0
X-Google-Smtp-Source: APXvYqyzVfGTe5ZMTUvw/mz2Lnoil9owFq5/vyGm5++FfjsALFtt+xZ/r3CftlC7He3jKFbQBYl0sQ==
X-Received: by 2002:a5d:6acd:: with SMTP id u13mr9035860wrw.154.1560349794799;
        Wed, 12 Jun 2019 07:29:54 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm195269wmh.18.2019.06.12.07.29.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:29:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Revert "test-lib: whitelist GIT_TR2_* in the environment"
Date:   Wed, 12 Jun 2019 16:29:41 +0200
Message-Id: <20190612142941.22056-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244
In-Reply-To: <20190519144309.9597-1-szeder.dev@gmail.com>
References: <20190519144309.9597-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts my commit c1ee5796dc ("test-lib: whitelist GIT_TR2_* in
the environment", 2019-03-30), which is now redundant.

Since e4b75d6a1d ("trace2: rename environment variables to
GIT_TRACE2*", 2019-05-19) the GIT_TRACE2* variables match the existing
GIT_TRACE* pattern added in 95a1d12e9b ("tests: scrub environment of
GIT_* variables", 2011-03-15), so we no longer need to list TR2 here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 599fd70e14..57f7c30377 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -386,7 +386,6 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
 		TRACE
-		TR2_
 		DEBUG
 		TEST
 		.*_TEST
-- 
2.22.0.rc1.257.g3120a18244

