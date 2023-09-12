Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365BDEE3F0F
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 19:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbjILTcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbjILTcp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 15:32:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A94CF
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 12:32:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 295A819BDB3;
        Tue, 12 Sep 2023 15:32:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=mZyYNllfeSfywgCTqNYUbzM3V
        IOolQSRLgp5gdQkVKc=; b=RekdwNe97TddIiMzNO52rXjxnU3VR2VbBZXDVCHQY
        ARIMcxhwHgc/SQsnJZZ+EG087NtztSNFR7Q4s+mc9o+WwYXtblvii30ucBPhbNoy
        cYPI9TkP8qTa/BxXRy1y86FRFW5pJ2o5sy6DBzL1d+HgwiCUuCGhXU0AnWDngxG/
        GY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2286B19BDB2;
        Tue, 12 Sep 2023 15:32:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A0E119BDB1;
        Tue, 12 Sep 2023 15:32:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 1/3] update-index doc: v4 is OK with JGit and libgit2
Date:   Tue, 12 Sep 2023 12:32:33 -0700
Message-ID: <20230912193235.776292-2-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-158-g94e83dcf5b
In-Reply-To: <20230912193235.776292-1-gitster@pobox.com>
References: <20230818233729.2766281-1-gitster@pobox.com>
 <20230912193235.776292-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 231EA82C-51A3-11EE-9CC7-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Being invented in late 2012 no longer makes the index v4 format
"relatively young".

The support for the index version 4 was added to libgit2 with their
5625d86b (index: support index v4, 2016-05-17) and to JGit with
their e9cb0a8e (DirCache: support index V4, 2020-08-10).

Let's update the paragraph that discouraged its use for folks overly
cautious about cross-tool compatibility.

Helped-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-updat=
e-index.txt
index f4bb9c5daf..71d6ef9457 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -166,9 +166,11 @@ you will need to handle the situation manually.
 +
 Version 4 performs a simple pathname compression that reduces index
 size by 30%-50% on large repositories, which results in faster load
-time. Version 4 is relatively young (first released in 1.8.0 in
-October 2012). Other Git implementations such as JGit and libgit2
-may not support it yet.
+time.  Git supports it since version 1.8.0, released in October 2012,
+and support for it was added to libgit2 in 2016 and to JGit in 2020.
+Older versions of this manual page called it "relatively young", but
+it should be considered mature technology these days.
+
=20
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
--=20
2.42.0-158-g94e83dcf5b

