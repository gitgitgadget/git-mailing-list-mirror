Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE3C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 17:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbiBURSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:18:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiBURR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 12:17:28 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E0EBE
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:16:50 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5382182058;
        Mon, 21 Feb 2022 12:16:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dlZYiFqdzEhu
        Vh6A52TIQllpb3c9qKndSVZ8qLkTSps=; b=rFZD3mDbpcfFa7Zi+CDtx/hewWTo
        QiQ0mv1mvpMR+lKmftak5yhJgPOiDLhxfSrwmnB+BRyGLxJlIkRD6Mwfw1DD1qev
        +j63rpmuyA1RtHKN+KbLmKkwU0L75REZNSfTuKZyRGEmgv7XGDZNCESGp9MxMhdo
        7i7Dd7wM3tGeJNg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADA9B182057;
        Mon, 21 Feb 2022 12:16:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2128F182056;
        Mon, 21 Feb 2022 12:16:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/4] test-lib: improve LSAN + ASAN stack traces
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
        <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
Date:   Mon, 21 Feb 2022 09:16:47 -0800
In-Reply-To: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 16:58:31
        +0100")
Message-ID: <xmqqo830ta0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D42D088-933A-11EC-A67F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A UX improvement for [AL]SAN stack traces. See
> https://lore.kernel.org/git/cover-v2-0.4-00000000000-20220219T112653Z-a=
varab@gmail.com/
> for the v2.
>
> Changes:
>  * Renamed GIT_XSAN_OPTIONS to GIT_SAN_OPTIONS per Junio's suggestion

Heh, I wasn't suggesting anything.  I am OK with or without X, or
with X but X replaced with anything else ;-)
