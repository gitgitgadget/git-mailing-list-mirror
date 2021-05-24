Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65499C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48398613D2
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhEXRxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 13:53:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54084 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhEXRxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 13:53:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1225B76CD;
        Mon, 24 May 2021 13:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rwFHyvzPzohUe8yHRwm/qCgLb51hfHcQQR/C+Gc7nj4=; b=ajxK
        YJHLCrBKfvEsUzGo6dc5IZCAwaCikfbHDINrSDGZ3GjtMHMF3c6B3hfSa+EoVuDV
        uP5yPDV1vIJIqcKoMiMujeRDqXWVhDOz36LqDXvaPDg2uWn0u7C3nvMk/zfHSVOc
        49CO/WUs5uM6hYYdyC+IKIXLZcEfgR7pp/lXD6k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7E81B76CC;
        Mon, 24 May 2021 13:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20FC2B76CB;
        Mon, 24 May 2021 13:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
        <20210521222941.525901-4-felipe.contreras@gmail.com>
Date:   Tue, 25 May 2021 02:51:53 +0900
Message-ID: <xmqqcztgj9za.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9C3CF32-BCB8-11EB-9E57-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commits 50cff52f1a (When generating manpages, delete outdated targets
> first., 2007-08-02) and f9286765b2 (Documentation/Makefile: remove
> cmd-list.made before redirecting to it., 2007-08-06) created these rm
> instances for a very rare corner-case: building as root by mistake.
>
> It's odd to have workarounds here, but nowhere else in the Makefile--
> which already fails in this stuation, starting from
> Documentation/technical/.
>
> We gain nothing but complexity, so let's remove them.
>
> Comments-by: Jeff King <peff@peff.net>

This is curious.  I understand what other kinds of trailers like
Helped-by and Suggested-by people sometimes use mean, but this one
does not tell anything other than that this person had some comments
on an earlier rounds, does not tell us what kind of comments they
were and if something was done to address those comments or the
comments were totally ignored or what.

The patch text itself, and the justification given in the second
paragraph, both make perfect sense to me.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/Makefile | 42 +++++++++++++++---------------------------
>  1 file changed, 15 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 0f59cc0853..73b88c3aad 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -296,8 +296,7 @@ docdep_prereqs = \
>  	cmd-list.made $(cmds_txt)
>  
>  doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
> -	$(QUIET_GEN)$(RM) $@+ $@ && \
> -	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
> +	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
>  	mv $@+ $@
>  
>  ifneq ($(MAKECMDGOALS),clean)
> @@ -318,8 +317,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
>  $(cmds_txt): cmd-list.made
>  
>  cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
> -	$(QUIET_GEN)$(RM) $@ && \
> -	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
> +	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
>  	date >$@
>  
>  mergetools_txt = mergetools-diff.txt mergetools-merge.txt
> @@ -327,7 +325,7 @@ mergetools_txt = mergetools-diff.txt mergetools-merge.txt
>  $(mergetools_txt): mergetools-list.made
>  
>  mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
> -	$(QUIET_GEN)$(RM) $@ && \
> +	$(QUIET_GEN) \
>  	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
>  		. ../git-mergetool--lib.sh && \
>  		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
> @@ -357,30 +355,25 @@ clean:
>  	$(RM) GIT-ASCIIDOCFLAGS
>  
>  $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
> +	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@+ $< && \
>  	mv $@+ $@
>  
>  $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(TXT_TO_HTML) -o $@+ $< && \
> +	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@+ $< && \
>  	mv $@+ $@
>  
>  manpage-base-url.xsl: manpage-base-url.xsl.in
>  	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
>  
>  %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
> -	$(QUIET_XMLTO)$(RM) $@ && \
> -	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>  
>  %.xml : %.txt $(ASCIIDOC_DEPS)
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(TXT_TO_XML) -d manpage -o $@+ $< && \
> +	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@+ $< && \
>  	mv $@+ $@
>  
>  user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(TXT_TO_XML) -d book -o $@+ $< && \
> +	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@+ $< && \
>  	mv $@+ $@
>  
>  technical/api-index.txt: technical/api-index-skel.txt \
> @@ -402,27 +395,24 @@ XSLTOPTS += --stringparam html.stylesheet docbook-xsl.css
>  XSLTOPTS += --param generate.consistent.ids 1
>  
>  user-manual.html: user-manual.xml $(XSLT)
> -	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
> -	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
> +	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
>  	mv $@+ $@
>  
>  git.info: user-manual.texi
>  	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
>  
>  user-manual.texi: user-manual.xml
> -	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
> -	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
> +	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
>  	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
>  	rm $@++ && \
>  	mv $@+ $@
>  
>  user-manual.pdf: user-manual.xml
> -	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
> -	$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
> +	$(QUIET_DBLATEX)$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
>  	mv $@+ $@
>  
>  gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
> -	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
> +	$(QUIET_DB2TEXI) \
>  	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml)+ texi.xsl $(xml) && \
>  		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml)+ && \
>  		rm $(xml)+ &&) true) > $@++ && \
> @@ -434,13 +424,11 @@ gitman.info: gitman.texi
>  	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
>  
>  $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
> -	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
> -	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
> +	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
>  	mv $@+ $@
>  
>  howto-index.txt: howto-index.sh $(HOWTO_TXT)
> -	$(QUIET_GEN)$(RM) $@+ $@ && \
> -	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
> +	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
>  	mv $@+ $@
>  
>  $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
> @@ -450,7 +438,7 @@ WEBDOC_DEST = /pub/software/scm/git/docs
>  
>  howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
>  $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
> -	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> +	$(QUIET_ASCIIDOC) \
>  	sed -e '1,/^$$/d' $< | \
>  	$(TXT_TO_HTML) - >$@+ && \
>  	mv $@+ $@
