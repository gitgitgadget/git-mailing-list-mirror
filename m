Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618A420248
	for <e@80x24.org>; Sun, 10 Mar 2019 15:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfCJPO7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 11:14:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40499 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfCJPO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 11:14:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id w6so1857559ljd.7
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOSfh6udrnk+JT44AT6Nv3BPxdnhJyL5U8NYYx4jJaI=;
        b=i4eqol2zKJClryAlXtaAYuwgbp2YE5FUqGNcoatTGqeQyMCLe3lRtXu/f6n39wkJP2
         JkKHjrnxrSJokiUEzMLCXB+oWhb2vjcnRRSXPZ2xgaSfHH6M95+0sbHYVBqdEhmsOfSN
         mQUW75f2uQuyBkzqcUOv0QkJRWD+FKRF1vLunFwJ+hnpbrf/Fm9NX9kOZRD7692guQ7S
         YuwAgcg4g3ElIveXjp3ULkPC6RaPe8X+qY6D3UDuFpG74w5Eq7ssvu9OnlXqCrYadvbU
         vwqctHX2J0hLxCRu2Mbm29HfAF8AFb3kc5ai3LNBd+cFFdghWVE9l+V6DlFb/SrKr+nk
         H09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOSfh6udrnk+JT44AT6Nv3BPxdnhJyL5U8NYYx4jJaI=;
        b=TvPSVB2M0tu7SL53drQ8x7qT60jEKqmszGHao0EyBSBRbnrOZwKHLVX6V/zeYzjqET
         LBgZjt7rfNhZkrxsv1yfRAOg7Zs71YVhkiPaokXIniEZRV6fxgj4tK9VppwksXMbio9q
         1RFSUkPBB7/eLLdsHj41p8sLBty4j7w7aMFKpQ9L4dvI9hjkfCByuR/WKBPvWxe0DRBI
         THiSUwuCvnD3j8oHRpaV+9TrOWZuNyNI0ASo1zJFxQls8V6DaI2oPpooamHrijmRkXtJ
         1VdU/SgLcjZkvlobZeUYSPV2hQxmSK82ZStxM7PBJhzw+lIukbyWnDI1VaWYn4j4B4M9
         WE+g==
X-Gm-Message-State: APjAAAXeP3jXAaZQRbQeu/QzKc16lObLJ+BG4XGMTfz8BqxzXDOlU10m
        qGzHaaL5amVFSHa/NPzahrUnRVX2
X-Google-Smtp-Source: APXvYqwVPLUGT0qN6kcdTNkmQw+lwBw5OUbWvhGV73tvRzJdF6/5WbVdkCJ8RqhNFsu2kMdX17GPqQ==
X-Received: by 2002:a2e:918d:: with SMTP id f13mr15579052ljg.151.1552230896138;
        Sun, 10 Mar 2019 08:14:56 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id v20sm568292ljv.83.2019.03.10.08.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 08:14:55 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] Documentation/Makefile: add missing dependencies on asciidoctor-extensions
Date:   Sun, 10 Mar 2019 16:14:23 +0100
Message-Id: <7ec45f69fabee22f2a9b4e08c5ba7d88b32814be.1552230490.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552230490.git.martin.agren@gmail.com>
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com> <cover.1552230490.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I really should have caught this when I wrote 00c87bceaa
("Documentation/Makefile: add missing dependency on
asciidoctor-extensions", 2019-02-27). That commit made sure that the
xml-files depend on our Asciidoctor-specific extensions, but that just
helps for the ".txt -> .xml -> .[157]" transformations.

Because we produce the html-files directly as ".txt -> .html" -- not as
".txt -> .xml -> .html" --, we need to make the html-files too depend on
asciidoctor-extensions.rb.

There's one exception to the above paragraph. We do render
user-manual.html by going through an intermediate user-manual.xml, which
is an explicit, special-cased target. Add the missing dependency to
user-manual.xml.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f63c775e88..f58904a929 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -334,12 +334,12 @@ clean:
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
 
-$(MAN_HTML): %.html : %.txt asciidoc.conf
+$(MAN_HTML): %.html : %.txt asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
+$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
@@ -356,7 +356,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-user-manual.xml: user-manual.txt user-manual.conf
+user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d book -o $@+ $< && \
 	mv $@+ $@
-- 
2.21.0

