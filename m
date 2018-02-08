Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73551F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeBHQUk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:40 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43571 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHQU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:27 -0500
Received: by mail-wr0-f196.google.com with SMTP id b52so5299078wrd.10
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=UTZ/b2/D1xOYFxrlxLZFk6EOcSAYZJx5NHlSK7v/LhkGwqBr1rn8FWvLNXRDiKBXPr
         6b1knGdJ4v92k3gJVY+q+uT5nUvbU5jQQk3A/djC7hpXqiAgaKmP9QkYyx0RfPwcfzyY
         LEtN3NUHOOKbFNJHWJoyruB4yBspVar1fpayzfDKhO/HuwAW8A3d3LOOXw4oem43m+XY
         nPlx+crICpVwkyLydEfDAbSSkh4zqiH6ciwlm6Rp3rmTVPV+LNJOeEllFIvYLxqpN5j/
         eG+MQ4MN4GxW4Mg2fkqyGXZlPIsVOfcreH+UnM0IcAOmXilS5RE37VY8prUemNi/a4wA
         T4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=16icXLLyxTowzsfiDvW8fGZ8ejK3caTkR3xBXIRWtLQ=;
        b=MOzsh/3z68s0EFPaVETY9FYUjM9NWqp95NcA3gn69jrUvl1VRCjE9v/ewmrYGkK6Ov
         kJWgKVCoZ2m77ZEor7b+ziYxkNQnuFRTdmXv81p1qtM8vTjofK62W81c9JvYHDBktQPb
         NPCtTkHLw0nOfE8BLch1ujSwdooybok1gI1H1CwuDkWFGf51gZd1A1SOBKWnetLK6qbo
         VFhdVLb1qb2JKVhfyb3BjxaBKqRJSLtjEyU9wyeRgcb240DnTASLZyFfUUdEtDCLyygf
         KOn+z1u4VRt60OLDw8RYKz2Exj0/aFYYG2ZHCi2G+GypqclT63stis1nFCCK1DHow3Yv
         J6lw==
X-Gm-Message-State: APf1xPBU9ravKWiqOVdLKOb6TimJRVy1BNtYhw7wzJnyKj9UC3fXDs+T
        n9quspUgPheKnmUookDeXshDZ7DO
X-Google-Smtp-Source: AH8x226P9rBb0pTyroOSw6cef7xxHrqzpkI/k9V0U+SRYRV8zXY65ognbJE9thmQaJzPbFk9X0ay2g==
X-Received: by 10.223.170.205 with SMTP id i13mr1325950wrc.38.1518106825702;
        Thu, 08 Feb 2018 08:20:25 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:24 -0800 (PST)
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
Subject: [PATCH v2 14/17] git-fetch & config doc: link to the new PRUNING section
Date:   Thu,  8 Feb 2018 16:19:33 +0000
Message-Id: <20180208161936.8196-15-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
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

