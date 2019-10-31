Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE9E1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 06:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJaGW7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 02:22:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38019 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfJaGW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 02:22:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id q28so3617592lfa.5
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8g+DUPfOw7/ltFQvoZapaE1d1m9c6/3grOJHquOPjrM=;
        b=aQ3zTLqMFo72TKwUlyabV0n2GfiWDW5AbBbQpp3NJ63TFhWjNWb23vEkM4MqgEk3v3
         awXJ4dLSQVtMRtyTnpKzhypDL0d0c2ig256B1EDnpF3LnUiD0UcuZmLuyASOfeKrE3zW
         4zvxl1AWI9BNi/vqnmIChkIEUAYfD3FsTfaCbKHYu5XvO4zjt60utVZZ2vDMILSAAeCW
         uTQMVZO13MdxS6tDPRQzJaWtPXjOtt/km6n0u/Vq0TlQb205MoIa1UKybmgEFAWpv+n6
         yjy6ygVp46PdmjayDpF5e8qGsSTHlF1yTXRTTMS3mAnglU7oNHlhkmt3lmM8j526zUq0
         oWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g+DUPfOw7/ltFQvoZapaE1d1m9c6/3grOJHquOPjrM=;
        b=aQuiC9OQgQFxRQZrvJttPOprAGNj4pDbiOfD1wUhbCAVnOogUO3LHXjIimIAojPocf
         s1r8nfVvF6e6Z1LiTbKTYWTB6BGLkIosYlaqlkDYrjo2iL3CpxWzOXFeEch5TRmjdgCM
         EQnsP7oXiijxnM+V3b3FKWIvspB6EIS7MP7l3nL1fUYR4ISFj06g7DFHFBYUvNPBs8eq
         yKOnvURlokJ9YAyaqv1mjt3yckFwyADeYK2R6RZ9YQOeEfgBmIh7KPt7tMMHWlsV6RkU
         qabC7uPrSJGCjYKkEkklHsmSylvxtnk3PiHcUkaRQiO0OD/jQMrFndpMG5FhuoIEasaS
         OR9w==
X-Gm-Message-State: APjAAAVmRvV+/AbhbqDASLevAoQ8ajaNQA/5EdrGyLhplmrv3WC3/HDK
        8Oq8wQ+8N7NzUZCoQ1YpZKimsERr
X-Google-Smtp-Source: APXvYqxSurUGQ9oerciQqJ8RrlnGrQyudhCh7cbD1lVTt5DsrYxdGq+iiIaHIuHu+ACxFB7kB9kkuw==
X-Received: by 2002:ac2:420a:: with SMTP id y10mr1859121lfh.65.1572502975606;
        Wed, 30 Oct 2019 23:22:55 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 132sm1195405lfk.8.2019.10.30.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 23:22:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] manpage-bold-literal.xsl: match for namespaced "d:literal" in template
Date:   Thu, 31 Oct 2019 07:22:27 +0100
Message-Id: <20191031062227.14535-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191030204104.19603-1-martin.agren@gmail.com>
References: <20191030204104.19603-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently regressed our rendering with Asciidoctor of "literal"
elements in our manpages, i.e, stuff we have placed within `backticks`
in order to render as monospace. In particular, we lost the bold
rendering of such literal text.

The culprit is f6461b82b9 ("Documentation: fix build with Asciidoctor 2",
2019-09-15), where we switched from DocBook 4.5 to DocBook 5 with
Asciidoctor. As part of the switch, we started using the namespaced
DocBook XSLT stylesheets rather than the non-namespaced ones. (See
f6461b82b9 for more details on why we changed to the namespaced ones.)

The bold literals are implemented as an XSLT snippet <xsl:template
match="literal">...</xsl:template>. Now that we use namespaces, this
doesn't pick up our literals like it used to.

Match for "d:literal" in addition to just "literal", after defining the
d namespace. ("d" is what
http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
uses.) Note that we need to keep matching without the namespace for
AsciiDoc.

