Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3602036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdKUXeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:34:37 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:32783 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUXeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:34:36 -0500
Received: by mail-io0-f195.google.com with SMTP id i184so13891535ioa.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NdeWnkkpG/+idlaHiCI0pGPZHVbznYKD5T0uc5i6KTI=;
        b=GqFV+k96gkKj42V3nqJj2GRWealIbyBBcZGwslIg6qKR1nN4bLUm9gX7Ueg7VRo9OL
         rzWXrPWbET7cbjaguRbXZ5fke8XVrRxrTuXAQa4vYqKLzvsS7VyJMYInZ/uZuZ0GPY1H
         5okGpOyv0jOHvsCn3wSZyUIrQJkWXlrQAaIxF26rTEBEd/XIL0hbCQ/m1QxQldObI9l8
         imVhfsesrha0lE3UHJ04cFlGTLlnOIyzUQPQXdxAGYzbfI2RXFVUoSzjdL6E8wstem4D
         og6zBVkTigFdInTWo3sy5D7vAJSalMqGK79iVGasPGXRtCxdyi8G0hnQok5hQh1AbM78
         rDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NdeWnkkpG/+idlaHiCI0pGPZHVbznYKD5T0uc5i6KTI=;
        b=jJA8wivEQZ3xzLg7dl/36jT1P7dkmAagzy3XwlFwqhW2pUC2ForiA3Lbkgviz6WXFd
         Iu5vMc2d2ErxkyJL+o1gCV+h4ufDWuxpmP1yuxcPCcFsik2Fqv7NFkqIB08iI8aWX9dL
         I0IpSMLw0wFJZfOB9NYqJd6PFNrkHcNk0RkFub98PsN8yDbv894OaGylVcuMGKO+RWIn
         unEv3nYbfju12JjEfOiszR44lCQRVPag5GWcgSC7VINTGpgocTlxlOxioahhjdLOOVbJ
         AlinwYS49wmuzdqz+LzXy9oHl1U+cbkTfounmblrMWoOAVRCktf3UgfPCHOZMIgS3Tpl
         XaoQ==
X-Gm-Message-State: AJaThX4e+ICwdVUEmUEhnkjuDvnLqNByZfydJVD/VaWj5+1PWSGBo4kr
        nZj0NomPRv/W2iD/PZFVbgaL/25s
X-Google-Smtp-Source: AGs4zMaCh4wHAEJdENxi13iw7v2/4WZZzfSsK0oLtNnp+EIK5IPedq7kJ4zW6hpQ7kvPRHpQJc5HGw==
X-Received: by 10.107.130.227 with SMTP id m96mr19714942ioi.35.1511307275221;
        Tue, 21 Nov 2017 15:34:35 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g93sm3244073ioj.51.2017.11.21.15.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 15:34:34 -0800 (PST)
Date:   Tue, 21 Nov 2017 15:34:32 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Documentation: allow overriding timestamps of generated
 asciidoc
Message-ID: <20171121233432.GN3429@aiede.mtv.corp.google.com>
References: <20171121232935.GM3429@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121232935.GM3429@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anders Kaseorg <andersk@mit.edu>
Date: Wed, 30 Nov 2016 22:21:15 -0500

Allow overriding the timestamp in generated documentation by setting
SOURCE_DATE_EPOCH to the number of seconds since 1970-01-01 00:00:00
UTC to use.

This makes the generated documentation reproducible from the source
code as long as that variable is set, without losing the last-modified
dates in the default build.

With this change, the package passes Debian's build reproducibility
test (https://wiki.debian.org/ReproducibleBuilds/TimestampsProposal).

The goal is to make it easier to verify that binary packages of open
source projects were built from the source they were claimed to have
been built from.  https://reproducible-builds.org/ has more details.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Perhaps this should e.g. be taking the latest timestamp of all its
inputs.  That would be straightforward to do, but what's here is what
we've been running with for the past year, so I'd rather stick to it,
at least as a starting point.

Another tweak I'd be interested in is allowing asciidoc to take the
timestamp as a parameter instead of inferring it from mtimes.
Asciidoc accepts an "--attribute footer-style=none" parameter, but I'm
not aware of an "--attribute footer-date=<foo>" parameter to keep the
footer but override its date.

 Documentation/Makefile               | 7 +++++--
 Documentation/technical/api-index.sh | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ab65561af..dfec29f36f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -410,6 +410,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(QUIET_GEN)$(RM) $@+ $@ && \
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
+	$(if $(SOURCE_DATE_EPOCH),touch -d '@$(SOURCE_DATE_EPOCH)' $@+ &&) \
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
@@ -420,8 +421,10 @@ WEBDOC_DEST = /pub/software/scm/git/docs
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | \
-	$(TXT_TO_HTML) - >$@+ && \
+	sed -e '1,/^$$/d' $< > $<+ && \
+	$(if $(SOURCE_DATE_EPOCH),touch -d '@$(SOURCE_DATE_EPOCH)' $<+ &&) \
+	$(TXT_TO_HTML) -o $@+ $<+ && \
+	rm $<+ && \
 	mv $@+ $@
 
 install-webdoc : html
diff --git a/Documentation/technical/api-index.sh b/Documentation/technical/api-index.sh
index 9c3f4131b8..07b3909627 100755
--- a/Documentation/technical/api-index.sh
+++ b/Documentation/technical/api-index.sh
@@ -20,6 +20,11 @@
 	sed -n -e '/^\/\/ table of contents end/,$p' "$skel"
 ) >api-index.txt+
 
+if test "${SOURCE_DATE_EPOCH:+set}"
+then
+	touch -d "@$SOURCE_DATE_EPOCH" api-index.txt+
+fi
+
 if test -f api-index.txt && cmp api-index.txt api-index.txt+ >/dev/null
 then
 	rm -f api-index.txt+
-- 
2.15.0.448.gf294e3d99a

