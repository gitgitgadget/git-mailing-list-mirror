Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842DF1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937048AbeFRXnZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:25 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42453 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937005AbeFRXnY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:24 -0400
Received: by mail-ot0-f196.google.com with SMTP id 92-v6so20529377otw.9
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtQitJE7lPAfII7qVznbKKE9RCqyu2dPh9gaZSzykeI=;
        b=Isf1AeKbaYBf7jACMPRLqzAHYc9mdUZpd3xcsN5dGL7sUsAp/1oSXEDoVSIeUOEFLb
         YbiJdVjiKQp/8k/uZkYjX6vvQl/Q4Bd0QKa0JUkRi9W+FUJIJa3q7yYuNZaIYKvDl0r+
         71S8dmcdieqpUQkkVjjTCIOh63lUX8Jcx5CNNDes2+Dl2/JZf5Vc4uRh6NWqy5pmBpxH
         7BDIOPyVP8b/OGDaFY7ktcSzIBmLiBtfyNCO9gyqUbLCL4GcAKQXZps5yXzU+i90CfJG
         +uOwnw1yAhqLMaCtxOwCsCgQWCQSUrKC10Rmy+bU+hQb/iPsHxMPOxERfoEMxOpg8Tox
         ewBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtQitJE7lPAfII7qVznbKKE9RCqyu2dPh9gaZSzykeI=;
        b=nHwdDnnNne98RUTLbdAnU1abstk0t8pAlRbTlkTfvF3HfEJwgeMrwXfOJiTqluOnLT
         QjmN48lRAgcrBL46ZvbkPsub1YGW/iQA0HIgLjInQpVqXt+noO2pHXsGvHkQQyoisPae
         Qchy4u2RwBmHbB52hO2AEAKNY96j7RPIQ7pU3vCl0Yi02SfRZX/Rc8VC9Wjdrnk4vbCn
         2iV90dj1gEzvUfp7KTlLBDXPP7T2c6vlTfq50apW4QIGnwz/WW8UyMFLmyXeri8dYRct
         tWyVNdPf1e1c5SXXBSqYHL3OP81LA25yCz4K2pYOG7b0yQ0dNavturvmvKPtRDmeTDPA
         qG4Q==
X-Gm-Message-State: APt69E26sAztasrJOF8U6nEVIiP2aNTs4JQbqTf+ioxMwkpRx5XnE0nn
        BqiUiloUa1fs/KIamZQxVB255y4c9Ck=
X-Google-Smtp-Source: ADUXVKL6QCW0zCAAwxnshodrLj32CcYmmFcOjaLe3iM4IGM+G+9Mf6TcVE+m2izyeLaq2bPZMRX2hw==
X-Received: by 2002:a9d:255d:: with SMTP id j29-v6mr8483365otd.280.1529365403103;
        Mon, 18 Jun 2018 16:43:23 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id w189-v6sm7369948oie.45.2018.06.18.16.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:22 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 6/7] grep.c: add configuration variables to show matched
 option
Message-ID: <4a36cd93c616b2a546c21c923d64f953a780e55d.1529365072.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support git-grep(1)'s new option, '--column', document and teach
grep.c how to interpret relevant configuration options, similar to those
associated with '--line-number'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt   | 5 +++++
 Documentation/git-grep.txt | 3 +++
 grep.c                     | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 58fde4daea..e4cbed3078 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1183,6 +1183,8 @@ color.grep.<slot>::
 	function name lines (when using `-p`)
 `lineNumber`;;
 	line number prefix (when using `-n`)
+`column`;;
+	column number prefix (when using `--column`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
 `matchContext`;;
@@ -1797,6 +1799,9 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.column::
+	If set to true, enable the `--column` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 31dc0392a6..0de3493b80 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -44,6 +44,9 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.column::
+	If set to true, enable the `--column` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/grep.c b/grep.c
index 9f5b00a471..8ffa94c791 100644
--- a/grep.c
+++ b/grep.c
@@ -96,6 +96,10 @@ int grep_config(const char *var, const char *value, void *cb)
 		opt->linenum = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "grep.column")) {
+		opt->columnnum = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp(var, "grep.fullname")) {
 		opt->relative = !git_config_bool(var, value);
@@ -112,6 +116,8 @@ int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
+	else if (!strcmp(var, "color.grep.column"))
+		color = opt->color_columnno;
 	else if (!strcmp(var, "color.grep.matchcontext"))
 		color = opt->color_match_context;
 	else if (!strcmp(var, "color.grep.matchselected"))
-- 
2.17.0.582.gccdcbd54c

