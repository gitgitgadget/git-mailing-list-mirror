Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07542021E
	for <e@80x24.org>; Sun,  6 Nov 2016 17:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbcKFRQ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 12:16:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55238 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750927AbcKFRQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 12:16:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D04744A70D;
        Sun,  6 Nov 2016 12:16:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cYWuvz2Lc+5DnntIFPQFQYUvdzA=; b=e4ZvGp
        FDmDDJElrc7yNVVcOIZ4y9SzZzeN4TOBd0vtwPaJZ4Zu9uLqOjriRzoIzPVDDsTe
        5vwyE8mgtjAQEMW3bUFaTHBWLVV2/eZqXIlmXBZfdeOSVvpj1KYCmhUGvF959yF/
        KzVS6XTZZ3HT6EYXuNR7b3e6DJ6YL6s6vqRkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WBBiggcqUXkUr1mgt2BJ5YVQ/SV7uVVe
        X3qbNqY6rrfAukDhkfIzpaNW5PeVic1IEY7L1luf+wQqyGhh54/lloJp3u4eH8UC
        AIjs6tu77JISwgp9ZyHaeHGdCnQrPEHgHRMVF4k2TQ0QezNL2CLLFSJ0YExuK0y0
        sJCW765X4ek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6E7E4A70C;
        Sun,  6 Nov 2016 12:16:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E0A64A70B;
        Sun,  6 Nov 2016 12:16:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-13-chriscool@tuxfamily.org>
        <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
Date:   Sun, 06 Nov 2016 09:16:53 -0800
In-Reply-To: <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
        (Christian Couder's message of "Sat, 5 Nov 2016 01:45:04 +0100")
Message-ID: <xmqqoa1scyuy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0733A06-A444-11E6-9EDE-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I think it is easier for user to be able to just set core.splitIndex
> to true to enable split-index.

You can have that exact benefit by making core.splitIndex to
bool-or-more.  If your default is 20%, take 'true' as if the user
specified 20% and take 'false' as if the user specified 100% (or is
it 0%?  I do not care about the details but you get the point).

