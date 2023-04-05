Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E9C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 12:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjDEMzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjDEMzA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 08:55:00 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6EE30FE
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 05:54:59 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so24236805fac.8
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK1Xco8E1W2swSPSZT2L0LZjOaQmZhHGFmD88EHcQJ4=;
        b=lmJNp7tZ7ZhHG+b3Ihm9XOFAq/zctm4xK0OLnZ5aFgHfnPNI+Q/I8kX8pjk+BUDOiq
         16bQrxRfK7Qui2XvTHcicrvUIhdK1N0iOnjm7iicfBQjLGEO17ui2N2Oqwl+XBgkD4Sh
         0JFQvOaxPlZ5i1AYwA1MSz7vtlkYNzjo1pt1Ub1FMdjWLgJ6Pa6cmzzIcHRQ1uigxA50
         WG1Jzc0x9vKtwULKCq6+TJtNdNacUZ+SQUWLstx4dEan2Sv2QjBBJsjW+2BF42SzW96z
         TxkGJWM1L1pl6aYNW4J++AbIIM0DjyfzVHAEpXBZPyIVoXtHCblfmlmaaqDZhhoVvVfN
         fPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK1Xco8E1W2swSPSZT2L0LZjOaQmZhHGFmD88EHcQJ4=;
        b=7KTHPcxA7dKV2XtyGtA/NuklXeDdK0vPl0RB02xJuR5gfAgYbNkWyRYfYKmSQNglTe
         rAt8DIpn3bLlhLh3WasJzEQWJRvlPBzzuG87F0Wcxm9xccf+z71IuLtNbLDptH2uBxiX
         70C1s6HExVViQ/xOv7JixLBzjBAux/UMj0LtTK4KSehAFfzScHFg+oWk/z86fn65Zrbi
         M1Kq+oNY8hIBcpGGu+zwNz/deS7NQhT7aRgVtLRmuPOgRIdFp5uAMgSrYSxodgYwrus2
         Jl1x2+8DCbUh0KAZKlgw+gtHC+E5K3vQUw8tqTG8DYBOqsgF/h/t2DBteoz5lRvXSxt7
         I7hg==
X-Gm-Message-State: AAQBX9cpC6ZbpkD7b0+eRzc0DbqCFeIkenBloAflRMFVwesA0pinbxAN
        2wKUGFlvHIQ7WrdEpj9CK3MgGRUJOAo=
X-Google-Smtp-Source: AKy350brrFxJaMVy4OvlAXU2A+Kg4iaD1klvumHw5vaqjAuB31o6Q8cWrIbt57JH5UXy/k8JqTH4Ig==
X-Received: by 2002:a05:6870:2114:b0:17a:d2ab:aeb8 with SMTP id f20-20020a056870211400b0017ad2abaeb8mr3799748oae.33.1680699298395;
        Wed, 05 Apr 2023 05:54:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id xy9-20020a05687123c900b001718e65a5d0sm5327249oab.57.2023.04.05.05.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:54:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 2/3] doc: use deprecated syntax in doc guideline
Date:   Wed,  5 Apr 2023 06:54:52 -0600
Message-Id: <20230405125453.49674-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230405125453.49674-1-felipe.contreras@gmail.com>
References: <20230405125453.49674-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Everyone has moved on but us.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/DocumentationGuideline.adoc | 26 +++++++++++------------
 Documentation/Makefile                    |  2 +-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/DocumentationGuideline.adoc b/Documentation/DocumentationGuideline.adoc
index 940c09c905..8f1300f898 100644
--- a/Documentation/DocumentationGuideline.adoc
+++ b/Documentation/DocumentationGuideline.adoc
@@ -20,7 +20,7 @@ This is a line which contains special characters: < > &
 ----
 
 The tools used to generate the documentation will convert these special characters when appropriate, for example for
-HTML they will be converted to `\&lt; \&gt; \&amp;`, so you don't have to worry about that (for reference check
+HTML they will be converted to `&lt; &gt; &amp;`, so you don't have to worry about that (for reference check
 {2}[Special Character Substitutions]).
 
 Formatting can be easily added:
@@ -139,22 +139,22 @@ https://docs.asciidoctor.org/asciidoc/latest/[AsciiDoc Language Documentation]
 == Caveats
 
 Because the format is so straightforward, one might be tempted to forget that we are using a markup language, but it is
-a language, and certain strings have certain interpretations, for example `+{tilde}+` is going to be substituted with the
+a language, and certain strings have certain interpretations, for example `{tilde}` is going to be substituted with the
 `tilde` attribute (`~`).
 
-So one can't just use `+{foo}+` haphazardly, these texts have to be escaped. For example with `+\{foo}+`. So one should
-write `+master@\{upstream}+`. However, other texts, such as `{<foo>}` can't be attributes, so escaping would show the
+So one can't just use `{foo}` haphazardly, these texts have to be escaped. For example with `\{foo}`. So one should
+write `master@\{upstream}`. However, other texts such as `{<foo>}` can't be attributes, so escaping would show the
 backspace.
 
-To avoid all these problems, one should use literals `pass:[+foo+]`.
+To avoid all these problems, one should use literals `pass:[`foo`]`.
 
 ----
 * {<tilde>}
 * \{<tilde>}
 * {tilde}
 * \{tilde}
-* +{tilde}+
-* +{<tilde>}+
+* `{tilde}`
+* `{<tilde>}`
 ----
 
 Renders as:
@@ -164,23 +164,21 @@ Renders as:
 * \{<tilde>}
 * {tilde}
 * \{tilde}
-* +{tilde}+
-* +{<tilde>}+
+* `{tilde}`
+* `{<tilde>}`
 ====
 
-However, more often than not what we want to show is `+{tilde}+`, not +{tilde}+, so in those cases what we want is
-literal monospace text, so we have to add backticks: `pass:[`+{tilde}+`]`. For more information see {4}[Literal
-Monospace].
+For more information see {4}[Literal Monospace].
 
 This isn't theoretical, developers have been confused by this.footnote:[{5}]
 
-There are other replacements, such as `+<=+` replaced with `<=`. Which again: has confused people.footnote:[{6}]
+There are other replacements, such as `<=` replaced with `⇐`. Which again: has confused people.footnote:[{6}]
 
 So when in doubt just use literal monospace.
 
 === There's more
 
-But what happens if the literal text contains `{backtick}` or `{plus}`? In those cases you can use the inline `pass` macro:
+But what happens if the literal text contains `pass:[`]`? In those cases you can use the inline `pass` macro:
 
 ----
 The following characters must be encoded: `pass:[~!@#$^&*(){}\;",<>?'`+]`.
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 59b64a6d5e..bb29a0c87f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -373,7 +373,7 @@ SubmittingPatches.txt: SubmittingPatches
 	$(QUIET_GEN) cp $< $@
 
 %.html : %.adoc
-	asciidoctor -I . -r asciidoctor-extensions.rb -o $@ $<
+	asciidoctor -I . -r asciidoctor-extensions.rb -a compat-mode -o $@ $<
 
 XSLT = docbook.xsl
 XSLTOPTS =
-- 
2.40.0+fc1

