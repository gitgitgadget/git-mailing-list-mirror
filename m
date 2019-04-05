Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE5D20248
	for <e@80x24.org>; Fri,  5 Apr 2019 22:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDEWv2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 18:51:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58639 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfDEWv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 18:51:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3882578D8;
        Fri,  5 Apr 2019 18:51:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=aIJIm66eupUYR9eJYiXi/TUGl
        FU=; b=dSXNUkP7HTMxe99BShMpZDUr0SLNp3g8NBgx6q4eSdSkFHUwuy0aMO249
        rwdkLONwikt3hJcMDM+1bafKsdVc3bbj0sRHzEYuLr3sU5l3CxNGa/AvnEhUhmuB
        JGHzW68ZS2h8CCeo+Zhhw8CD0wFNKW6HMIGqaWJqbkX2BYagY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=ZFain9sjlo+98Q0Gdp8
        y6JOI60H/A0kiSQ+AOQ7UorQmA78Gui1dw+pq3ScJ2/zlWnpQyDJHsGntnh5ovea
        av3111iKrdyQy0PpjicWiWUdC9li/niXt60dNoPpqs6mA/FMe/9E8KohfIl/nUk/
        A9henAgqeLDNdSwGb0/GOtIg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CBD22578D6;
        Fri,  5 Apr 2019 18:51:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43438578D1;
        Fri,  5 Apr 2019 18:51:21 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] Documentation/git-show-branch: drop last use of {apostrophe}
Date:   Fri,  5 Apr 2019 18:51:14 -0400
Message-Id: <20190405225115.3882-2-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
References: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 55BA5F4E-57F5-11E9-9999-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The {apostrophe} was needed at the time of a521845800 ("Documentation:
remove stray backslash in show-branch discussion", 2010-08-20).  All
other uses of {apostrophe} were removed in 6cf378f0cb ("docs: stop using
asciidoc no-inline-literal", 2012-04-26).

Escape only the leading single-quote.  This renders properly in asciidoc
and asciidoctor.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Maybe it would be easier to change the example commit messages
and avoid having to nest single quotes within double quotes?  I
don't know if that's much preferable to escaping only the opening
single quote.

I went with the more minimal change to avoid having to rewrite
other bits of the example (and risk making them not match what
users would see if they ran similar commands).

This is another potential parsing bug in asciidoctor.  Of course,
distros will have versions of asciidoctor in place for some time
which have trouble parsing this doc.  Since it's not much work
for us to adjust the text to work around it, that seemed
reasonable.

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
