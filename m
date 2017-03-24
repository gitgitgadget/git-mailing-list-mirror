Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33541FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935979AbdCXSlc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36125 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935915AbdCXSlY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so2252537wmf.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb5vW3GBrytlU1iAB9X/y6F8Gs+JnLJBxo32d8oFTR4=;
        b=EKZN6xlTsAHBWH+OwBzL8ZBvVMqmGZdeDfo4ytpOFDA/2LDBpEIzvq5OdF//2hD32H
         d7Uk5S3DVeNkFVxGzXxanhEYNuYjmsW6Cgp02CvDCux9VlIbvQT82g+KZbVM7zMv44yq
         haeUm1IoMzvVAfm8kllnnzjWll5tLLkkCF7k/ei86yx+k/6Ete1fBE7PHYkG0xUTyUAu
         dbub6TUNwgToH8ZAu5ZURy+qZykc1M+vkUftyU7i4fw+OFAqXKvp9mkC7FnRU1fpx7QS
         Eu4k5dMu2Blm0/DQl7wb+pgoPC9Ktr7l2/60C9SqSAX5K7klEfTfo2XxQT3KWn/Pmq7P
         PGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb5vW3GBrytlU1iAB9X/y6F8Gs+JnLJBxo32d8oFTR4=;
        b=qVhfcRvxKw70h/JdDZasOsVSGMN0z3n2g6OJ3ydaoYgY7NiXwcx6wRbr79grnTxuzf
         JuVIykOnQ/aUmCv511O0/5ZVdNk1O7pLaamkD/ZVtD5gi5IpY1R2oR4cnJBkiOVX7FtD
         +5i/tAwxMf+Y8Gt2C8tkWXFDCt7O+6nhDTI7xONH0E8ADxAZZ0byI5fLle8PPe8dh5HZ
         a5UZhoOpOSH0lZm1thnWVxLUmdDrzXYKmI7ve3Ti5YeJ3TxWqIq+2JhTsnlwZOhqGwK0
         Zr5/mIHkpLPFCzTKTL7csKqnFv8P3uYOSpATLtWR06jBngDgueAaEU1H+MP8QmP2/ybE
         skTw==
X-Gm-Message-State: AFeK/H1h302JQjkrH+qY7OeXtX1S6rC90aGie4aCbyFrqLM7FiHhi9g7YA+aaPjS1g5L2g==
X-Received: by 10.28.126.17 with SMTP id z17mr4396242wmc.33.1490380881981;
        Fri, 24 Mar 2017 11:41:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/16] tag doc: reword --[no-]merged to talk about commits, not tips
Date:   Fri, 24 Mar 2017 18:40:46 +0000
Message-Id: <20170324184059.5374-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the wording for the --merged and --no-merged options to talk
about "commits" instead of "tips".

This phrasing was copied from the "branch" documentation in commit
5242860f54 ("tag.c: implement '--merged' and '--no-merged' options",
2015-09-10). Talking about the "tip" is branch nomenclature, not
something usually associated with tags.

This phrasing might lead the reader to believe that these options
might find tags pointing to trees or blobs, let's instead be explicit
and only talk about commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 68b0ab2410..3abf912782 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -125,11 +125,11 @@ This option is only applicable when listing tags without annotation lines.
 	specified).
 
 --merged [<commit>]::
-	Only list tags whose tips are reachable from the specified commit
-	(`HEAD` if not specified).
+	Only list tags whose commits are reachable from the specified
+	commit (`HEAD` if not specified).
 
 --no-merged [<commit>]::
-	Only list tags whose tips are not reachable from the specified
+	Only list tags whose commits are not reachable from the specified
 	commit (`HEAD` if not specified).
 
 --points-at <object>::
-- 
2.11.0

