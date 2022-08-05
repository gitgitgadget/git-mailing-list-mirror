Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE92C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 16:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbiHEQMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiHEQMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 12:12:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B7073919
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 09:12:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EDD01974C5;
        Fri,  5 Aug 2022 12:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y/FgOzytNFjS
        avqtmJ03BO9zcN5m2fskhTSebixDX/U=; b=ArIKy6nwoUOx6kvQddA/ZxVED7Mp
        LUeT0uNrTkQA8bgks0Xw9QlvemOXHbsxW/RXwOkQ2KL1M+4AHtZODv+U0TuirOP8
        bzYVeF97ansu2U+krFAKteB1+mmq2Iib/48NWDYC34pDAVj7zBtDGI6r75b0cx2T
        j9s6C++cX179Pes=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35D161974C3;
        Fri,  5 Aug 2022 12:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 495F01974C1;
        Fri,  5 Aug 2022 12:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 11/12] docs: move cruft pack docs to gitformat-pack
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
        <patch-v8-11.12-b9dde9788d4-20220804T162138Z-avarab@gmail.com>
        <xmqq5yj73d6l.fsf@gitster.g>
        <220805.86h72rrsuc.gmgdl@evledraar.gmail.com>
Date:   Fri, 05 Aug 2022 09:12:12 -0700
In-Reply-To: <220805.86h72rrsuc.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 05 Aug 2022 10:29:08 +0200")
Message-ID: <xmqq35ea1xgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5DD68EA6-14D9-11ED-957F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> That makes sense to me, and I agree that in the longer term we may
>> want to treat the pack bitmap format documentation the same way.
>
> I have that patch locally already, and figured I'd send it in shortly
> after this lands. I just didn't want to burden you with the merge
> conflict with c7e7f5dd814 (Documentation/technical: describe bitmap
> lookup table extension, 2022-07-20).
>
> The merge conflict is relatively easy to deal with, I included a
> resolution in the v3 of this series (but ejected the change out of v4):
> https://lore.kernel.org/git/cover-v3-0.7-00000000000-20220712T195419Z-a=
varab@gmail.com/
>
> I can still re-roll with it if you'd like it sooner than later, or
> ac/bitmap-lookup-table could be re-rolled on top of this topic
> eventually (it seems it needs an eventual re-roll anyway due to SHA-256
> flakyness).
>
> Or we could just go with the status quo here and leave it until the dus=
t
> eventually settles, which is what I went with so far.

Let's go slowly.  Others may feel differently and prefer separate
manual pages for .mtimes and .bitmap formats instead.  They have
more info to form their opinions after this round lands.

Thanks.
