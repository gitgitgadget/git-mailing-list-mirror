Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7903CC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E15B610EA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJ1R5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:57:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65198 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhJ1R5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:57:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84F79F30B0;
        Thu, 28 Oct 2021 13:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bjiWSdGXvH4q
        RqGq1LIt9i+n7A+I58huAWDNYWamYfk=; b=K0p7oDdLSRthJOWomEiBbQAC5oQo
        wqJQtmq0RI3gMbV9RrAuaOzY5JQp8/KEG7q8yhZxOM9PWuL1ksLMqi2MVAPeb61D
        qOXeJx34KOAyWglCT/0v+Vv8fBYl8jQ0c03IYmH00bS3AAstwIpoplhPKOm+vSGc
        oNVhtrgGMx/Aw0o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A2AEF30AF;
        Thu, 28 Oct 2021 13:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CBE11F30AE;
        Thu, 28 Oct 2021 13:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 8/9] doc: git-http-push: describe the refs as pattern
 pairs
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
        <20900b019f835e9293fb5d70ae8dbdced3b781c0.1635438124.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 10:55:25 -0700
In-Reply-To: <20900b019f835e9293fb5d70ae8dbdced3b781c0.1635438124.git.gitgitgadget@gmail.com>
        (=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Thu,
 28 Oct 2021
        16:22:03 +0000")
Message-ID: <xmqq4k91rq42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3B65E374-3818-11EC-A8C5-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> -Each pattern pair consists of the source side (before the colon)
> -and the destination side (after the colon).  The ref to be
> -pushed is determined by finding a match that matches the source
> -side, and where it is pushed is determined by using the
> -destination side.
> +Each pattern pair '<src>:<dst>' consists of the source side (before
> +the colon) and the destination side (after the colon).  The ref to be
> +pushed is determined by finding a match that matches the source side,
> +and where it is pushed is determined by using the destination side.

Looks good.  It is unfortunate that this does not share the text
with description of refspec in "git push" documentation page, but
let's not worry about it too much.  I think we will probably start
talking about deprecating "git http-push".  Who still uses it and
why, I do not think of a good reason offhand.

Thanks.
