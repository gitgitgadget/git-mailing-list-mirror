Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A36EC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 07:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354292AbiAYHgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 02:36:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65216 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446038AbiAYHdc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 02:33:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17E5217B640;
        Tue, 25 Jan 2022 02:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=hiMlb8uuJKRm9zsGKTI08q1Rv
        go5QyEnkEv9GCFyJVM=; b=Njuxh+r+DcS4DYAfCMyRiUhsTVJ2cX/6d/Y++apcG
        J98d9d6u3KXrS5rNfcvhYxJJqxgnc5IzPpoi4yliGBAYBHbx5MRkTPyOzagPQVjx
        DJyGyrOuDc/RTnfYuTzRM/2avKK5wyEWacAJ2cKdxh8Kj8VW1yAEd6GFnTfslc5j
        U0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1086017B63F;
        Tue, 25 Jan 2022 02:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CC1317B63E;
        Tue, 25 Jan 2022 02:33:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jo=C3=A3o?= Victor Bonfim 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Some sub-commands can't be completed by TAB key.
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
        <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org>
        <CAGP6PO+GMi6jqRZ5HWxES5GDYkEDHoXOOZ+VvDkm0sC4nxkT4Q@mail.gmail.com>
        <5a30ac1f-d414-0976-cd08-7b059117af41@gmail.com>
        <xmqqpmoi9qna.fsf@gitster.g>
        <Odvn8_XIojrgpHG7xMtrBXdhoxr20X_fFRYoDtvkUKb1FOd-13j_l40TBAc1hn7rSddJ-YrQak8AuetNQ9LkeVeVoS3RTlIeSQ9znqyMApc=@protonmail.com>
Date:   Mon, 24 Jan 2022 23:33:25 -0800
Message-ID: <xmqq1r0w1d8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 157991CC-7DB1-11EC-A2FE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jo=C3=A3o Victor Bonfim  <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
writes:

>> It is also worth noting that completion will also include whatever
>> alias.  I get "lg" in the mix because I have...
>
> That sounds like something that should be hidden, no?
> Like, all aliases are left unmentioned?

Unlike the plumbing commands that are meant to be used in writing
scripts and not typed in interactive sessions, and more like
Porcelain commands that are meant to be used by human end-users in
their interactive sessions by getting typed from the keyboard, an
aliase is often (and certainly my "lg" is) defined in order to give
a short-and-sweet typesaver to a command with common initial options
that the user finds useful in their interactive sessions.

I am curious to find out what makes you think it is a good idea to
omit them from completion.


