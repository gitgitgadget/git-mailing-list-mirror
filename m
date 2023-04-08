Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF3C76196
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 00:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDHASe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 20:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDHASc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 20:18:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6AE07F
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 17:18:32 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j12so141517oij.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680913111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTrQD8nWGbK3LZmK8VhC6zvagZSZHkSAQtv1U0Akca4=;
        b=VIzGjqx8mawlu+HoXlbo/HcCYyI80uWiXnsXCweybWIq6+nlNZFs2CYHtkqCAIE9LT
         sMZGxMVcYWLmKq/lqAKHp9yKtYNSy+OqLUHIRD3rYTfE1zZbkcDjodr8cB41334NaOLf
         baqQWwYW1eEPq2I+2kT367lLwRXnE+CTAGwdD8t3b171kI4eJH8gBru0tzMCEKB63BAq
         wpFprsJLi3KWVlPkvZkM9N6oi4d8Jp7s/cLYmG1jdcgWzHdIDk7790S+j2VNqn8t2oVT
         zoE/qMY+Ojgjot3lmSrDFWTllbCRPkT5bDryJ8XrTXR30+vwOnDqe8xceqw/Qr5bi03j
         7/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680913111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTrQD8nWGbK3LZmK8VhC6zvagZSZHkSAQtv1U0Akca4=;
        b=VEz0p0Hyb8Q8UZCkVgmF/BoZdWYMUXUP7OqsF3i9PS42IqMue2mvPAJExgXRKc7sqZ
         +QhpqEbxvLsusY/dOoWFsxDjNiyc84WL8Zib9meul3hexVUNkFzG2MvRxVo2ywdmhfNU
         +FW41qwkmHm5kb9RZFn9i7z5LWJj9HCnm75iBeHm3Q1DPHv9Vr/0KxoHq+83Tu6Lt+bp
         iPsWle00rhEzED8Qn6bjJ5ycs2bCC3Hk/NRGY27+x6hZH0kH6bveiCV6LX10xjpS/gka
         ixSIYmW5rwEeENZPDz4lo04ktYNkDsPXfSP+eW9FmUNepPDKnnvHx5F5Dj12mh99iM35
         aNaA==
X-Gm-Message-State: AAQBX9dPawyTOCatKfLtNzpYRa+Vscq43ghXLpk9I/WpF3WHpChYhSV7
        AU03GgCuKBlB0+WQS6fFPMMYFoig470=
X-Google-Smtp-Source: AKy350b1VrPJzVG587LNMOnCN491fTPq8k/HanZOfh7fVxBHxYYgomGALmI30l5toHRKbUhyzHPDlA==
X-Received: by 2002:a05:6808:1454:b0:378:916e:2959 with SMTP id x20-20020a056808145400b00378916e2959mr336398oiv.34.1680913111051;
        Fri, 07 Apr 2023 17:18:31 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ex19-20020a056808299300b003875e29808esm2141235oib.0.2023.04.07.17.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 17:18:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: simplify man version
Date:   Fri,  7 Apr 2023 18:18:29 -0600
Message-Id: <20230408001829.11031-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hacks to add version information to the man pages comes from 2007
7ef195ba3e (Documentation: Add version information to man pages,
2007-03-25). In that code we passed three fields to DocBook Stylesheets:
`source`, `version`, and `manual`, however, all the stylesheets do is
join the strings `source` and `version` [1].

Their own documentation explains that in pracice the source is just a
combination of two fields [2]:

  In practice, there are many pages that simply have a version number in
  the "source" field.

Splitting that information might have seemed more proper in 2007, but it
not achieve anything in practice.

Asciidoctor had support for this information in their manpage backend
since day 1: v1.5.3 (2015), but it didn't include the version. In the
docbook5 backend they did in v1.5.7 (2018), but again: no version.

There is no need for us to demand that that they add support for the
version field when in reality all that is going to happen is that both
fields are going to be joined.

Let's do that ourselves so we can forget about all our hacks for this
and so it works for both asciidoc.py, and docbook5 and manpage backends
of asciidoctor.

[1] https://github.com/docbook/xslt10-stylesheets/blob/master/xsl/common/refentry.xsl#L545
[2] https://docbook.sourceforge.net/release/xsl/current/doc/common/template.get.refentry.source.html

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a6ba5bd460..4721b000c1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -150,8 +150,7 @@ ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-amanversion=$(GIT_VERSION) \
-		-amanmanual='Git Manual' -amansource='Git'
+		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
-- 
2.40.0+fc1

