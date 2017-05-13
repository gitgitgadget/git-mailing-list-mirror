Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5677A20188
	for <e@80x24.org>; Sat, 13 May 2017 23:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756164AbdEMXqF (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:46:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35229 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755689AbdEMXqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:46:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id r58so11266851qtb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWClpfI4rKACf9bPthBhb/ElgzdCADEsAPds6SfkLqQ=;
        b=LRin61tC8Xh8brW6dHzvMu9/9BS6JbAe7uRaqhaaqBDQRhRMUtFQsd2EDCQOqPBeTQ
         ATyxqxbXj/eDG8rSbma+KIBFNT4ah35KF4dJpUrZyss2m76xP3WLQArhfohC3U+STgmS
         aiEIhjzNN7WeQJ2R6wyPy+NHtbVwJp0o3szmR9aa8lrWDo4WhAsplRaR+vuxjDKxgV1h
         dokhaoAVLfMH4mQBZ+MbXQAC8zMXDYdt1n+82AODzFSPnQ3AeZ9lfHtjAmNHKvRvKx4/
         2bMyTK1doQy1pX3rHgjjF7OgLVuFOmmOZ/AqG3d5ctRfj1w9B5MWx2Lq980P92qpSbEY
         nqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWClpfI4rKACf9bPthBhb/ElgzdCADEsAPds6SfkLqQ=;
        b=sJTKKCMzrsdhwxxCFX9csmsUAoBkcXxGItd1NkV0jlPtcVR5EEBILKgSajmRKMzQsI
         1LQpfdsrHFSaNEp3Q+bPiXEHGrzPP1Tzgj53c8zh1TkDpFRE3Soh3Y83yOEz3OkSnCh1
         e4My/VbofWN9y+Y5TN5+f8Wz7ZaGOOXTgrx3PRE6xMqbiOkVYOBnFgibidMkcP7T4mII
         bx5/+9iPic9mkrXWNtc7x3IXVXsuX7yzqt0aeM8IWxz9ACVD/hItJ4I9Z4hqwrGRmRIM
         IGOrqHZA9rfcE8Kj0JVNPrsj9KjBxSCpV5+2ambtXdJywqtftLW2kcCIOSZn6RrJw7ii
         5ifA==
X-Gm-Message-State: AODbwcBJwni4JfAWIYNeORm4ktU63bPQZOEjy+iXts6NU09bkjtADQ+l
        lMbMaaI4bubWuQ==
X-Received: by 10.237.48.66 with SMTP id 60mr11197957qte.25.1494719160695;
        Sat, 13 May 2017 16:46:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h14sm5319234qta.18.2017.05.13.16.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:45:59 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] grep: skip pthreads overhead when using one thread
Date:   Sat, 13 May 2017 23:45:30 +0000
Message-Id: <20170513234535.12749-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513234535.12749-1-avarab@gmail.com>
References: <20170513234535.12749-1-avarab@gmail.com>
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
2.11.0

