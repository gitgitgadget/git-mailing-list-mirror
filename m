Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC32A20248
	for <e@80x24.org>; Wed, 10 Apr 2019 00:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDJAhm (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 20:37:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56038 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDJAhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 20:37:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2813E13DCFE;
        Tue,  9 Apr 2019 20:37:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ocDMbGmnrP5daKwU+Ke3nH9Pj
        Z4=; b=ZfGcjYOA5WWtjO9vCj+I5LID7bVLn3qKMdCLw0IT8sOkWzuds0z4MBV/A
        dsWQMGylahfahqxd+sj3e5S+lTAXq3+TSg0g+XX2m7R/ws23xchJjfWELeQDgMxq
        0VDhok0GdUGPTjE7qwDOlpD+Q66eLEwpqyh20rDvQ2e8MlKvKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=COMGDdo9H5Hn4tLgFjy
        yRgWqnecYlwto15M7WiyJ8KQ1vzdHixenFNi5QmpkY5MtNNC6e3AtkR3ZXIZy35r
        64VJeeoVhz0QVGGK7uzVx5+1FxdFr55DgMBy8jmC6S7/rscv8ELbjy8Qr+CQpOsn
        o4A2B2NQogcwtTjvrXzEMl+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 207D713DCFD;
        Tue,  9 Apr 2019 20:37:39 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52A0D13DCF9;
        Tue,  9 Apr 2019 20:37:37 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/2] Documentation/git-show-branch: avoid literal {apostrophe}
Date:   Tue,  9 Apr 2019 20:37:33 -0400
Message-Id: <20190410003734.17124-2-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
References: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: D7A42EB4-5B28-11E9-82A4-1646B3964D18-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The {apostrophe} was needed at the time of a521845800 ("Documentation:
remove stray backslash in show-branch discussion", 2010-08-20).  All
other uses of {apostrophe} were removed in 6cf378f0cb ("docs: stop using
asciidoc no-inline-literal", 2012-04-26).

Unfortunately, the {apostrophe} is rendered literally with Asciidoctor
(at least with 1.5.5-2.0.3).  Avoid this by using single-quotes.

Escaping the leading single-quote allows the content to render properly
in AsciiDoc and Asciidoctor.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-show-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-b=
ranch.txt
index 4a01371227..5cc2fcefba 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -167,7 +167,7 @@ $ git show-branch master fixes mhf
 ------------------------------------------------
=20
 These three branches all forked from a common commit, [master],
-whose commit message is "Add {apostrophe}git show-branch{apostrophe}".
+whose commit message is "Add \'git show-branch'".
 The "fixes" branch adds one commit "Introduce "reset type" flag to
 "git reset"". The "mhf" branch adds many other commits.
 The current branch is "master".
