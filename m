Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA1520248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfCKJ0J (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:26:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33013 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCKJ0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:26:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id c13so13447625wmb.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/g2/Vfyeed/N1mnUE5TzGuRK5sB67STSierLZVFlSE=;
        b=stmT/XYXZri66nHYwjXYlWDyixzpdd31YX1dUczdjjJypJrFto2XzXjmFAMp1DBjLU
         nd7Qg258END+sstOAcFzJXQhjZRoD2LRngqtGywxTuhGw+d7Jox3k4QdKefJY1uwswsl
         wvDRCIO9I9HLgnBFgnobfMatynt0xUsmQ0qXA4DUlQyIUmY9ozwMR0F7ezC1jc7kXjW8
         OmNliEUtLPlAbOYyXef1Hv6y/RCkoAb+zcAsQOpDEsOxnnp21Le4j4MSeJPmho5mT+iJ
         jne8c0cY9UPAuemkUQ2RCrq2uUwbIV7FNXb9GXGz+o5r5LumFqqnF9JT1g+eT9LMsnYC
         6iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v/g2/Vfyeed/N1mnUE5TzGuRK5sB67STSierLZVFlSE=;
        b=sNN6Obko5d20wM9T+mounM3lQfnYzznSmI+jIJCA/9Y8xa1kcTba7041aDPgJFtMmS
         BgtZVGzJdbpMGReZ5ZPhiLwPn/cb4F51OS56/gcI8StsSL2ioSIMuKVs6HsIw8lY9uVt
         VYVi41D7WujdzUswg8r73nERBRJWwQpZ9VKkfoloOJ9pzk4aH7Vy691RSK/2bLVr/ssG
         V/4dPFZPrEslOgdjQjdpIiyMLQoJt+92ybcIwQUqus+vWHZlmaMoF+neJqlx4zSM0BJw
         Pg1LtIJZguj6cb2yj77R1IpV6Iv/6XsRZqFjH8o/n7qYfidyFbzsh28S8x2+ofY8JfDl
         //rw==
X-Gm-Message-State: APjAAAWKmtYEfF9YpjEqH/zzsMFjDmlbE+2V7N8i57MWXhBfUfybjaM/
        RJ3lbXIDjowSwwVgSKUsRjVTaMqZkL4=
X-Google-Smtp-Source: APXvYqxLKMAGqi8CwduK0LbWU/6W7WjEqOGSScOtKjOc/nBx9OyWsLSRzDdHAl2KqIwxLUE/KW8VZQ==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr16026658wmj.13.1552296366072;
        Mon, 11 Mar 2019 02:26:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id q10sm4629856wrr.75.2019.03.11.02.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:26:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 1/3] Documentation/Makefile: add missing xsl dependencies for manpages
Date:   Mon, 11 Mar 2019 18:26:03 +0900
Message-Id: <20190311092605.259322-1-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-155-ge902e9bcae
In-Reply-To: <xmqq4l89kbkr.fsf@gitster-ct.c.googlers.com>
References: <xmqq4l89kbkr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Ågren <martin.agren@gmail.com>

These stylesheets very rarely change, but when they do, it really helps
if the manpages depend on them. We're casting the net a bit too wide
here, since we'll only ever use a subset of the stylesheets, but since
these files change so rarely, that should be ok. It's better than
missing a dependency.

Observe that manpage-base-url.xsl is a generated file, so we need to
list it explicitly, besides the `wildcard` expression we're adding here.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d5d936e6a7..ea6b8e5d72 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -347,7 +347,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl
+%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-- 
2.21.0-155-ge902e9bcae

