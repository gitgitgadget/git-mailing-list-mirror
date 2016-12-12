Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B71203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbcLLXrc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 18:47:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50067 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751932AbcLLXrc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 18:47:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C479A57D88;
        Mon, 12 Dec 2016 18:47:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FCVZJsbymjqS82wyP+BT9a9XQxc=; b=FHC0vD
        J1+ZEDRANxDV4p5rXBjFkwHZmJ3QFQqoL/aFolRaVow6SAk3Flh2h1VyX8PekVt3
        J69eQYBqayzpz5XeImsd9SZVmd99Ylv6gK93RAMWKf/94fNJWyYn/reep/DBghsF
        uNndRQTSFpKIJQ9f+AFHXTrWThk/pIXjxVre8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nZrHdRbIVJSc8HG5FaZ7hfaIpSf8AlY7
        4412544LHrm4qGcd8KLbC0zxAT+5kCOfegyyzfDsUZpudv4PE66gImQpwqAeSIPq
        +YTFm4K88aNOkjOS6aAhCIDZzKIW6YhoxOwfiLTWWBH4jNJQ8XsbB9gZnHt56apv
        StRvhaqxF20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBBE357D87;
        Mon, 12 Dec 2016 18:47:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B90E57D86;
        Mon, 12 Dec 2016 18:47:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com
Subject: Re: [PATCH v3 4/4] real_path: have callers use real_pathdup and strbuf_realpath
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <1481566615-75299-5-git-send-email-bmwill@google.com>
        <xmqqzik07pin.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 12 Dec 2016 15:47:29 -0800
In-Reply-To: <xmqqzik07pin.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 12 Dec 2016 14:26:24 -0800")
Message-ID: <xmqqfuls7lri.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58428508-C0C5-11E6-A9F4-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Williams <bmwill@google.com> writes:
>
>> Migrate callers of real_path() who duplicate the retern value to use
>> real_pathdup or strbuf_realpath.
>
> Looks good.

This has small non-textual conflicts with Stefan's embed^Wabsorption
topic; please holler if you spot my mismerge.  Thanks.

