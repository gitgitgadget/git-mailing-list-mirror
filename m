Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB09C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 00:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiFCAhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 20:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFCAhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 20:37:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844661009
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 17:37:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF666126C3C;
        Thu,  2 Jun 2022 20:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=r7OmKlUUgOlzw+SficfMIUVCa
        Uw+Gh6eEO8AqcPNyRk=; b=ggLihFE8bYsZzcNbs1p2aXP7OyRSB1GkrC8boRQh0
        YAYgSyVPOGgzMvGmPyx7EmYl0hSlFAGWaESz+1nWwZYLNK+ewbkOVIm1W3lFeIPZ
        d2vMuS5O0uXFDFCkhZnO6fUzOYZyoxDTrUl5p1tNUe/3cVbkWRih3gFS5Y+Sa5HY
        bY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D96126C3B;
        Thu,  2 Jun 2022 20:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1797126C37;
        Thu,  2 Jun 2022 20:37:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] run-command API: rename "env_array" to "env"
References: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20220602T090745Z-avarab@gmail.com>
        <patch-v3-1.2-80ef05d5b0a-20220602T090745Z-avarab@gmail.com>
Date:   Thu, 02 Jun 2022 17:37:25 -0700
Message-ID: <xmqqczfqinui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57C4BD16-E2D5-11EC-AA48-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The rest of this is all a result of applying [1]:
>
>  * make contrib/coccinelle/run_command.cocci.patch
>  * patch -p1 <contrib/coccinelle/run_command.cocci.patch
>  * git add -u
>
> 1. cat contrib/coccinelle/run_command.pending.cocci
>    @@
>    struct child_process E;
>    @@
>    - E.env_array
>    + E.env
>
>    @@
>    struct child_process *E;
>    @@
>    - E->env_array
>    + E->env

It makes sense to have this in the log message for documentation
purposes.  We have plenty of examples of renaming a symbol to
another, like the simple ones in object_id.cocci, so adding this to
the collection in contrib/coccinelle would not add much value.

Will replace.  Thanks.
