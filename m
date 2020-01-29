Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F8AC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CB220720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/H1h7Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgA2FVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:21:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64725 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgA2FVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 00:21:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0735CB3D88;
        Wed, 29 Jan 2020 00:21:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w8PZOBe1jTQXp2f9ltRX+Rs22O8=; b=R/H1h7
        RurYJs3YtztQOZtQ5uB0VUOB+TAGgoA85pp9QL9QcDqchxAOu0rqu82af3OzOco3
        HzFJ7I+HxAnj+3tYQzJOh6Gbzp5E2L68zovsRIScoNAJU8r/pBIclNGUFJBh6Oc/
        DVVWXB8r/Ov2SGTwUFV61kpSUkzGk/0KnVUKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iV3gacJiF8L+0+O3y4B6hLEMSymFMqg7
        LU16aXFiXccUbqANPxj+5NZjPnBco4zkHfbH85aVAOgOMIi+aMtC355KqiEozcZy
        In+3DtZw93Ker+gW0lW3DzLN+ZRjN+x9Vsrkd1lwuOSjBeHXwWbtd8agwyk/JIcX
        D2wBIvBiwL8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F40C0B3D87;
        Wed, 29 Jan 2020 00:21:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30C72B3D86;
        Wed, 29 Jan 2020 00:21:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
References: <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
        <xmqqr1zj6xl6.fsf@gitster-ct.c.googlers.com>
        <20200129024124.GC596379@coredump.intra.peff.net>
Date:   Tue, 28 Jan 2020 21:21:32 -0800
In-Reply-To: <20200129024124.GC596379@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jan 2020 21:41:24 -0500")
Message-ID: <xmqq7e1a7s83.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37185BF2-4257-11EA-8F74-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Though I'd still slightly worry that somebody might not consider
> configured refspecs. Saying more clearly "any refspec no matter where it
> comes from" might still be worthwhile. I.e., something like:
>
>   Defines the action `git push` should take if no refspec is given
>   (whether from the command-line, config, or elsewhere).

That's 100x better than to say "explicit" "implicit" etc. and then
have readers guess what the adjectives mean or explain what they
mean in (parentheses).

