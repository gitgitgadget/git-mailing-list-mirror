Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9911F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeBIUdJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:33:09 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43477 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeBIUdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:33:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id b52so9437840wrd.10
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=LDgJnfQ3PKN/TAtZL9cGNE/kMIwV+cPppDdWQ+CvvZixi4LhxR7xwWsEQnJKp6/+vD
         qms0vUWGu8Fj5U5uW/DPevYNtU6HZFKiSfDVxskAknj2z5NH71M/hPqJ/gYJJeyrYTIj
         f1mdJla4RHQMgFUi14De16FGGpYQWzejT81THx0RbZFHFZC0t/aIv00kdQAejkUFQfdn
         78/hV+FWA9AIYJaClC1McX1Nia8sov7RB7whyGvY8l0ghlsC2UqEj1VyW3Os9enn5O29
         gn8MyJnsA94dBnBS5k33yn+CzeSAcBJWcwJlQ7M7xwlBJpWliB7JFWJSVoDqtz03Aauv
         m8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=LM23M4+mQRxtfodUQzWTUjAEcMfOS2npSlx18BnWrqHAzz2jIsWr7P98RE+tp+9x0J
         2Xcix50mJdlDY9Rko+6trKTATcSY+FGnr2ifopSjIZafjedt9ypS9lJXoew53tASe/hJ
         IYhtr/YCr52wI1LxNsiuAiBhZmSSxO6ypd7v+RnvS5XTMbP7bPY2JbbbXGSuSVzoeqKY
         uygeyFwpVCElIXxYJADaKme3WJ2cGgnRTL1x2nzt+HZuYVf183i499GRUiU8uarfQKg3
         1/Ww8whhJUB1BoVvRYQ6GidkErHqsB9Tg67u2bgp5x6qpm9rCfrVgiKsaawairTlyOQX
         WiZg==
X-Gm-Message-State: APf1xPB088wEi3EyZ+FLrbyUIzzNuT638+DfNwTpx/rdr6wm5dCVv3op
        nAurXVFxfRaPijyk0H/S82DkaN2a
X-Google-Smtp-Source: AH8x225ufyzGV3GjPEvCbqXXJKcyEV13v3wmIsdwA2xM3INxpPt+83MgzEw+SSeEMcWYHYvKbVj/cA==
X-Received: by 10.223.156.207 with SMTP id h15mr3164482wre.281.1518208383032;
        Fri, 09 Feb 2018 12:33:03 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:33:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 14/17] git-fetch & config doc: link to the new PRUNING section
Date:   Fri,  9 Feb 2018 20:32:13 +0000
Message-Id: <20180209203216.11560-15-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
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

