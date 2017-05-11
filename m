Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158B62018D
	for <e@80x24.org>; Thu, 11 May 2017 17:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbdEKRCV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:02:21 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35517 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbdEKRCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:02:20 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so3617509qtb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fjryow+8mkLRNrh3gpTRgTItteVzC5vHv7xzAjrvBCI=;
        b=o/I3l3yhet2a508ji+7MNZB1FbOALBZrWtG6f/8OBkCBv4qEprzwkpr2AI2VAQ5a0A
         9YDWItaMPkKbYvSc25O0EhY6rb7rFD3G79EBhVqHwjk6avRFmuatN/CBmyTL3JIyP/5Q
         ulDkp24+kDK9SBsoFJgIa4DcjseTfNY/kPfKij79IgYIS3EM91QluJcCvBfSA2KQEA2p
         K3FIXasNagzOZBVqN4AMCQZTi2MmHYJzpSxmcElPNZ8VC+jGGqYX7QJwdj5UUmzZrKJp
         7Xw+k+/d5prHpEzvjghrKDM4D01bGL6H8Gmi1rj820kT6qXQwY1X8DhRc4QiinlDTFzc
         605g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fjryow+8mkLRNrh3gpTRgTItteVzC5vHv7xzAjrvBCI=;
        b=f45wt8ZBj6b14DyGOwFMY/J2LyIY6S5Zs5VXhBP6qeyQ3sY0HGFV38IuNo8djCIcaA
         3+aA3hy7y03MCLXSBkrMdptuh5jSXdsRQVYbusg+qbTsAv0mCvypgGI2PJSeKglsZPsw
         Z8bpyhOrTdY5E5VI6z9S9yOIdyzAvIx1y097wzczH0THSRL5GDQ5qY6YpX5mFtEnikLi
         Bft8oZ+8xdU4EwYecyA37kVeIxjj0Vi6GMDFElcVUssz1oZ4V402Y2slV2HWOYHAS/PR
         fRf/HRr1tTcH+xqXlz0y9YnxgZqabadz0XG+FatuPcCtl3fAWTo9vUemvnSVhxpKZsv3
         Eg/w==
X-Gm-Message-State: AODbwcBhBucsRTetbf5o8phzBPr35wKXNbF7E/Sj75MZ3X/YecIUxgCW
        QyTGnQq2jZrt7g==
X-Received: by 10.237.34.58 with SMTP id n55mr112926qtc.117.1494522139480;
        Thu, 11 May 2017 10:02:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10sm480407qte.15.2017.05.11.10.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:02:18 -0700 (PDT)
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
Subject: [PATCH 2/7] grep: skip pthreads overhead when using one thread
Date:   Thu, 11 May 2017 17:01:37 +0000
Message-Id: <20170511170142.15934-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511170142.15934-1-avarab@gmail.com>
References: <20170511170142.15934-1-avarab@gmail.com>
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
index 7baa4778b7..9c0d1ecc12 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1240,6 +1240,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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

