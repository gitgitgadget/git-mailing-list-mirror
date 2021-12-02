Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF776C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbhLBGiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 01:38:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56342 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhLBGiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 01:38:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 404C615B3CA;
        Thu,  2 Dec 2021 01:35:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GD6An1Xah6m2
        P+KmgNGl4jbDf2ISOkSep9GC8NvXLyE=; b=qsDT6IuM/AMEP3I/CEO6m/5NnzkS
        a3R92o3r3/JsH3i5aS3cTy9VW2Rb7hSXo2xfA+S+GYAnUPLCgwqevcbyoyEXm1EX
        w5kFz404dbTEEvTbQhnTwtCZv/K73mlSwGeVj1wiV+yy+PEYsFL7dzJH3XPhpt4/
        boowCig4DAt6934=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3895D15B3C9;
        Thu,  2 Dec 2021 01:35:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB42B15B3A4;
        Thu,  2 Dec 2021 01:35:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, chris.torek@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH 2/3] editor: allow for saving/restoring terminal state
References: <20211202035446.1154-1-carenas@gmail.com>
        <20211202035446.1154-3-carenas@gmail.com>
Date:   Wed, 01 Dec 2021 22:35:23 -0800
In-Reply-To: <20211202035446.1154-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 1 Dec 2021 19:54:45 -0800")
Message-ID: <xmqqtufrwm38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 080A874A-533A-11EC-85A1-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> When EDITOR is invoked to modify a commit message (or do some
> other editing), and it is a terminal mode editor, it will need to
> change the terminal settings, and if it misbehaves could leave the
> terminal output damaged as shown in recent reports from Windows
> Terminal[1]
>
> Instead use the functions provided by compat/terminal to save the
> settings of the terminal and recover safely, but only do so if
> the editor is known to have issues and unless the user has told
> us through a boolean configuration "editor.stty" that it is safe
> not to do so.
>
> [1] https://github.com/microsoft/terminal/issues/9359
> ---
> The commit message was contributed by me, but the rest comes from:
> https://lore.kernel.org/git/xmqq7dcnyh5o.fsf@gitster.g/
> Signed-of-by is missing as I didn't know what would be preferred
> or if the Author will be ok with my grammar (ginger free grammar
> check seems to approve, otherwise)

It was merely an illustration patch, without 3/3 it would not be
complete, and most importantly, finishing the last mile like 3/3 did
is 80% of the work.  I'd rather see you take the authorship of the
commit that results from the squashing of 2 and 3.

Any patch I send here is by default signed off by me.

Thanks.
