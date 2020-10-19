Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14EEC43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660A222282
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EgCLLbAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgJSR0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:26:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57551 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbgJSRYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:24:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E6407AAC1;
        Mon, 19 Oct 2020 13:24:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=51vnpe1zeqOua7eITOFc7/b8W9M=; b=EgCLLb
        AExiua6mGHAVkcBCXw5+C1LfQCpsEYbbjIkIbONzBUXwINz1IVLkVX6vpyiaSSj/
        axtDEeF1nT+z6ZqIJ4rOXGcUolSIUk37wP+N7ZTC95Q6Dmc5xLv86Hu7A11nDQnT
        ZOivWpzSLUiKZZB2SpPjlAVB7j/7p4q5BtgGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pG80CFPNWeVR2Ssu1i5dqNEbevX659zY
        KkEIxevp+aqx/PIvzDkSshQRCQvBNgthRsznEPWXFTBHvu6Kt+SHxhSew3h/muRy
        QrFRz/jnJx/FojAR9fYEsA+hzWa13MQkIgjNoZVGREO/M956XRWg3MGvskVA9Hgb
        7GXyN77OeH8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16C317AAC0;
        Mon, 19 Oct 2020 13:24:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E4A47AABC;
        Mon, 19 Oct 2020 13:24:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GIT PULL] git-gui changes for v2.29
References: <20201017163411.hk7tqwzyqzvynf6c@yadavpratyush.com>
        <xmqqmu0k8vej.fsf@gitster.c.googlers.com>
        <20201019081944.l45a4mskjg5qvwqc@yadavpratyush.com>
Date:   Mon, 19 Oct 2020 10:24:49 -0700
In-Reply-To: <20201019081944.l45a4mskjg5qvwqc@yadavpratyush.com> (Pratyush
        Yadav's message of "Mon, 19 Oct 2020 13:49:44 +0530")
Message-ID: <xmqqmu0iuo0u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE696946-122F-11EB-AA96-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> On 17/10/20 01:11PM, Junio C Hamano wrote:
>> Pratyush Yadav <me@yadavpratyush.com> writes:
>> 
>> > Junio,
>> >
>> > Please pull in the changes in git-gui for v2.29. 
>> 
>> OK, thanks.  Pulled but not pushed out (yet).
>> 
>> By the way, next time we might want to arrange subsystem pulls a bit
>> sooner than immediately before the final---what do you think?
>
> Ok. I'll send the PR by -rc0 or -rc1 next time.

Sure, of you can even tell me to pull and cook in 'next' during the
early to mid part of a cycle if you wanted to give a particular
change wider exposure.  The point is that it does not have to happen
immediately before the release.

