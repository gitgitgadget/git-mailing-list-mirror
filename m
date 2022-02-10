Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0760AC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 17:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbiBJRUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:20:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245113AbiBJRUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 12:20:07 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604F8E70
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 09:20:08 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 978B11188DD;
        Thu, 10 Feb 2022 12:20:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u7QdGqLxJci+
        W2Kjc2p+5qgPIEv/OUrFcTOaNNLvy2c=; b=wqNeuWChlD1VQjp/yVV0EAv4q7nF
        EGP9iaGZBMCWQAp4s1jiAIGXnBBBuKFyCRDBkmlZ6RFGqXrv1LhX46UHrLqdhRhy
        utkQjw7/e40uyKxUDIVTZ0CpP6iVljJAj26chXy1G8hxhdSMu4YEPEQKuQFLYYmM
        LwtL8jkpeHr0qQQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 792A81188DC;
        Thu, 10 Feb 2022 12:20:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68DE41188DA;
        Thu, 10 Feb 2022 12:20:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     jaydeepjd.8914@gmail.com
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
References: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
        <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
        <81e8a217-356d-65cd-3a89-f20ef9c1a5d7@gmail.com>
        <xmqqleyjxzs4.fsf@gitster.g>
        <c64e52e1-3916-dc7a-60d7-98c324814f0e@gmail.com>
        <xmqq4k57xlot.fsf@gitster.g>
        <bc36eab7-62ae-2e67-aa4f-cceec5c86012@gmail.com>
Date:   Thu, 10 Feb 2022 09:20:02 -0800
In-Reply-To: <bc36eab7-62ae-2e67-aa4f-cceec5c86012@gmail.com> (jaydeepjd's
        message of "Thu, 10 Feb 2022 12:41:55 +0530")
Message-ID: <xmqq1r0awse5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B067CD0C-8A95-11EC-B3E7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jaydeepjd.8914@gmail.com writes:

> Here is an example. The synopsis of command `send-email` vs synopsis of=
 `commit`:
>
> ```
> git send-email [<options>] <file|directory>=E2=80=A6=E2=80=8B
> git send-email [<options>] <format-patch options>
> git send-email --dump-aliases
> ```
>
> ```
> git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend=
]
> 	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword=
):]<commit>)]
> 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> 	   [--allow-empty-message] [--no-verify] [-e] [--author=3D<author>]
> 	   [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
> 	   [-i | -o] [--pathspec-from-file=3D<file> [--pathspec-file-nul]]
> 	   [(--trailer <token>[(=3D|:)<value>])=E2=80=A6=E2=80=8B] [-S[<keyid>=
]]
> 	   [--] [<pathspec>=E2=80=A6=E2=80=8B]
> ```
>
> The `commit` synopsis has a more verbose overview of all the options av=
ailable compared to `send-email` synopsis.

I think the former is more modern style that leaves the description
of options to the main text.  It also allows the synopsis section to
make it stand out very different operating modes instead of having
the alternative listed with [ A | B | C ] and having the readers
guess if all combinations of alternatives are valid (they are often
not).

The former style takes more thought to write well, when a command is
multi-purpose and has different operating modes (cf. "git checkout").

For "git commit", even though conceptually creating a totally new
commit and amending the current one are two quite distinct opeating
modes, they pretty much take the same set of options, so I suspect
we can do with just one

	git commit [<options>] [--] [<pathspec>...]

in the modern style, but I dunno (that is why I said "it takes more
thought" and I cannot afford much time to think it through just for
illustration purposes).

Thanks.

