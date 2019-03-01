Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B248220248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbfCARez (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:34:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50453 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfCARez (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:34:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32E6243191;
        Fri,  1 Mar 2019 12:34:53 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=w1MegZGq7DiH3DoJ3U7+MBi1k
        XU=; b=jbcmGOnqes/gVoBu1BpnbOvO5TnxWiNrkaWFAKy9P/9KyXLHm0mMaNkbE
        MbAUI8gVFeG7OVkBZukwoXLrwlTDaCae/QxbPK89TFqwbAm/7xjVtH5tsF3RvDU2
        y0J0Fv7KosPqmZnveZvW//nY2WJjXd1thNsSKr2BbAhjcw6OGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=NTQrrJkIs6x3WKu1L/R
        kWdWRkjXodKv/QfvYideL9S8KC0z0Bzhn7wZaIg1KxnIjwUDoeaPnLCmz7jyzH+X
        rTRTd0x/Bg7S3u1jNAyJYD7PZZ4TqVkzKxnkCMM2F7XzyS+1OW7I3q6oBpVzWGST
        VHPv4AIaNQmyRzl8+Ng2Vj0g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B97D43190;
        Fri,  1 Mar 2019 12:34:53 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC5D74318C;
        Fri,  1 Mar 2019 12:34:48 -0500 (EST)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] doc: note config file restrictions for completion.commands
Date:   Fri,  1 Mar 2019 12:34:41 -0500
Message-Id: <20190301173443.16429-2-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228230506.GA20625@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 50C7C4CC-3C48-11E9-B4AC-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion.commands config var must be set in either the system-wide
or global config file.  The completion script does not read a local
repository config.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/config/completion.txt | 3 ++-
 Documentation/git.txt               | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/completion.txt b/Documentation/config/c=
ompletion.txt
index 4d99bf33c9..4859d18e86 100644
--- a/Documentation/config/completion.txt
+++ b/Documentation/config/completion.txt
@@ -4,4 +4,5 @@ completion.commands::
 	porcelain commands and a few select others are completed. You
 	can add more commands, separated by space, in this
 	variable. Prefixing the command with '-' will remove it from
-	the existing list.
+	the existing list.  The variable must be set in either the
+	system-wide or global config.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 00156d64aa..638f4d6cc9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -172,7 +172,8 @@ foo.bar=3D ...`) sets `foo.bar` to the empty string w=
hich `git config
 	others (all other commands in `$PATH` that have git- prefix),
 	list-<category> (see categories in command-list.txt),
 	nohelpers (exclude helper commands), alias and config
-	(retrieve command list from config variable completion.commands)
+	(retrieve command list from config variable completion.commands,
+	set in the global or system-wide config file)
=20
 GIT COMMANDS
 ------------
