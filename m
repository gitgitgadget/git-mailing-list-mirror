Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CAC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D6D20715
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vgBKpA+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgERShY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:37:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52758 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgERShY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:37:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFAFB63149;
        Mon, 18 May 2020 14:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vm+wVR6cxLLDxndFk4AHo2RPpbs=; b=vgBKpA
        +oWT0JP7ZfnTl6NeMH9bgOVXVBSIdaehD90gIf19zDhynGdOOKerpuTHokBG0PPu
        /c2mlm6ts4f/CRh4TwyoQW0ztjRL8gBGMJeI1TUFIqevja6m/kOzXeJRTVCd4B50
        bMCenDTIAGo+d4R4DplPXSHXPFauXWoTyCyKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=In9g731YncfWQTAWoM9hLe9zXtSZDJGn
        lZBTKOo57G9oNb31eWwmeEId09MTFO0Kg0lYTpSA+8JxtGOIcNXEBzBeIwQW8S5m
        qPI4P7To/KeFU3GoFDtPpfgYrKrY/T+7Bfm2UUEBlTuQr/Dbmd1/YUeaKxfWdifd
        BtI5qhMEv38=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A767763148;
        Mon, 18 May 2020 14:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E68F63145;
        Mon, 18 May 2020 14:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/7] remote-curl: remove label indentation
References: <cover.1589393036.git.liu.denton@gmail.com>
        <cover.1589816718.git.liu.denton@gmail.com>
        <a2b28c0b28bb972f164ff0a9e48ae6b623a2a125.1589816719.git.liu.denton@gmail.com>
Date:   Mon, 18 May 2020 11:37:20 -0700
In-Reply-To: <a2b28c0b28bb972f164ff0a9e48ae6b623a2a125.1589816719.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 18 May 2020 11:47:19 -0400")
Message-ID: <xmqqtv0d2iov.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BF5F18E-9936-11EA-B9E8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In the codebase, labels are aligned to the leftmost column. Remove the
> space-indentation from `free_specs:` to conform to this.

Even though there are 50+ remaining labels that tells us otherwise,
we have 300+ labels that support the position.

;-)

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  remote-curl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 6844708f38..da3e07184a 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1276,7 +1276,7 @@ static void parse_push(struct strbuf *buf)
>  	if (ret)
>  		exit(128); /* error already reported */
>  
> - free_specs:
> +free_specs:
>  	argv_array_clear(&specs);
>  }
