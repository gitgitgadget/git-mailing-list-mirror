Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EAFC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4A56108B
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhKJTUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:20:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57716 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhKJTUG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:20:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D566100234;
        Wed, 10 Nov 2021 14:17:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iYmjQnZdhfm7DIvpBQijFyquwDwlcGM6qeuQtg
        G3aec=; b=cWbyI9KPTqWzg6l1/1sRyKkCp4aTBqIwR4uG/FoCNGPwl3G0fmp3Hx
        umQws8/KEGx8PAatkHtXTC8ShbPQZ9cWRKM/z1loc06UDSQ5hGzlSaiKbZaynqrZ
        g3F14R2QuRST/MUOh+XUlJHxAOibgbtJ0sm1++Tq38J+G3IHkiBp4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9429E100233;
        Wed, 10 Nov 2021 14:17:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0132C100232;
        Wed, 10 Nov 2021 14:17:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jc/fix-pull-ff-only-when-already-up-to-date, was Re: What's
 cooking in git.git (Nov 2021, #03; Tue, 9)
References: <xmqqy25wygek.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111101402240.21127@tvgsbejvaqbjf.bet>
        <xmqqpmr8x6zn.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111102000250.21127@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Nov 2021 11:17:15 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111102000250.21127@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Nov 2021 20:09:09 +0100
        (CET)")
Message-ID: <xmqqlf1vyg5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D174A886-425A-11EC-9936-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I didn't recall I did it as a regression fix, but as a fix for
>> relatively old change that is already in released version(s) in the
>> field.  If the breakage is new between 2.33.0 and 'master', I think
>> it is a good idea to merge it down.
>
> I can say with conviction that this is a very recent change of behavior,
> as I needed this quick-fix on Oct 30:
> https://github.com/git-for-windows/build-extra/commit/fb311a97cf82243ea1fe4036f1b180f5a3e6bc7f
>
> I don't recall the particular details how this fix came about, as it was
> the day of -rc0 (and I don't remember whether I needed this _before_ or
> _after_ Git for Windows -rc0 was released). All I remember is that an
> automated build broke because it created a local commit and then expected
> `git pull --ff-only` to succeed (because the remote was not ahead, but it
> necessarily was behind the local HEAD).
>
> The change of behavior might have been introduced by v2.33.1, or by
> v2.34.0-rc0.
>
> So yeah, I would argue that it is a regression introduced in this cycle.

Yeah, I was agreeing with you.  Together with the simple-ipc thing,
we will have two fixes in the final one on top of -rc2; hopefully
these would be the last ones ;-)

Thanks.
