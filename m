Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6022720248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfCVJdL (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51884 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfCVJdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so1426893wmf.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymah7V7qjj0iS6332aEkdrxLe9QKJfxCLGBu7hRDLaE=;
        b=o42Osz5lXdXsmqAz5qFpQbNKmHLN5H1gdyFlkp0+zn8k9JrmFEhNDtt30sK/DIeev3
         1ZrctD4T4I26Ba4py3soUwVqFlAV7YH4RYCkACW5b/1xDb6jdKSckJx+iVOy28PRpKh1
         75FKzinIyciJq+TTH6WLxq1dJAD4lp6t5rWfAHUKHW7mnbRQawPJvtru6Znt3ZeKJntF
         BPKEWM94Lqt0i4NhGhNfYiacK0VdVvEBmGoeDFOC7FlYqVM+C0KpOhMYSm4jI8mI5lvv
         Ub8hSmohY6ARaPnuzFO4gdHw8BaISxqt7SJHhTV7oFKY9y4Qs4SgujKhEUcP7EcgOmvG
         8UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymah7V7qjj0iS6332aEkdrxLe9QKJfxCLGBu7hRDLaE=;
        b=MHB8DATuNlFgp6YkhszOPtLLCPHluDTXY41jiV/Th8NBGfJoNIwcrOjVWBPSmvnkAk
         XQzY3hFZynKls0EswYumE1v5w4fcIOgoeP+7rfNDV8IJmzrLLL4GGicyp5BpzFiVO7O2
         8cHre2liMec9GMErr+0wiAIJywYmi+r/MXNC6nZJo2es9GM9TVmIA+0cJNC0TH2KAI5E
         IddrO1KXcCy2jKTl2lOJVkO99x7VK4YwzvEfn3j2N6Dt16Z7pV8UlquEUVzr8d1Yxscb
         fKYlEJyezRBRyjXFYQjZW1+5OfANLKfFoLVILWyE8h48hKQWaOg5oz77VJcghCMBxXLJ
         l5nQ==
X-Gm-Message-State: APjAAAW1Z5SQ/rklJPV4LrgIoZpaWUq3QUwt3jvRETnx8ZCaFCQf894W
        onAnWXwZdUv7S/k7d3mbhiWoEYZgUNk=
X-Google-Smtp-Source: APXvYqwpXlcBQjzgn9Pm1xh9nZy72m4cEr5lKrhkkOfbaKf2XmdB/RBif6fhaqoK+MGTrjtFhh9fkQ==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr2230806wmf.77.1553247187968;
        Fri, 22 Mar 2019 02:33:07 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:07 -0700 (PDT)
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
Subject: [PATCH v3 06/11] gc docs: fix formatting for "gc.writeCommitGraph"
Date:   Fri, 22 Mar 2019 10:32:37 +0100
Message-Id: <20190322093242.5508-7-avarab@gmail.com>
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

Change the AsciiDoc formatting so that an example of "gc --auto" isn't
rendered as "git-gc(1) --auto", but as "git gc --auto". This is
consistent with the rest of the links and command examples in this
documentation.

The formatting I'm changing was initially introduced in
d5d5d7b641 ("gc: automatically write commit-graph files", 2018-06-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 3e7fc052d9..56918a5008 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -59,8 +59,8 @@ will also be excluded (this is the equivalent of running `git gc` with
 
 gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
-	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
-	'--auto' the commit-graph will be updated if housekeeping is
+	linkgit:git-gc[1] is run. When using `git gc --auto`
+	the commit-graph will be updated if housekeeping is
 	required. Default is false. See linkgit:git-commit-graph[1]
 	for details.
 
-- 
2.21.0.360.g471c308f928

