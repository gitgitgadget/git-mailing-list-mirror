Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB21C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B89D6135A
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhETWyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 18:54:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62978 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhETWyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 18:54:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE560D998F;
        Thu, 20 May 2021 18:53:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QnwBY1ZewbSP
        maR2PHPFrQ0xXUlWwKzsozK2RcC5MQM=; b=tKk1l2eXLZPJha8yDQMuF3DYST7K
        OlMznIM6TMdWgRl0O+rkNR2hySh85At+5upZVXqeP6jfe4ZEmW/mD+uSPTE1RcQt
        t5udzyVFlkb+DOCdLaVv0YnEmc60kYSLT0oHeuypjl1Oh4cns7WBR8YebP9Qc237
        YPVdKQip2HBW/8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBE59D998E;
        Thu, 20 May 2021 18:53:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32E4BD998D;
        Thu, 20 May 2021 18:53:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] help: fix small typo in error message
References: <20210520074214.40903-1-jn.avila@free.fr>
Date:   Fri, 21 May 2021 07:53:07 +0900
In-Reply-To: <20210520074214.40903-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Thu, 20 May 2021 09:42:14 +0200")
Message-ID: <xmqqbl95t3u4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25207EC2-B9BE-11EB-A256-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Classic string concatenation while forgetting a space character.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  list-objects-filter-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  This is a new message added in this round, so let's
fast-track this fix down.



> diff --git a/list-objects-filter-options.c b/list-objects-filter-option=
s.c
> index 96a605c8ad..fd8d59f653 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -102,7 +102,7 @@ static int gently_parse_list_objects_filter(
>  	} else if (skip_prefix(arg, "object:type=3D", &v0)) {
>  		int type =3D type_from_string_gently(v0, strlen(v0), 1);
>  		if (type < 0) {
> -			strbuf_addf(errbuf, _("'%s' for 'object:type=3D<type>' is"
> +			strbuf_addf(errbuf, _("'%s' for 'object:type=3D<type>' is "
>  					      "not a valid object type"), v0);
>  			return 1;
>  		}
