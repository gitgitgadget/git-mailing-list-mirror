Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530B920D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdFASVS (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36857 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdFASVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id k15so13356037wmh.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h09+9edpFNueJApX/zmHdxbRP8OMzpExmigKEr2YEiU=;
        b=Cgpi7zFkRFuzb/1D1eQBkdj2NbZn6ca2gWvvQg9hVFpUlDhSsO4Q/WKt6eCoeN2cpz
         TG2U4Ci/B+Ggo4fH20uXZhLo2d+nSkAZtH8C0x/5BfLwFIfRA0HY1Grzhcs8oLkLlAD5
         3Om6PZn/LrwVNIsFS9gwKa/U++WH/eNIDGLyBdi1vCqNYA72587lF6dfqUI7yimi5yd0
         WBzt08LiGogFU4ha9F4KoC4fx1R9itdKREqVDBXmoZjeSRNzY5ZGSJyj/J1UcUYBZF5G
         CWQKgjY7p9RaQzklLWi6Hs79aqfXVrW128KPBA+RZJrepPX/MhwJpJ/80qSh4wiR8gGW
         +wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h09+9edpFNueJApX/zmHdxbRP8OMzpExmigKEr2YEiU=;
        b=poA+DamKuzDjOQ/4Vnd6jdRsFJOEKhNfFDu+FkRjLnyeAZmH9U5nYmeFxMtIyqVuso
         a7kqD6IJNxPzpzFfsD7jCkmdI9OdsLBQL3AhBpkEEGxuGwXMquZWrB9GZFQ9LyfXnUKB
         dryR1gUCHO3C0u8BmONNpM81X1ar6WvPfZWv5DkWdR7kXEGo7a8sRYDR6rL9OxdN6IbO
         lMy7dH8QraPofEbJLMHIAI0mq9DRrDEnxw0MlhJ7clhcnoHxV0UOyqBC0xJau4SuX0LX
         iev9C0wLMtKYEGc2GAEhL+NzlH7QCGfBXN4VmbeGMIto/UMqDXWNKceo1aoEnKeLGiiV
         KPHA==
X-Gm-Message-State: AODbwcASODRziKEyE7SeMjdmvWTI1Vb32oBoheQMT+lEr4XbxoVS2Jh0
        zyX/FHM+Fnyfo0euKDZl8Q==
X-Received: by 10.28.84.67 with SMTP id p3mr372557wmi.40.1496341274162;
        Thu, 01 Jun 2017 11:21:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/8] grep: skip pthreads overhead when using one thread
Date:   Thu,  1 Jun 2017 18:20:50 +0000
Message-Id: <20170601182056.31142-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170601182056.31142-1-avarab@gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skip the administrative overhead of using pthreads when only using one
thread. Instead take the non-threaded path which would be taken under
NO_PTHREADS.

The threading support was initially added in commit
5b594f457a ("Threaded grep", 2010-01-25) with a hardcoded compile-time
number of 8 threads. Later the number of threads was made configurable
in commit 89f09dd34e ("grep: add --threads=<num> option and
grep.threads configuration", 2015-12-15).

That change did not add any special handling for --threads=1. Now we
take a slightly faster path by skipping thread handling entirely when
1 thread is requested.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6e1744550c..a0a3922f92 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1238,6 +1238,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		num_threads = GREP_NUM_THREADS_DEFAULT;
 	else if (num_threads < 0)
 		die(_("invalid number of threads specified (%d)"), num_threads);
+	if (num_threads == 1)
+		num_threads = 0;
 #else
 	if (num_threads)
 		warning(_("no threads support, ignoring --threads"));
-- 
2.13.0.303.g4ebf302169

