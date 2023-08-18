Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D4EE498E
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 18:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379306AbjHRSRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379414AbjHRSQw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 14:16:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A09420F
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 11:16:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40FF81A15B4;
        Fri, 18 Aug 2023 14:16:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=S
        GShndudIollOzNdpPbzUZAqCNkJj1+hb9bb/5IjzeI=; b=xcZ3cTJPwn/qbAQel
        kxaqy2sNXjXdEV/CeWVUUNLLWWFCoo+Va0XGnZdzwuSoWzVqbCIvQQP1wnzYXwLW
        4JTozfpP9Fv45hEH/jlqfjchwQVLmfrX8hDd69mC38xje1zudnfdKv08opuf6VX1
        dgpeiUI2S+Wg51/qsXoCeIyriE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39A0C1A15B3;
        Fri, 18 Aug 2023 14:16:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A49E21A15B2;
        Fri, 18 Aug 2023 14:16:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] update-index doc: v4 is OK with JGit and libgit2
Date:   Fri, 18 Aug 2023 11:16:44 -0700
Message-ID: <xmqqil9cusfn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63DE15C8-3DF3-11EE-BC9A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index f4bb9c5daf..3d90d6f9ab 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -166,9 +166,12 @@ you will need to handle the situation manually.
 +
 Version 4 performs a simple pathname compression that reduces index
 size by 30%-50% on large repositories, which results in faster load
-time. Version 4 is relatively young (first released in 1.8.0 in
-October 2012). Other Git implementations such as JGit and libgit2
-may not support it yet.
+time. The first version to support it was Git 1.8.0 released in
+October 2012, and support for it was added to libgit2 in 2016 and
+JGit in 2020, respectively.  Older editions of this manual page called
+it "relatively young", but it should be considered mature technology
+these days.
+
 
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
-- 
2.42.0-rc2-7-gf9972720e9

