Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E5C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiHDVhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHDVhE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:37:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9287A6D9CB
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:37:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23BE91BF6C0;
        Thu,  4 Aug 2022 17:37:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Cv7x6qCXJm8R
        IpfGrt/89pQ270V8nUQ/XrL75A2d92U=; b=JU24YgV5ucjYUatNR0AnwjmbqK+w
        hPsdy5oRpwQnWDo49cZlt3EKaZ2duavuMmxBEJ+6GAfVaoEW9rApwEkbE5V6Nfib
        gkmKoD++4mUPIqH7wPLZg+j2TLvjkxadMvrs2r1aPdXfNr4GiS5WiONfmw5IpKLD
        CEPe/9etaYnlQrM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D6831BF6BF;
        Thu,  4 Aug 2022 17:37:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A42EC1BF6BC;
        Thu,  4 Aug 2022 17:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 00/12]  docs: create & use "(user|developer)
 interfaces" categories
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
Date:   Thu, 04 Aug 2022 14:36:57 -0700
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 4 Aug
 2022 18:28:29
        +0200")
Message-ID: <xmqq1qtv3d3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 919CE9FC-143D-11ED-9789-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> See the v5 for a general overview:
> https://lore.kernel.org/git/cover-v5-0.9-00000000000-20220721T160721Z-a=
varab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (12):
>   help.c: refactor drop_prefix() to use a "switch" statement"
>   help.c: remove common category behavior from drop_prefix() behavior
>   git help doc: use "<doc>" instead of "<guide>"
>   git docs: add a category for user-facing file, repo and command UX
>   git docs: add a category for file formats, protocols and interfaces
>   docs: move commit-graph format docs to man section 5
>   docs: move protocol-related docs to man section 5
>   docs: move index format docs to man section 5
>   docs: move signature docs to man section 5
>   docs: move pack format docs to man section 5
>   docs: move cruft pack docs to gitformat-pack
>   docs: move http-protocol docs to man section 5

OK, I have to admit that my eyes were a bit too tired to give a
fine-toothed-comb review, but between range-diff output and a full
reading of the new ones that range-diff did not match with the old
round, I did not find anything unexpected.  Looking good.

Thanks.
