Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D91D1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeH2Tpq (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 15:45:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:58889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbeH2Tpq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 15:45:46 -0400
Received: from localhost.localdomain ([185.190.160.130]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MC3zg-1g3sO5494a-008ud3; Wed, 29 Aug 2018 17:48:09 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Tim Schumacher <timschumi@gmx.de>
Subject: [PATCH v3] doc: Don't echo sed command for manpage-base-url.xsl
Date:   Wed, 29 Aug 2018 17:47:20 +0200
Message-Id: <20180829154720.20297-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc1.1.g093671f86
In-Reply-To: <20180829134334.14619-1-timschumi@gmx.de>
References: <20180829134334.14619-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5qqvG7tn/wmnQN+JosGObssadRwOk5PPTWBMrur7naKQpkKhMVi
 1OREvIMPkCQu+4i8rXlQPuHwcP5g9e9AS3b3pSGuDXCi0Ofjwi4ZivO7+GWuWtbNUp3+uIg
 Duu5UMOm9dw9pzE1ASMsXS3j4qhdZl8ZlA1usjZ1Yq1PJVhmz6VUgUEwOjFQvZYfjJb0fIN
 fy/nXp3EnhyMErEtRAw8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6QZO7PNhYnI=:umWv8zYExzmBHlrgKBoi+t
 Aa4Y2buBSKTJTNAaLfHswRnEYzbQd4TOpq/xpOLvxt7O2i1kh1aE6vQktXDGAGemEgn8PtBAc
 Mfm5raP6TtAJi5+fjzUvwA4em12i6iLIo6s7iPwiAduXuzTNiiJZtmLwL7p74mNbwGSZhmSdv
 8GjU5Q+PSTen+jpIsMFaf4R+Rm61dQfqYSyjBNCvzCr5IhVxXGnnrmfCNqSI7C3n7/oPEC3d4
 Gh0LkFYjcruOkhG6f9ANmZOaMdLkSkEwYkxbN5h338Viz0CyelQYav7PLMhJg1urhNWyfFfIq
 FA5AWECYbXjE4K5w4Y5+mLgNcxuwG9hyApihDGqyPU7naDuxKYQLiY71/oqAel6Ia+XphI+Vz
 clSL37PlCulIwhrObxf3N7QPnWhbdW9dM8RSNN2+FiMEoKqKsgtdVq9Oa7MyFQGImN6C4Cwg1
 kLqdm3n9IbJ0lIYxOiPWMKoMbDGUjjAVFxnMMffo8RKi5iCkYgSJQC4YsEQeD9WQkCo6UMZCg
 hR0wye45RKkwfcfAoAA6PXfn/N4rGOu8oBGK+GJ8ylxTMCAWztaEvsbxunWNqpue4SP24f6UM
 wc9rKPFcUuJbHagAEPHssrP5d7KmpuDuc5IqobVVNpBbNu5HvTc28G25TtSYEStkpIbQifNqK
 n/cGNnwMnW5ePoYH2iJ1NTni5542Pcew+AWs/1SfGKM3jlc5A0XBZKCLcb6mt1OvmYY2oUYEp
 FtW0gCvG72ddd2TurUD5jPqk5B6n/pXjik6ieMgyPuGuNnijUHVuGx3ptik=
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
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a42dcfc74..95f6a321f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -344,7 +344,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 	mv $@+ $@
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
-	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
+	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl
 	$(QUIET_XMLTO)$(RM) $@ && \
-- 
2.19.0.rc1.1.g093671f86

