Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141C3201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 22:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbdKLWH1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 17:07:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56018 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751039AbdKLWHZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 17:07:25 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE0EB6049A;
        Sun, 12 Nov 2017 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510524444;
        bh=BAdApp3byiwYOVHhVgg/afsg5gDoV4+qdDe0GV8NjaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=06ZtmtdNMeLlpeNxqVgawDXyiNoJM7GO2d6D15kEpo+77JaLs5ZQotpWDQqkpmLlU
         G73dSiAbV/TUUFqnoQ66ULJFOx3CL4VuR1J2xaAsWVQTffG7TWbX5xh71upFFWyd3M
         /tceR/j+UVOeNiwDYDn5na3blj9+Em2l4BP0GSUcRb4Eg8H5XljXcAru4G2tZ+Yvx5
         BCfwxOyjzTuR/gEsw6XhQkSYZ4rPUDl2q1Yt/Jmy0zDK0UD56SHqCagw7zWrBVcMj2
         2rSK6SEs2tqr9JfKGK/IrW6texOwIr5D54CLxidUCI9yZDqQmnnVRrtUABF22x//lu
         qqsVaZEkhNBj2klDFRhj3FWybnDZj6DwtD+mCGI97xRj88CVo9huyBbZ1//fyGoZRE
         FTFVqhjO5e4zxK9/+x9QojCnuPMc+MHKJ20aztBOEBb+ueLOtijDgnBvhVKMbSD25S
         VSMq+2lCw2lL/7a/XejmlE3Evi2ZrMkpGmT4NVxtt+94SJIWjTX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 1/2] Documentation: enable compat-mode for Asciidoctor
Date:   Sun, 12 Nov 2017 22:07:17 +0000
Message-Id: <20171112220718.792129-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
In-Reply-To: <20171112220718.792129-1-sandals@crustytoothpaste.net>
References: <20171112220718.792129-1-sandals@crustytoothpaste.net>
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
