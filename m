Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119DBC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3866109F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhKCUal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:30:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56074 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhKCUaj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 16:30:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9721E4F1B;
        Wed,  3 Nov 2021 16:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymM9Ff9B1PLdSuM0F012jDp5afzrNaqBLGzifV
        un2Gw=; b=xsnqvecNabXVZb5PFBdA18iX7lELaNG/3bI7Lr6ZCpY0G4VxNC21fE
        VP5ylGSkIRE1ouTI1p3FeUwqpLAHg3439PkGrU+G2BlbBRFLfyltEvuz+RsIvtSq
        fSIzVZLf5xNpZ9PnjvmyGMSclgrvzeZrK5vF6sHh/4xUbWq+BavjE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B13C8E4F1A;
        Wed,  3 Nov 2021 16:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F10DCE4F19;
        Wed,  3 Nov 2021 16:28:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Dongsheng Song <dongsheng.song@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf_addftime(): handle "%s" manually
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
        <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
        <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
        <xmqqcznldobz.fsf@gitster.g>
        <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
        <xmqq1r3zd9k5.fsf@gitster.g>
        <YYEihoLbEGi44dDb@coredump.intra.peff.net>
Date:   Wed, 03 Nov 2021 13:28:00 -0700
In-Reply-To: <YYEihoLbEGi44dDb@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 2 Nov 2021 07:35:34 -0400")
Message-ID: <xmqqtugt56i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ACE03B2-3CE4-11EC-98BE-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this also needs squashing in?

 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/rev-list-options.txt w/Documentation/rev-list-options.txt
index 24569b06d1..43a86fa562 100644
--- c/Documentation/rev-list-options.txt
+++ w/Documentation/rev-list-options.txt
@@ -1047,7 +1047,7 @@ omitted.
 has no effect.
 
 `--date=format:...` feeds the format `...` to your system `strftime`,
-except for %z and %Z, which are handled internally.
+except for %s, %z, and %Z, which are handled internally.
 Use `--date=format:%c` to show the date in your system locale's
 preferred format.  See the `strftime` manual for a complete list of
 format placeholders. When using `-local`, the correct syntax is

