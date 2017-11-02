Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6932202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 01:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbdKBBYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 21:24:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65455 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752416AbdKBBYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 21:24:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45635AA7C5;
        Wed,  1 Nov 2017 21:24:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=so8kn8ME6/d5
        fuh6sHZl1gynndg=; b=WKglG/hbryurmn7bk2zexRwPU8Uc7DwW+k52s39v6qgR
        QKQ8rFYARLsE14N9N+ZSvVKNajUqzoJP3K+CweJYtnyCTqLU8BHjeX1XU5daZs0/
        Qgm8RIkh/rr+qEOTV8NJuSzwmZS4KkvvU2t3kGabk7OwxzXki7i0kTLS/rOyzpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h3WTlr
        GjOLyCqrVgv1hKTIV856xi+l04D/0v4i7TxJnv3JgWBL9vHwxHBqIHvb6oCnKn78
        EQkWKvLXzfL63RSzWzW5jz8UHNlLaEUf2eYG3iSmk/M4jvOKgO8sopA6j2TAwVkv
        a+7hJ1TpC0IFU9jRyPtXbsVK25YtrGBtlqXuU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CD5DAA7C4;
        Wed,  1 Nov 2017 21:24:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2744AA7C3;
        Wed,  1 Nov 2017 21:24:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/7] remote-mediawiki: skip virtual namespaces
References: <20171029160857.29460-2-anarcat@debian.org>
        <20171030025142.19421-1-anarcat@debian.org>
        <20171030025142.19421-5-anarcat@debian.org>
        <CAPig+cSRrXj9BdgM6Q2OdBZtYJOVOnfo4BaG30C-_ug3QunPfQ@mail.gmail.com>
        <87wp3a54nj.fsf@curie.anarc.at>
Date:   Thu, 02 Nov 2017 10:24:40 +0900
In-Reply-To: <87wp3a54nj.fsf@curie.anarc.at> ("Antoine =?utf-8?Q?Beaupr?=
 =?utf-8?Q?=C3=A9=22's?= message of
        "Wed, 01 Nov 2017 12:45:36 -0400")
Message-ID: <xmqqvaitsc9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 99DBFFF2-BF6C-11E7-A39B-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 <anarcat@debian.org> writes:

> It might still worth fixing this, but I'm not sure what the process is
> here - in the latest "what's cooking" Junio said this patchset would be
> merged in "next". Should I reroll the patchset to fix this or not?

The process is for you (the contributor of the topic) to yell at me,
"don't merge it yet, there still are updates to come".

That message _may_ come to late, in which case we may have to go
incremental, but I usually try to leave at least a few days between
the time I mark a topic as "will merge" and the time I actually do
the merge, for this exact reason.

Thanks.
