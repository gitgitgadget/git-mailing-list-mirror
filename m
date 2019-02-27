Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD2F202AA
	for <e@80x24.org>; Wed, 27 Feb 2019 18:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfB0SST (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 13:18:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39814 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbfB0SSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 13:18:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id r123so4805328lff.6
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 10:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZROV2dCTtGt6ENXRib+oJmIG1iQR8S3Z9ZVmLuiJDK8=;
        b=RHHj668/en9Md5IClhv2Dk44UFSsmBUsF7V0ZqJ7kIPtyNkvhvN0+wXU38LSupP9aC
         pDqzL2cpzn0hNXG1Lib1s5nJDCgvCnKJcM28+HC78xqsyAYEaxCMGhFDilhOnH0TkjpW
         Z/XsZDI5Y/E5dUUMqXF4KqyeyRn6pkxiNalGIcR6sbkCdFHYPhVa0GslRbILp6hLJJUj
         boz9/c1HA9u0aZiDLnk/QhCUVOPPb1Fg/wgqdU4rDa+icLXUTjDQMhJpnq/1ZFwIhsD0
         VgrCkS42I8hKQC0TUTn81eUEoaShbSOfBoTe0/dAM8iurqq8nQW8ZPY5Zxc9mk+ju0LP
         EGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZROV2dCTtGt6ENXRib+oJmIG1iQR8S3Z9ZVmLuiJDK8=;
        b=SfVxIyK5xydmU0nish1PCHMNnjMkEn5sTLMymynDIcc3VSv2IpqEu6IR2d5mA4ln9R
         KG1dhRUt28YXzOdCkfidD5lcsFcYFdf7yA0wHYJL8o3IACYPNi8Jo5NVnpxTfMERYe/l
         aEMXheYzc2tgZ5m6M6Mnq0si9znO8WU+uzuzA7k2dkQZEeiE0h1V9qZq9Wswp7yvtZaB
         2aX/k5zjumrMrX9JoZvCaKKXPG6dbudIFEv4O9DhW/cLH99GUXqn1tk61MVZtDWLNoNX
         uEw81oQSJn0VO1qO3VSkweUXE7Zw7Ip+s3a1xlqaDdb3gdHAzZRjgn53dblSS/BhMla2
         d94Q==
X-Gm-Message-State: AHQUAubIe8TsxqsFRhCx7FmBRxnueRUo5WDii6/SuLwgJ5JgAZqNQA1y
        ByQhsY1C38yO2HHwvlHPLR4d6pVz
X-Google-Smtp-Source: AHgI3IYG+tVzkyivQW8Hn0ZRpwARWrU6iemJD9/mpjlgeQdflHYcxLRRwgBM9JVRW6I5DKz+HTCDLA==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr1682271lfi.3.1551291495672;
        Wed, 27 Feb 2019 10:18:15 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f19sm547297lfk.69.2019.02.27.10.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 10:18:14 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] Documentation/Makefile: add missing xsl dependencies for manpages
Date:   Wed, 27 Feb 2019 19:17:52 +0100
Message-Id: <6f08eb292e9b6774c21c0d9276506f055596703a.1551290936.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551290936.git.martin.agren@gmail.com>
References: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com> <cover.1551290936.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These stylesheets very rarely change, but when they do, it really helps
if the manpages depend on them. We're casting the net a bit too wide
here, since we'll only ever use a subset of the stylesheets, but since
these files change so rarely, that should be ok. It's better than
missing a dependency.

Observe that manpage-base-url.xsl is a generated file, so we need to
list it explicitly, besides the `wildcard` expression we're adding here.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 26a2342bea..0f8054a115 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -354,7 +354,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl
+%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-- 
2.21.0

