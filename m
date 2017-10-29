Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8463D202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 21:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbdJ2VT2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 17:19:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55674 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751794AbdJ2VTZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 17:19:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DB1F46044B
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 21:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509311965;
        bh=BAdApp3byiwYOVHhVgg/afsg5gDoV4+qdDe0GV8NjaE=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=eYOBF6qRTD7fHvLz4zw1VvTlh9MB/pr/H0m8ju+Er8H8iCa0i5sdWqhAZaV41ua5w
         7V3ZYrXS4AgCQTcg11gfP8Kl74XBnAi1aO8kMCZXHJU5cfCGpt6J9TM82CIhTzAM6x
         0P3kU5ccnIVe9s24sq8IhrzaYEWl1MZ1vA3+2jsbc7Q+CsPaiGvb0jd/JPkFvvDVul
         0zppF5mBxm7HmHF7Sr4B0zKhAHIJys7wFctkTOqJ7NtNxldEgf8WrDqhH41hX1EjT4
         tWPCdjE8uNaPhKP2nGo3YSbEQoR5zhXnTGemvPs3hfPG8Spn2uqp5ZCH4g8V3edmHS
         JvmdO63zUK2QrGph+IMg7yp4RHygnZzhHw0HDFADMkOvoRzTtibVu0a2nslPmwAVBp
         atcr7Ctlz7MGkWErwfGEtBIOS/4zDPEVtKdNG1hijgKAycHsjOvN0XWgYmWqQ8IYoy
         dClhgyBKarFKK2heOGCyk3Kx0moXEYG8iiH73n7CgHysQjvEXLI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] Documentation: enable compat-mode for Asciidoctor
Date:   Sun, 29 Oct 2017 21:13:07 +0000
Message-Id: <20171029211308.272673-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc2.357.g7e34df9404
In-Reply-To: <20171029211308.272673-1-sandals@crustytoothpaste.net>
References: <20171029211308.272673-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor 1.5.0 and later have a compatibility mode that makes it more
compatible with some Asciidoc syntax, notably the single and double
quote handling.  While this doesn't affect any of our current
documentation, it would be beneficial to enable this mode to reduce the
differences between AsciiDoc and Asciidoctor if we make use of those
features in the future.

Since this mode is specified as an attribute, if a version of
Asciidoctor doesn't understand it, it will simply be ignored.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 471bb29725..d5ad85459e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -181,6 +181,7 @@ ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook45
+ASCIIDOC_EXTRA += -acompat-mode
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
