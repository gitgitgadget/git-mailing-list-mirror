Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC4AC47099
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02291613BC
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhFAWvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 18:51:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58213 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhFAWvA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 18:51:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FA8EC7E26;
        Tue,  1 Jun 2021 18:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vLK5HmY+a2REzhlPf70tb+yzunOccwJ8QvfzqB
        AnIGc=; b=KpOz2vmXumCIx4vmEz9nW5viuE1bhJ3w2Vy4Zg+JTpUzaM14kTprwX
        cozUeNDH6x4+CbbgL5sYvycyD0h2MkhUuCeHEVL9MiKlW8ddUrm2M4Hw1iTsBBXA
        s+xNeuWHCAQCQjmxdiWvUS9o91Eo8FNDnc96KeD0tC8QGQkg+JBog=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 981BDC7E25;
        Tue,  1 Jun 2021 18:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2508CC7E24;
        Tue,  1 Jun 2021 18:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
        <xmqqzgw9qky5.fsf@gitster.g>
Date:   Wed, 02 Jun 2021 07:49:16 +0900
In-Reply-To: <xmqqzgw9qky5.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        02 Jun 2021 07:28:02 +0900")
Message-ID: <xmqqv96xqjyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9854FBF4-C32B-11EB-A348-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>> +1 for merge.conflictstyle = diff3, rerere.enabled = true, and
>> log.decorate = short from me. I noticed others already mentioned
>> these.
>
> As the inventor of rerere, I agree on rerere.enabled.  It was made
> opt-in only because I thought it was somewhat risky when the feature
> was introduced, but it has been stable and useful, and it is long
> overdue to be enabled by default.

Just to make sure, rerere.enabled is fine, but as I am not
comfortable to recommend rerere.autoupdate to any human users, I
would be opposed to turning it on by default.  Giving people a
choice is fine, but the default should be a safe one that offers
users a chance of final sanity checking before proceeding.
