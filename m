Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02E0C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EF2611EE
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhEaEMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 00:12:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64396 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhEaEMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 00:12:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBC7713948C;
        Mon, 31 May 2021 00:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5IRuP1n3l6GUZihSDkrm3EM/EY5ibdLBnYgEddnGH0U=; b=JX8W
        94iz/WhazQJjrQkoYFk+VAFjY106kdARYQxUlgijaB/WprFrMoJGNBCmu9Oo8JzR
        vEThLNofbTACx0NJ37hgla1cACsuzedQzDLe9hV6xXx40Y3Hq1SdRCELgokM5OuS
        Ev7MkgcG3Kjck2XDvzIFr6xKUREwgY0+hpq4adQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D492313948B;
        Mon, 31 May 2021 00:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05A9013948A;
        Mon, 31 May 2021 00:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
        <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 13:10:26 +0900
Message-ID: <xmqqo8cry24t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21D7F28A-C1C6-11EB-BACC-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -530,6 +545,7 @@ static struct {
>  	{ "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
>  	{ "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
>  	{ "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
> +	{ "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
>  	{ "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
>  	{ "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
>  	{ "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },

Doesn't this conflict with your own zh/ref-filter-atom-type topic?
Shouldn't one build on top of the other?

Or did we find something fundamentally broken about the other topic
to make us retract it that I do not remember?

Thanks.
