Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7511E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 10:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeKNUtU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 15:49:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeKNUtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 15:49:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so16737604wrr.0
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 02:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2GisaVi1Z+GUs5RhqGpGvI39YAo46R7li0KGcY/9DI=;
        b=gzRtmBUvnGtTPCSmpzlWorjmH7iveIdDNsPjZJlPy/mpttLsKc4CZpaoCRs7J+tDHf
         f71tUL8dmqcJlS7oWYMxnJmyCASoYCdTDWcM90nLNbgmyf7T5RNspY9PByYopk8hQrt+
         tgyrqYB4g1cZm+bts1acz2i8Zrk1BSwI2v8Q0EKQM34s++xnQAaT7/QmcsRuYRC3y2u2
         wvimN6R8awLaiziO2Mg095xTzfPYSNCrgEwppGJtCe7DwAlohy0rBTsJmhLYeMe5dmjb
         IVamLHAlgoh+piF1MpjkW7t4ENSjJIhXuOo3bs6KAr9sUyne8OKM9213PHWC5btVm3zY
         fmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2GisaVi1Z+GUs5RhqGpGvI39YAo46R7li0KGcY/9DI=;
        b=WQONi3tE4uw4S9Hx78BgBCjwqFlye1rU9pu6BDGNS2voquNAtxm3gJUhdAXqCnX5e3
         AWXCk0WyPkFg3cOZDuqKsDf75395IgU6aVkCqth5SdMwj8u+VTe6a35mXSYhFM1UiUJY
         Dhbmfvx9Pz/ZdMVcY6sy1Ne0e5t74ZWcqIAr17TEy1OyCoT4tn9aUQESUaxvdT9EH/ME
         vZXF77MgvvtXNkrhIQIM/AsAzsdQERyMGFOWFAq8e8a4bN92wGaoI5d2cfOm1LaEG/P9
         8pU64ZF7DkXl52Dl4i3sJhef4qT9a+9bno6oK0m1LOkHK1y6CU8jdNP55EYDRS2JAyqj
         DjHw==
X-Gm-Message-State: AGRZ1gImrj9bSJBHpfD+tqCXmwDNtgJwFNWnOcMnySuLgHWpYncTq35u
        CAzc+XTqlyOrndvKl8tVXMo=
X-Google-Smtp-Source: AJdET5d7KnjUdpf+NstoxGGN/0gsX/1zWPWL6+WBzjUBjDA5/rjpfNVTPh9yyyK79/iRgyzbz77PYw==
X-Received: by 2002:adf:b6a8:: with SMTP id j40-v6mr1277309wre.55.1542192396317;
        Wed, 14 Nov 2018 02:46:36 -0800 (PST)
Received: from localhost.localdomain (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id p188-v6sm11274079wmp.31.2018.11.14.02.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 02:46:35 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] Documentation/clone: document ignored configuration variables
Date:   Wed, 14 Nov 2018 11:46:20 +0100
Message-Id: <20181114104620.32478-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.gbfcc7ed3e6
In-Reply-To: <20181114104620.32478-1-szeder.dev@gmail.com>
References: <20181114104620.32478-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to limitations in the current implementation, some configuration
variables specified via 'git clone -c var=val' (or 'git -c var=val
clone') are ignored during the initial fetch and checkout.

Let the users know which configuration variables are known to be
ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
documentation of 'git clone -c', along with hints to use the options
'--mirror' and '--no-tags' instead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-clone.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index a55536f0bf..2fd12524f9 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -189,6 +189,12 @@ objects from the source repository into a pack in the cloned repository.
 	values are given for the same key, each value will be written to
 	the config file. This makes it safe, for example, to add
 	additional fetch refspecs to the origin remote.
++
+Due to limitations of the current implementation, some configuration
+variables do not take effect until after the initial fetch and checkout.
+Configuration variables known to not take effect are:
+`remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
+corresponding `--mirror` and `--no-tags` options instead.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-- 
2.19.1.1182.gbfcc7ed3e6

