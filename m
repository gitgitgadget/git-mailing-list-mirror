Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C3C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKUM1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiKUM1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:27:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05E2AB0E3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:27:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5so8348957wmo.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YwOlPmIHMAu0LfcxnbRTtYAhc+Rl9hkoE7IllTJtFg=;
        b=RhhVUETKGuIZyGu8CHSAGrKuS/X3xdpREk+TF50Yab4jzidzIijQOrL80H0cRWd42i
         nqDJ164X1/nWkkoqCHaiT3Musnzksf2JPzKbCPXkW8yamMcnrnwXVTxF2lKIJ/iudhul
         nHPDrvytTfvHMlbcG2UPRvVsF319eVaZPNBvgrXo0OMSpjEzRX8caCa0FMPHQ4AEsmmP
         B32Nvxgxon/Dc4ovIBUlt7s12u6fDUOuTKQs4McSeSsz2FZ4tnM2FYGCvzMAGzxO6V8b
         UEUjj02mrO7s4voA6KwVfkUWVQE4Q8I12geC0NPAkG25aCeZD2x0qzw9yE74Y/Nagvke
         B6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YwOlPmIHMAu0LfcxnbRTtYAhc+Rl9hkoE7IllTJtFg=;
        b=tsxQdNmwWeKYF1zoWpF2pgDjhEqwlV8U44tz7oK53vCmpVFdZukmOZ4rW53WWiW+ZU
         jOiSehxNeCkALPsFe4wdVY+xq1WfAWbqUtzzxiqxli3bFZyX3QC84iCPqx/YxIWdineU
         1aN+cf0F+sLkMUfmtRyG3881TOTTwlRu85hJJXzlEFU7/epvzE7408zRT8vzGIvUJ/k4
         HY36F2lGxujeXzEbjz/eeR+0fKxZn1qWcO0sDf/6rlw54VwTklatdkq4njptLWdIrf39
         fdsSagvKtpnWVr+7Q82w/vTV+WPtJvaUd2H/ARebRJGpor8ReWzxhoOidiZR6hoXOKhP
         KvEA==
X-Gm-Message-State: ANoB5pkqz8tUdNGXaxf62tqBRBH3lX2SIeEI7EFOdQ8z8cU9Sf6BgiU1
        Iyx6Xa8AKELqCYXRNioK5FeZ87aNsjQ=
X-Google-Smtp-Source: AA0mqf5ib7xNfcbHfYdu0HubYYwghuq4N7uepYeWBkDLOQcSbW1bE4TLxYDn3EQnYYuyV1tFxOnuRg==
X-Received: by 2002:a05:600c:22c4:b0:3cf:71b7:7a41 with SMTP id 4-20020a05600c22c400b003cf71b77a41mr12925396wmg.31.1669033623022;
        Mon, 21 Nov 2022 04:27:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b003cf87623c16sm20712034wmb.4.2022.11.21.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:27:02 -0800 (PST)
Message-Id: <ccfea26de333ac5a08a5df4c9b790811067bd437.1669033620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
        <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 12:26:59 +0000
Subject: [PATCH v3 1/2] git-jump: add an optional argument '--stdout'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yoichi Nakayama <yoichi.nakayama@gmail.com>

It can be used with M-x grep on Emacs.

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/README   | 10 +++++++++-
 contrib/git-jump/git-jump | 11 ++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 8bcace29d21..0340980959b 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -79,6 +79,14 @@ git jump grep -i foo_bar
 git config jump.grepCmd "ag --column"
 --------------------------------------------------
 
+You can use the optional argument '--stdout' to print the listing to
+standard output instead of feeding it to the editor. You can use the
+argument with M-x grep on Emacs:
+
+--------------------------------------------------
+# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
+Run grep (like this): git jump --stdout diff
+--------------------------------------------------
 
 Related Programs
 ----------------
@@ -100,7 +108,7 @@ Limitations
 -----------
 
 This script was written and tested with vim. Given that the quickfix
-format is the same as what gcc produces, I expect emacs users have a
+format is the same as what gcc produces, I expect other tools have a
 similar feature for iterating through the list, but I know nothing about
 how to activate it.
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 92dbd4cde18..091d1add0ec 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,7 +2,7 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump <mode> [<args>]
+usage: git jump [--stdout] <mode> [<args>]
 
 Jump to interesting elements in an editor.
 The <mode> parameter is one of:
@@ -15,6 +15,9 @@ grep: elements are grep hits. Arguments are given to git grep or, if
       configured, to the command in `jump.grepCmd`.
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
+
+If the optional argument `--stdout` is given, print the quickfix
+lines to standard output instead of feeding it to the editor.
 EOF
 }
 
@@ -69,6 +72,12 @@ if test $# -lt 1; then
 	exit 1
 fi
 mode=$1; shift
+if test "$mode" = "--stdout"; then
+	mode=$1; shift
+	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+	"mode_$mode" "$@" 2>/dev/null
+	exit 0
+fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-- 
gitgitgadget

