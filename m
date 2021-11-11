Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F40C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEBC61284
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhKKS2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:28:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50246 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhKKS2n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:28:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EB8EF1522;
        Thu, 11 Nov 2021 13:25:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/yP9Y6RlQceYTAghg09BrcOeAU131+AxdgfJVy
        frWXA=; b=SapXn8cIkLBEhV1rIrf+qUfkLyQfAAASPVq8cTbGggBzdrEsZ8JQmS
        CH3g6DOO/Wk0kjX5OrVYJaNa+fHij49dWFOvATwBjpHgz1MuXctAUxUSMxEcspFE
        qg2BZ/nfsDV/MO1zV9uniSb8nyhI4Im8zYEW1IeFKseBc1SG1eHk0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26F53F1520;
        Thu, 11 Nov 2021 13:25:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FB72F151F;
        Thu, 11 Nov 2021 13:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Nov 2021, #03;
 Tue, 9)
References: <xmqqy25wygek.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111101343570.21127@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Nov 2021 10:25:51 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111101343570.21127@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Nov 2021 13:47:01 +0100
        (CET)")
Message-ID: <xmqqczn6mtw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDF88DEA-431C-11EC-94C0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> P.S.: The second reason is that I was uncertain as to your decision
> regarding Stolee's thread about the optimal final location for Scalar.
> Since it seems that we can actually go forward with `contrib/scalar/` even
> if you eventually decide you prefer another place, I plan on submitting a
> new iteration with adjustments for v2.34.0, after that release.

When "make install" at the top-level of the tree starts installing
"scalar", I'd prefer to see it outside contrib/.  That is the only
preference I can think of right now.  Before that happens, if there
is a way to install it, e.g. "cd contrib/scalar && make install", as
long as it is clear that it is not yet official, I have no problems
with.

There is no hard rule that "git" has to be the only top-level
command the end-user interacts with.  We already ship "gitk" and
"git-gui" with us, and adding "scalar" to the mix is OK.  Some
people may love it, and others may hate its design choices with
passion, but that is the same for "gitk" and "git-gui" already.
