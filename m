Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC6F1F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 11:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdCAL12 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 06:27:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34391 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdCAL1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 06:27:17 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so5572617pgb.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 03:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gz+yl/LiX69kt/fz7P/kPRxdEUFdqoXekp6sTTX/2lY=;
        b=mH+CHD3EjHfM4RVmcV8e+V3AFxQm8DTDIJkz7iz0QzAED/Bd6zelzISFCv6P2F/Wta
         7RJZgbxFKjFbLXBdRwLMhQRZ2qG3w3BUM8CJvjpp+aH7Vvw2AysqzMdZt3qKjdvYPm+1
         q17KEBeZ98RIFTJ9yMczZeT2SA/gMmgUDnSsjO2d9r6ZEYuAj3XxJKsRwWTrUXZCDNbG
         cGgJrA9H8PYjvOcRSzPsCbPhwUvJvUR1a1DpEpBsh8C6hY3Xum7dGNomEBe7OiZ7hl2S
         DLmPo964Hg0Nm/7/U2j60f1j84H6xkzI/O4leTi/EqYLcJnL/sRwvhRg1yuyycgtXe+q
         ms9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gz+yl/LiX69kt/fz7P/kPRxdEUFdqoXekp6sTTX/2lY=;
        b=hkH9ROZpDm60e1r5JkVpBKfhIm2VHU9pOolmqGlIYRk2TUepJLyPbGDI59KNKixwor
         UVgjLSFNQWYcQmlUclfaBHtfeVB8ZFOtv7z/Nb7ppsiJs1cp0x3vDoP0VsDi8TcJnCHe
         ETQIVF+LXfpObzNVcdrwEdzNtY0hF/FIQHSPGKBFC4xIjf7ek7ig9i3jrckryRQuZGqZ
         7G7vvI2GjsEBz0ODX3Qm7zrol3cDC0JHbZGcCnsZwSpcYUUvaTUqn3eR8xa9BBMRz9UD
         eXDDvsG0/MEpMyelwODYDuA13+KpPrHqeJq83wlVzmv9rGKMmfFJTlao3CBXW3Vtw29U
         gB0g==
X-Gm-Message-State: AMke39mipXeSoQDFUnazWiut6E7x49c+B6PVBvK5LycdsTSDg0m3TCC33Kbi1gwjyK92qQ==
X-Received: by 10.99.0.23 with SMTP id 23mr8134072pga.139.1488367604644;
        Wed, 01 Mar 2017 03:26:44 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id b8sm10081922pgn.6.2017.03.01.03.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 03:26:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Mar 2017 18:26:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 0/3] Conditional config include
Date:   Wed,  1 Mar 2017 18:26:28 +0700
Message-Id: <20170301112631.16497-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170224131425.32409-1-pclouds@gmail.com>
References: <20170224131425.32409-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v7 changes:

 - typo fix here and there
 - delete a dead TODO comment
 - delete the error on unrecognized condition (we probably want a
   better, general mechanism for troubleshooting config keys anyway)
 - some fix up on include.path document because the "one or many"
   confusion started from there

I don't have a good answer for Jeff's PS about includeIf ugliness. I
agree that includeif is ugly but includeIf looks a bit better. I don't
see a better option (if only "include" does not start or end with a
vowel...). Maybe includewith? Suggestions are welcome.

Interdiff below (just on patch 3, not the first two)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index aab3df04fb..2a41e84bab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -93,9 +93,11 @@ was found.  See below for examples.
 Conditional includes
 ~~~~~~~~~~~~~~~~~~~~
 
-You can include one config file from another conditionally by setting
-a `includeIf.<condition>.path` variable to the name of the file to be
-included. The variable's value is treated the same way as `include.path`.
+You can include a config file from another conditionally by setting a
+`includeIf.<condition>.path` variable to the name of the file to be
+included. The variable's value is treated the same way as
+`include.path`. `includeIf.<condition>path` supports multiple key
+values.
 
 The condition starts with a keyword followed by a colon and some data
 whose format and meaning depends on the keyword. Supported keywords
@@ -104,13 +106,14 @@ are:
 `gitdir`::
 
 	The data that follows the keyword `gitdir:` is used as a glob
-	pattern. If the location of the .git directory match the
+	pattern. If the location of the .git directory matches the
 	pattern, the include condition is met.
 +
-The .git location which may be auto-discovered, or come from
-`$GIT_DIR` environment variable. If the repository auto discovered via
-a .git file (e.g. from submodules, or a linked worktree), the .git
-location would be the final location, not where the .git file is.
+The .git location may be auto-discovered, or come from `$GIT_DIR`
+environment variable. If the repository is auto discovered via a .git
+file (e.g. from submodules, or a linked worktree), the .git location
+would be the final location where the .git directory is, not where the
+.git file is.
 +
 The pattern can contain standard globbing wildcards and two additional
 ones, `**/` and `/**`, that can match multiple path components. Please
@@ -169,15 +172,15 @@ Example
 		path = ~/foo ; expand "foo" in your `$HOME` directory
 
 	; include if $GIT_DIR is /path/to/foo/.git
-	[include-if "gitdir:/path/to/foo/.git"]
+	[includeIf "gitdir:/path/to/foo/.git"]
 		path = /path/to/foo.inc
 
 	; include for all repositories inside /path/to/group
-	[include-if "gitdir:/path/to/group/"]
+	[includeIf "gitdir:/path/to/group/"]
 		path = /path/to/foo.inc
 
 	; include for all repositories inside $HOME/to/group
-	[include-if "gitdir:~/to/group/"]
+	[includeIf "gitdir:~/to/group/"]
 		path = /path/to/foo.inc
 
 Values
diff --git a/config.c b/config.c
index ad16802c8a..0dac0f4cb2 100644
--- a/config.c
+++ b/config.c
@@ -191,7 +191,6 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		/* TODO: escape wildcards */
 		strbuf_add_absolute_path(&path, cf->path);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
@@ -245,16 +244,12 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 
 static int include_condition_is_true(const char *cond, size_t cond_len)
 {
-	/* no condition (i.e., "include.path") is always true */
-	if (!cond)
-		return 1;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
 		return include_by_gitdir(cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(cond, cond_len, 1);
 
-	error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
 	/* unknown conditionals are always false */
 	return 0;
 }
@@ -278,7 +273,7 @@ int git_config_include(const char *var, const char *value, void *data)
 		ret = handle_path_include(value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    include_condition_is_true(cond, cond_len) &&
+	    (cond && include_condition_is_true(cond, cond_len)) &&
 	    !strcmp(key, "path"))
 		ret = handle_path_include(value, inc);

Nguyễn Thái Ngọc Duy (3):
  config.txt: clarify multiple key values in include.path
  config.txt: reflow the second include.path paragraph
  config: add conditional include

 Documentation/config.txt  | 77 +++++++++++++++++++++++++++++++++++----
 config.c                  | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+), 7 deletions(-)

-- 
2.11.0.157.gd943d85

