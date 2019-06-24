Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E761F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfFXRWh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:22:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50777 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfFXRWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:22:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1451C65599;
        Mon, 24 Jun 2019 13:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P66H8kVb4GER4EaotpHuzhnW4kc=; b=VHkPKc
        FGraTPLrK4350RjUA7//CAcdycW73jmz4r4YcZuxkSmkCe8uiKLLpOoEyFXxC+it
        iN86TjHUkjSDwbUXngyiL1xEAAejMBFcKtskrTysrkfYeEX8oYHu8OlAdpXzHoXR
        yl4RDRCBVNUAlAa/jIjtq6GQFpyh3yfIJEMrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JMKl8PQkHETJwej9f/ZV+S/p9sG+mrj8
        QgbGsW550PYMhQfGKIlaOtE691QUxTqfpGPFyFfyDKIN3XVlDcT2xQZsEOgD+pbT
        RgkOBgXi+n3CkP8wMwFeY3OireOiRPQxjNRCBSlLra7fpme3jRmJi0UrstExkWdr
        3YSwqubWzBU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CA6C65597;
        Mon, 24 Jun 2019 13:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3070965594;
        Mon, 24 Jun 2019 13:22:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 13/14] completion: add default options
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <20190621223107.8022-14-felipe.contreras@gmail.com>
        <CACsJy8AATA-7Z+HsA80NQ2j4Z9JeuSYXiBZLi=7FopzfLY1R+w@mail.gmail.com>
Date:   Mon, 24 Jun 2019 10:22:30 -0700
In-Reply-To: <CACsJy8AATA-7Z+HsA80NQ2j4Z9JeuSYXiBZLi=7FopzfLY1R+w@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 22 Jun 2019 10:01:36 +0700")
Message-ID: <xmqqa7e6j3u1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A66787DA-96A4-11E9-8B93-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jun 22, 2019 at 5:31 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> Versions of Git older than v2.17 don't know about
>> --git-completion-helper, so provide some defaults for them.
> ...
>> +__gitcomp_builtin_add_default=" --dry-run --verbose --interactive --patch --edit --force --update --renormalize --intent-to-add --all --ignore-
> removal --refresh --ignore-errors --ignore-missing --chmod=
> --no-dry-run -- --no-verbose --no-interactive --no-patch --no-edit
> --no-force --no-update --no-renormalize --no-intent-to-add --no-all
> --no-ignore-removal --no-refresh --no-ignore-errors
> --no-ignore-missing --no-chmod"
>
> And who's going to keep these uptodate? If you do this, might as well
> delete --git-completion-helper
>
> A more acceptable option might be regenerate git-completion.bash and
> run --git-completion-helper to generate these, or make
> git-completion.bash source a generated file.

Nicely analysed and summarized.  What kind of target audience are we
talking about?  What's the payoff vs cost comparison trying to
catering to those who install more recent completion script that
requires the --git-completion-helper option without using antient
Git?

If the cutoff boundary is 2.17, that is more than year ago, and the
boundary gets further and further in the past as time goes by. Also,
depending on how old the version of Git the target user runs, these
hardcoded and manually listed options may not yet even exist in
their binary.
