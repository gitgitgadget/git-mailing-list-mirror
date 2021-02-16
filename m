Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74579C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F4264E7C
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhBPXEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:04:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53304 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBPXEe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 18:04:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3454C118DC6;
        Tue, 16 Feb 2021 18:03:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qQbz/V5RAgnqtSGy5m/0HnadneA=; b=FC52iP
        eLqSLQUKXozzjiqjnI8bHV9Q3nahQGYF7IBaI+8A1zfDxSabIrIVCS29nK6sFErO
        Ox/1Sgy+jYBiJ12c6fRjrn353cIKFNzEJ7XrVAULOF1fn0ADjoogtCSx3KUUm7Dk
        Ofh5jMVO0qhrGHq6dzeTjyi7ckQp0pIpsnDQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nXZzR8eAox7dEsmIyAz8ykITm4eN6xX0
        +jv/KKUr9ajOipJtE/S+KhjkUqif8Jzj2k+TAOCeh+ID8234kgZv7lIIq0AGpMUE
        RAt5H5RXhZNF0QPbyqjTRyLLYYoBw4MF+tPqX6sQ5CuHJM6ozh9PpvEOWRQ3BjCR
        8GhFrB7SXYE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CB92118DC5;
        Tue, 16 Feb 2021 18:03:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49DF3118DC4;
        Tue, 16 Feb 2021 18:03:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [OUTREACHY][PATCH v1] doc: fix naming of response-end-pkt
References: <5qGT6uzPLUGN2DXCMTzhixEhKHwaT6hODaOHQ485sfCROycrTDPx6P2Nd5dOy4J-gnhb_lKpxW4jJqhut-4gmoeIyuhpqbA5fXCeHoKHrK8=@protonmail.com>
Date:   Tue, 16 Feb 2021 15:03:46 -0800
In-Reply-To: <5qGT6uzPLUGN2DXCMTzhixEhKHwaT6hODaOHQ485sfCROycrTDPx6P2Nd5dOy4J-gnhb_lKpxW4jJqhut-4gmoeIyuhpqbA5fXCeHoKHrK8=@protonmail.com>
        (Joey Salazar's message of "Tue, 16 Feb 2021 21:21:50 +0000")
Message-ID: <xmqqlfbnobsd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A34932C-70AB-11EB-8B7D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Salazar <jgsal@protonmail.com> writes:

> Git Protocol version 2[1] defines 0002 as a Message Packet that indicates
> the end of a response for stateless connections.
>
> Change the naming of the 0002 Packet to 'Response end' to match the
> parsing introduced in Wireshark's MR !1922 for consistency.
>
> [1] kernel.org/pub/software/scm/git/docs/technical/protocol-v2.html
> [2] gitlab.com/wireshark/wireshark/-/merge_requests/1922
>
> Signed-off-by: Joey Salazar <jgsal@protonmail.com>
> ---
>  Documentation/technical/protocol-v2.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This came from b0df0c16 (stateless-connect: send response end
packet, 2020-05-19), didn't it?

The original commit even says "response end packet" on its title, so
I am reasonably sure the patch under discussion is an improvement ;-)

Having said that, asking its author to review the change would be
the most appropriate (cc'ed).

Thanks.

>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index e597b74da39..6c55d566d8b 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -33,8 +33,8 @@ In protocol v2 these special packets will have the following semantics:
>
>    * '0000' Flush Packet (flush-pkt) - indicates the end of a message
>    * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
> -  * '0002' Message Packet (response-end-pkt) - indicates the end of a response
> -    for stateless connections
> +  * '0002' Response end Packet (response_end-pkt) - indicates the end of a
> +    response for stateless connections
>
>  Initial Client Request
>  ----------------------
> --
> 2.29.0.rc2
