Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FDF1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbeAUADy (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44398 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeAUADs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id t74so9939351wme.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lpbif+mFeoIDH1s4HhI6FotapcRS84bl01lmLsZHXmw=;
        b=MeiCTZ4lZ0TuNCQdg3iA40JJXIkOMPvDFOEOfP+m6v2dbbT8htWcQitXpvtZxJk+E2
         ARtgQlMx5pfEa1DsM3CbOWdjiscCxL0WMzX552AkNeMaTLc2EvAw+fLDZIKLjwTkbXc1
         3ITRxAQldTZSDglO8nhfoFlDYc6Rvs0pvmfm7dQH0BTYhRhLydjTLeVYbm/rCuu7EjtE
         ZO8mOgJwACuwOD0+CGAWaBmHD2AYLRjv5YYnCRdtjE+sHpqhn2JFuYFhbKSCEdT7lRzg
         jICn46boqu+gTG34cFUrNVcGnnzJ2tDSOyN1ymVKj9WDejYEpNE7kAlq41PQ5hWjgYn/
         HbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lpbif+mFeoIDH1s4HhI6FotapcRS84bl01lmLsZHXmw=;
        b=BhG95OrGVdD+DLtfjxd1SmCauSw8o7qHsn7+YYx4vx5gHwEDr28Cr8QIgRnnuu0T+M
         GHvrxA8WqHIyOSIHKU5yukjd+ocKhx4hERSkdWSvnvlnOOlLp1qliaCKQm8cncJ4wk/4
         BIhxBRe21J/Hzvp/eUrTDTB6UUp7fDzwOkEieflNkgejW5IqguPIXA1gS5X+AGWarwPM
         GyoOJ6vo8PiASDGm8JWBJaayGC4dggxZC8k5Zs2Hle/l5oWDVnBlByUMmk9HcrLRhLiM
         i+Zi2ysEAxpOXtbi3dkX0tm0OhqKIZdKKWE4ylXFn7JHTqbCZZ/cJsfaxcPsr7HYjrlW
         6RtA==
X-Gm-Message-State: AKwxytchnrv3BUVSi0Llh8UqvGR5caGU8dR9LY4JYWgkbG20GLOkuyMQ
        xMQmMEH8Zt8vIL0T1st0Z+KMKyRJ
X-Google-Smtp-Source: AH8x226s+pbfrNVMkEkjojphiNj6hmF67uksrY0wjP8NttY9TiyGr0qQlQ5zYot/eKSpvpPd7rIt+A==
X-Received: by 10.28.192.24 with SMTP id q24mr2020869wmf.96.1516493026705;
        Sat, 20 Jan 2018 16:03:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:45 -0800 (PST)
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
Subject: [PATCH v2 09/12] fetch: don't redundantly NULL something calloc() gave us
Date:   Sun, 21 Jan 2018 00:03:01 +0000
Message-Id: <20180121000304.32323-10-avarab@gmail.com>
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

Stop redundantly NULL-ing the last element of the refs structure,
which was retrieved via calloc(), and is thus guaranteed to be
pre-NULL'd.

This code dates back to b888d61c83 ("Make fetch a builtin",
2007-09-10), where wasn't any reason to do this back then either, it's
just something left over from when git-fetch was initially introduced.

The initial motivation for this change was to make a subsequent change
which'll also modify the refs variable smaller, since it won't have to
copy this redundant "NULL the last + 1 item" pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..b34665db9e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1302,7 +1302,6 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 			} else
 				refs[j++] = argv[i];
 		}
-		refs[j] = NULL;
 		ref_nr = j;
 	}
 
-- 
2.15.1.424.g9478a66081

