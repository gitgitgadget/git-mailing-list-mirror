Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B51C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 16:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbiBDQUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 11:20:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52930 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiBDQUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 11:20:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF79F118003;
        Fri,  4 Feb 2022 11:20:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QNp6V4U4RkoB
        YApxI9mI6yJnmsHCGpKKiIlZJKFvTwU=; b=KD/Q9dOfcOEM0Xr7ey8RRuGwUtVn
        2xqYI+s54bl1gm2BBZsZT/2QatMbcFLvRISZX4sVuyY9OEiBTh78FQJ7pl7QPMfu
        YkFureDONNbsdqRMAZh+99AIjgbbswFin1fsbUmErIK7W5AiebfwtfPHQib/oTde
        eblToUNnLO5v5m0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3EFC118002;
        Fri,  4 Feb 2022 11:20:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19559118001;
        Fri,  4 Feb 2022 11:20:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
References: <20211117005701.371808-1-emilyshaffer@google.com>
        <20220203215914.683922-1-emilyshaffer@google.com>
        <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
Date:   Fri, 04 Feb 2022 08:20:44 -0800
In-Reply-To: <220204.86pmo34d2m.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 04 Feb 2022 02:15:27 +0100")
Message-ID: <xmqqiltuob6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6850767C-85D6-11EC-AA60-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I just genuinely don't get where this is headed. I.e. for the last
> iteration I did a demo patch on top that showed that there was no case
> added by the series where the on-the-fly discovery wasn't equivalent to
> the set-in-config value[4].
>
> That change showed that after this series in a state where the config
> *is* redundant to on the fly discovery (or maybe not, and we're just
> missing test coverage).
>
> But since you're citing correctness do you have some repo->sub
> relationship in mind that would be ambiguous in a way where the
> configuration would resolve the ambiguity?

This is an excellent question, which I wish I could have raised in
my earlier response.  A clear explanation why this setting is not
a redundant copy but adds real information on top of what we should
be able to learn from the filesystem structure would really help in
justifying the new thing.

Thanks.
