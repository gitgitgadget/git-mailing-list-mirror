Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4E61F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfGDJOn (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:14:43 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41074 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGDJOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:14:43 -0400
Received: by mail-ed1-f44.google.com with SMTP id p15so4730946eds.8
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GQdhnpA0A/JJV0Z+5YAH59BG5GifWdadGAcw17gJYGc=;
        b=dnpmwElGnrrBiErnpBA9XLkK8k+APC+JxeKHYBwP9RA5dtmGK9zKiFTznOqnz9uzXc
         LoagN+4G6zgB9E3Sl0lPsjDY7HaUr5NgKjCp0Vxqj+yylMObVY2QkYOrLIc7A+6g4Cpz
         hc3C6F+lsskqaEQZHIJDR8X7FAXmcRmCV10C1upmFHx+QyDw2+RwcFJIsCGiEguQP6M/
         tHobmk/fa13a5R7ftLHph2Aru1nKEBdwU2qeF3ZInLmmgosnM8yKqIa8giftR4Keago9
         J8HxiH/QzavRyOdGBxqmymEck8rDCi5rdr8iOnIiwoM2azLzS+jDSl/R302INhVIlWwe
         u9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GQdhnpA0A/JJV0Z+5YAH59BG5GifWdadGAcw17gJYGc=;
        b=AkDSsPP5O5SH6fFn6WpM2a/hZ7Av4lacJxsVxXnu1kgSDKrmNMOGANs3/+j61fn1vF
         +kee349eDN4aHf7mOpFAGxuzeLd17dKmN7/BeDTdvB7QI+DZG0CvlRU2MbFqaaJ0YLcH
         3nPs69TVxMeYK9ZDUzVlOBC5F3XzNDMIojLQzbd7WU/T1T5T8WLEQa12QvTc5Uq33XX0
         HjzYXbbdO5z9vW/OOSOdYKHs4kurGpq4h7clx7CbiNQCtJirTPKe97xJbkDr2cbalDmt
         pmGRrfwEzlFfFcHjuXuoViUQAFVkxwLWZAkwKyMcDE1MowMJr5CWYrMaowD6afkObu2h
         Sy9Q==
X-Gm-Message-State: APjAAAWBldHOC99KzQDsuaYajaiFABWYEWs4KIpCtSjTCVn/T7GgXlBW
        +a2nO5sv5FPV/2KBh97By2jPhByN
X-Google-Smtp-Source: APXvYqxOF0KI40of/cg8LQb+tZ1c06Ve0PLuJbF0zZQuL5fJwED7in3sTef8eq/eR74G/i1hRzojaw==
X-Received: by 2002:a17:906:6582:: with SMTP id x2mr39308889ejn.2.1562231681284;
        Thu, 04 Jul 2019 02:14:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m31sm1470670edd.42.2019.07.04.02.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:14:40 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:14:40 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:14:39 GMT
Message-Id: <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.216.git.gitgitgadget@gmail.com>
References: <pull.216.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Avoid illegal filenames when building Documentation on
 NTFS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A `+` is not a valid part of a filename with Windows file systems (it is
reserved because the `+` operator meant file concatenation back in the
DOS days).

When building in Git for Windows' SDK, the `make.exe` that interprets
our `Makefile` is an MSYS2 program, which uses the MSYS2/Cygwin trick of
mapping such illegal characters into the private Unicode page, so as
long as you use programs that are aware of this trick (all MSYS2/Cygwin
programs are, however e.g. `git.exe` is not) things are all dandy.

Let's just not use the `+` character.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/Makefile | 88 +++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index dbf5a0f276..792ddf872e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -297,9 +297,9 @@ docdep_prereqs = \
 	cmd-list.made $(cmds_txt)
 
 doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt) build-docdep.perl
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
-	mv $@+ $@
+	$(QUIET_GEN)$(RM) $@.new $@ && \
+	$(PERL_PATH) ./build-docdep.perl >$@.new $(QUIET_STDERR) && \
+	mv $@.new $@
 
 -include doc.dep
 
@@ -344,8 +344,8 @@ GIT-ASCIIDOCFLAGS: FORCE
             fi
 
 clean:
-	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
-	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
+	$(RM) *.xml *.xml.new *.html *.html.new *.1 *.5 *.7
+	$(RM) *.texi *.texi.new *.texi.new.new git.info gitman.info
 	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/*.html technical/api-index.txt
@@ -355,14 +355,14 @@ clean:
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(RM) $@.new $@ && \
+	$(TXT_TO_HTML) -d manpage -o $@.new $< && \
+	mv $@.new $@
 
 $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(RM) $@.new $@ && \
+	$(TXT_TO_HTML) -o $@.new $< && \
+	mv $@.new $@
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
@@ -372,14 +372,14 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_XML) -d manpage -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(RM) $@.new $@ && \
+	$(TXT_TO_XML) -d manpage -o $@.new $< && \
+	mv $@.new $@
 
 user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_XML) -d book -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(RM) $@.new $@ && \
+	$(TXT_TO_XML) -d book -o $@.new $< && \
+	mv $@.new $@
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
@@ -397,46 +397,46 @@ XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
 user-manual.html: user-manual.xml $(XSLT)
-	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
-	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
-	mv $@+ $@
+	$(QUIET_XSLTPROC)$(RM) $@.new $@ && \
+	xsltproc $(XSLTOPTS) -o $@.new $(XSLT) $< && \
+	mv $@.new $@
 
 git.info: user-manual.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
 
 user-manual.texi: user-manual.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
-	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
-	rm $@++ && \
-	mv $@+ $@
+	$(QUIET_DB2TEXI)$(RM) $@.new $@ && \
+	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@.new.new && \
+	$(PERL_PATH) fix-texi.perl <$@.new.new >$@.new && \
+	rm $@.new.new && \
+	mv $@.new $@
 
 user-manual.pdf: user-manual.xml
-	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
-	mv $@+ $@
+	$(QUIET_DBLATEX)$(RM) $@.new $@ && \
+	$(DBLATEX) -o $@.new $(DBLATEX_COMMON) $< && \
+	mv $@.new $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml)+ texi.xsl $(xml) && \
-		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml)+ && \
-		rm $(xml)+ &&) true) > $@++ && \
-	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+ && \
-	rm $@++ && \
-	mv $@+ $@
+	$(QUIET_DB2TEXI)$(RM) $@.new $@ && \
+	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml).new texi.xsl $(xml) && \
+		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml).new && \
+		rm $(xml).new &&) true) > $@.new.new && \
+	$(PERL_PATH) cat-texi.perl $@ <$@.new.new >$@.new && \
+	rm $@.new.new && \
+	mv $@.new $@
 
 gitman.info: gitman.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
-	mv $@+ $@
+	$(QUIET_DB2TEXI)$(RM) $@.new $@ && \
+	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@.new && \
+	mv $@.new $@
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
-	mv $@+ $@
+	$(QUIET_GEN)$(RM) $@.new $@ && \
+	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@.new && \
+	mv $@.new $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
@@ -445,10 +445,10 @@ WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(QUIET_ASCIIDOC)$(RM) $@.new $@ && \
 	sed -e '1,/^$$/d' $< | \
-	$(TXT_TO_HTML) - >$@+ && \
-	mv $@+ $@
+	$(TXT_TO_HTML) - >$@.new && \
+	mv $@.new $@
 
 install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
-- 
gitgitgadget
