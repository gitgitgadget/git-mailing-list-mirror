Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD6AC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 22:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGJWEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 18:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJWEh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 18:04:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD511A0E
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 15:04:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18182123360;
        Sun, 10 Jul 2022 18:04:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PeQzVO/Vx+0kfeAWxa+LSIOORA3HGW1sRpXDQ+
        RBaJ4=; b=aFsM+Ni/1YU07R99dzhYqsuh/LEV5E5yJgoH4JJlp5Uow9M0Nc4ql2
        EEcw8Bcp+7xagfpOd/hcylPGHTgWgBCORE1D3E0rKoKJI2Nt/lSvnKUYHyq+XjFc
        5QzIYQm8D9ZGdynJZzGaHUxM59h0Omn8qYLFUNbiy8h81JnKY+b6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EBD712335F;
        Sun, 10 Jul 2022 18:04:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EBD912335E;
        Sun, 10 Jul 2022 18:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
        <xmqqilo6t2qy.fsf@gitster.g>
        <e45c4fc1-3a30-726c-51f3-00caeca0a552@iee.email>
Date:   Sun, 10 Jul 2022 15:04:31 -0700
In-Reply-To: <e45c4fc1-3a30-726c-51f3-00caeca0a552@iee.email> (Philip Oakley's
        message of "Sun, 10 Jul 2022 22:52:45 +0100")
Message-ID: <xmqqsfn8pqts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 470484EA-009C-11ED-915C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>>> +	This option implies `-u`. Lone CR characters are untouched, so
>>> +	cleaning *^* not idempotent. A CRCRLF sequence cleans to CRLF.
>> Lack of verb BE somewhere. 
> '^' It took me three re-reads to see my mistyping as my head knew what
> I'd meant to write, I've marked above as a note to self.
> Aside: Are there any guides / suggestions / how-to's for on-line
> reviewing that you can recommend o

Sorry, but I do not know of any good "trick" to fight against our
common tendency to easily miss trivial typoes and thinkos in what we
ourselves wrote.  We can be surprisingly blind to what a colleague
can spot immediately, and that is why it helps to have a thorough
read-through by a reviewer with fresh eyes.  When I was a more
prolific contributor, I sometimes tried to read aloud what I wrote
to myself, both docs and code, and caught silly mistakes before
sending them out to the list, but I do not recommend it to others.