This boldness was introduced by 5121a6d993 ("Documentation: option to
render literal text as bold for manpages", 2009-03-27) and made the
default in 5945717009 ("Documentation: bold literals in man",
2016-05-31).

One reason this was not caught in review is that our doc-diff tool diffs
without any boldness, i.e., it "only" compares text. As pointed out by
Peff in review of this patch, one can use `MAN_KEEP_FORMATTING=1
./doc-diff <...>`

This has been optically tested with AsciiDoc 8.6.10, Asciidoctor 1.5.5
and Asciidoctor 2.0.10. I've also verified that doc-diff produces the
empty output for all three programs, as expected, and that with the
MAN_KEEP_FORMATTING trick, AsciiDoc yields no diff, whereas with
Asciidoctor, we get bold literals, just like we want.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Range-diff against v1:
1:  fb5372c3cf ! 1:  a22ed4896c manpage-bold-literal.xsl: provide namespaced template for "d:literal"
    @@ Metadata
     Author: Martin Ågren <martin.agren@gmail.com>
     
      ## Commit message ##
    -    manpage-bold-literal.xsl: provide namespaced template for "d:literal"
    +    manpage-bold-literal.xsl: match for namespaced "d:literal" in template
     
    -    We recently regressed our rendering of "literal" elements in our
    -    manpages, i.e, stuff we have placed within `backticks` in order to
    -    render as monospace. In particular, we lost the bold rendering of such
    -    literal text.
    +    We recently regressed our rendering with Asciidoctor of "literal"
    +    elements in our manpages, i.e, stuff we have placed within `backticks`
    +    in order to render as monospace. In particular, we lost the bold
    +    rendering of such literal text.
     
         The culprit is f6461b82b9 ("Documentation: fix build with Asciidoctor 2",
         2019-09-15), where we switched from DocBook 4.5 to DocBook 5 with
    @@ Commit message
         match="literal">...</xsl:template>. Now that we use namespaces, this
         doesn't pick up our literals like it used to.
     
    -    Add an exact copy of the template where we match for "d:literal" instead
    -    of just "literal", after defining the d namespace. ("d" is what
    +    Match for "d:literal" in addition to just "literal", after defining the
    +    d namespace. ("d" is what
         http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
    -    uses.) Note that we need to keep the non-namespaced version for
    +    uses.) Note that we need to keep matching without the namespace for
         AsciiDoc.
     
         This boldness was introduced by 5121a6d993 ("Documentation: option to
    @@ Commit message
         2016-05-31).
     
         One reason this was not caught in review is that our doc-diff tool diffs
    -    without any boldness, i.e., it "only" compares text.
    +    without any boldness, i.e., it "only" compares text. As pointed out by
    +    Peff in review of this patch, one can use `MAN_KEEP_FORMATTING=1
    +    ./doc-diff <...>`
     
         This has been optically tested with AsciiDoc 8.6.10, Asciidoctor 1.5.5
         and Asciidoctor 2.0.10. I've also verified that doc-diff produces the
    -    empty output for all three programs, as expected.
    +    empty output for all three programs, as expected, and that with the
    +    MAN_KEEP_FORMATTING trick, AsciiDoc yields no diff, whereas with
    +    Asciidoctor, we get bold literals, just like we want.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
    @@ Documentation/manpage-bold-literal.xsl
      <!-- render literal text as bold (instead of plain or monospace);
           this makes literal text easier to distinguish in manpages
           viewed on a tty -->
    -+<xsl:template match="d:literal">
    -+	<xsl:value-of select="$git.docbook.backslash"/>
    -+	<xsl:text>fB</xsl:text>
    -+	<xsl:apply-templates/>
    -+	<xsl:value-of select="$git.docbook.backslash"/>
    -+	<xsl:text>fR</xsl:text>
    -+</xsl:template>
    -+
    - <xsl:template match="literal">
    +-<xsl:template match="literal">
    ++<xsl:template match="literal|d:literal">
      	<xsl:value-of select="$git.docbook.backslash"/>
      	<xsl:text>fB</xsl:text>
    + 	<xsl:apply-templates/>

 Documentation/manpage-bold-literal.xsl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/manpage-bold-literal.xsl b/Documentation/manpage-bold-literal.xsl
index 608eb5df62..94d6c1b545 100644
--- a/Documentation/manpage-bold-literal.xsl
+++ b/Documentation/manpage-bold-literal.xsl
@@ -1,12 +1,13 @@
 <!-- manpage-bold-literal.xsl:
      special formatting for manpages rendered from asciidoc+docbook -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		xmlns:d="http://docbook.org/ns/docbook"
 		version="1.0">
 
 <!-- render literal text as bold (instead of plain or monospace);
      this makes literal text easier to distinguish in manpages
      viewed on a tty -->
-<xsl:template match="literal">
+<xsl:template match="literal|d:literal">
 	<xsl:value-of select="$git.docbook.backslash"/>
 	<xsl:text>fB</xsl:text>
 	<xsl:apply-templates/>
-- 
2.24.0.rc2

