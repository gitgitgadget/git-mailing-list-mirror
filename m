Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0850D20986
	for <e@80x24.org>; Fri, 21 Oct 2016 09:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933937AbcJUJUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 05:20:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52864 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbcJUJUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 05:20:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u9L9KbGr025964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 21 Oct 2016 11:20:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9L9KUiM009711;
        Fri, 21 Oct 2016 11:20:38 +0200
From:   Matthieu Moy <Matthieu.Moy@imag.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] Git.pm: add comment pointing to t9000
Date:   Fri, 21 Oct 2016 11:20:24 +0200
Message-Id: <20161021092024.15861-2-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.10.1.651.gffd0de0
In-Reply-To: <20161021092024.15861-1-Matthieu.Moy@imag.fr>
References: <xmqq1szaeda9.fsf@gitster.mtv.corp.google.com>
 <20161021092024.15861-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 21 Oct 2016 11:20:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9L9KbGr025964
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1477646439.71351@O1tE6RYW/E/GkmelDxCBdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_mailboxes should probably eventually be completely equivalent to
Mail::Address, and if this happens we can drop the Mail::Address
dependency. Add a comment in the code reminding the current state of the
code, and point to the corresponding failing test to help future
contributors to get it right.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 perl/Git.pm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index 42e0895ef7..8bb2b7c7e3 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -870,6 +870,8 @@ Return an array of mailboxes extracted from a string.
 
 =cut
 
+# Very close to Mail::Address's parser, but we still have minor
+# differences in some cases (see t9000 for examples).
 sub parse_mailboxes {
 	my $re_comment = qr/\((?:[^)]*)\)/;
 	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;
-- 
2.10.1.651.gffd0de0

