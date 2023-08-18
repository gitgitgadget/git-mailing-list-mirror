Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE63EE49A1
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 23:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbjHRXhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbjHRXhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:37:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778B30DF
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:37:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD12F1A1E5B;
        Fri, 18 Aug 2023 19:37:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=YqXpVrSSnLpevaKdN/GOU4cbE
        ho1tWSlR4J9ytaD/ok=; b=oEqJiGEnPlDopJ69glDVt2Lvxg1Nhv1PYcygm/K/7
        +SmV7vyu2AMnbGXvlyiNtyrDmeg+/lzW0rJP0B2fLU20t+/GP1xtpzIPX1cteMif
        ZVxYVedSS7BWmj97W7EYXKDVjNnrYA+Mus6QkMlrLD6Fyorpyit0r00RuDUcP9CZ
        F0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B42791A1E59;
        Fri, 18 Aug 2023 19:37:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25FB11A1E58;
        Fri, 18 Aug 2023 19:37:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/3] update-index doc: v4 is OK with JGit and libgit2
Date:   Fri, 18 Aug 2023 16:37:27 -0700
Message-ID: <20230818233729.2766281-2-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230818233729.2766281-1-gitster@pobox.com>
References: <20230818233729.2766281-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 33AA3850-3E20-11EE-A94E-25B3960A682E-77302942!pb-smtp2.pobox.com
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-updat=
e-index.txt
index f4bb9c5daf..a367f8d65a 100644
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
+Older editions of this manual page called it "relatively young", but
+it should be considered mature technology these days.
+
=20
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
--=20
2.42.0-rc2-7-gf9972720e9

