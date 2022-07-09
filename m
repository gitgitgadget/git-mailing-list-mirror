Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC5C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 21:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGIVeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 17:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIVeg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 17:34:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83864EE14
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 14:34:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F149518F582;
        Sat,  9 Jul 2022 17:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IzaMN7ktwzMKnE+mRQVh63iEajdAHOwmzBCQiL
        8n7nM=; b=VYTPa+0Q/k2fliJyeVrmxEHF7fdV1GwFMKdPcw4zL7YsIa6sHXlf5l
        jsSSzShSUiNMN+FlvJqnJx/L/fxyAze9NbiHzeF84jlwpPdbY6xzsMXRM4ufU78P
        5ikwlv2rsZoWR1G/51Dd1R+O2MSM5Hy/eBoo74X/DJc23qnjPZVfE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA53418F581;
        Sat,  9 Jul 2022 17:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C69318F57F;
        Sat,  9 Jul 2022 17:34:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 0/4] Add some Glossary terms, and extra renormalize
 information.
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 14:34:30 -0700
In-Reply-To: <pull.1282.git.1657385781.gitgitgadget@gmail.com> (Philip Oakley
        via GitGitGadget's message of "Sat, 09 Jul 2022 16:56:17 +0000")
Message-ID: <xmqqa69it1g9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB3C19FC-FFCE-11EC-867E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This short series looks to add the basics of the reachability bitmap and
> commit graph phrases to the glossary of terms. While these techniques are
> well known to their developers, for some, they are just magic phrases.
>
> The first patch [1/4] is to show OBD as an abbreviation to avoid a UNA [0]

Avoiding unnecessary TLA is even better than avoiding.  As I didn't
see in the other three patches that we need to use the OBD acronym,
perhaps we can omit this step?

> Patch [2/4] provides a basic statement for the Commit-Graph's purpose.
>
> Patch [3/4] provides a similar statement for the reachability bitmaps.
>
> These two patches maybe misses out on some linking information as to the
> benefits these have and the basics of their heuristic.
>
> Patch [4/4] follows up on a bug report about the lack of idempotence for the
> `--renormalise' command. See commit message for details.
>
> [0] UNA Un-Named Abbreviation.
>
> Signed-off-by: Philip Oakley philipoakley@iee.email
>
> Philip Oakley (4):
>   glossary: add Object DataBase (ODB) abbreviation
>   glossary: add commit graph description
>   glossary: add reachability bitmap description
>   doc add: renormalize is not idempotent for CRCRLF
>
>  Documentation/git-add.txt          |  3 ++-
>  Documentation/glossary-content.txt | 15 ++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
>
> base-commit: 30cc8d0f147546d4dd77bf497f4dec51e7265bd8
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1282%2FPhilipOakley%2FGlossary_terms-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1282/PhilipOakley/Glossary_terms-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1282
