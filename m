Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E331F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbcH3RVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:21:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58944 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932463AbcH3RVt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:21:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDEE738D4A;
        Tue, 30 Aug 2016 13:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yqs1oT9XI5UImG0PRbre/Dt/oZ8=; b=DjnN3W
        ZzPlF2C0NBUTAPjjPyB+0FY1r5bTC0oA7SExkl5HSyTgpq4zo9nFAe5ZbROyVo6i
        dW5JaKQDHIkxN0VQ5gh/JUQZ/cP32ZWD/KVZNZznP1jQjuKrKEXFJCNcbmgobbHS
        8qMM6SIwjU7TdvrTAIwg0L7bt+4DXyLcxvShc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LIkbJu3Z4UztOGE7ymPVeRV7+MHS6Ttn
        gLMRDy6tDqxrMzpi0n8bJDdcEQF9310y1aeKX13edqgTTGbD5nNUC3NRH/3hCwTV
        2KLdfDB1d8lXotSXWg8o5Lew6wjB03TIAyxfE7Zi6kn2nELcdf/xZ0oYdwPD3waw
        uLsejocYD/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D64DD38D49;
        Tue, 30 Aug 2016 13:21:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C77C38D3F;
        Tue, 30 Aug 2016 13:21:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/14] sequencer: lib'ify read_populate_opts()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <0fde7522953f71bd07e6aa7a15081dbf069aa6b6.1472219214.git.johannes.schindelin@gmx.de>
        <xmqq37ln9ubo.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608301116450.129229@virtualbox>
Date:   Tue, 30 Aug 2016 10:21:45 -0700
In-Reply-To: <alpine.DEB.2.20.1608301116450.129229@virtualbox> (Johannes
        Schindelin's message of "Tue, 30 Aug 2016 11:17:38 +0200 (CEST)")
Message-ID: <xmqqk2ey5g0m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B09675E-6ED6-11E6-8507-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I still think that it is a serious mistake for library functions to die().
> But I have no time to take care of git_parse_source() right now.

I think we already agreed on both points during the previous round
of review ;-)
