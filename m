Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC847C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiDMQrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiDMQrL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:47:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FC3CA63
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:44:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 394CB19A775;
        Wed, 13 Apr 2022 12:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LjpXBwz1CSfD5ozbj2CBGqsEzzulV+7SloXkRX
        aVE1I=; b=FnIFa9Ejh15l/Mfex5YkmXgFczMwM45c9MMpc28k0j180xkq3zTfcU
        S+PqMWELmzK5ZFSE0vI0dqExOJ5f3wiSszTxT4mu9hRZwMJTqHRuKh+zKEMUDaLF
        XB9VKaRKmwoP1JpsQnk8v46lnjSG3/xhixqWbes/BMfZ1yxcFEabg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3017C19A774;
        Wed, 13 Apr 2022 12:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8893719A773;
        Wed, 13 Apr 2022 12:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/3] Updates to the safe.directory config option
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <xmqq35iharig.fsf@gitster.g>
        <e8383303-e82c-dc23-9f28-6ff566021e82@github.com>
Date:   Wed, 13 Apr 2022 09:44:41 -0700
In-Reply-To: <e8383303-e82c-dc23-9f28-6ff566021e82@github.com> (Derrick
        Stolee's message of "Wed, 13 Apr 2022 12:25:40 -0400")
Message-ID: <xmqqee219bly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0498651A-BB49-11EC-BFC5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I tried to do my due diligence here, but I will admit to some amount
> of haste being applied due to the many distinct sources that have
> motivated the change.

OK.  Thanks for a fast response to a brown-paper-bag bug or two.

> The tests that are added are in a new test file, so hopefully
> those don't collide with anything.
>
> The changes in setup.c apply within the ensure_valid_ownership()
> so should apply to any versions that have the fix.

Yup, I was more worried about newer test helpers and API functions
that did not exist in the older code base, but after reading the
patches through, I think these are all from battle tested and solid
part that applies to all relevant maintenance tracks.

Thanks.
