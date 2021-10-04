Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0CDC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B800B6126A
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhJDQkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:40:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55612 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhJDQkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:40:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3313215A11F;
        Mon,  4 Oct 2021 12:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hj1nXnq12sFs
        J3CIJoJLhDWqkSn03rjuGU6B7+GjLbg=; b=BMcilw0DQp0+WaYqPZHjy1vYHqHI
        pLQE5TVWfB+X+7BRbGud460ZnEnOFhVbm0sbK5RmmitnW/nSowKKGuyVEFW5NLiM
        B78fb/jvfQSeCDKiBeYnqCfDnWAwKLvq+wcGTNcV2asIjS8JYO0ewyZyMMY3/ux3
        IIaDP5I/m3u/73Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BCF715A11E;
        Mon,  4 Oct 2021 12:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F40015A11D;
        Mon,  4 Oct 2021 12:38:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/2] protect git from a rogue editor
References: <20211002153654.52443-1-carenas@gmail.com>
        <20211004072600.74241-1-carenas@gmail.com>
Date:   Mon, 04 Oct 2021 09:38:16 -0700
In-Reply-To: <20211004072600.74241-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 4 Oct 2021 00:25:58 -0700")
Message-ID: <xmqqwnmswxs7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A3C082A-2531-11EC-BE4B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> The following series, expands git's terminal support to allow for
> saving/restoring its settings around an EDITOR call.
>
> The reason why that might be useful has been documented[1] by Windows
> users that had found themselves not able to read clearly the messages
> printed by git after a commit (or a rebase) when the default EDITOR
> failed to reset the terminal settings completely.

Sounds sensible.  I do not think it is limited to Windows---I think
I've caused vi crash to get me into an non-echoing terminal myself
non some variant of UNIX before Linux era ;-)

