Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9AC433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiAXRav (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:30:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65301 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbiAXRau (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:30:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97780174E61;
        Mon, 24 Jan 2022 12:30:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=D
        h0GvcuXwbVUXpEHzKkk+iew0a3JKcA1uww3Va7yAXw=; b=vzS8FwFbR4V+Iww6r
        qOZfnPB2EVTJ8EfM9MuqvTqupYg8SpLwU3yT90OQF0dZI3D2yn62TTQ8BQkmVcFd
        z1H3NvxwXzhcbOf3xMiyO7sLUnVc939QX+qdVyh8/pumn+37bAX/8q9w+WrHxxkz
        V4zdxNzwXlbKMcmu5kN3H0YMas=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90397174E5F;
        Mon, 24 Jan 2022 12:30:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDCAF174E5E;
        Mon, 24 Jan 2022 12:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] RelNotes: add builder notes
Date:   Mon, 24 Jan 2022 09:30:46 -0800
Message-ID: <xmqqwnip59dl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E46DE8A-7D3B-11EC-815E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a couple of new things in this release that are useful to
know if you are building from source, so let's add a small section
to the release notes to describe them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---

 * Sorry for showing this the very last minute.  As people can
   guess, this is a fallout from the release engineering I am doing
   right now...

diff --git a/Documentation/RelNotes/2.35.0.txt b/Documentation/RelNotes/2.35.0.txt
index fa5a7318a8..d69b50d180 100644
--- a/Documentation/RelNotes/2.35.0.txt
+++ b/Documentation/RelNotes/2.35.0.txt
@@ -13,6 +13,16 @@ Backward compatibility warts
    of GNU grep.
 
 
+Note to those who build from the source
+
+ * You may need to define NO_UNCOMPRESS2 Makefile macro if you build
+   with zlib older than 1.2.9.
+
+ * If your compiler cannot grok C99, the build will fail.  See the
+   instruction at the beginning of git-compat-util.h if this happens
+   to you.
+
+
 UI, Workflows & Features
 
  * "git status --porcelain=v2" now show the number of stash entries
