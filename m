Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB78C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F89860EE0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhIVT35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:29:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60850 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhIVT34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:29:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2356915A3A5;
        Wed, 22 Sep 2021 15:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pgCnL52Y3ATd15t67MFsXlqcRHJS6LlClLvj2L
        F5xNE=; b=xaDjg7aNWWthQRanUYCL/sh5kEXKUKqCc1bkBJzNSsIlG+3ZQ23eWz
        NceVkuKXw2vnDFLumg6CNEyRQdrN0IifvOcItMrjWS12IhJoJBQejtwgz6dmge8L
        CWtXW9dXg6v0rFmWEkBEBGlBIjrfGNVHEKGkl73M1KbHSgo1RRgQw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AAFB15A3A4;
        Wed, 22 Sep 2021 15:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FBB815A3A3;
        Wed, 22 Sep 2021 15:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        wolf@oriole.systems
Subject: Re: [PATCH] rev-parse: fix mismatch quoting of separator in the
 message
References: <20210922111744.675326-1-bagasdotme@gmail.com>
        <YUtqp+1Mwl2v0kuh@nand.local>
Date:   Wed, 22 Sep 2021 12:28:22 -0700
In-Reply-To: <YUtqp+1Mwl2v0kuh@nand.local> (Taylor Blau's message of "Wed, 22
        Sep 2021 13:40:55 -0400")
Message-ID: <xmqqzgs45s15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40736A2A-1BDB-11EC-8689-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Sep 22, 2021 at 06:17:45PM +0700, Bagas Sanjaya wrote:
>> There is a quoting mismatch quoting `--` separator in "no usage string
>> given...." message (`' instead of ``). Fix it.
>
> For what it's worth, I think that the `' style is typographic, since the
> pair look like English "smart quotes" (as opposed to straight quotes). I
> have no opinion about which is better, but I don't think the pre-image
> was necessarily a mistake.

I thought that we try to avoid "smart quotes" in our messages.

And we do not expect our users to be expecting to read their error
messages in markdown, so `--` is not a "Fix", either (do we have
many instances of such uses of backticks in messages already?).

Let's just stick to the true and tried pair of single quotes here.

Thanks.
