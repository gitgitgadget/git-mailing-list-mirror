Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E6C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0162072D
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="laQf8nTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831362AbgJ0UX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:23:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57293 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1831358AbgJ0UX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:23:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 586C9E7643;
        Tue, 27 Oct 2020 16:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ewtl0fXFTarWlqAqMoadA7pHY9M=; b=laQf8n
        Tx1fJs+TnjWxua5vs2jvZEM88SmiKoJWYsYdyL+gBjD+1p7nFRXp0o13uaCTpYtA
        d2cR+UbhUVugA91Y4IDksIoSA7SJdIJ1zAs5+tokf+pHNYCqISJAkoWASxTLBe5H
        sRqrBU9Z/ndAvhphll+bpxFRjWxixRBgbcAVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b5zkIvj6ZpreLPJA3FfbVgA8sFNlClTT
        35Bg2FHufXlBA1kX6poEuTbLoUQuZyE1/2AoGTzB6myi+308aDdzK0+K0z1sfokd
        hGHvgggQGAcupGbUriq0FipnpLBOEnyPCZugb4g9lk2EM7l7EA81nPVkT5KtgpoC
        fgCboVc+ZzM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CF63E7641;
        Tue, 27 Oct 2020 16:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E432E763A;
        Tue, 27 Oct 2020 16:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
        <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
Date:   Tue, 27 Oct 2020 13:23:50 -0700
In-Reply-To: <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
        (Felipe Contreras's message of "Sat, 24 Oct 2020 22:46:19 -0500")
Message-ID: <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5467F76E-1892-11EB-9279-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> What I am trying to get at is if we would want to keep the earlier
>> zsh parts of the series, but with nobody seemingly interested in, it
>> is hard for me to justify queuing them.
>
> You are asking in the wrong forum.
>
> I would gladly point you to *dozens* of issues reported in Stack
> Overflow and Oh-My-Zsh if you don't believe me.

Oh, no, there is no "believing" needed.

Have you fed your patches to those folks who have dozens of issues
and the patches made their life better?  It does not help much to
make me look at these forums; we need some way to make those in
these forums aware of your improvements, try them out and report
success, to help the wider range of users who are not even in these
forums and struggling with their zsh-completion use (they will get
their zsh/git completion from their distros---I am assuming that the
distros get theirs from us in contrib/completion/).

> Or you could just install zsh and see the issues for yourself.

No, thanks.  I am not a zsh user, and have no plan to become one ;-)
