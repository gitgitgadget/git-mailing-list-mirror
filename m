Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D592C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FD561186
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhKJRXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 12:23:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50618 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhKJRXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 12:23:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A556AFF52C;
        Wed, 10 Nov 2021 12:20:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UAHsWhe9NrVcTpjwMVxLBxeeVKkaVudoagOAPn
        HtonY=; b=rLigv6JAelrqzAYddAQG+R+OcQiF/NtFAhdsMw0NcIpG4yRPhS4cFm
        JhNrMFbyJiyhjEv5dqTxSPq985mQipoIh0YKgCqGAd65juB2kxH21Ao54ACWERIP
        UXxaK6QrnM97sHp6lKS1/baLBaw15vzr35XX3TZQslCF0Uunrjm/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D47EFF52B;
        Wed, 10 Nov 2021 12:20:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1342DFF52A;
        Wed, 10 Nov 2021 12:20:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jc/fix-pull-ff-only-when-already-up-to-date, was Re: What's
 cooking in git.git (Nov 2021, #03; Tue, 9)
References: <xmqqy25wygek.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111101402240.21127@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Nov 2021 09:20:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111101402240.21127@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Nov 2021 14:04:38 +0100
        (CET)")
Message-ID: <xmqqpmr8x6zn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8100D948-424A-11EC-A5A2-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 9 Nov 2021, Junio C Hamano wrote:
>
>> * jc/fix-pull-ff-only-when-already-up-to-date (2021-10-29) 1 commit
>>   (merged to 'next' on 2021-10-29 at ad4753e668)
>>  + pull: --ff-only should make it a noop when already-up-to-date
>>
>>  "git pull --ff-only" and "git pull --rebase --ff-only" should make
>>  it a no-op to attempt pulling from a remote that is behind us, but
>>  instead the command errored out by saying it was impossible to
>>  fast-forward, which may technically be true, but not a useful thing
>>  to diagnose as an error.  This has been corrected.
>>
>>  Will cook in 'next'.
>
> I would like to register a vote for advancing this into v2.34.0,
> still.

I didn't recall I did it as a regression fix, but as a fix for
relatively old change that is already in released version(s) in the
field.  If the breakage is new between 2.33.0 and 'master', I think
it is a good idea to merge it down.

Thanks.

