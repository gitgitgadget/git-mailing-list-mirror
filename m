Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0299220248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfCVJdE (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33899 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfCVJdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so3868010wmc.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Tbe/tae1N/ST1rYfBFw3t4mz1O/zliGul1YTY740Zo=;
        b=Hj6A3zkNnWh+Qr0vHP88Uqrd9FXRethkWGEjNaqbNvmABwiLFzcwLPril+BE0neo7r
         1aNoJL2oGNhjEnMJYfVztTON5fhqlGAmlPx+slsLRIjaGjR9lTnTj5u620Er70PwI2WX
         8AaP/7h/Q7LPyhBVeVYF1AZh1NnMBle/89iDiqW8cnZg6aS6fawnSouTZ7imi76REk8a
         iCbKA7PEGVGNV5XhaC8eb9Wvs0TJ6Oszl5u8yiDbb8B4Q6tAOuYwVfCkReDcdhT5vwaG
         INZsaLzDlu4wA3RYadH0nmu1h+oj+j93nfbX5QbFoRphDhguSQs5SM/hANt4e292aBRb
         mH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Tbe/tae1N/ST1rYfBFw3t4mz1O/zliGul1YTY740Zo=;
        b=mijicAI5B3nVzFf1GUmx6aP8dAgLbKHIALoZQD3geNLq+ZXvb8ojRlB+iSL05AL9Nx
         QSJSUCXaruO2VkhnJ44kg6sI778aIl/1KUf8X1FxzDpaKb++jowxsQo4zy5654bcIUxs
         GoCybpue46b6BrwYXM1Y8x/DQG6kIpNCQ7z3vgl+6DdsGpckHsk4LLnCIXAi3LIYE7WI
         0Yl50glrCHDQjdOj/zqB25sqv5IKIQtpU1JxOWtbdhfmPUpwAw4qaSM/jQsenmeHZ1Qf
         fZAE4sAQKQ2MOuLpI0j3FeGY7aaB6Rf7eeHV4hamh8iHOwVP9Fu1/XH6pqQC95vi4f09
         PGrg==
X-Gm-Message-State: APjAAAW0FZuggcqNb5z4k5vUyjFZP1mdkIJYT31h6wW5qBLuFymbG/PT
        AbK7WTisoBkItVnMSgkuzijyoQdQ5Ek=
X-Google-Smtp-Source: APXvYqz+LRxNzR11vvmDCxXwCD77vg3j2/0ewSeu5oFHyoWrAMY7n86/yMt5OfvyolXdyJ6reKwuFA==
X-Received: by 2002:a1c:2d4c:: with SMTP id t73mr2316681wmt.142.1553247181364;
        Fri, 22 Mar 2019 02:33:01 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/11] gc docs: modernize the advice for manually running "gc"
Date:   Fri, 22 Mar 2019 10:32:32 +0100
Message-Id: <20190322093242.5508-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docs have been recommending that users need to run this manually,
but that hasn't been needed in practice for a long time except in
exceptional circumstances.

Let's instead have this reflect reality and say that most users don't
need to run this manually at all, while briefly describing the sorts
sort of cases where "gc" does need to be run manually.

Since we're recommending that users run this most of the and usually
don't need to tweak it, let's tone down the very prominent example of
the gc.auto=0 command. It's sufficient to point to the gc.auto
documentation below.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a7c1b0f60e..dd22eecc79 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -20,17 +20,16 @@ created from prior invocations of 'git add', packing refs, pruning
 reflog, rerere metadata or stale working trees. May also update ancillary
 indexes such as the commit-graph.
 
-Users are encouraged to run this task on a regular basis within
-each repository to maintain good disk space utilization and good
-operating performance.
-
-Some git commands may automatically run 'git gc'; see the `--auto` flag
-below for details. If you know what you're doing and all you want is to
-disable this behavior permanently without further considerations, just do:
-
-----------------------
-$ git config --global gc.auto 0
-----------------------
+When common porcelain operations that create objects are run, they
+will check whether the repository has grown substantially since the
+last maintenance, and if so run `git gc` automatically. See `gc.auto`
+below for how to disable this behavior.
+
+Running `git gc` manually should only be needed when adding objects to
+a repository without regularly running such porcelain commands, to do
+a one-off repository optimization, or e.g. to clean up a suboptimal
+mass-import. See the "PACKFILE OPTIMIZATION" section in
+linkgit:git-fast-import[1] for more details on the import case.
 
 OPTIONS
 -------
-- 
2.21.0.360.g471c308f928

