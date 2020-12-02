Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3405C6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CCC221FD
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgLBW4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:56:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56938 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbgLBW4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:56:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7EF78B146;
        Wed,  2 Dec 2020 17:55:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BIWawfn43mGbQEIaTDndJvOI/sM=; b=krBhKO
        +nR6t1ypUEyAgN/pAoJTQLckw+rEhAHbt1fGFgihjV1I1Q0VG42hl+fN8hpqXPG5
        xCWKt7WMevAE0SgVsuC04mXmrsKs2RTwn1AWwBkntIxKOiiXhBGBGZwM6QAcp7pj
        dx+WY/Ul3sDUMBtyGOMK5EUq7/+Js5QPHr0PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BcWD+bzyl36NGU3cdod/PVx3Jwz2rFZC
        da6ZNq5b3+gcmkoD8qpBIzyGUAzVgnQpz2J9ylXTS/nxkYFdQi1J7DqVRppNB66G
        eNVCTEYIGDZyabs/OjoiNQEdObGD3BRzBCjKYcob8rKvpLySnvkCK7OK5Bj5SrET
        nKivGoKHg6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EDD08B145;
        Wed,  2 Dec 2020 17:55:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E78B8B144;
        Wed,  2 Dec 2020 17:55:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: improve "branch" definition
References: <87blfnhm8w.fsf@osv.gnss.ru>
        <xmqq7dqbn1nl.fsf@gitster.c.googlers.com> <87im9vekzf.fsf@osv.gnss.ru>
        <xmqqr1ojlkng.fsf@gitster.c.googlers.com> <877dq05swb.fsf@osv.gnss.ru>
Date:   Wed, 02 Dec 2020 14:55:56 -0800
In-Reply-To: <877dq05swb.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        02 Dec 2020 14:50:12 +0300")
Message-ID: <xmqq5z5jlsw3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A908754-34F1-11EB-AC8D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> So, what do we finally do? Just remove "active", or replace it with
> "separate"?
> ...
> It's fine with me either way. Will you just fix it yourself, or should I
> re-roll if "separate" is not accepted?

Let's see ... gitster goes and looks for what he suggested ...

    So, I dunno.  I'd say just settling on the simplest "is a line of
    development" would be the easiest path for now.

I've queued the following.

Thanks for pinging a stalled thread.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
From: Sergey Organov <sorganov@gmail.com>
Date: Mon, 23 Nov 2020 23:05:51 +0300
Subject: [PATCH] glossary: improve "branch" definition

The old phrasing is at least questionable, if not wrong, as there are
a lot of branches out there that didn't see active development for
years, yet they are still branches, ready to become active again any
time.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes (amlog):
    Message-Id: <87blfnhm8w.fsf@osv.gnss.ru>

 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 090c888335..67c7a50b96 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -18,7 +18,7 @@
 	Untyped <<def_object,object>>, e.g. the contents of a file.
 
 [[def_branch]]branch::
-	A "branch" is an active line of development.  The most recent
+	A "branch" is a line of development.  The most recent
 	<<def_commit,commit>> on a branch is referred to as the tip of
 	that branch.  The tip of the branch is referenced by a branch
 	<<def_head,head>>, which moves forward as additional development
-- 
2.29.2-577-g9ac7fd3f3f

