Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6462820248
	for <e@80x24.org>; Wed, 10 Apr 2019 00:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfDJAho (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 20:37:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64418 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfDJAhn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 20:37:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D08B413DD00;
        Tue,  9 Apr 2019 20:37:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=IupBwIbzmyx/AuNd8qhpTHw7R
        M0=; b=o7QokI5wotFA5mr2+XSe6qfFtVpwumad2/Dj8e+sq0MfC1hGMs+dfNU+w
        mcXnh0TRA0UAsjBTnrj0jaPAKFSVLE6QE0Ga3IYnhbhIDR76nh7whGkcUjcdTpvY
        BalGHwCBgYeDSYCNlcXsVgEbAyt/HFUC+VNITgExXkApgR1ZWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=HvlfWEd9g/bkFG6o6EW
        ndV5w1XK3ImBr7J70kRU35dX1NiI0REvGxFwCXi9BZnoUJoAciDWXusA0P/qfneQ
        Y7o77c3LB9P56lHI7lSWZv9zt/Ugo647FfglJSNqPdMgNridR7PI/S6sF9LiUIFu
        /MfZbPU8fnhoeduKQdYWJSX4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8A7C13DCFF;
        Tue,  9 Apr 2019 20:37:40 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08CFD13DCFC;
        Tue,  9 Apr 2019 20:37:38 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/2] Documentation/git-svn: improve asciidoctor compatibility
Date:   Tue,  9 Apr 2019 20:37:34 -0400
Message-Id: <20190410003734.17124-3-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
References: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: D8A7E454-5B28-11E9-8EFB-1646B3964D18-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second paragraph in the CONFIGURATION section intends to emphasize
the word 'must' with bold type. It does so by writing it as *must*, and
this works fine with AsciiDoc. It usually works great with Asciidoctor,
too, but in this particular instance, we have another "*" earlier in the
paragraph. We do escape it, and it is rendered literally just like we
want it to, but Asciidoctor then ends up tripping on the second (or
third) of the asterisks in this paragraph.

Since that asterisk is (part of) a literal example, we can set it in
monospace, by giving it as `*`. Adjust the whole paragraph in this way.
There's lots more monospacing to be done in this document, but since our
main motivation is addressing AsciiDoc/Asciidoctor discrepancies like
this one, let's just convert this one paragraph.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-svn.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b99029520d..81aaef8e4e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1100,10 +1100,10 @@ listed below are allowed:
 	tags =3D tags/*/project-a:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
=20
-Keep in mind that the '\*' (asterisk) wildcard of the local ref
-(right of the ':') *must* be the farthest right path component;
+Keep in mind that the `*` (asterisk) wildcard of the local ref
+(right of the `:`) *must* be the farthest right path component;
 however the remote wildcard may be anywhere as long as it's an
-independent path component (surrounded by '/' or EOL).   This
+independent path component (surrounded by `/` or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using 'git config'.
=20
