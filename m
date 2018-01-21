Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAAB1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeAUADt (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:49 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42293 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeAUADq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:46 -0500
Received: by mail-wr0-f193.google.com with SMTP id e41so4820172wre.9
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=dLcL1XmElYLwZISdVkBLc+sycP1vkFv/+SjEBT40yzfS8m3X/89yokoj6iFa5QZFO3
         g/9K0j6ut1HmEtBdqhAJ2LsYI7qPQ3qOA2MqpN7dGxJ+1RsmdmAdTWd7RRibyCyv3QC3
         j+e5FP7Z310oXfIFirpN90OzvGibH95rTiIQ+kU2m4fPo8Tea1W7o9XHEWOlnlosXkC0
         bOm49Rz4XDZZADKzXkNwXuOg7bzDwfPHB3/qQaHkOQdGRLoXXJRngWxev+2xvJlywDvF
         +cbiOroXsagD65RtCzNNjAvXFOwC3Hd4bE7ONuqE7FBc0rAg0k7vs/Und8TjzyfpBgzj
         zcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=RjBkdhV7Z1fVGeuUf2tD5vbl0pqDAJM3jH9fD1VIzDfLeBmQFqRpbBx8MwVeuMU3oO
         0YKMsVpFaOZjTVAKFUmNAXO1L6Fhpr+Ub+vMX7AN8ClWhK4bN6nbYSOnC5hBawGCuF/K
         OXK7pNz+5O3guFVPmfSh0j7F9bMc9Q9pUDwLDhv0gNSbrBUQfVg7I8fCfO4Qmbw2i+5H
         HPVSWQILarGsYnmNSbDN5LWHbowZ0PtTZMNiVd3KP+YcIras6xTYfETEUEZiqx58iBBF
         yS78MflLhBfDiiw+2l/+ootkGvR1PsclPaMILMgejsPnW0D8yTLYljCLK/lukMLjJmns
         I5aw==
X-Gm-Message-State: AKwxyteR3yeOFYTJn0vEKq8L+tv7lxLjRhxRr1zGNlt8ACxTU3wjnIwL
        oylNcU5xCHufgT/nl5W/5RWJ0kuE
X-Google-Smtp-Source: AH8x226EtU/jUVULanCGJS4HHxa76l0NQMW4/noRbgIUxf3HVQW4UoFg+wQMx65ZtidQUCksGjNNag==
X-Received: by 10.223.134.45 with SMTP id 42mr2480342wrv.218.1516493023942;
        Sat, 20 Jan 2018 16:03:43 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:41 -0800 (PST)
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
Subject: [PATCH v2 08/12] git-fetch & config doc: link to the new PRUNING section
Date:   Sun, 21 Jan 2018 00:03:00 +0000
Message-Id: <20180121000304.32323-9-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
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

