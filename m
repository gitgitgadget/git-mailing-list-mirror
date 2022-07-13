Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3514C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 19:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGMTwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGMTwa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 15:52:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E382610D
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 12:52:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EFE813C5A7;
        Wed, 13 Jul 2022 15:52:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tmZkBNLfUIwx
        3akiqkQcBRuLqlUozGxbtpNAp9nq75c=; b=yGEahZBIUf6eIuwxSjBta4dolfQS
        Qcn1pet33O33t+AUzg21qKAxnWh/i4D/UL8mMtWLTutH28577kv+tRDUPo+kAbiJ
        Jnl/b5/zUgJOxQmXiC6b3NTKlvgB539gZj891ikazrui6s7Fe43VeSlbYyzv214a
        8eAAyCnEQa7IDKo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0390913C5A6;
        Wed, 13 Jul 2022 15:52:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E7FD13C5A3;
        Wed, 13 Jul 2022 15:52:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Manuel Boni via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Manuel Boni <ziosombrero@gmail.com>
Subject: Re: [PATCH] config.txt: add completion for include, includeIf
References: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 12:52:27 -0700
In-Reply-To: <pull.1285.git.1657738937049.gitgitgadget@gmail.com> (Manuel Boni
        via GitGitGadget's message of "Wed, 13 Jul 2022 19:02:16 +0000")
Message-ID: <xmqqv8s0bxj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 532EA3B8-02E5-11ED-B42C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Manuel Boni via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Manuel Boni <ziosombrero@gmail.com>
>
> Git config's tab completion does not yet know about the "include"
> and "includeIf" sections, nor the related "path" variable.
>
> Add tab completion support for the aforementioned items,
> along with two new tests, based on the existing ones,
> specifically for this completion. Variable completion only works
> for "include" for now.

You may have started this work for tab completion, but I think you
should describe it as adding missing documentation (this comment
extends to the title of the patch, too).  The work to teach "tab
completion" about the variables "git config" can take has done long
time ago, and the work by this patch to add description for
<include> and <includeIf> is used as an input to that previous work,
which results in "git config inc<TAB>" to be command line completed.

> Credit for the ideas behind this patch goes to
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
>
> Signed-off-by: Manuel Boni <ziosombrero@gmail.com>
> Based-on-patch-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>

The order of these two is backwards, no?  =C3=86var may have written
something that inspire you to arrive at this version, which you
signed off before sending it out.

> +include.path::
> +
> +includeIf.<condition>.path::

Losing the extra blank line will make it clearer, if your intention
is that the next lines apply to both of the above two.

> +	Special variables to include other configuration files. See
> +	the "CONFIGURATION FILE" section in the main
> +	linkgit:git-config[1] documentation.

Thanks.
