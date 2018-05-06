Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E08C200B9
	for <e@80x24.org>; Sun,  6 May 2018 20:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeEFUmh (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 16:42:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40936 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751814AbeEFUmg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 16:42:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E7AB260760;
        Sun,  6 May 2018 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525639354;
        bh=8oWA2yBQ4do7x6gUcBA3VrmaUL76UZXRmwwYnlP2AwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hAicPKAsPnadgpi5jWY5aQWg1/r6Qd7uE4KDgtkYHvlo8KRVbmLr0e9hoEg1qN26Q
         NThptifmczl7PYdLdb8b93YHtb9gyk3Gn/EY3x7Wl4RAkBnGdyJbI6tAA7OXmdq+TE
         8rpI1fTrwXiNrso5u09TksNGnA496gMesvnXHMk6eGqdkziYPqRjs5FlNd+gXq6kx5
         WZz8OABOWXjXRbu4jgecjFsu06hnyWP7DJxj//Gvjn6fRyyWzz+9+5EzUnh5RtY1Qt
         vwqBy6XjOBiUIi/pOdA+xLUoKZXeFk2VD0Q4QuoDDy3i57URqZXQGzbEBxXo+xHkL9
         U47XQnrsLpi7EuC6iz29NSFmITwumd5ComYHSf+dSqD4HT8WLLqfroE01zGe2FHmfh
         C1znpbLBPT8BCFzjtWZbbsIqhbhboXD02y55TfSgbz+18tZXKZ/dop2XzyNu92a9q2
         i7oRRgKZ7Iju2oH9+/Lik2M39fxzmgyq+Amg7p4u+M9cbx+dCsi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 2/2] Documentation: render revisions correctly under Asciidoctor
Date:   Sun,  6 May 2018 20:42:26 +0000
Message-Id: <20180506204226.955739-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506204226.955739-1-sandals@crustytoothpaste.net>
References: <20180504015202.GP13217@genre.crustytoothpaste.net>
 <20180506204226.955739-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating a literal block from an indented block without any sort of
delimiters, Asciidoctor strips off all leading whitespace, resulting in
a misrendered chart.  Use an explicit literal block to indicate to
Asciidoctor that we want to keep the leading whitespace.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
A future direction we could go here would actually be to turn this into
a table, which might render more acceptably in all forms.  But I think
this patch provides a useful improvement and we can switch to a table
later if desired.

 Documentation/revisions.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dfcc49c72c..8f60c9f431 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -345,6 +345,7 @@ Here are a handful of examples using the Loeliger illustration above,
 with each step in the notation's expansion and selection carefully
 spelt out:
 
+....
    Args   Expanded arguments    Selected commits
    D                            G H D
    D F                          G H I J D F
@@ -367,3 +368,4 @@ spelt out:
 	  = B ^B^1 ^B^2 ^B^3
 	  = B ^D ^E ^F          B
    F^! D  = F ^I ^J D           G H D F
+....
