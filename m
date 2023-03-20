Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D3FC6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 19:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjCTTJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCTTIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 15:08:53 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4048A41
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 12:01:11 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v2-20020a056830090200b0069c6952f4d3so7288526ott.7
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679338850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxc+KTon3BFkYCQjHDZuU/CZRzzz9k9A2O5pc85qWi4=;
        b=S0fzQZ3U5Gu9jnaUQk+Y8h2C4+QlzqXCmqP1dU72HxnDo79glx6/UUL0BPK+ZvgxvI
         +xh5Qak601YYRW6oe0Q6WaKH51TfNL6kLAaA+KeBWmfS9ZE8/a4P18WVFFkTlx/mzVRV
         EjUzxxn7Wk+ygU/60QQA51ZPr8BXHFTK8DE8bSyAiZLPQ0PNLARwMdDyYHylTrQrQO0C
         OrBikk/4q1h0a8yDUiqhSkB+q/7tVnpejUjKgKEPOXm+3GDV7RP4gzihUXTdo5gPaPgX
         sH6XxIYvL+JDU4SSTM98WOKI8YjTO7fZHHUSq6c1NOO86rSc7XEBPdfudhVXhiu7ngXO
         TlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bxc+KTon3BFkYCQjHDZuU/CZRzzz9k9A2O5pc85qWi4=;
        b=EPpkpHk5pFOi341iVqKINz66RjXYIi28UzaJYGM64kFXUQs3RMzoMlnSj2sw6hfOvD
         lRQHBXaLsW6sRIfgT+oILBp6kqwhHrdeYw6Cj4WbsyhxXDRqg2+C5oSoaa/5Hklflb5i
         KXZlmJ4cHF6slQiJvJl2SjZqYqOZQOMI5hgUW0M5yp++D02fasrZPDeaQvHM93c4fXsD
         WWD+Wp9b32Q+zXi5mmmEFg9a4mQw2SlzTEEw6bz/kOt2fY0heCodyIZ6NHxrYmtpsyF4
         NFnXlmcrb/GVWM7lXGU4ur2Yp1PsAcmoOyxULiJZtWPumwuqoeH4azmu9D//tzPdawS9
         mmWw==
X-Gm-Message-State: AO0yUKUU12RUYxKVIYOqyAcTY+iKQ17tbVEb55LKku0Woc0WlXgAU9EN
        NMShLJ93lxkddv5YSMqCpMX3iwR0lq0=
X-Google-Smtp-Source: AK7set8EFiURJRLzJb/cnypfWCQwdJH0KUYKr+3bp5mXFhX5naRtXN7qUUS9ntXv8OeJyDBPhdT+EQ==
X-Received: by 2002:a05:6830:1404:b0:69c:ddae:a1b2 with SMTP id v4-20020a056830140400b0069cddaea1b2mr605656otp.1.1679338849766;
        Mon, 20 Mar 2023 12:00:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e18-20020a0568301e5200b0069abd1e5573sm4268145otj.17.2023.03.20.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 12:00:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] doc: remove GNU troff workaround
Date:   Mon, 20 Mar 2023 13:00:47 -0600
Message-Id: <20230320190047.79836-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2007 the docbook project made the mistake of converting ' to \' for
man pages [1]. It's a problem because groff interprets \' as acute
accent which is rendered as ' in ASCII, but as ´ in utf-8.

This started a cascade of bug reports in git [2], debian [3], Arch Linux
[4], docbook itself [5], and probably many others.

A solution was to use the correct groff character: \(aq, which is always
rendered as ', but the problem is that such character doesn't work in
other troff programs.

A portable solution required the use of a conditional character that is
\(aq in groff, but ' in all others:

  .ie \n(.g .ds Aq \(aq
  .el .ds Aq '

The proper solution took time to be implemented in docbook, but in 2010
they did it [6]. So the docbook man page stylesheets were broken from
1.73 to 1.76.

Unfortunately by that point many workarounds already existed. In the
case of git, GNU_ROFF was introduced, and in the case of Arch Linux
a mapping from \' to ' was added to groff's man.local. Other
distributions might have done the same, or similar workarounds.

Since 2010 there is no need for this workaround, which is fixed
elsewhere, not just in docbook, but other layers as well.

Let's remove it.

[1] https://github.com/docbook/xslt10-stylesheets/commit/ea2a0bac56c56eec1892ac3d9254dca89f7c5746
[2] https://lore.kernel.org/git/20091012102926.GA3937@debian.b2j/
[3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507673#65
[4] https://bugs.archlinux.org/task/9643
[5] https://sourceforge.net/p/docbook/bugs/1022/
[6] https://github.com/docbook/xslt10-stylesheets/commit/fb553434265906ed81edc6d5f533d0b08d200046

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile               |  8 --------
 Documentation/manpage-quote-apos.xsl | 16 ----------------
 Makefile                             |  4 ----
 3 files changed, 28 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9c67c3a1c5..a6ba5bd460 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -191,14 +191,6 @@ MAN_BASE_URL = file://$(htmldir)/
 endif
 XMLTO_EXTRA += -m manpage-base-url.xsl
 
-# If your target system uses GNU groff, it may try to render
-# apostrophes as a "pretty" apostrophe using unicode.  This breaks
-# cut&paste, so you should set GNU_ROFF to force them to be ASCII
-# apostrophes.  Unfortunately does not work with non-GNU roff.
-ifdef GNU_ROFF
-XMLTO_EXTRA += -m manpage-quote-apos.xsl
-endif
-
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
diff --git a/Documentation/manpage-quote-apos.xsl b/Documentation/manpage-quote-apos.xsl
deleted file mode 100644
index aeb8839f33..0000000000
--- a/Documentation/manpage-quote-apos.xsl
+++ /dev/null
@@ -1,16 +0,0 @@
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<!-- work around newer groff/man setups using a prettier apostrophe
-     that unfortunately does not quote anything when cut&pasting
-     examples to the shell -->
-<xsl:template name="escape.apostrophe">
-  <xsl:param name="content"/>
-  <xsl:call-template name="string.subst">
-    <xsl:with-param name="string" select="$content"/>
-    <xsl:with-param name="target">'</xsl:with-param>
-    <xsl:with-param name="replacement">\(aq</xsl:with-param>
-  </xsl:call-template>
-</xsl:template>
-
-</xsl:stylesheet>
diff --git a/Makefile b/Makefile
index 50ee51fde3..60ab1a8b4f 100644
--- a/Makefile
+++ b/Makefile
@@ -207,10 +207,6 @@ include shared.mak
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
-# Define GNU_ROFF if your target system uses GNU groff.  This forces
-# apostrophes to be ASCII so that cut&pasting examples to the shell
-# will work.
-#
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
-- 
2.39.2.13.g1fb56cf030

