Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C2CCA485
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347419AbiFHA0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452612AbiFGXOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:14:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41B520B7D7
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:00:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBAC812608D;
        Tue,  7 Jun 2022 17:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xs8GhrLLM3sAAk3BuYGon52NYxzlbKv7j+1NPO
        m46Rc=; b=UwEz1ILcozfVc7ikI8luRmB0z6SiJsCXcRxdinJOyj7GUveQQwUzd9
        9jrFWc3VKUT3sXqmywUQINOsvWaztLq7YQpdkvS9uaA1WH4kenBfCcF/LNcyQcuA
        PGByaNcKFcqdL11qWVeR6TxutiqaUEcHTb8w0XAYAbO/SZjYXnj7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D33B212608C;
        Tue,  7 Jun 2022 17:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21ED112608A;
        Tue,  7 Jun 2022 17:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 0/3] bitmap-format.txt: fix some formatting issues
 and include checksum info
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <xmqqfskgwcou.fsf@gitster.g>
Date:   Tue, 07 Jun 2022 14:00:37 -0700
In-Reply-To: <xmqqfskgwcou.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Jun 2022 11:28:17 -0700")
Message-ID: <xmqqo7z4ur2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1F5DB1E-E6A4-11EC-8EE0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> There are some issues in the bitmap-format html page.
>
> "First, it does not even exist!" before anything else ;-)
>
>> For example, some
>> nested lists are shown as top-level lists (e.g. [1]- Here
>> BITMAP_OPT_FULL_DAG (0x1) and BITMAP_OPT_HASH_CACHE (0x4) are shown as
>> top-level list). There is also a need of adding info about trailing checksum
>> in the docs.
> ...

No, this is not quite ready for production.

Almost all the "indented" material are shown in fixed-width
typewriter format in the resulting HTML output.

Look how ugly the output from it is.  Not your fault; it is mostly
because when the original text was written, it was not even meant to
be given to AsciiDoc.

  https://twitter.com/jch2355/status/1534276427607986178/photo/1
  https://pbs.twimg.com/media/FUrYP2nakAAnRaH?format=png

And as I already said, removal of the blank lines made it harder to
see what is going on in the source, and because the output is pretty
much straight copy of the source in the fixed-font, just like reading
the source in the terminal, the output here is equally hard to read.

  https://twitter.com/jch2355/status/1534277664441511937/photo/1
  https://pbs.twimg.com/media/FUrZZXUUsAEmEeT?format=png

If we really want to give it to AsciiDoc, we'd need to reformat it
more extensively, not just tweak it on the surface and making an
equivalent of <pre>...</pre> slightly easier to read, which is what
this patch does.

Thanks.
