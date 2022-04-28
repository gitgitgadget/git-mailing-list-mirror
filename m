Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E96DC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 04:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbiD1FAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 01:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiD1FAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 01:00:33 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A1A98F60
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 21:57:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62E331A5319;
        Thu, 28 Apr 2022 00:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lnFtZ9xY04zS
        fQB/H18ytQmn1SgPappfENNYDfJfrbM=; b=ury81bD3GSTocrkNtDhQFDwsHMgZ
        WpFASqG4FiecSgZB+RYdgoUh/25cxiG/9QHqhDpH7BooOhd/dDzcYjNIzBJC4op5
        3rWBVVbTMEMW5Wxbg5UljXdIcVtpSXqtYuDMxCb4QLOsgACXn8XFX7Zouk3X4BbV
        44WC/vDWWkzPYww=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4768B1A5318;
        Thu, 28 Apr 2022 00:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB81D1A5316;
        Thu, 28 Apr 2022 00:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH 0/2] fix `sudo make install` regression in maint
References: <20220427222649.63516-1-carenas@gmail.com>
        <20220428033544.68188-1-carenas@gmail.com>
Date:   Wed, 27 Apr 2022 21:57:13 -0700
In-Reply-To: <20220428033544.68188-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 27 Apr 2022 20:35:42 -0700")
Message-ID: <xmqqy1zphkk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABF9934E-C6AF-11EC-9C38-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> The following series complement the recently queued[0] RFC that adds
> the missing functionality to allow git to validate a git repository
> while running under sudo.
>
> They could be squashed together if preferred, as they seem to be
> smaller that I had originally assumed and also unlikely to conflict.
>
> The test uses a function I stole from rs/t7812-pcre2-ws-bug-test that
> could be alternatively moved to a common location and reused if that
> is preferred, but it is small enough that might be as well be done
> as part of some cleanup later.
>
> Tried to change the documentation in a way that wouldn't conflict with
> other on the fly changes, but there is at least one pending change
> not in seen AFAIK in the same file from G=C3=A1bor which might[1], but =
the
> resolution should be to take both sides.

We shouldn't have to worry too much about anything that is not in
'master', as we can kick out things that conflict whose resolution
is too cumbersome and ask contributors to rebase and come back if
needed.  Regression fixes are more urgent than anything not in
'master' at this point, although of course we do not have to make
conflicts deliberately ;)

It seems that these two apply cleanly on top of the other one that
in turn applies cleanly on top of maint-2.30, which is very much
suitable base to build these fixes on.

Thanks, will queue.

I've already read through them but additional set of eyes are
appreciated as always and even more than usual.  Hint, hint...



