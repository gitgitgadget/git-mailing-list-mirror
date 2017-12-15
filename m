Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2FE1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 18:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755970AbdLOSMh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 13:12:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62295 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755554AbdLOSMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 13:12:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BED24B4430;
        Fri, 15 Dec 2017 13:12:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EJqBZEmxljfpna7pk6iJP9yOhz4=; b=DrmrWC
        T9iQwINgUUVC5eNXMiG/nEdBmUH4rNyiEI88gEbIYzgZzG+QyEKk1l/u/rNoXjm+
        k+Kj4jjR+axIG0l8A8mVOztKlh98oBD72onTzQef9llcdCO22h/GXAcynW9C1Ai4
        FNJmYqEdhQPweU5fXNNqfGiyl5BXsEnFXIQLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=je2y09qP0kMrPHM4pF/+CuSkfLAExdz0
        iNF0oSl/1KB4LMFx0ZEUrDdU1cHOm1M4UNGmLuH6OLVunsUAIQ/oxwyNwYcV7kz6
        vlqwxAN7siMDEt6U1LIjJhR/rgZz/qBo5pi2ibQdtmknmRg760NQ4Jiw9A7YO4E3
        LkIp3bWvOo8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B47F0B442E;
        Fri, 15 Dec 2017 13:12:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A2CCB442C;
        Fri, 15 Dec 2017 13:12:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] Offer more information in `git version --build-options`'s output
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
        <cover.1513294410.git.johannes.schindelin@gmx.de>
        <xmqqind7rik1.fsf@gitster.mtv.corp.google.com>
        <CAPig+cRymagTe20ZJS4Z0DyPy0_OuE7zEuP1wiEk0rWhDdk6nw@mail.gmail.com>
Date:   Fri, 15 Dec 2017 10:12:32 -0800
In-Reply-To: <CAPig+cRymagTe20ZJS4Z0DyPy0_OuE7zEuP1wiEk0rWhDdk6nw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 15 Dec 2017 13:03:05 -0500")
Message-ID: <xmqqefnvrhbj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 860C25BE-E1C3-11E7-B213-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Dec 15, 2017 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>       no commit associated with this build
>>
>> I find this output somewhat klunky for machine parsing (and it is
>> inconsistent with the style used for "sizeof-long", which hints that
>> these are "<token> <colon> <value>" lines where whitespaces are
>> avoided in a <token>), but hopefully this is primarily for human
>> consumption and scrypts that are trying to find a specific piece of
>> information would know how to use 'grep', so the inconsistency does
>> not make much of a difference in practice anyway.
>
> Simply omitting that line from the output of --build-options would
> also be an option if the commit can not be determined...

What we see in Dscho's patch is better than that option, though.  At
least, explicitly checking for "no commit associated" would tell you
if the version of Git is too old to have "built from commit:" line
or it is new enough but was built from a tarball.
