Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28EAC433EF
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 06:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiBMGZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 01:25:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBMGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 01:25:58 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C39C5E77C
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 22:25:54 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F29D1016B9;
        Sun, 13 Feb 2022 01:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ihERJBMEAbM4
        UPN7+tK9RpyCzrbLjORiWROnPbkH7ug=; b=Yn1QKQohspiEHLRA93//g478x2L+
        E2MCmjTCaNgdRphgKOVHlJiXSPICM7eVTQ5RYbPzTQZu7heVjkqRMAJMYm+RBPck
        /qrO2xVtIfgBd5qvhRqBu13Y7bn8AgCfN9Xp035mRULtGhM+u0BkKVUQt/RGiNc1
        0p4kjVQ30m9N52M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CE2B1016B8;
        Sun, 13 Feb 2022 01:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.67.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3C201016B7;
        Sun, 13 Feb 2022 01:25:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
References: <20211117005701.371808-1-emilyshaffer@google.com>
        <20220203215914.683922-1-emilyshaffer@google.com>
        <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
        <YgF5V2Y0Btr8B4cd@google.com>
        <220212.864k53yfws.gmgdl@evledraar.gmail.com>
Date:   Sat, 12 Feb 2022 22:25:51 -0800
In-Reply-To: <220212.864k53yfws.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 12 Feb 2022 21:35:48 +0100")
Message-ID: <xmqqbkzb705s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB34EA96-8C95-11EC-95A9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We have a /a/b/c/d.git mounted, but not a parent /a/b/, and walking
> upwards causes it to be mounted?

;-)
