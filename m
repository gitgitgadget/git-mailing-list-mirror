Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81611F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfFJR55 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:57:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53600 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388592AbfFJR54 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:57:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4D6286C69;
        Mon, 10 Jun 2019 13:57:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i0Z7nXEsiAP+
        2IHzKPyT5LvWw+c=; b=yiaX4XTaaj73w1wW6EF4Pv4DvWnGRbZSIXXdgAvtHaqc
        Sofpif/8/P19p3uwNSnkxzeLjSEXEX/9kZQTi3iSTRA6CPuGFOzAP9VuZJW1TovO
        18a3GcAe1Q4g4AUAIkdh/lUIvr1Et2Os/nO9QlE+mK+HooxJiAyTa3Y1xUW4TjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KAHqp5
        iuXfpoRLeB1E/ICYDMurMKALVZC7BrCi5NffWjZDXIL503p7x8RVS6rqQQn/DKz6
        91eBEn2vvpQUu7Gp6MZoE4WYy3VK82vRX0n1W+Y98VR84sRCycrq1qM0RWc44v5N
        y29Pot5Qv3AMAFqt9Kvea3LMfCIE1YtU7G6L8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD27586C68;
        Mon, 10 Jun 2019 13:57:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3E0086C67;
        Mon, 10 Jun 2019 13:57:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC/PATCH v2] doc branch: provide examples for listing remote tracking branches
References: <2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
        <20190528231605.10108-1-philipoakley@iee.org>
Date:   Mon, 10 Jun 2019 10:57:48 -0700
In-Reply-To: <20190528231605.10108-1-philipoakley@iee.org> (Philip Oakley's
        message of "Wed, 29 May 2019 00:16:05 +0100")
Message-ID: <xmqqtvcxmig3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4368DDEC-8BA9-11E9-ABEC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> The availability of these pattern selections is not obvious from
> the man pages, as per mail thread <87lfz3vcbt.fsf@evledraar.gmail.com>.
>
> Provide examples.
>
> Re-order the `git branch` synopsis to emphasise the `--list <pattern>`
> pairing. Also expand and reposition the `all/remotes` options.
>
> Split the over-long description into three parts so that the <pattern>
> description can be seen.
>
> Clarify that the `all/remotes` options require the --list if patterns
> are to be used.
>
> Add examples of listing remote tracking branches that match a pattern,
> including `git for-each-ref` which has more options.
>
> Improve the -a/-r warning message. The message confused this author
> as the combined -a and -r options had not been given, though a pattern
> had. Specifically guide the user that maybe they needed the --list
> option to enable a remote branch pattern selection.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> in response to=20
> <2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
> thread: https://public-inbox.org/git/?q=3D%3CCACsJy8CwY8gzeWa9kNRX3ecez=
1JGiQiaOknbAoU7S%2BhiXBoUGQ%40mail.gmail.com%3E
>
> to: Git Mailing List <git@vger.kernel.org>
> cc: Duy Nguyen <pclouds@gmail.com>
> cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> cc: Junio C Hamano <gitster@pobox.com>

This looks reasonable to me---is it ready to go even with its RFC prefix?
