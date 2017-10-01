Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FA620A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 00:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdJAAKu (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 20:10:50 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:51026 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdJAAKt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 20:10:49 -0400
Received: by mail-pf0-f176.google.com with SMTP id m63so1376953pfk.7
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jpny290P78BG3DfdCNXocbfwX/3ftxXLIrFQsdzQjE4=;
        b=iKicQx4CQTm+bA/5BehrG+1r2GQjeM1TZsd0XNt8PKOT8UHpzVRhKWXvxRT12N6oCu
         pLMW2+wkg+TgfnHupS2KFpyLRWQSdxdt7vMHmfJxm/AGjl6JCWNpDVUNlSXnq4KFQSQj
         FQpms7YTtJ9a3w0NJaYsk9oa+mU90KXR7O6NH9B2/NQf7sbqhTtGGREWpkixp5qvJAWI
         LghRqE7MYtDu+ut5/0ODUA+tIQ6Aa7+mVcnKw9rxADvtD66hjQ1b6bPp8MN7nEgBTYHn
         GB9tSbrhwPSiXDeyjbab+H4jT+IvoubO7ojttNkyckeFDtQK5H95hy/zpAu8KsNsZjPS
         q09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jpny290P78BG3DfdCNXocbfwX/3ftxXLIrFQsdzQjE4=;
        b=G8AdFUmMqVFVmaZU5w3nm8wU5GpI4ZMyNxzRflVKzfLOAMm1OGCwLsmQZxYBYqKOBI
         MuKR7pA8JU+MpLQNTXVcmi7QNzYxaP/OypGJ605O0b4yEpBCnS+AA+WNdqmL5OSlxpFX
         irUwn5j4XmFMNDBR9FmifVarsn+AUVoGF+jST9jhiaoxXebAyeCAPXMU9sAd9DMY6kUV
         qMiLTtuc7TL8j8e9WXc7ueN4rCd+tEub/Ph6PskiONGnJermkEeQGi+RhhQ2HBc19NZC
         Z1Yu6nvAh3V/sPJEC/R5wHJaDWsr9JibrCSWZyMX0RekjDhDNc+UBXwLWMt5HO4xCOSo
         HWzw==
X-Gm-Message-State: AMCzsaX1FTTav08w0+AzrlCruAKrCEMjUGy3harCgRPGOgpij1mT9HNF
        M7I2qwBxDDzpPvBEuLwwMXoC/xWLALQ=
X-Google-Smtp-Source: AOwi7QCnVjdVf5AMOOYEetsQohsDdTfV4XaMPJGvACNEDxszNcv3UrEXv/nTTDSLJfb9/IrnHzE7sA==
X-Received: by 10.99.60.23 with SMTP id j23mr1354613pga.318.1506816648542;
        Sat, 30 Sep 2017 17:10:48 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id s17sm11002669pgq.25.2017.09.30.17.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 17:10:46 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 3/6] doc: 'trailers' is the preferred way to format trailers
Date:   Sat, 30 Sep 2017 17:10:34 -0700
Message-Id: <20171001001037.23361-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001001037.23361-1-me@ttaylorr.com>
References: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001001037.23361-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation makes reference to 'contents:trailers' as an example
to dig the trailers out of a commit. 'trailers' is an unmentioned
alternative, which is treated as an alias of 'contents:trailers'.

Since 'trailers' is easier to type, prefer that as the designated way to
dig out trailers information.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 03e187a10..6b38d9a22 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -213,7 +213,8 @@ line is 'contents:body', where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as 'contents:trailers'.
+are obtained as 'trailers' (or by using the historical alias
+'contents:trailers').
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
-- 
2.14.1.145.gb3622a4ee

