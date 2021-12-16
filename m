Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA64C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhLPV7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:59:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61770 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhLPV7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:59:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F6B9178529;
        Thu, 16 Dec 2021 16:59:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IEimzFIdgHNN
        wRpDQGCPocbliWnqN2t3LJEdfGKqbno=; b=kDK7sY4RqDqAcAixn6VJZwxjrWo9
        V8YBRkbduonSeuUhaGGlA4vVwlJumyWXIwnj4GVyKQlCBKU3TmkgeoGZgUw8DCBK
        NpNJbytmR2pnlWXER80ZNJnW2qYHtmZ+6AfzymdyPwCEdnk9BtqtWJ4UuF3XLzoB
        9Hkg6SXg86k+AIk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37EA0178528;
        Thu, 16 Dec 2021 16:59:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94580178525;
        Thu, 16 Dec 2021 16:59:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/1] grep: align default colors with GNU grep ones
References: <20211216115622.85506-1-lenaic@lhuard.fr>
Date:   Thu, 16 Dec 2021 13:59:39 -0800
In-Reply-To: <20211216115622.85506-1-lenaic@lhuard.fr> (=?utf-8?B?IkzDqW5h?=
 =?utf-8?B?w69j?= Huard"'s
        message of "Thu, 16 Dec 2021 12:56:21 +0100")
Message-ID: <xmqqh7b88b3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77F716E0-5EBB-11EC-8BD2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:

> git-grep shares a lot of options with the standard grep tool.
> Like GNU grep, it has coloring options to highlight the matching text.
> And like it, it has options to customize the various colored parts.
>
> This patch updates the default git-grep colors to make them match the
> GNU grep default ones [1].
>
> It was possible to get the same result by setting the various `color.gr=
ep.<slot>`
> options, but this patch makes `git grep --color` share the same color s=
cheme as
> `grep --color` by default without any user configuration.

I am not a huge fan of adjusting our defaults to other people's
default, since it will lead do an inevitable "Why don't they adjust
to match ours?" question, plus "We've been happily using the default
coloring, and you suddenly changed it to something ugly. We want our
color back and we do not care that now you match what GNU does".

The UI color choice is so personal, which does not help us either.

Having said that, I'll keep an eye on what others say on this
thread.

Thanks.

