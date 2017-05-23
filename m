Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DE620281
	for <e@80x24.org>; Tue, 23 May 2017 19:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764518AbdEWTZj (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:25:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34178 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764475AbdEWTZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:25:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so41724493wmf.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ykQacloswLh2YDreKNNHuZUlrBWbu4iwtdD41KXcAz4=;
        b=SmFTtmEAJLO/ErC++nPygltG4/tm0UmMi7etc13e/t8U/G8iNHYOpEV2l8OjsmFZ2n
         56BItyI2L6D/0gppNwzTJbQ6JfK7JDDyZkbZ1vfpbHyf8PC9AY31TOJ2rnp8vnm9qfw0
         FaeyXYTLPCkr/OS4JrmiRqzZFFhMKWHAo28yzJKmh7tpZAhSISV7PZyKZi1qlfEg/t/H
         +UdrOShZKLlCwILCTvwC80B/zervIqZvLBTDk1L7n0gBnhggMPCpatofKWvysc1UZmDe
         UEGd1MKZtJqegheLtTQSXDpvyMhaIxzqTRrOdc5bMr6so+4HIr92TA16m4Yvq5hzR87j
         P32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ykQacloswLh2YDreKNNHuZUlrBWbu4iwtdD41KXcAz4=;
        b=qiDKpm3L+j+gP0XD/YZeH+/HDNbeSbcZXxZVdYBidnW7VkSZlCoyoyDE0dix8oQ3cU
         bPCNHcjuFIYVHMqsjHlreid1/DIIFLQ9CUAFsbr8cnnti5qomj9OJmGo5fn/qg154Mql
         fB/9MmPvMe3/qdvNCc/p7YYFIaqiznET6cIxbPSDvdyzRCW1dN5gaHJpREqLpAQVtpTC
         915wTs1pIc4/hfXBl0RJnNi4wdLI40IpAsEdO2kWu841coFvb+0Drfa334mRpfrKLhNf
         ZtGnqMklecklokAuQDxdnAKWMvERqCiEIc49uUdj8FI+ld5bDp0sfxFRcUKDKhJr4TnJ
         o5yA==
X-Gm-Message-State: AODbwcApMOV5u9x+Nv6qGgTdFUcaE+uzd9ws+LioKDdAvvkmz7s6Wn7B
        aK+q8sui8FH10g==
X-Received: by 10.28.208.130 with SMTP id h124mr3657824wmg.21.1495567520989;
        Tue, 23 May 2017 12:25:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a24sm2203480wra.17.2017.05.23.12.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:25:20 -0700 (PDT)
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
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] grep: skip pthreads overhead when using one thread
Date:   Tue, 23 May 2017 19:24:48 +0000
Message-Id: <20170523192453.14172-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170523192453.14172-1-avarab@gmail.com>
References: <20170523192453.14172-1-avarab@gmail.com>
In-Reply-To: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
References: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
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
index 12e62fcbf3..bd008cb100 100644
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

