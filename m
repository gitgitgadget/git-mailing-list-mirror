Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E90209FD
	for <e@80x24.org>; Thu, 25 May 2017 20:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165436AbdEYUFv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 16:05:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32919 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161618AbdEYUFu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 16:05:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so39780599wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykQacloswLh2YDreKNNHuZUlrBWbu4iwtdD41KXcAz4=;
        b=ZsrV/xCIzQfBj9foe4Eagq2+yr0cqFGb068MrtobM76/MB3YH6+taJgjH7PxgY/X+v
         Tsg5PJJWPlObbTUz5aKvqq06hNzfczD+Jj2+jZFyyAXqouFHnO8XQpkgKgUavEOq1iXi
         cjsT6EdRw1IHvb7TK/y/6TplfVTdndi/2pgfF5jJ4znllipbw5SrWXw+VeUQyEPe60lK
         nwrVJLDjK+cR8Os2s1Ky0MxZ8iMKhgt96oA01a08OC2SKWiVyJiyLkFd+3LKnOpgP3rf
         +wbU77zuaqfkBzeZff6IGJa0wyj0Mm64bTkubZ2kqWaUCODqeSAqQV2yWFFIcPKHaDlc
         cyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykQacloswLh2YDreKNNHuZUlrBWbu4iwtdD41KXcAz4=;
        b=r5YvUXbIiIa+DQBfCMp2w5waY6XwtB5berFizZbh/Faf8OlskQ2T7GPcuMp3n6JTjJ
         IHTLoSuB9cfirs5cPAMXNLplMTTogV9zxvsgziV6EOJrcdjcNYX4kwVelU2mZtoxyzNK
         9ocEnjFwPFwQ/RBHYT6iy/NSFwm/le4xdGGz0Taaxm7XaYps+4LRWluK2dOthExLYF2d
         svs969ccIW4ip7+T+UFViXMW/74Vs+lHuXUGIh8UTj2ZipwQW2asP6J8Q6rupDfkm+bQ
         hdU8QtVfvyvge8VIjDl5b5tTXqr7Tc7G2jgh7AZtrQGGgeQ1Jko6hlJivSl0GM5kVzoK
         sA9Q==
X-Gm-Message-State: AODbwcDc7bGPKp4CdNlZQYRcr4Sv1wMazv/qbVDerp26/xHTLhYOl8U9
        rdIRXXqUcbIX7w==
X-Received: by 10.28.157.209 with SMTP id g200mr10426234wme.34.1495742749541;
        Thu, 25 May 2017 13:05:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r60sm10574313wrb.37.2017.05.25.13.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 13:05:48 -0700 (PDT)
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
Subject: [PATCH v3 2/7] grep: skip pthreads overhead when using one thread
Date:   Thu, 25 May 2017 20:05:23 +0000
Message-Id: <20170525200528.22037-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525200528.22037-1-avarab@gmail.com>
References: <20170525200528.22037-1-avarab@gmail.com>
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

