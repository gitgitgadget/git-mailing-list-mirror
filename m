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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD231F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfICSv6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:51:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42934 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfICSv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:51:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id u13so13730909lfm.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vt3vOzqN7elKceBe6oa2ENrExrRMrNxPTH6Dn/8E+H8=;
        b=AxEuRtkY1qzs2nB7oyrl84+a+Pbix/wLfz+Z/SGdkavK2RC0T6tGxR5yoZ/9JZY9Nj
         1eT+FI3U+ILVkAiL22zFcvLGlsjRlbY1mU18AMHniseAGCf3ddcwidLzXsTlotTSy7rE
         6zmTv+CY6aqVy33x15PyomaAMER7fuWvFzjpcagfnCnxITl/vGdWw0QK8IwpOlrSGYqh
         maEUdPDIDHIhaBwrUI0cvG7dRBbRpHiYonBeWtxiWasqFqvfhmd1hFYg6ZDIwZO/NxWJ
         910OfEm/2NeVI++n8TBE3LDM0RjHJntOdBhARmq2qLovXYKrsDW5HpwY2i3i/PRTcX7K
         PiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vt3vOzqN7elKceBe6oa2ENrExrRMrNxPTH6Dn/8E+H8=;
        b=oky9geQoiGiSKGK875EM2E4Ho/+ls/HS9SwqGP1TdRLomCqV4AnhXs0pHanEZI/1Ch
         +05VTF9IAjDhL5PADB4SXzruucTZwxcbLKtg6aiuMTkupX3f9Rqbntp/v7VoLungP+Pd
         izDSBcKTs3KuAISz0bIHZZExpzqFBtmzaET/P5GZyIE+7bw3IttMlbM6lyMfEkWzvplk
         WXahP0kBsoW5A88tVuFLZOJSvnw1HjJvlqnYegUxvJCicgaWUY7bSfaMb/LUkApV4BW1
         T7K0Kw+S9srkMAhWw85y6d4xjJs4rFkPo8fLtX26Uz4E0y1NiGmOJA72WWDdAJvc7u9p
         XEuw==
X-Gm-Message-State: APjAAAWX4oObXHG/rMYrFkEx6qCmyOQAOrIIRpx3c6YfEwi50oYzHzHu
        WWaLStiIs0p6WCFxVVQlX2GGNdiP
X-Google-Smtp-Source: APXvYqzAuSGKrkUivG24lBzW/b7dTubDF5/qKPpN5aO8diIgh0oUMHMKWhrWKropnOgpSx5C5pVo8w==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr7842367lff.184.1567536715317;
        Tue, 03 Sep 2019 11:51:55 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id s21sm2971443ljm.28.2019.09.03.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 11:51:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] asciidoctor-extensions: provide `<refmiscinfo/>`
Date:   Tue,  3 Sep 2019 20:51:20 +0200
Message-Id: <7545b16bd845580548dee380a54891ed1f75290f.1567534373.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567534373.git.martin.agren@gmail.com>
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com> <cover.1567534373.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we build with AsciiDoc, asciidoc.conf ensures that each xml-file we
generate contains some meta-information which `xmlto` can act on, based
on the following template:

  <refmeta>
  <refentrytitle>{mantitle}</refentrytitle>
  <manvolnum>{manvolnum}</manvolnum>
  <refmiscinfo class="source">Git</refmiscinfo>
  <refmiscinfo class="version">{git_version}</refmiscinfo>
  <refmiscinfo class="manual">Git Manual</refmiscinfo>
  </refmeta>

When we build with Asciidoctor, it does not honor this configuration file
and we end up with only this (for a hypothetical git-foo.xml):

  <refmeta>
  <refentrytitle>git-foo</refentrytitle>
  <manvolnum>1</manvolnum>
  </refmeta>

