Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A22C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 20:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJMURu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJMURt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 16:17:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171154C626
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 13:17:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EBC6158C33;
        Thu, 13 Oct 2022 16:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FmjpUKzfIx8x
        iv9SyaPJ7QnHIJ2BIuE+otu/z7DiC7w=; b=dN7Me373/a/dZp89a4V3BfwhrGj6
        pWMkgmNFPNSQFbky81VNJXF0kz7aK0Abiu6P3oAxQ0yeJ1V4zSQVW1SXo5eZ6zNy
        V53GYegSarHEX6f36mDqmej43Ln5LqQysSLBpHs1MB+842SbD05ax3wy1QuDJ40P
        K1yfncaadtS8L78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35297158C32;
        Thu, 13 Oct 2022 16:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94B79158C30;
        Thu, 13 Oct 2022 16:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/15] run-command API: pass functions & opts via struct
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
        <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
        <CAFySSZDdSCHjKCH74h-uStZa4n9xGPbA95unpQUK82b+sBQuvA@mail.gmail.com>
Date:   Thu, 13 Oct 2022 13:17:45 -0700
In-Reply-To: <CAFySSZDdSCHjKCH74h-uStZa4n9xGPbA95unpQUK82b+sBQuvA@mail.gmail.com>
        (Calvin Wan's message of "Thu, 13 Oct 2022 12:19:27 -0700")
Message-ID: <xmqq5ygnfpg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1A144FAA-4B34-11ED-9D97-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Hi =C3=86var
>
> Thank you for condensing the patch series into something more palatable
> for reviewers. The general consensus from the review club yesterday (we
> looked at v2) was that it was difficult to follow what patches were
> relevant to your original intention and what patches were auxiliary QOL
> changes. Also having too many intermediary patches where you add
> variables/functions that were later deleted made it hard to visualize
> which parts of the patch would end up making it into the final state. I
> appreciate the "show your work" approach you take, but I think that
> approach is better suited for more difficult patch series where there
> are significant/difficult to understand functionality changes. In this
> case, the end state of a refactor is clear and there are no
> functionality changes so I believe a more condensed series would be
> easier to review. That being said, I don't believe there is a need to
> spend more time trying to condense this series so future reviewers have
> an easier time -- the end result and intentions are enough.
>
> Reviewed-by: Calvin Wan <calvinwan@google.com>

Thanks, both.
