Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D2A1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbeAHWHM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:07:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60312 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753616AbeAHWHL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:07:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB846D6A0F;
        Mon,  8 Jan 2018 17:07:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gpvdbAWnoorn
        cXrHYlUjzz8MNoQ=; b=rfwzaZ2NQt74a4wPq1yiemVGc8Py8CZpT9gyXn1Hu2is
        IjQh216MuizE1vmWdlIQs1DzlSVuapn9654dVQxvat3ocDeERhuS5NwKE371IGXn
        0R1muX4RMP04mvLbyGx2ydtXsxGg8oDYa758zTCWwf3VChUaIighJplwONgH2HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LC7B7H
        ek77XR8Jja6nbj+kQYF2vOdBb/bC8x7QNUjFSnRyU/OznMUaD36zr609XLGRO9aU
        Ucr0cazzEVPQI80AIUqL6ESrIIzPE2SA/ip2jqbq/7njt9J/L15dxO1FO4Io8If1
        W2JNbzpEQ4RlcPeB+kQ3xp22/KVfS7xt6VUJM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4222D6A0E;
        Mon,  8 Jan 2018 17:07:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DF35D6A0D;
        Mon,  8 Jan 2018 17:07:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
References: <20180108172214.23615-1-szeder.dev@gmail.com>
Date:   Mon, 08 Jan 2018 14:07:09 -0800
In-Reply-To: <20180108172214.23615-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 8 Jan 2018 18:22:14 +0100")
Message-ID: <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 46095BB6-F4C0-11E7-81D2-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The reason why Travis CI does it this way and why it's a better
> approach than ours lies in how unsuccessful build jobs are
> categorized.  ...
> ...
> This makes it easier, both for humans looking at the Travis CI web
> interface and for automated tools querying the Travis CI API,...
> ...
> A verbose commit message for such a change... but I don't know why we
> started with building Git in the 'before_script' phase.

Thanks for writing it up clearly.  TBH, I didn't even realize that
there were meaningful distinctions between the two cases after
seeing that sometimes our tests were failing and sometimes erroring
;-)

> Should go on top of 'sg/travis-check-untracked' in 'next'.
