Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA1D1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 01:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeKMLY7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:24:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62169 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:24:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 059DF1EA89;
        Mon, 12 Nov 2018 20:29:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oYibYkfuR49U
        nNGOZF7Bk6VPT0g=; b=qJCqBj3+rWvDy5z6jd0fDpVIgX3qapPmysyqBaZX15/C
        T1ihQ9r339jvIMxGxqOBMNdiwwD7SSOXk6Mm3td3mg9DC2VeKrx7TLFkKos8AXxl
        GbEIShZNGpqiSHgTZ0ogZ08dXEr/WpDnVZBBk7NGlB4zda4AP8sFrC2pVbV41Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KrOo8h
        WGk4old0E3+pvYY3cUxzw2BudVwtGqNsETa1VnK/DC0eHYCSHb8g1h5COPMzoulB
        PvpbmNuUYOBdPIzRKPHC7EMVXTu/L99q9jFvjV1hkO9gZCHxEwW0tY+UNRY1Y/zp
        XkVWnH9sm5ggaUv7Got/Yk70GFiPRSuZqkVHQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F313F1EA88;
        Mon, 12 Nov 2018 20:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 10A9D1EA87;
        Mon, 12 Nov 2018 20:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johan Herland <johan@herland.net>
Cc:     carenas@gmail.com, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/notes: remove unnecessary free
References: <20181111094933.27325-1-carenas@gmail.com>
        <CALKQrgdCNxXSOG-KRUeNaw2q=hOGh9+-zM5ATHwmDEmOC7UAcw@mail.gmail.com>
Date:   Tue, 13 Nov 2018 10:29:07 +0900
In-Reply-To: <CALKQrgdCNxXSOG-KRUeNaw2q=hOGh9+-zM5ATHwmDEmOC7UAcw@mail.gmail.com>
        (Johan Herland's message of "Sun, 11 Nov 2018 11:41:02 +0100")
Message-ID: <xmqqh8glzrx8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8529093E-E6E3-11E8-8EC9-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> On Sun, Nov 11, 2018 at 10:49 AM Carlo Marcelo Arenas Bel=C3=B3n
> <carenas@gmail.com> wrote:
>>
>> 511726e4b1 ("builtin/notes: fix premature failure when trying to add
>> the empty blob", 2014-11-09) removed the check for !len but left a
>> call to free the buffer that will be otherwise NULL

Wow, that's a old one.

>>
>> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> Signed-off-by: Johan Herland <johan@herland.net>

Thanks, both.  Will apply.

