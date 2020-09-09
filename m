Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F8C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8520F2065E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U3wn4DLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIISKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:10:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56642 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIISKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 14:10:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAD68EFB0B;
        Wed,  9 Sep 2020 14:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uWW/94rA6JwQ
        RCLW67/MUZf29pk=; b=U3wn4DLb7fDi5mznJV/V1ECDktOlrI2VpXalGPYgbe3V
        kUqy73PLjfFXCuZ/0j2anrUeHc7OC7SGjLVQTCiXJ0hc7etaESpJ0VNTFnXKtNHb
        FhF723FP0kU5DbM7kEVw/Q6OhSHujDy4+okCBmFaw/YgLllcA1aJczzUur3wUx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sDlpBA
        8L3LVXwhWwT2uQpQKUlX8Qr7zqrb3/GOpe6cDvxmVuDhMES0JfrDC7fYIHGshTAF
        5gnxlHgNJeNe0izddxJe5ROavtW+KdWBBrPmDbmy/ZwpZBjMmNfsZj3yB4xVUJ1N
        VXkdmDkY27ut4puDUO79HxQRIM1nTBpniZzTM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4292EFB0A;
        Wed,  9 Sep 2020 14:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA6B9EFB09;
        Wed,  9 Sep 2020 14:10:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Daniel Villeneuve <dvilleneuve.4142@gmail.com>, git@vger.kernel.org
Subject: Re: permissions of main folder for git-manpages.tar.gz
References: <cc8487b0-c23f-46c3-b8c3-e3188b7c0d0e@gmail.com>
        <xmqq7dt3x134.fsf@gitster.c.googlers.com>
        <20200909032838.GA59978@Carlos-MBP>
Date:   Wed, 09 Sep 2020 11:10:05 -0700
In-Reply-To: <20200909032838.GA59978@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 8 Sep 2020 20:28:38 -0700")
Message-ID: <xmqq363qx1mq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0F91ADA-F2C7-11EA-91F9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Tue, Sep 08, 2020 at 05:09:35PM -0700, Junio C Hamano wrote:
>>=20
>> I'm contemplating to apply something like the following patch to the
>> build procedure so that I can externally control the mode bits
>> recorded in the tarball by setting TAR_C_EXTRA_OPTS to options that
>> overrides mode bits and stuff (it takes GNU tar unfortunately, but
>> I suspect I am the only person that runs dist-doc target anyway)
>
> also useful (albeit not for the same reason) with BSD tar for adding
> things like "--check-links", either way don't forget the signed-off
> while adding:
>
>   Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Thanks.  I haven't even written a proposed log message yet, but I'll
remember.
