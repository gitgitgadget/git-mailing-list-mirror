Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB7420D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbdDPWVd (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35207 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbdDPWVb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so18459482wrc.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uSte149Yh6Y1OSZEp1cSpywA4VZCwLxUEUeuIbJ5fI=;
        b=TgjES6Zus6L4TYZk4o3eDhridX5vxiEV1CvtU9TSOaDinR6Pb8tLY6AI1Yet4v5Exk
         EFzA1O7Wz05XxjOOk9+3esZXUuid+K9fOAfX+9JTkCQp5G7Anj/8QCDBxHTQQVh1RaXB
         XB3761hZX7k6OUHnh/+y/NpTzBvGQG9ADIurcXiEwoOsZejA/ITgqZHzcmXMFLeYdX6g
         /NtZ8QqWNTn+ddNASoE3uRZKmLRs9jWBECbKRWM5daWIsfG4GMF+rZ+/BWnzmUbajdDf
         4tiG2yFrZ1Sn/ZUwcbwoqX5GP8bFicB2aJyx2W0vvptUIhDB2ala3rROnnstFOAbcbFe
         tj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uSte149Yh6Y1OSZEp1cSpywA4VZCwLxUEUeuIbJ5fI=;
        b=g0wyz7hnii7Bi3tOOjwRILLsvXKeuWxSp2zt33OqhOkEMgAbNXYZKdav/vkHKP1oFB
         nAVY+/5to9POLUUsm5QVzYb4VFB4VvDuPKhWZGrceD2X+h5B96nHEAD4Yis7GKUoTAaH
         E129xCQH8j/E3UpoQPtYR0dcmHiS0nuPUj7+om8J4gXc50rcVWgGH0o1+EzSF+m1weNV
         T4I5iFFcsqipvlomHzS/l0fSDCMoNKwg9OjlWYf9PEzcp2Q9YzpQBdLHOsdVePWlUx0e
         /65rtVRpORo0ftq7iUJYtfCl01DXY4uk9JaNV1wTzV/uwGDTKzRCHPZte/SKfZEf8JtW
         cLig==
X-Gm-Message-State: AN3rC/6c79wyktIU1+rntkv3opXsavV/u0oxw7yA0IU6R8L2g06ZllYv
        Whl9LmLcjbfbJQ==
X-Received: by 10.223.175.211 with SMTP id y19mr15607721wrd.77.1492381289930;
        Sun, 16 Apr 2017 15:21:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:29 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] grep: skip pthreads overhead when using one thread
Date:   Sun, 16 Apr 2017 22:20:58 +0000
Message-Id: <20170416222102.2320-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
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
index a3d380551b..cb3323060e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1225,6 +1225,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		num_threads = GREP_NUM_THREADS_DEFAULT;
 	else if (num_threads < 0)
 		die(_("invalid number of threads specified (%d)"), num_threads);
+	if (num_threads == 1)
+		num_threads = 0;
 #else
 	num_threads = 0;
 #endif
-- 
2.11.0

