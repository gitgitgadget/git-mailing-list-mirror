Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F7BC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8310620725
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wy81VD9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgJ2UZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:25:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51558 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:25:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F9CE102FF0;
        Thu, 29 Oct 2020 16:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gTNSobmioiWyV88SXwPYaeRG2O4=; b=Wy81VD
        9lwU7vjXVUF4RRph4PqGV8ZEXKN2/n6+GX12lXYR5ZqpIGK7/N3TfUfzJP4HHsLH
        cfq2xw2TyZbH3rYlhOdsRjUoJPf8I1o/qqV8uZT09UxO8+hYQeUHAqEtaVwoDfek
        zPjwZIr13KPiC/psOo2ryN6DIHS5LAtR49YJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oLhoTzRXT2cJIFh5HMGFOUGfRCPbvEnc
        mmx/kELLoSLxopN7uZuUTVCI4g0CPPCugTEQiZo+UOmrtw6VLyNSMyMkkCBeT3T9
        DVKYYXFdq3Gvz5HrCvXtSh+mf5h8pI7Rc+3socGlqGCiw2D3iP+vmPKOtCNwurFT
        raTfXpTmIqo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 786FC102FEF;
        Thu, 29 Oct 2020 16:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC8D4102FEC;
        Thu, 29 Oct 2020 16:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/6] blame-options.txt: also mention 'funcname' in '-L'
 description
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <f7b64bf3302f934c44cf9364e4f008bb9ce26def.1603889270.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 13:25:37 -0700
In-Reply-To: <f7b64bf3302f934c44cf9364e4f008bb9ce26def.1603889270.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Wed, 28 Oct 2020
        12:47:47 +0000")
Message-ID: <xmqq5z6s7pa6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8862D24-1A24-11EB-A038-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Make it clearer that a function can be blamed by feeding `git blame`
> '-L :<funcname>' by mentioning it at the beginnning of the description
> of the '-L' option.

I think it makes tons of sense to mention both <start>,<end> range
and <funcname> range in the description.

It is not a new issue you are introducing with this change, but I
think the latter does not deserve to be treated as if it were an
afterthought by being a mere parenthetical mention.

>  -L <start>,<end>::
>  -L :<funcname>::
> -	Annotate only the given line range. May be specified multiple times.
> -	Overlapping ranges are allowed.
> +	Annotate only the line range given by '<start>,<end>'
> +	(or by the function name regex '<funcname>').
> +	May be specified multiple times. Overlapping ranges are allowed.
>  +
>  '<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans from
>  '<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
