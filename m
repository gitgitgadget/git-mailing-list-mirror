Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A03C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 20:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003B62073B
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 20:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lvwmmtRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgCCUIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:08:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53073 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgCCUIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 15:08:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AACC8C6A02;
        Tue,  3 Mar 2020 15:08:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pWyOtGmkjHV0P3zg8K6rkut5QrQ=; b=lvwmmt
        RIfWtgvHxaeBm2kFWP+4w+zkEe7D/xmS3CPRroEcHONuZf4zGvrddDADDgVXmTjv
        l/DgYxlUzdcJeFFA8n4LXZBAPTS7Hz+0N++52u6iEHJQl67ShEk7Aft2PoWLw4kL
        HGUpqW5y2P700Wa4mhIrSrq/tjfDgmnzIrojY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N1yBuRM+l6cXAfoY345rfkHHbuqyrRVf
        4WWGVWGofEDOMea7snYPL1wnm/JLo7m2LQY4k80ASdmP9LmbpereASN39NJIj/25
        WpJRgoSNZIh0yGtz9geiba4it7oH0BiIcXcFNRke6Qveou5hVMHN9iMa8MgUGOdG
        7EzVBtjdCEQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A191DC6A01;
        Tue,  3 Mar 2020 15:08:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C99EDC6A00;
        Tue,  3 Mar 2020 15:08:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Takuya N via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Takuya Noguchi <takninnovationresearch@gmail.com>
Subject: Re: [PATCH] doc: use 'ref' instead of 'commit' for merge-base arguments
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
        <CAGyf7-Ez1Fx-VUVmDWxRxLaZcU+Tu4kZ+F2+0uNKkx2oftjEJQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2003031507500.46@tvgsbejvaqbjf.bet>
        <xmqqd09ta4tn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003032035510.46@tvgsbejvaqbjf.bet>
Date:   Tue, 03 Mar 2020 12:08:43 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2003032035510.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 3 Mar 2020 20:38:19 +0100 (CET)")
Message-ID: <xmqq5zfl8alw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9A9B8DC-5D8A-11EA-A093-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>
> We do not only want commit objects. It is totally legitimate to ask
>
> 	git merge-base HEAD v2.25.0
>
> (v2.25.0 is of course not a commit, it is a tag that _refers_ to a
> commit.)

I meant to say (and was expecting those who know to know)
committish, of course.

> Earlier, we would probably have called this a "commit-ish", but since
> users got so confused by this instance of Git Speak (is my interpretation
> of the reason, at least), we tend to call them "revs" these days.

I am not among that "we".  "rev" is an older and even more nerdy Git
speak that was invented back when Linus was active, and as you can
see, we used the word to mean not just commit or commit-ish, but
anything that can be turned into an object name (you'd realize that
you know it already, when you think about what 'rev' means in "git
rev-parse").  The phrase *-ish came much later (I think I was among
those who started it).

