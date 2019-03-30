Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6E620248
	for <e@80x24.org>; Sat, 30 Mar 2019 18:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfC3Sa1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 14:30:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53521 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfC3SaS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 252B845D5D;
        Sat, 30 Mar 2019 14:30:16 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=8Q4+KkN2UIYalFFRCfAQno2g5
        U0=; b=cK+MYf9O9qi9HvvcIfpTa1i05AldXLKHGgw2y6KjMnKDai9ORgKl+67ns
        hBdgcJ4o9UMspSzJ+iamEFvBKmRdP72JnGl8r7U+Fr9DkYlyBjz0y8PCEZr5OtK5
        I717tskKjrN6xfVGsKM+E7xh/eBqoMNgw8TU6MfuDJANHdv5Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=bD0F+xJte1rLdy1udi7
        oOoUdELYKSFezMq/OiyObGrlXutAGssxJYBiBRC8V9AJqlJt/YFyEWTeBMCrRL/h
        QlfATnARjaN3m1Ah21F3svSA7efu/dqAKoG5UfjgN1gtxhiR7OCph0Jk2892KbLd
        Ak1v1J22+pAmT5So4GeTCQc0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1ECAF45D5C;
        Sat, 30 Mar 2019 14:30:16 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C66145D57;
        Sat, 30 Mar 2019 14:30:11 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 2/2] Documentation/git-status: fix titles in porcelain v2 section
Date:   Sat, 30 Mar 2019 14:30:01 -0400
Message-Id: <20190330183001.16624-3-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330183001.16624-1-tmz@pobox.com>
References: <20190330183001.16624-1-tmz@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: DB62295A-5319-11E9-BBD7-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoc uses either one-line or two-line syntax for document/section
titles[1].  The two-line form is used in git-status.  Fix a few section
titles in the porcelain v2 section which were inadvertently using
markdown syntax.

[1] http://asciidoc.org/userguide.html#X17

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

The '^### ' lines were added in 1cd828ddc8 ("git-status.txt: describe
--porcelain=3Dv2 format", 2016-08-11).  I'm _presuming_ they were made
with markdown syntax in mind, but if not I can drop that bit from the
commit message.  Jeff H, do you happen to recall?

As an aside, while I was reading the Asciidoc/tor manuals, I notice the
two-line title syntax was not mentioned in Asciidoctor.  That seems to
be because Asciidoctor has suggested the two-line title format should be
deprecated, as discussed at:

    https://github.com/asciidoctor/asciidoctor/issues/418

I'm not sure how likely that is to occur.  With the 2.0 release,
asciidoctor plans to use semantic versioning, so I would not expect any
deprecation to happen before at least 2.1.  It would only affect use
without compat-mode.

 Documentation/git-status.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 861d821d7f..d4e8f24f0c 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -278,7 +278,8 @@ Header lines start with "#" and are added in response=
 to specific
 command line arguments.  Parsers should ignore headers they
 don't recognize.
=20
-### Branch Headers
+Branch Headers
+^^^^^^^^^^^^^^
=20
 If `--branch` is given, a series of header lines are printed with
 information about the current branch.
@@ -294,7 +295,8 @@ Line                                     Notes
 ------------------------------------------------------------
 ....
=20
-### Changed Tracked Entries
+Changed Tracked Entries
+^^^^^^^^^^^^^^^^^^^^^^^
=20
 Following the headers, a series of lines are printed for tracked
 entries.  One of three different line formats may be used to describe
@@ -365,7 +367,8 @@ Field       Meaning
 --------------------------------------------------------
 ....
=20
-### Other Items
+Other Items
+^^^^^^^^^^^
=20
 Following the tracked entries (and if requested), a series of
 lines will be printed for untracked and then ignored items
@@ -379,7 +382,8 @@ Ignored items have the following format:
=20
     ! <path>
=20
-### Pathname Format Notes and -z
+Pathname Format Notes and -z
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
=20
 When the `-z` option is given, pathnames are printed as is and
 without any quoting and lines are terminated with a NUL (ASCII 0x00)
