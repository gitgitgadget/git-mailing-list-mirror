Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4391C433EF
	for <git@archiver.kernel.org>; Sun, 15 May 2022 16:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiEOQyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEOQyK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 12:54:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23C2CC91
        for <git@vger.kernel.org>; Sun, 15 May 2022 09:54:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33A1B12469A;
        Sun, 15 May 2022 12:54:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qOTkVMP9FiHo8GtTElCQqXWgeFZTIeb0L6EbNP
        1TrYE=; b=E8NvRVuBiUFo6bKlQEoHs9vaJCcPuin/kRQIt8jBZYq2QyrZR+2+8K
        tJ8XPVcQvwBAYEzU78bTMvmWMjCmmTWxc31ssJHA3yIGnmnVkaJ1XB3+FwP2aG95
        fDzU1wW/Wd11RQYaGeCw0eN488+Ytm52DXJgEWNjj/SFK3l850Zh4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16BE5124699;
        Sun, 15 May 2022 12:54:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD091124698;
        Sun, 15 May 2022 12:54:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] t0034: add negative tests and allow git init to
 mostly work under sudo
References: <20220510174616.18629-1-carenas@gmail.com>
        <20220513010020.55361-1-carenas@gmail.com>
        <20220513010020.55361-4-carenas@gmail.com>
        <xmqqee0ycjos.fsf@gitster.g>
        <CAPUEspj1JTG2Ujuk4O6ogo6qEQEwe-2aHF8J95xjX+OpY4cenQ@mail.gmail.com>
Date:   Sun, 15 May 2022 09:54:02 -0700
In-Reply-To: <CAPUEspj1JTG2Ujuk4O6ogo6qEQEwe-2aHF8J95xjX+OpY4cenQ@mail.gmail.com>
        (Carlo Arenas's message of "Sat, 14 May 2022 07:36:16 -0700")
Message-ID: <xmqqr14u7n4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A102534A-D46F-11EC-A392-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Thu, May 12, 2022 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Heh.  I am a bit surprised that double sudo would become a separate
>> prerequisite,
>
> It is because it goes away in the optional patch 4, since it won't be
> needed anymore after that.

Hmph, it may not be needed, but it should still work, in which case
it probably is still worth testing, even with the optional patch #4.

No?
