Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ECCC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 01:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbiBPBkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:40:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241897AbiBPBkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 20:40:20 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09268237EC
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 17:40:09 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B024818D79C;
        Tue, 15 Feb 2022 20:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FRzZYqqiA4bPtTyQecip2eeH6OCAsNwkG9QY0A
        2t7Xo=; b=jMHyQugUiecjo3b/f0jQcmHQdMK3gr1ixFFcRevy9kvW42DOxREh0A
        8eAgaS7m2czcYHrBZ2KoqrEgW7ZPovxy8iGMBHc++bHA6rmHmOWTQiWN5UcaGaoX
        xaZRkEgLZ8/vwW3VcIZBRI55ljqwWOz24NH3ysxQ08WoZBHzANFzU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A83D318D79B;
        Tue, 15 Feb 2022 20:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 142F218D797;
        Tue, 15 Feb 2022 20:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] name-rev: replace --stdin with --annotate-stdin in
 synopsis
References: <pull.1216.git.git.1644958327302.gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 17:40:05 -0800
In-Reply-To: <pull.1216.git.git.1644958327302.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Tue, 15 Feb 2022 20:52:07 +0000")
Message-ID: <xmqqbkz7y4ga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC1CF56-8EC9-11EC-BF34-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> d9976b184596 added --annotate-stdin to replace --stdin as a clearer flag
> name. Since --stdin is to be deprecated, we should replace --stdin in
> the synopsis.

Thanks for a careful reading.  d9976b184596 was what merged the
whole series; let's blame the particular step instead.

Here is what I'll queue.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: John Cai <johncai86@gmail.com>
Date: Tue, 15 Feb 2022 20:52:07 +0000
Subject: [PATCH] name-rev: replace --stdin with --annotate-stdin in synopsis

34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin,
2022-01-05) added --annotate-stdin to replace --stdin as a clearer
flag name. Since --stdin is to be deprecated, we should replace
--stdin in the output from "git name-rev -h".

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 138e3c30a2..929591269d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -473,7 +473,7 @@ static void show_name(const struct object *obj,
 static char const * const name_rev_usage[] = {
 	N_("git name-rev [<options>] <commit>..."),
 	N_("git name-rev [<options>] --all"),
-	N_("git name-rev [<options>] --stdin"),
+	N_("git name-rev [<options>] --annotate-stdin"),
 	NULL
 };
 
-- 
2.35.1-129-gb80121027d

