Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAAFC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiBWUNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiBWUM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 15:12:56 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DC840E7F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:12:28 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 840BD11ECC4;
        Wed, 23 Feb 2022 15:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X8PuQ2uNqOG6pc5CHWQM1ymHtYUOWWa2GLptvC
        qWjyI=; b=tlzYQvBxmO5mpidfG6O27o2AyV4y3pWVsVmOUnGhyxjaWh7yGMMPCc
        5vz7fqINQ2cZezQF3e+9wtFrKC3kYvuscr+f9/pOcS9Ip8j8NeIzAsXkxDCFIpIA
        fDqFaIJoROlcqewScegskTn0zzUKZ4fnIMeb0CR4UioimoYoqvOzI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B34E11ECC3;
        Wed, 23 Feb 2022 15:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A493E11ECC1;
        Wed, 23 Feb 2022 15:12:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
        <4d3fecbf-23f9-f6b6-414e-8eaca620aced@gmail.com>
Date:   Wed, 23 Feb 2022 12:12:25 -0800
In-Reply-To: <4d3fecbf-23f9-f6b6-414e-8eaca620aced@gmail.com> (Phillip Wood's
        message of "Wed, 23 Feb 2022 13:55:39 +0000")
Message-ID: <xmqq8ru1uyty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB8C6F42-94E4-11EC-B649-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I can see that showing compilation errors without having to expand
> anything is useful but in my experience they are relatively rare 
> compared to test failures. If I understand the rest of the message
> correctly we're left with having to expand print-test-failures and 
> searching for "not ok" to find out what went wrong with this series.

It matches my experience that most of the time I have to look for
test errors, not compilation errors.  Having to expand the other
group and looking for "not ok" is something I've got accustomed to,
so if that part improves, that would be great, but if that part does
not become worse, then that is OK, at least to me ;-)
