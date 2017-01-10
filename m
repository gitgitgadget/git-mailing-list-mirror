Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC93B20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbdAJUn0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:26 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34863 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdAJUml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:41 -0500
Received: by mail-qt0-f180.google.com with SMTP id x49so111083551qtc.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EOLrjmH8z+Z/5AdlT0yEzDtH/swl7ymLKNgwVYo6ekg=;
        b=P74n5jhqj0kwz1BSMGieXDRxInQKKMKUw4UYL44G/pHDE1rv/MkcZQwcqo1iDqKrTG
         OpsEPgZH2Do+5hdUdwiIm9Bjbrw84bRq2/HE1MgufjYqYqnKjY1kd5tWjPqztqL8Ae3U
         bRRiDBGiw4Pfl7LPAm1+uLwo2TLXq9k8lwiyFs7t8D0fY/I1incv0GSMnmyhW1xKy0uU
         L98PJdgJdM935Dy/CguqZ/G+vZTD1ioElH5Sp0VtHfSp5rdzV4IiyilcZ1z3xueLyBuv
         50+EUYef8HsBXBF74WgifhHfvYVQrG7eWikoqjokDr63eyhzZ2EWqMBa6juLPFzYtuNY
         8c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EOLrjmH8z+Z/5AdlT0yEzDtH/swl7ymLKNgwVYo6ekg=;
        b=C80GohPTUIptJwBeUIA3LJBgG60nuFJWDUTaE8kZ8TWN4/1ipoXTyTa4K5apDd14Kq
         B9jagZyTl63XU28TGTTwyRN1dxyC+ZR4B+51NtgNJE10r+PdQqDMXL7+Ccm6uH368toS
         /CD+GQZ95ZOlY/cX7p1dnGqlMDgSVqsOr3I/tec078rHsx0xIzmtGK80NZteodMh1W51
         UnPTRqFuIDZOEMei2LidIdV6oxlz8MoOFfA9mtAm860h959LFaTh/gslFn9/9Vd3SAOQ
         ELnKiHUl+OzjKVggDENyWZ0ZcWzM+mFGtJfxpO3EZIYWUcQtge8HRSuGZHXhMxEq5BS1
         npZA==
X-Gm-Message-State: AIkVDXLV5GHLIlRfqv3AyKIsl/Gysv1O6fpsEjjJ0YbW55syHjF/PnUIq+lPij0lmawv2YHI
X-Received: by 10.237.59.28 with SMTP id p28mr4515815qte.222.1484080960407;
        Tue, 10 Jan 2017 12:42:40 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:40 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 02/14] rev-parse doc: pass "--" to rev-parse in the --prefix example
Date:   Tue, 10 Jan 2017 15:41:50 -0500
Message-Id: <20170110204202.21779-3-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--" argument avoids "ambiguous argument: unknown revision or
path not in the working tree" errors when a pathname argument refers
to a non-existent file.

The "--" passed explicitly to set was removed because rev-parse
outputs the "--" argument that it is given.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 Documentation/git-rev-parse.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index b6c6326cd..7241e9689 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -91,7 +91,8 @@ repository.  For example:
 ----
 prefix=$(git rev-parse --show-prefix)
 cd "$(git rev-parse --show-toplevel)"
-eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"
+# rev-parse provides the -- needed for 'set'
+eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
 ----
 
 --verify::
-- 
2.11.0.390.gc69c2f50cf-goog

