Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577A91F404
	for <e@80x24.org>; Wed, 29 Aug 2018 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeH2Rkz (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 13:40:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:53391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeH2Rkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 13:40:55 -0400
Received: from localhost.localdomain ([185.190.160.130]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M8pKi-1g4tCM2r9w-00CBgn; Wed, 29 Aug 2018 15:43:50 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        Tim Schumacher <timschumi@gmx.de>
Subject: [PATCH v2] doc: Don't echo sed command for manpage-base-url.xsl
Date:   Wed, 29 Aug 2018 15:43:34 +0200
Message-Id: <20180829134334.14619-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc1.1.g093671f86
In-Reply-To: <20180828212104.2515-1-timschumi@gmx.de>
References: <20180828212104.2515-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fohYvZYkRYZuemBwOemozbdBymiean+LqFtdN97iKl+TtI+mSrY
 Pqj8PHZMge5Y9OhtO5z5MMKN01+4sapWSJtlM2qfppNwvKOFztMVd4QU3CZhoURqHnIo8Vf
 uhDEor7B8ntXs7q1yLd1Q3eK2GjVh0WAcbJM56Dhh6RxhihCtXN5LSIIDpN22uXY9iyDk8U
 SS/qbWi/MVhWseBmkO2ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g/AcJrgzelk=:xO7+/bNVn+MYaLFnW0GI6Q
 1DXfnRxSGxzWlQZEGmJSO65sKiIs0TiD7OUGruEDoJykxb8NaLA8NM1VBcZIdWuCf8HMI39FD
 ZqiRetSBKSVqVIPsMBFLSki19ULekZ0P6w2E2NEFaglGQyivrOxhyt5omMtIU7D6fen1Vikal
 zHYxWhLYjxcdWKnekIB2lvg8bmITS7TJEMWkxReHgcWUNXIOgKHu4u8iexfLq0lp+Ob84IhkM
 0B+a4YDF9Im9bArywetoDlBbz7Po9mUQm/LGoaAxjv7NPjmT+hKdV6JF7NtYzRVKIJFLqMx3U
 zhKafty6WQo7GBAXokIdGDOD9/IxeWOPyAPT2Dt6n/avgWWqiufox+Kybf8zGi55a/WSCK3OP
 zvVVM1toYNx292yFDh0wlWe+uHAW6For51LgMHgIFv8XiNIw5VRE/92kS4UR3Q9B78kUJeYXY
 0M5h1v54Ei2ElvJ9PW7448WQszgvPfS9RmeeSZdHZPbwkR73fX2Fvf3HRkMyUcKtnG+Q4VsJc
 plm1U2YT183EoIx4LisAUDvLbo5CU0UfeTC+hL6Wr0VhSI96TBxuXtVYBA14mTD75KJfFmHpg
 ESvEfxuD0RaUr9+85uezGypFtqlsKi5sXrEGnK3NweSczCMNlkf4NRy8eA2OQnj5Snq9WoRxZ
 x0IEw34p/tJvgPFzhc7dCbVUh0W9u95/FM+/QrO1jIcbDOi+ZyhVF2qDUpA1tAtnI9cWM0P9S
 C4p2hKzFtF3eam7PXQOWOMQmSaJYhpaBAUT/oQ8A6279Wuj29XfbClzfVLo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the sed command for generating manpage-base-url.xsl
was printed to the console when being run.

Make the console output for this rule similiar to all the
other rules by printing a short status message instead of
the whole command.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---

To Junio C Hamano:
The rule does now print "SED manpage-base-url.xsl"
to the console, which is similiar to other QUIET_$TOOL
rules.

To Eric Sunshine:
I reworded the commit message to focus more on _why_
the patch is relevant.

---

 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a42dcfc74..cbf33c5a7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -225,6 +225,7 @@ ifndef V
 	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
 	QUIET_GEN	= @echo '   ' GEN $@;
 	QUIET_LINT	= @echo '   ' LINT $@;
+	QUIET_SED	= @echo '   ' SED $@;
 	QUIET_STDERR	= 2> /dev/null
 	QUIET_SUBDIR0	= +@subdir=
 	QUIET_SUBDIR1	= ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -344,7 +345,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 	mv $@+ $@
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
-	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
+	$(QUIET_SED)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl
 	$(QUIET_XMLTO)$(RM) $@ && \
-- 
2.19.0.rc1.1.g093671f86

