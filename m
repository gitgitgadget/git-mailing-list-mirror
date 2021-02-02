Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B003BC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB4164F7C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhBBVam (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:30:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53070 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBBVal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 16:30:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5BC295E41;
        Tue,  2 Feb 2021 16:29:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JpzOcicg1hV83iGdJAUKcE4WPJA=; b=pFn1VT
        FJjevHiRb81DsR6KgurYMtTuR3ZRjtnaBtce0u+Cq0RT2IIbo5xQRkofFbrU/RDA
        T0XOFbwVbtU7QB8LkEWlGVC3MwAMRcw33pAE8uSufK4Ts1B//x3hOn5fLerT+Npx
        GinBzu5SOAi+b2lhOywxlIE0qkbYEaqXdm1DE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KXIBb8nCWFcHKSj4LQGPjp/RJyzjlz6B
        1zO4eos2f09JuzZcrtVytDQk3jPelIUVt1sGkCpEMD24+HmWw8bfJQ2WCAG0u/Ht
        26Kkq4X594uuTLDxo2wsrl89pu4WOgpfNMtCAzRVupzu9Zvbr2WrwXN84Vvq+MPU
        HBgXEZM5yq8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDFF695E40;
        Tue,  2 Feb 2021 16:29:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BBE895E3E;
        Tue,  2 Feb 2021 16:29:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Paul Jolly <paul@myitcv.io>,
        Git List <git@vger.kernel.org>
Subject: Re: Bash completion suggests tags for git branch -D
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
        <YBkVFTOP6K1//i6m@coredump.intra.peff.net>
        <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
        <xmqqpn1igznk.fsf@gitster.c.googlers.com>
        <CAPig+cQoCuQSyrKfE_sNCvi=Yo2035e0TOA1sOBF1HE02-kFjA@mail.gmail.com>
Date:   Tue, 02 Feb 2021 13:29:57 -0800
In-Reply-To: <CAPig+cQoCuQSyrKfE_sNCvi=Yo2035e0TOA1sOBF1HE02-kFjA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 2 Feb 2021 12:24:51 -0500")
Message-ID: <xmqqlfc6f99m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCBA0DEE-659D-11EB-876A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 2, 2021 at 12:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>> From: Jeff King <peff@peff.net>
>> Subject: [PATCH] completion: treat "branch -D" the same way as "branch -d"
>>
>> Paul Jolly noticed that the former offers not just branches but tags
>> as completion candidates.  Mimic how "branch -d" limits its suggestion
>> to branch names.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Perhaps a Reported-by: would be appropriate?

Comparing the way I wrote the above, and a bland description of
"this is broken how" plus "Reported-by:", I personally feel the
former gives the credit in a more proper way, but if more people
prefer the more mechanical style, I can adjust.

Here is what I queued.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
From: Jeff King <peff@peff.net>
Date: Tue, 2 Feb 2021 04:02:13 -0500
Subject: [PATCH] completion: treat "branch -D" the same way as "branch -d"

The former offers not just branches but tags as completion
candidates.

Mimic how "branch -d" limits its suggestion to branch names.

Reported-by: Paul Jolly <paul@myitcv.io>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 463a3124da..ba950a247d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1438,7 +1438,7 @@ _git_branch ()
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
-		-d|--delete|-m|--move)	only_local_ref="y" ;;
+		-d|--delete|-D|-m|--move)	only_local_ref="y" ;;
 		-r|--remotes)		has_r="y" ;;
 		esac
 		((c++))
-- 
2.30.0-586-g047f30a795

