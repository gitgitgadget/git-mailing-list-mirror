Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A45F1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbeASABR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:17 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32975 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932817AbeASABG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:06 -0500
Received: by mail-wm0-f67.google.com with SMTP id x4so4919427wmc.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=W2CL3SAmoS/ds7f5MHe3f1BOLxUXUDFXN76StFxkDtxt5AX3134tSLKKnLJzpz+9WV
         zfNfAj5B7OIFy+KsABfU+24vBy3fT9NxTC0Y+ZPDr+oJd+iicp0tla+iDEc9EYln0Brb
         ySkGX7tbU3LMU+DdLrnizlweXCZbS3obnqf4ym0vyIGOOe4CHEiK+14TC/PbC4OxlrV4
         7RE3JqH+4zQcEhj1vD4phT7cUVuC2kdli6lbzzd6ULd1vY7w3ZjqwchULtfhccem6fit
         jdA6Xvb9ULUOoSKFwId3KLuuw/Dri/8n+0qnkmxAs7qpTcKCUYj6Gwm7+8IJJgJP3w3m
         zDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=OdJ++ONrAcHl8LA7hf9621h0MFD4IgzKWEPcTADVTTdqJhTL08Mzaj9MiEhB8J6HNu
         s7rmTrYhCUw8utm5Wj4Do9tHJeCLgByixqx75036ptezkd/Ul0bCbvqpUWbNKHLul4HV
         +K0YKKM1838AbC7ixFPOwFdUHm2anach5If2E3cOrGdQT8bmTO2Ub7AHgMrMfIBYMrO8
         +kesYbypgtRC3H9DhUxswfdPTs43KlU77O43JtyMDpEPrbTmStXN+7WEu0KFJQjjxOBL
         Wpie9zG5Yu0bNSwz40rrqOkCfkD8LPbRW8iN7jDVKt6DMGJfYICQhJ9tGbO7Cc4fKP57
         cUsg==
X-Gm-Message-State: AKwxytc108QhrXvBPsNkP/NXFu1lOCZK/rIhX9K3GwZn8093WJ7dqf2L
        E/9ryQ4HERlTPdLWVMx/b5Hy8yrh
X-Google-Smtp-Source: ACJfBot3PFT6gHScJbNoo9gYzX7mt06PAbcirDxfxFdxNvcrcSaP2noxwqFjA5mY5hvfvISm90vQ5A==
X-Received: by 10.28.132.207 with SMTP id g198mr6152240wmd.118.1516320065075;
        Thu, 18 Jan 2018 16:01:05 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:01:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/11] git-fetch & config doc: link to the new PRUNING section
Date:   Fri, 19 Jan 2018 00:00:24 +0000
Message-Id: <20180119000027.28898-9-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
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

