Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A940F1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeAWWOG (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:06 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34114 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932256AbeAWWOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:14:04 -0500
Received: by mail-wm0-f68.google.com with SMTP id j21so15377330wmh.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=RQ4KmpOPdC+Q6skTiPGxO40aZkpCDPAE1KXlf5FKfjkYnG6EaA/xJgdzwLtBfTv/kU
         gWff7b0H5m5IdwY8WoY6fg3b52gK9OurJxAjIB13b3mEHadLPKTX97iDZsRM7WUDRQ4J
         DCweyNvPKS8u7fdYOkCA1DEUZHMoU/bLL1Xp3erlbbyd1Vy67iFLf/d3TVj8/KXCU1Cr
         hB6eaLwhrp9GosYC7MFhcj64KikF6vmnEfcPEeeHzIqDDAguOSI7hpd/52gebXYWY3mO
         q9Rm2jC+hvma6rzQdtU2BqYlgPAR1ju3F7tJF72NbQ5r+6YqgK1giEb3osKTuKUi9mWt
         NneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=As+0e/muUa1Wn25GI5YHMeSEnah0tythPdukzickCSJFf0y7E5iR3S6nMXVSrgxYqX
         nEHMlL65vJYUiDxIGDbDJSqGifJ9Ayo5DQdxoJ5yNuMgt/z6TfxKJCn2N8T+CtchIm35
         LHmEoxzgoqgBVlOQEfD7Ex+OAPSLisKvodChYNeYtONQNoqavOKJsaDWOT6hltH3Ho0L
         Z7mzGRvtwgjWmWKVv2pcCyh3EAkY19AnNk4Rqe9zdQ6/e5S9g8bdYsS/ZBQQ0v0GGJ96
         cQwU8si7Du9hzdnY/fZsu6ZlEsUqPnT+pdbQvjHJq7arEfu8OjYFQvDpKOUCgQiITH9u
         GghQ==
X-Gm-Message-State: AKwxytee0rNP9gowN3cLsZRUgRcuZv6UqCXHAtXzDNUsfqSzFfD7NhQ2
        jaolvhP/TBC3OcsNPGeO7EyOcD/f
X-Google-Smtp-Source: AH8x226t2zuTDlPcsAvQp5gjApOa+y3OC1rsQl4Kpk/0fd+B3mQs/osANtAI3jIKqOzL2K+v206WVw==
X-Received: by 10.80.158.238 with SMTP id a101mr20569959edf.166.1516745643144;
        Tue, 23 Jan 2018 14:14:03 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:14:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/11] git-fetch & config doc: link to the new PRUNING section
Date:   Tue, 23 Jan 2018 22:13:24 +0000
Message-Id: <20180123221326.28495-10-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the documentation for fetch.prune, fetch.<name>.prune and
--prune to link to the recently added PRUNING section.

I'd have liked to link directly to it with "<<PRUNING>>" from
fetch-options.txt, since it's included in git-fetch.txt (git-pull.txt
also includes it, but doesn't include that option). However making a
reference across files yields this error:

    [...]/Documentation/git-fetch.xml:226: element xref: validity
    error : IDREF attribute linkend references an unknown ID "PRUNING"

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 6 +++++-
 Documentation/fetch-options.txt | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..0f27af5760 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1398,7 +1398,8 @@ fetch.unpackLimit::
 
 fetch.prune::
 	If true, fetch will automatically behave as if the `--prune`
-	option was given on the command line.  See also `remote.<name>.prune`.
+	option was given on the command line.  See also `remote.<name>.prune`
+	and the PRUNING section of linkgit:git-fetch[1].
 
 fetch.output::
 	Control how ref update status is printed. Valid values are
@@ -2944,6 +2945,9 @@ remote.<name>.prune::
 	remove any remote-tracking references that no longer exist on the
 	remote (as if the `--prune` option was given on the command line).
 	Overrides `fetch.prune` settings, if any.
++
+See also `remote.<name>.prune` and the PRUNING section of
+linkgit:git-fetch[1].
 
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fb6bebbc61..9f5c85ad96 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -74,6 +74,9 @@ ifndef::git-pull[]
 	line or in the remote configuration, for example if the remote
 	was cloned with the --mirror option), then they are also
 	subject to pruning.
++
+See the PRUNING section below for more details.
+
 endif::git-pull[]
 
 ifndef::git-pull[]
-- 
2.15.1.424.g9478a66081

