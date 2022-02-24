Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406A5C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiBXUF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiBXUF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:05:58 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C52763DF
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:05:28 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F3B310D352;
        Thu, 24 Feb 2022 15:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Sb3mnKPbFfap
        S4Xr7Q1TdrDg3BW/+dQc8ARjkQ5bYVM=; b=GhbkMNYvaUF61nViaNyZK80Q9Ymg
        yIvy3pX1bRDpX6nMya2pEWRsyWMV4OVerv67AXj2QqLWVpRbhbvSWlQ5yd2anyan
        6Ik3aC9BoO0pA++/7jun8ckJgGiQMwqPni62Y+K66a1QBBOta+h00aH1QV/PxJNx
        q42ft8DlO1c+a8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6694C10D351;
        Thu, 24 Feb 2022 15:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C20B110D350;
        Thu, 24 Feb 2022 15:05:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
        <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
        <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
        <YhPL+wSxtI0KIz07@nand.local>
        <220221.868ru4avw6.gmgdl@evledraar.gmail.com>
        <xmqqee3vwepd.fsf@gitster.g>
        <220222.86o82z8als.gmgdl@evledraar.gmail.com>
        <xmqq4k4puyn9.fsf@gitster.g>
        <220224.86bkywaakn.gmgdl@evledraar.gmail.com>
Date:   Thu, 24 Feb 2022 12:05:25 -0800
In-Reply-To: <220224.86bkywaakn.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 Feb 2022 10:14:51 +0100")
Message-ID: <xmqqa6egkp2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BB112A4-95AD-11EC-A534-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So you're OK with the assumption/method being used here, but would
> prefer if we also added an explicit check/"exit 1"? E.g.:
> =09
> 	if test "$TEST_DIRECTORY" =3D "${TEST_DIRECTORY%/t}"
> 	then
> 	        echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in =
'/t'?" >&2
> 	        exit 1
> 	fi

Exactly.
