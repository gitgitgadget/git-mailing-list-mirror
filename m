Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B7E1F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfAQB3h (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:29:37 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:32928 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfAQB3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:29:36 -0500
Received: by mail-wr1-f46.google.com with SMTP id c14so9196034wrr.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 17:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwGYCAcnJzEMEfQB+b08TkADzSse7zDZxY/GEE+a5OA=;
        b=Y72S9Ks5gYRyMA21l4GPVunqa81WoT1OiabsdzPsg+YG+sIpc2FQnNtnPw0lQSNPjc
         sYDdygEzsFPkv24ACLpxMxevDLJbeMX/RXhLSGM7t89UnlTNsZ0SLHKRJcjy3JTgrwHD
         7Qs24gK/SorF4Xm8mvsa/y4qXF0QgvWjjvcE0Id+KajGgR21OlyEK/maweXReUzjp0Tk
         0+rBRhrafrzedHucjfhAMBTX6YicgcWPssQi2YMiYkID4sLO/Vrim88V0ccxws+NpsAr
         8KUJ3P9eei7AEMGl0ATyZoODmBgRHei7M6MVMS8ftj0LChmtxir6kdSRQCJ1tYmaVyRJ
         anuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwGYCAcnJzEMEfQB+b08TkADzSse7zDZxY/GEE+a5OA=;
        b=q9lPlXbjxowfmWD5avlBgw3BoTf4DgT+wAPnonKhMB+nG5A3xLG4MPu3jcHZ5P20yW
         FwuBHPN3pxBzDQD/0diqPDCh+ugtaKEca3sGCftpnfUl3xtdlBp4VSIC9SOO3w9qdUC9
         Aa51v+F2Fx9al4ldOrqVaTL3xfHa9j/LkNY2xGoyqdx9AKhRE91hkxGq53gbLw11r5SH
         w9UP8IfpN3Z6ETZUXxaK6Xu/TuJfL6AHNvfci6zsLxL2Iu/uZLF0mttl3JfC7MP8WKtN
         r8zMOpm29nhAhm2ttkyJTZ7HQvTXJQDqV6x+xfT1J9nt8yj7xHpSGoZe0LVZ0GAHfr0r
         SFZA==
X-Gm-Message-State: AJcUukfbNp9iLx6UPVH6ZGPv/8M5yB+SimbwNpObvrykqK0k/hFs1BeY
        ZYlWVsDkgUEAgRYA59MCNPI=
X-Google-Smtp-Source: ALg8bN6i1HVSWmoTYnrt+GhABBQX8fOJbYvDvaSnpDPs1Tsq4fxc4kvraOlOLn9octRmUxP7N/L0Rw==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr10062954wrs.272.1547688574874;
        Wed, 16 Jan 2019 17:29:34 -0800 (PST)
Received: from localhost.localdomain (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id y13sm36818272wme.2.2019.01.16.17.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 17:29:34 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/5] .gitignore: ignore external debug symbols from GCC on macOS
Date:   Thu, 17 Jan 2019 02:29:10 +0100
Message-Id: <20190117012913.30562-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20190117012913.30562-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20190117012913.30562-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git is build with a "real" GCC on macOS [1], or at least with GCC
installed via Homebrew, and CFLAGS includes the '-g' option (and our
default CFLAGS does), then by default GCC writes the debug symbols
into external files under '<binary>.dSYM/' directories (e.g.
'git-daemon.dSYM/', 'git.dSYM/', etc.).

Update '.gitignore' to ignore these directories, so they don't clutter
the output of 'git status'.  Furthermore, these build artifacts then
won't trigger build failures on Travis CI via b92cb86ea1 (travis-ci:
check that all build artifacts are .gitignore-d, 2017-12-31) once one
of the following patches updates our CI build scripts to use a real
GCC in the 'osx-gcc' build job.

[1] On macOS the default '/usr/bin/gcc' executable is not a real GCC,
    but merely a compatibility wrapper around Clang:

      $ gcc --version
      Configured with: --prefix=<...>
      Apple LLVM version 9.0.0 (clang-900.0.39.2)
      <...>

    So even though 'make CC=gcc' does indeed execute a command called
    'gcc', in the end Git will be built with Clang all the same.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..a9db568712 100644
--- a/.gitignore
+++ b/.gitignore
@@ -229,3 +229,4 @@
 *.pdb
 /Debug/
 /Release/
+*.dSYM
-- 
2.20.1.499.gf60de1223c

