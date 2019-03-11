Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C3320248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCKJ0J (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:26:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfCKJ0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:26:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so3608718wmj.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UN1Chqz62Odjby61Uqy3M12OU4QqX7aXz3a4gP6nVqI=;
        b=gRf1bCV7fjfSzspcWfQsyKvXMOzgHol1JVZONh/tZPb/YlMFnHZ9o5eH8lt1vT1Dmh
         fejt2C89eEjEewq821MThfc90qzHikezWPtEUo3WNsS+lYDehx5Y9e8MI2t6lqQOqNHB
         uMdApLQ66n23ZvBez7y+6ZvxOtkMcRQVIenTDpuTwKqy48KxVOmaooc+iJxIDKtBnsMu
         pHl/9ECU36oKMglNUF/lrabbpAIFjfQmPQGDhJ6DZcXOD+zvkLlXozI54E2iH2kQaQU+
         zIEJD6c5U/OsM+qq7z8thbyGPNKFJDkPLCoeteRo1L05ed2xuseNzsdneRxsIAvH2Z8k
         mJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UN1Chqz62Odjby61Uqy3M12OU4QqX7aXz3a4gP6nVqI=;
        b=pTJf7TqmAJtm3XqeNJxUY2yohKJcGkr4wN2/MTNA1O4O/BnEJfs29oIuACUJkt949P
         CRSj1FYR7hamahUbZLnAW3NLrxODaFQveYkQOeNpIiIaBl5CxW+0qUeQNbBH+POxEKJ/
         ztgG7pv1zEGUqJ4VS6V54Ar2nr1a8HHKd8dkflKQ1OZx63VsSZRNkM/ER9eqGOU7+j9l
         G1mYlgDu77tKBjrShfYthmxltr0POVYqkGRzb6zFiAs2BTLTji8QHTAbViH/qBZ8Ei3l
         KnJsGgUwYqFzZuSYhc5Vb+B83J+86KKupXOExZiR487sHvdX8QPLEE9PiPuxdYEFle3r
         aoEQ==
X-Gm-Message-State: APjAAAUZZWcAxkP8XnJjRlvtELzQXekLRKY0lagx09jNSCEt6shL8nkJ
        1XmQVZJK+z0PVODl1SV2i4+hQcKT0Bs=
X-Google-Smtp-Source: APXvYqx9qSkZCtVDq63bZZymF+Ff8Yksqbjq9dYLmHQo8rgf+5KUz1nn2/zhq0di+C+M8MlHOgZwtw==
X-Received: by 2002:a1c:6045:: with SMTP id u66mr9585035wmb.133.1552296366964;
        Mon, 11 Mar 2019 02:26:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a8sm4579864wrt.79.2019.03.11.02.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:26:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 2/3] Documentation/Makefile: add missing dependency on asciidoctor-extensions
Date:   Mon, 11 Mar 2019 18:26:04 +0900
Message-Id: <20190311092605.259322-2-gitster@pobox.com>
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

asciidoctor-extensions.rb has never changed, but when it does -- such as
in the next commit --, it helps if the xml-files depend on it. We're
casting the net a bit too wide here, since we'll be rebuilding even with
AsciiDoc, which won't look at this file. But since this file changes so
rarely, that should be ok. It's better than missing a dependency.

Similarly, most of the html-files are produced directly from ".txt';
make the html-files too depend on asciidoctor-extensions.rb, both
the HTMLified manual pages as well as the user-manual that does use
.xml intermediary.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ea6b8e5d72..f58904a929 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -334,12 +334,12 @@ clean:
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
 
-$(MAN_HTML): %.html : %.txt asciidoc.conf
+$(MAN_HTML): %.html : %.txt asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
+$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
@@ -351,12 +351,12 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt asciidoc.conf
+%.xml : %.txt asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-user-manual.xml: user-manual.txt user-manual.conf
+user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d book -o $@+ $< && \
 	mv $@+ $@
-- 
2.21.0-155-ge902e9bcae

