Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965D61F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfIPTA5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:00:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35963 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:00:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so840258lff.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAxd3Uf4ktT/GcOEQjNp+7eJUiWpfUxduKWXuS9Xik4=;
        b=VVC3zU8rs1wNp6n9WJGOKskgOfuA//lB5qhpd3+fk0gU7s8yIg1544Ga+GUE+4p2GX
         1uH5Q6SnvsMKUWqExj8aWRtEVr1DEw/6/qgw/kDvWK+nvP7pnxQ2FTIaPj/OQa6xZ/ZV
         O606frGd3VyVuAyf//8WVdKC03uGfx2k2l7nAc+Quq35Rd14PG+U4zZzgUG4w39wA13i
         471pJgTCH5gplb+9VP0XAfz/vjVLmNPc9Zfjv/tMiaYIZKcPyCjTwCDdfr1MJVJ6dvXA
         s4G+g9YG2f5WSEg9BRLaxROMUEYikge7icee/++IER75Lk9IQQChEzz63QUgtHwasnPr
         yP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAxd3Uf4ktT/GcOEQjNp+7eJUiWpfUxduKWXuS9Xik4=;
        b=i3mKXmV/7yJrD8JzoGM8TXuG+1mmrdDgmUv59vDHvYrVb/+jslxol3khI631qmHBV7
         ME988OGBqGjLxy8/SiHDLe7eXwOETvJ4UkiMGE3302ONGPYdTwmudISsuS1+zEIPnBGS
         pkBomU1PYzCnpX0WqXjfICkV5elI1JdaSkiLdEuMJlwipu0a9cHYWiMk/NQoqa/MRW/u
         mXAi5s7iVMj1ceLO9C9Tvr/v4JD3EsnFwPgs/hiXEqbPU57VCyI1h90flZtvQh5VbSGR
         qdlbrreTJYQLeafVW7LzEFzm+auGdCYDo/F6NVSdXnrWtwTjT5rGiO8yn3KrPKNmn8KN
         Pctg==
X-Gm-Message-State: APjAAAUxjaAFfgPC70eW2tKTguPpiB2Ao01RXyHQBkrPmIIxpncLp3ME
        o/Fd3YcJLeZ+6mDQYe/vTR8RSSoL
X-Google-Smtp-Source: APXvYqx1+YaQh1JnAJ90WDWK1+PUtuQEquopQ4NlaMaD0UP49cW7HXrtOxAirs4vbod7gQynwdGnbw==
X-Received: by 2002:ac2:4a89:: with SMTP id l9mr497835lfp.122.1568660452513;
        Mon, 16 Sep 2019 12:00:52 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j28sm9127608lfh.57.2019.09.16.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:00:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] asciidoctor-extensions: provide `<refmiscinfo/>`
Date:   Mon, 16 Sep 2019 21:00:27 +0200
Message-Id: <4eb89fda71a647bd44aa1d308674e7694db7b17d.1568658269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568658269.git.martin.agren@gmail.com>
References: <cover.1567534373.git.martin.agren@gmail.com> <cover.1568658269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As can be seen from the previous commit, there are three attributes that
we provide to AsciiDoc through asciidoc.conf. Asciidoctor ignores that
file. After that patch, newer versions of Asciidoctor pick up the
`manmanual` and `mansource` attributes as we invoke `asciidoctor`, but
they don't pick up `manversion`. ([1] says: "Not used by Asciidoctor.")
Older versions (<1.5.7) don't handle these attributes at all. As a
result, we are missing one or three `<refmiscinfo/>` tags in each
xml-file produced when we build with Asciidoctor.

Because of this, xmlto doesn't include the Git version number in the
rendered manpages. And in particular, with versions <1.5.7, the manpage
footers instead contain the fairly ugly "[FIXME: source]".

That Asciidoctor ignores asciidoc.conf is nothing new. This is why we
implement the `linkgit:` macro in asciidoc.conf *and* in
asciidoctor-extensions.rb. Follow suit and provide these tags in
asciidoctor-extensions.rb, using a "postprocessor" extension where we
just search and replace in the XML, treated as text.

We may consider a few alternatives:

  * Inject these lines into the xml-files from the *Makefile*, e.g.,
    using `sed`. That would reduce repetition, but it feels wrong to
    impose another step and another risk on the AsciiDoc-processing only
    to benefit the Asciidoctor-one.

  * I tried providing a "docinfo processor" to inject these tags, but
    could not figure out how to "merge" the two <refmeta/> sections that
    resulted. To avoid xmlto barfing on the result, I needed to use
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
postprocessor example [2]. I looked into two other approaches:

  1. The nokogiri library is apparently the "modern" way of doing XML
     in ruby. I got it working fairly easily:
        require 'nokogiri'
        doc = Nokogiri::XML(output)
        doc.search("refmeta").each { |n| n.add_child(new_tags) }
        output = doc.to_xml
     However, this adds another dependency (e.g., the "ruby-nokogiri"
     package on Ubuntu). Using Asciidoctor is not our default, but it
     will probably need to become so soon. Let's avoid adding a
     dependency just so that we can say "search...add_child" rather than
     "sub(regex...)".

  2. The older REXML is apparently always(?) bundled with ruby, but I
     couldn't even parse the original document:
        require 'rexml/document'
        doc = REXML::Document.new(output)
        ...
     The error was "no implicit conversion of nil into String" and I
     stopped there.

I don't think it's unlikely that doing a plain old search-and-replace
will work just as fine or better compared to parsing XML and worrying
about libraries and library versions.

[1] https://asciidoctor.org/docs/user-manual/#builtin-attributes

[2] https://asciidoctor.org/docs/user-manual/#postprocessor-example

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 0089e0cfb8..85f14c7c11 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -20,9 +20,26 @@ module Git
         end
       end
     end
+
+    class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
+      def process document, output
+        if document.basebackend? 'docbook'
+          mansource = document.attributes['mansource']
+          manversion = document.attributes['manversion']
+          manmanual = document.attributes['manmanual']
+          new_tags = "" \
+            "<refmiscinfo class=\"source\">#{mansource}</refmiscinfo>\n" \
+            "<refmiscinfo class=\"version\">#{manversion}</refmiscinfo>\n" \
+            "<refmiscinfo class=\"manual\">#{manmanual}</refmiscinfo>\n"
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

