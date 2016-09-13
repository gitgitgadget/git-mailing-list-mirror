Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C8220984
	for <e@80x24.org>; Tue, 13 Sep 2016 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754771AbcIMUc6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 16:32:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754636AbcIMUc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 16:32:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 889A73D547;
        Tue, 13 Sep 2016 16:32:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5PjVwkXdqmqeRXF1ePS2VdBxjv0=; b=sJKBlT
        cbQqC1JO2b7YHqo96HPnT4fjPo9Ug/6t7G/iZ7Mirm8ulYVAhELFGi1CO5NZZ/BW
        HnVJXo8Nrc0dFGcDXzXgoOdrtM7jPI2ksJ5Bck2byD9lEAIAMLAOVEGxkY4agiXg
        84IwX1MwXr1fCSTJ0y5KYMfnHr27V7eT5USKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l8+BV5KbyAyATaC5Qj6yIPbZRxI8O/zl
        FutkoAoE9Qz0pwJkc4UmpM1HT8y71huQHyEPXcoGTvz15nRT5fGwRvFWDHEx6tQn
        /WC6Vg0ytstu6tDdy5mX98VeK7NVePtGhqKSqICXj1heL3+CtpYyZpo5SgZlvge/
        IaV2w1i3pHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F3E23D546;
        Tue, 13 Sep 2016 16:32:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F40613D545;
        Tue, 13 Sep 2016 16:32:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [RFC 0/3] http: avoid repeatedly adding curl easy to curlm
References: <20160913002557.10671-1-e@80x24.org>
Date:   Tue, 13 Sep 2016 13:32:50 -0700
In-Reply-To: <20160913002557.10671-1-e@80x24.org> (Eric Wong's message of
        "Tue, 13 Sep 2016 00:25:54 +0000")
Message-ID: <xmqqr38nv8ul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E4491AC-79F1-11E6-80CA-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> The key patch here is 3/3 which seems like an obvious fix to
> adding the problem of adding a curl easy handle to a curl multi
> handle repeatedly.

Yeah, sounds like the right thing to do and 2/3 makes it really easy
to read the resulting code.

> I will investigate those failures in a week or two when I regain
> regular computer access.

Thanks. Will tentatively queue on 'pu' and wait for updates.

