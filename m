Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0F21F404
	for <e@80x24.org>; Tue,  6 Mar 2018 02:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeCFCRn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 21:17:43 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44263 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbeCFCRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 21:17:40 -0500
Received: by mail-pg0-f65.google.com with SMTP id l4so7692835pgp.11
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 18:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Env8ti5zXwlgwIgA4B+x0DW44igBiAvNDh+XXRYthNg=;
        b=c09ARnIWk8qP8X49q73m2oElQspQGRoC6/LagmGyu5OcY+bQxhNPxNp+1Xfu/rxNfV
         DNyPl8tyQPFnr98lA7DL9MNH44vUM5/oLzesLL7YWjCNRcqRoGSkbGwHWAY0VXFMgkjl
         x+8f3rzgPd3cbjfMuZMvWP+RUu8RSxoeaRZ1oOM0VVPQDpzAssSxqLN8oSDYXJ8j4zqC
         yS8FGaqwyiaNgteJLSqaQiCk1dg+nozAlhamaOnagqjF2mPX5bqtxRhfdOiwkVpvKq/o
         ATl0ayhovR/9un1okGkZpmLiwL+fe/tuUVjHK/fmgDMBBmKexiqywizjeU0DtyAQ/Uyf
         kU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Env8ti5zXwlgwIgA4B+x0DW44igBiAvNDh+XXRYthNg=;
        b=QlIkCoRM4oDwfRaZ7h55jikxhnY8rX8AAmjp5CrKcOcH/yR1hmD2Hwk+kcf/mpsZu8
         TFRy3cTzHmEyrdU2jAYLGBDoeAmXKMT2yVcL7+qq2QzVXwiLsfzFlyOhOUgwFchCMkbc
         dz4yvi5IQEkcGvJs8u+ZnK0wQ/nqNlm0WXMgS/a75aB87VqGEo00OZYdGlVJyTvIk+w5
         dpK4H9vm1OXr08ZGHkOKemkSH3iPSTRBerMHGV3fv3a+iOqrbeu8ISVHotMhKRpLFkcM
         oDFafOzIhX4Ib1+uJVxO6ZSXheTVKeq5jkN1hQcHTS0Zu+NnPuwLAFv7f7kXf57++gdr
         jzKw==
X-Gm-Message-State: APf1xPDHPTGN1AsPsgaH+/bOUUQzBUEMs23OdmOBPBJ+OU8Q0drbnptb
        IXoEZHwxoprvU4TjzK1LACoZ+KvjPBc=
X-Google-Smtp-Source: AG47ELunO/34O200il/Lyp/8sx4zfuuutQvBQddYo9O1XYydFabAyudqmn/jRWG2Y8AGnnsNGuzJ7w==
X-Received: by 10.99.5.197 with SMTP id 188mr13760736pgf.196.1520302659693;
        Mon, 05 Mar 2018 18:17:39 -0800 (PST)
Received: from localhost ([2601:602:9500:3a4f:8042:ad20:287d:7753])
        by smtp.gmail.com with ESMTPSA id z7sm18521891pgv.2.2018.03.05.18.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 18:17:38 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/4] Documentation: list all type specifiers in config prose
Date:   Mon,  5 Mar 2018 18:17:27 -0800
Message-Id: <20180306021729.45813-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.15.1.354.g95ec6b1b3
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the `git-config(1)` builtin has not been recently
updated to include new types, such as `--bool-or-int`, and
`--expiry-date`. To ensure completeness when adding a new type
specifier, let's update the existing documentation to include the new
types.

This commit also prepares for the new type specifier `--color`, so that
this section will not lag behind when yet more new specifiers are added.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 390b49831..28d84ded9 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -38,12 +38,13 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-The type specifier can be either `--int` or `--bool`, to make
-'git config' ensure that the variable(s) are of the given type and
-convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool), or `--path`, which does some
-path expansion (see `--path` below).  If no type specifier is passed, no
-checks or transformations are performed on the value.
+The type specifier can be either `--int` or `--bool`, to make 'git config'
+ensure that the variable(s) are of the given type and convert the value to the
+canonical form (simple decimal number for int, a "true" or "false" string for
+bool, either of for --bool-or-int), or `--path`, which does some path expansion
+(see `--path` below), or `--expiry-date` (see `--expiry-date` below).  If no
+type specifier is passed, no checks or transformations are performed on the
+value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-- 
2.15.1.354.g95ec6b1b3

