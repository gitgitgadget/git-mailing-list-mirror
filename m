Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6B7C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF585610F7
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhKJVmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:42:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54630 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhKJVmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 16:42:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DBC710108A;
        Wed, 10 Nov 2021 16:39:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JIdLZxm3oEBz
        nfGgoEJ25MAX8VrCdzFwMp33kCHum4c=; b=U/QjrLh0ndgomYosyBBszKKy0Vtc
        75HGbqK5lWIS1OIndHtlqizGgoxd01x+H7nEy3EmzdgUOnSlUDeEwS2brNeMMhz9
        ul95FOWoBlo2C4z/Z3B3HJVbgYXCA5sZUEgsOXgwrW7pzt8/6igP9DXSOYc69TP0
        N1fmGFZeuZCZ7d0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34709101089;
        Wed, 10 Nov 2021 16:39:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B75B101088;
        Wed, 10 Nov 2021 16:39:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, fs@gigacodes.de
Subject: Re: [PATCH] RelNotes: mention known crasher when ssh signing with
 OpenSSH 8.7
References: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
        <20211110093912.4382-1-carenas@gmail.com>
Date:   Wed, 10 Nov 2021 13:39:26 -0800
In-Reply-To: <20211110093912.4382-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 10 Nov 2021 01:39:12 -0800")
Message-ID: <xmqqczn7y9kh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE1B917E-426E-11EC-8E53-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> As discussed[1] earlier, make sure there are no surprises when ssh-keyg=
en
> crashes on some users of OpenSSH 8.7 that are trying ssh signing.
>
> [1] https://lore.kernel.org/git/xmqqsfycs21q.fsf@gitster.g/
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Documentation/RelNotes/2.34.0.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/RelNotes/2.34.0.txt b/Documentation/RelNotes=
/2.34.0.txt
> index effab2ea4b..54dcc7240d 100644
> --- a/Documentation/RelNotes/2.34.0.txt
> +++ b/Documentation/RelNotes/2.34.0.txt
> @@ -8,6 +8,9 @@ Backward compatibility notes
> =20
>   * The "--preserve-merges" option of "git rebase" has been removed.
> =20
> + * The upcoming ssh signing feature is broken if used together with
> +   OpenSSH 8.7, avoid using it if you cannot update to OpenSSH 8.8
> +   (or stay at 8.6)

That may be correct, but it is NOT a backward compatibility note.
