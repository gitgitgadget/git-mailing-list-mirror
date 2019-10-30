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
	by dcvr.yhbt.net (Postfix) with ESMTP id 51DD91F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJ3Ulp (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:41:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34929 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ3Ulp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:41:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so4210979lji.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri9fX47ASlq6iKe3Ho0UuZTcE45T9wBozHkLIoZWyIk=;
        b=cEf6rkTJK1WqcMHPLc2O0eeXMJuvhtdT3xGdLEYXqXytuBs4H5ozP4Dn18S1smtU/M
         G6GN6RENgAVYbi4QpYSOiKbEBj1+aYT0XEzeaCi0CTUXlGUbLCiEcWLT/Ae5gTfquxdV
         /TbZnnB28OzubeltLWkMT7BQipo6UzxB+je7LfFmduSoLpuCOZ3RQsyN4xzqSAUGnfYJ
         CI2xXwNRkz6tyOQHxCqnlHl5qqt1VCKSsxHKwEj/MBdZ4D8/sQfzsdZ+UYHOPUKWMEXS
         yRgCQ9vRh+O1gWTOFGyR1LzJRRcHwtkcYeob6QnpFsqASPl/bmGO2WWloDb9Ne8v/soP
         v4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri9fX47ASlq6iKe3Ho0UuZTcE45T9wBozHkLIoZWyIk=;
        b=F5BliauP7Va9pYxzIp19u2I7Gm239+UbiNZoeymFqCtPArvGKxD79e+48yNn6GrKhr
         WJ3HLr//+PCvPeR+PLGd/svFBd+pzvYH8pjAJt7sU4AdgoTNvWQWSuigXlNaQz4sSP5C
         DBHzTCkq6Q1/70+DXY6lfrsP+BafJ4AuQaITfEzWGFwhJDuMtuLqNvs5/E/h5OWG7Jix
         EQITMwfWIfMagyaK8abyVQKklQdjp+BMZje8mPWKhTvTZN7pbX/FVBZqYUiyUpwdfT2f
         MroyhhDdeCMAi4oTySIOn+2claDviujXZxpOa1kntanHqasfT3/23MuOQLO0YfNjkJom
         h/rw==
X-Gm-Message-State: APjAAAUrjxZPuuKkG5ioYzxq+PZNx+X9XBlOoG7jCULTLsOHJjj+rISE
        8o0cyoWQxO2Uwq7UfzYTJrTzg/Gr
X-Google-Smtp-Source: APXvYqxskuNUJkcYJTIwPiPJNDO0H0+mjeLs4AMlJBOG/mdT3ZMjVfO7bQHU22QxeyPsCNgtOO19Wg==
X-Received: by 2002:a2e:b4aa:: with SMTP id q10mr1164295ljm.250.1572468102830;
        Wed, 30 Oct 2019 13:41:42 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id w11sm58144lfe.56.2019.10.30.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 13:41:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH] manpage-bold-literal.xsl: provide namespaced template for "d:literal"
Date:   Wed, 30 Oct 2019 21:41:04 +0100
Message-Id: <20191030204104.19603-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently regressed our rendering of "literal" elements in our
manpages, i.e, stuff we have placed within `backticks` in order to
render as monospace. In particular, we lost the bold rendering of such
literal text.

The culprit is f6461b82b9 ("Documentation: fix build with Asciidoctor 2",
2019-09-15), where we switched from DocBook 4.5 to DocBook 5 with
Asciidoctor. As part of the switch, we started using the namespaced
DocBook XSLT stylesheets rather than the non-namespaced ones. (See
f6461b82b9 for more details on why we changed to the namespaced ones.)

The bold literals are implemented as an XSLT snippet <xsl:template
match="literal">...</xsl:template>. Now that we use namespaces, this
doesn't pick up our literals like it used to.

Add an exact copy of the template where we match for "d:literal" instead
of just "literal", after defining the d namespace. ("d" is what
http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
uses.) Note that we need to keep the non-namespaced version for
AsciiDoc.

This boldness was introduced by 5121a6d993 ("Documentation: option to
render literal text as bold for manpages", 2009-03-27) and made the
default in 5945717009 ("Documentation: bold literals in man",
2016-05-31).

One reason this was not caught in review is that our doc-diff tool diffs
without any boldness, i.e., it "only" compares text.

This has been optically tested with AsciiDoc 8.6.10, Asciidoctor 1.5.5
and Asciidoctor 2.0.10. I've also verified that doc-diff produces the
empty output in all three cases, as expected.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 I've kept thinking lately that "wow, are we behind on marking up stuff
 to be monospaced/boldened"...

 I'm pretty sure about the background here, but I'm not at all sure 
 that this is the prettiest or correctest fix.
 
 Not sure if this problem is bad enough (and the fix good enough) for
 this to go into 2.24, but I offer this anyway.

 There are more manpage-*.xsl -- manpage-suppress-sp.xsl looks like it
 would have the exact same problem. But before diving in too deep, I'd
 rather submit this one to see if it's in the right direction at all.

 Martin

 Documentation/manpage-bold-literal.xsl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/manpage-bold-literal.xsl b/Documentation/manpage-bold-literal.xsl
index 608eb5df62..172388d6cf 100644
--- a/Documentation/manpage-bold-literal.xsl
+++ b/Documentation/manpage-bold-literal.xsl
@@ -1,11 +1,20 @@
 <!-- manpage-bold-literal.xsl:
      special formatting for manpages rendered from asciidoc+docbook -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		xmlns:d="http://docbook.org/ns/docbook"
 		version="1.0">
 
 <!-- render literal text as bold (instead of plain or monospace);
      this makes literal text easier to distinguish in manpages
      viewed on a tty -->
+<xsl:template match="d:literal">
+	<xsl:value-of select="$git.docbook.backslash"/>
+	<xsl:text>fB</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:value-of select="$git.docbook.backslash"/>
+	<xsl:text>fR</xsl:text>
+</xsl:template>
+
 <xsl:template match="literal">
 	<xsl:value-of select="$git.docbook.backslash"/>
 	<xsl:text>fB</xsl:text>
-- 
2.24.0.rc2

