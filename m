Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935FE20248
	for <e@80x24.org>; Sun, 17 Mar 2019 14:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCQOsd (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 10:48:33 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44710 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfCQOsd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 10:48:33 -0400
Received: by mail-lj1-f169.google.com with SMTP id n18so9816655ljg.11
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgksJhoSSa6y/Tq736UclA51dTxHGOigr8DPc9uKMvY=;
        b=U6/TzkbXFLlUz5g1+kp3R8UeC8Fi/fvLhrnRcI3rAgjXwCDwvlTBHv9SuslXmP9O1E
         ejdA49CpXTdDaiHzzIV2hDWXrsuO5rJ98T52MpNZge1tEkjjDt32wdSpvkvUxZnwU6EI
         2qPTr4Gd1xS4zZTyUFQTny50NVGLfUNAF9OtHRy7OzpJL+AeC4ljYrbj/SS/G+4UH7pO
         3bIypw+E97bYz522+j1JZOPiGsJ8ieBmw9RDSuAArIJYVwyaY+ljeEkYF6mKcG6HO+t9
         5JmQNeuqN+BH7ogZTr++iVQ46QEeZ6zlA+JWOReCtUFUrkIb7Z1oKOzXAy7Wf+KvVArB
         dJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgksJhoSSa6y/Tq736UclA51dTxHGOigr8DPc9uKMvY=;
        b=gruciG83cAOkE7BEG+l+Npql8Rq1G13jrQS39Jr3Qh0gosXDshfSFj2dgUBtWWzdpu
         hO2PV2bakWRB06pJ1CpYycYGcWeBVSDcE0L2oVUA//iejO0m8UJeQAlMPr95s6hdx4Bf
         arAuPT3khXNARJ/v8zyk3J6Rg7RQGETaUQlA6yBF2XN9LykGMAf4lj7rhLTC8qfO+kNp
         Uf+ogsvlCnj0An2f6PhDHw46JT5TwrNY7IOk7pI4dWoYHv3pkpxEBmkQIjmL4PHv030k
         Muf4OYdMmlYY4NHkRHgZ5OpWlCvWF9VOuPOPl9z9tpKmC1CzkUtqmifx5GC/7u+6gInf
         pzAA==
X-Gm-Message-State: APjAAAX9bsjTOEskZJT7m7ZVIDkzFgRJ4o4hTykd8MGk3FDEcaTEi0H2
        JgpG0f/xxu1JgvAT5Bsy1OX773/H
X-Google-Smtp-Source: APXvYqxLo5Bb9M03RVqWVii7B2DPfxwkOAKBbP9PtIRfQYpn6g/Sgqo52sDkKbF0AylrF6ZtL3tXLQ==
X-Received: by 2002:a2e:500d:: with SMTP id e13mr4868169ljb.169.1552834109599;
        Sun, 17 Mar 2019 07:48:29 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d26sm1571068ljc.15.2019.03.17.07.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 07:48:27 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Date:   Sun, 17 Mar 2019 15:47:47 +0100
Message-Id: <20190317144747.2418514-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
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
asciidoctor-extensions.rb, using a "postprocessor" extension.

We may consider a few alternatives:

  * Provide the `mansource` attribute to Asciidoctor. This attribute
    looks promising until one realizes that it can only be given inside
    the source file (the .txt file in our case), *not* on the command
    line using `-a mansource=foobar`. I toyed with the idea of injecting
    this attribute while feeding Asciidoctor the input on stdin, but it
    didn't feel like it was worth the complexity in the Makefile.

  * Similar to that last idea, we could inject these lines into the
    xml-files from the Makefile, e.g., using `sed`. This reduces
    repetition, but seems fairly brittle. It feels wrong to impose
    another step and another risk on the Asciidoc-processing only to
    benefit the Asciidoctor-one.

  * Considering the above abandoned ideas, it seems better to put any
    complexity inside asciidoctor-extensions.rb. It is after all
    supposed to be the "equivalent" of asciidoc.conf. I considered
    providing a "tree processor" extension and use it to set, e.g.,
    `mansource` mentioned above.

Let's instead try to stay as close as possible to what asciidoc.conf
does. We'll make it fairly obvious that we aim to inject the exact same
three lines of `<refmiscinfo/>` that asciidoc.conf provides. The only
somewhat tricky part is that we inject them *post*-processing so we need
to do the variable expansion ourselves.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Cc Todd and Peff who had a brief exchange [1] a while ago. Apparently
 Todd saw this "[FIXME: source]" on Fedora but Peff did not on Debian.
 I'm on Ubuntu 18.04 and used to see this also on 16.04. I'm not sure
 what might make Debian so special here.

 [1] https://public-inbox.org/git/20180627164443.GK20217@zaya.teonanacatl.net/

 I've based this on ma/asciidoctor-fixes, not because it's needed for
 the patch itself, but because it provides a15ef383e7
 ("Documentation/Makefile: add missing dependency on
 asciidoctor-extensions", 2019-02-27), which ensures that the
 documentation will be rebuilt. I'm hoping this was the right call.

 Documentation/asciidoctor-extensions.rb | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 0089e0cfb8..059279dee1 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -20,9 +20,25 @@ module Git
         end
       end
     end
+
+    class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
+      def process document, output
+        if document.basebackend? 'docbook'
+          git_version = document.attributes['git_version']
+          replacement = "" \
+            "<refmiscinfo class=\"source\">Git</refmiscinfo>\n" \
+            "<refmiscinfo class=\"version\">#{git_version}</refmiscinfo>\n" \
+            "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n" \
+            "<\/refmeta>"
+          output = output.sub(/<\/refmeta>/, replacement)
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
2.21.0