That is, we miss out on the `<refmiscinfo/>` tags. As a result, the
header of each man page doesn't say "Git Manual", but "git-foo(1)"
instead. Worse, the footers don't give the Git version number and
instead provide the fairly ugly "[FIXME: source]".

That Asciidoctor ignores asciidoc.conf is nothing new. This is why we
implement the `linkgit:` macro in asciidoc.conf *and* in
asciidoctor-extensions.rb. Follow suit and provide these tags in
asciidoctor-extensions.rb, using a "postprocessor" extension where we
just search and replace in the XML, treated as text.

We may consider a few alternatives:

  * Provide the `mansource` attribute to Asciidoctor. This attribute
    is only respected (i.e., turned into those <refmiscinfo/> tags) with
    1) the "manpage" doctype and/or converter [1], which we currently do
    not use, or 2) using Asciidoctor 1.5.7 or newer [2].

  * We could inject these lines into the xml-files from the *Makefile*,
    e.g., using `sed`. That would reduce repetition, but it feels wrong
    to impose another step and another risk on the AsciiDoc-processing
    only to benefit the Asciidoctor-one.

  * I tried providing a "docinfo processor" to inject these tags, but
    could not figure out how to "merge" the two <refmeta/> sections that
    resulted. To avoid xmlto barfing on the result, I needed need to use
    `xmlto --skip-validation ...`, which seems unfortunate.

Let's instead inject the missing tags using a postprocessor. We'll make
it fairly obvious that we aim to inject the exact same three lines of
`<refmiscinfo/>` that asciidoc.conf provides. We inject them in
*post*-processing so we need to do the variable expansion ourselves. We
do introduce the bug that asciidoc.conf already has in that we won't do
any escaping, e.g., of funky versions like "some v <2.25, >2.20".

The postprocessor we add here works on the XML as raw text and doesn't
really use the full potential of XML to do a more structured injection.
This is actually precisely what the Asciidoctor User Manual does in its
postprocessor example [3]. I looked into two other approaches:

  1. The nokogiri library is apparently the "modern" way of doing XML
     in ruby. I got it working fairly easily:
        require 'nokogiri'
        doc = Nokogiri::XML(output)
        doc.search("refmeta").each { |n| n.add_child(new_tags) }
        output = doc.to_xml
     However, this adds another dependency (e.g., the "ruby-nokogiri"
     package on Ubuntu). Using Asciidoctor is not our default, but it
     will probably need to become so soon (AsciiDoc relies on Python 2,
     which is going away). Let's avoid adding a dependency just so that
     we can say "search...add_child" rather than "sub(regex...)".

  2. The older REXML is apparently always(?) bundled with ruby, but I
     couldn't even parse the original document:
        require 'rexml/document'
        doc = REXML::Document.new(output)
        ...
     The error was "no implicit conversion of nil into String" and I
     stopped there.

Having never dabbled with ruby outside of this very file, I might be
missing something obvious, but I don't think it's unlikely that doing a
plain old search-and-replace will work just as fine or better compared
to parsing XML and worrying about libraries and library versions.

[1] https://asciidoctor.org/docs/user-manual/#builtin-attributes
[2] https://public-inbox.org/git/20190319074321.GA2189@sigill.intra.peff.net/
[3] https://asciidoctor.org/docs/user-manual/#postprocessor-example

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 0089e0cfb8..4ae130d2c6 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -20,9 +20,24 @@ module Git
         end
       end
     end
+
+    class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
+      def process document, output
+        if document.basebackend? 'docbook'
+          git_version = document.attributes['git_version']
+          new_tags = "" \
+            "<refmiscinfo class=\"source\">Git</refmiscinfo>\n" \
+            "<refmiscinfo class=\"version\">#{git_version}</refmiscinfo>\n" \
+            "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n"
+          output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
+        end
+        output
+      end
+    end
   end
 end
 
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
+  postprocessor Git::Documentation::DocumentPostProcessor
 end
-- 
2.23.0

