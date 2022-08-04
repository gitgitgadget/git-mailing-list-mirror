Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C0BC25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiHDVfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiHDVfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:35:04 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173F248F4
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:35:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AC86154CDB;
        Thu,  4 Aug 2022 17:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=026G3t3qDxsQ
        cA+HxGyR+hFBPvhPcxlXwW/0EhswBBM=; b=wV/qb5Up4Vzd5injxoUT9EI33pDj
        Orxr/q2DEmwcmSuJs5ij1XhdhijI+pgTmcXH7rYVDZqLBToh8vMkmr6LGli89sVC
        5g7m5VMZ9vBJdbYOpHGVrudTxx4S0abvJHXgf9f4DCqZsfRhjlayqY8ppx9eZ3oA
        cWCosqvkHM6W6tk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FD5D154CD9;
        Thu,  4 Aug 2022 17:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16355154CD8;
        Thu,  4 Aug 2022 17:35:00 -0400 (EDT)
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
Date:   Thu, 04 Aug 2022 14:34:58 -0700
In-Reply-To: <patch-v8-11.12-b9dde9788d4-20220804T162138Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 4 Aug
 2022 18:28:40
        +0200")
Message-ID: <xmqq5yj73d6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4AEF545E-143D-11ED-BC48-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Integrate the cruft packs documentation initially added in
> 3d89a8c1180 (Documentation/technical: add cruft-packs.txt, 2022-05-20)
> to the newly created "gitformat-pack" documentation.
>
> Like the "bitmap-format" added before it in
> 0d4455a3ab0 (documentation: add documentation for the bitmap format,
> 2013-11-14) the "cruft-packs" were documented in their own file.
>
> As the diff move detection will show there is no change to
> "Documentation/technical/cruft-packs.txt" here except to move it, and
> to "indent" the existing sections by adding an extra "=3D" to them.
>
> We could similarly convert the "bitmap-format.txt", but let's leave it
> for now due to a conflict with the in-flight ac/bitmap-lookup-table
> series.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

OK, so this round we roll the "cruft packs" into the main "pack file
format" documentation, because the former is merely a minor deviation
at file format level (i.e. comes with an extra .mtimes file) and the
philosophy behind how they are meant to be used is what makes them,
that is mostly the same as the normal packs, different.

That makes sense to me, and I agree that in the longer term we may
want to treat the pack bitmap format documentation the same way.

