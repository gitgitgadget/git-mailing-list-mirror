Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE1BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25470610A3
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhIJFkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 01:40:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58756 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhIJFkl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 01:40:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C735E29AA;
        Fri, 10 Sep 2021 01:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yI/3MtIRBeSbnPnhtE7tg4MARukZydtUQVptya
        XkyCw=; b=XIM6c2WCDVV85Id4KXL0U9mMpfSRdbNUGaTPP/Q1r7jik+eUlgNrUO
        ypssdiQ0NU00bUJl2G7D2t6z+oAX+01m6q51MMYkXVFB2hMp6M9FboVhM9iebPyd
        OhA7JywGVki+ovMfnGIZzPQQZFzn2m3t+z1kFr+isT0UJCsqnrL9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32A18E29A9;
        Fri, 10 Sep 2021 01:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2D22E29A8;
        Fri, 10 Sep 2021 01:39:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
        <YTOW352xtsbvJcKy@coredump.intra.peff.net>
        <20210907211128.mauwgxupbredgx7w@meerkat.local>
        <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
        <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
        <64a5aaf1-64af-3599-8520-ff3b55411e2a@gmail.com>
Date:   Thu, 09 Sep 2021 22:39:29 -0700
In-Reply-To: <64a5aaf1-64af-3599-8520-ff3b55411e2a@gmail.com> (Philippe
        Blain's message of "Thu, 9 Sep 2021 13:50:18 -0400")
Message-ID: <xmqqilz9ugz2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 787A9E20-11F9-11EC-903B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I agree it's nice to make it work out of the box, without the web server
> admin having to configure anything. But, I'm not sure we should completely
> drop the documentation patches: your patch will only affect future versions
> of git-http-backend, and users of previous versions will be left without
> any documentation as to how to configure it for protocol v2. So I would think we should
> keep the documentation patches, maybe with a mention "this should not be necessary
> in Git 2.34 and later versions" or something like that (since your
> commit message mentions that it "generally" should work like that depending
> on the web servers).

Thanks, exactly my thought on the need for docs.
