Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EFB320248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCKJ0L (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:26:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55446 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCKJ0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:26:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id q187so3606924wme.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utjyoUHjK9rYWafxvafvygkE7i4paZkW+hXf0ZD0Lxw=;
        b=bA2+cnt3X7cpmDnyf8jD6mn7NLmaD4R7Ptur1d90g2c1n5EkH5iFgI9qbjFdog4SgN
         jFnxH33He1SjXErn1SWVQBc+n48jGZZ9BpT0awYzOn4i5la9uF9+N8G6FExkiFaiJZyO
         P+w7sQ+uY3zbEc9uzC25GO/r2j4gc15JB+iXdZ3cSaV574vNBfgrkGsTJ72vWlmRbTa5
         sT5AwC2bEh3W2E85en1USULaB7cpivKbux5tkAvOtKEx6W40ijp40JRmdkih7x8Zeex4
         OE9BVuLjWOlX56gNR4Sv+DC2uEUnTffWKn+E/4ugdV5A97Zxdx7gvtSFa6BjzQJpSKQP
         QQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=utjyoUHjK9rYWafxvafvygkE7i4paZkW+hXf0ZD0Lxw=;
        b=hTbxEM/DdHw+IhIqLyVqbn53KyakyMfMpSxMPIKNDFcU1+Iil2aB6HlLlHSeb2C0ob
         bqcu0FxsOLujNvP79JOaYyhF3qkFNpJyUzNfstbzY7EbP/+3LwWf51B60RWBWehyN+ps
         kQusmhc1afrvyU3tXPvHo+LPz3wdc1H4EVDHQdKI7E56YIvALp/I2jMqmY7fLxbRG9dr
         bicv7ZIsYo9A2xX+TfnZIqEIr/qrMMoMorDVRxWF5NhjmW6z6W1BbJrRO0H5V4f98xgg
         Sw8YG2ibLDL3KpHVnYUBt0pqIk6f4wIRDa+Vdwl4lhRlfRz5J4Rc7w1wJChOMqSLfXuG
         LJYA==
X-Gm-Message-State: APjAAAU5dtplr/+cRXM8K47uVfBmcDPCl+0AL/M5MzgfoU4OrHpB7eVY
        dB2AZ0x5r71MKfO6z8Q281G3MXkaS4Q=
X-Google-Smtp-Source: APXvYqyJ6WPofqXDbGzLzJ58NLnqK3X6+ExLu+D8YMY2D6Ffq8eEbucXh+9wXMTURodPQtDq8dFJrA==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr15701964wmf.119.1552296368571;
        Mon, 11 Mar 2019 02:26:08 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id i4sm4547665wrw.19.2019.03.11.02.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:26:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 3/3] asciidoctor-extensions: fix spurious space after linkgit
Date:   Mon, 11 Mar 2019 18:26:05 +0900
Message-Id: <20190311092605.259322-3-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-155-ge902e9bcae
In-Reply-To: <20190311092605.259322-1-gitster@pobox.com>
References: <xmqq4l89kbkr.fsf@gitster-ct.c.googlers.com>
 <20190311092605.259322-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Ågren <martin.agren@gmail.com>

When we render, e.g., "linkgit:gitglossary[7]." with Asciidoctor, we get
"gitglossary(7) ." with a space between the linkgit macro expansion and
the punctuation. We can fix this by dropping the trailing newline after
we've turned `linkgit:foo[bar]` into `<citerefentry>..</citerefentry>`.

The diff produced by `USE_ASCIIDOCTOR=Yes ./doc-diff HEAD^ HEAD` is
almost 6000 lines large and shows how this fixes "git-foo(x) ,", "(see
git-bar(y) )" and so on. One might wonder whether this also turns, e.g.,
"see linkgit:foo[1] for more" into "see foo(1)for more", but no. We get
"...</citerefentry> for more" in the XML, see, e.g., git-am.xml, so the
space ends up in git-am.1 just fine. The same is true for the HTML output.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/asciidoctor-extensions.rb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index ec83b4959e..0089e0cfb8 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -11,12 +11,12 @@ module Git
       def process(parent, target, attrs)
         if parent.document.basebackend? 'html'
           prefix = parent.document.attr('git-relative-html-prefix')
-          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>\n)
+          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
             "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-          "</citerefentry>\n"
+          "</citerefentry>"
         end
       end
     end
-- 
2.21.0-155-ge902e9bcae

