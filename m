Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91ACD68E0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 00:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379188AbjJJAYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379119AbjJJAYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 20:24:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7AF9F
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 17:24:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43B8A1A3546;
        Mon,  9 Oct 2023 20:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BjnHfwuYDGSv0tkZsyjaUFE0fgBJGAGdQbpEEV
        wcXzA=; b=UybSUyLhTvtu2EWCLXXif+7jvMRJU5Z02fbLECWDeSERUq7SMHVcOq
        1JDSpmajmbaYt9s5sCiUZ3UlCvkkjnJOsRdJluZZqCSqOmC/SqmnFrz8cuteu7zj
        tMsofT8UNPnG2LymjPBNDYawo5IkfpZRBnu35TLMBCrvGMbk0jW/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 334191A3545;
        Mon,  9 Oct 2023 20:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 592F61A3544;
        Mon,  9 Oct 2023 20:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
In-Reply-To: <CABPp-BGL_QzRd3mRhSF7rHYNA4pFWfKPA+UuZDODFgEv-1BHhA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 9 Oct 2023 10:04:28 -0700")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        <xmqq7cnzaav0.fsf@gitster.g>
        <CABPp-BGxVnhnmoajWyqY_gMvQ42W5S6VX5EOXq3PW=GLVQwe0g@mail.gmail.com>
        <xmqqjzrz5hgn.fsf@gitster.g> <xmqqmswv3p11.fsf@gitster.g>
        <CABPp-BGL_QzRd3mRhSF7rHYNA4pFWfKPA+UuZDODFgEv-1BHhA@mail.gmail.com>
Date:   Mon, 09 Oct 2023 17:24:03 -0700
Message-ID: <xmqqa5srwcik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 520F341A-6703-11EE-A34F-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> >> In my opinion, --remerge-diff does this better; wouldn't we want a
>> >> ...
>> > Between -c and --cc, I do not think there is anything that makes us
>> > favor -c over --cc.  While the algorithm to decide which hunks out
>> > of -c's output to omit was being polished, comparison with -c served
>> > a good way to give baseline, but once --cc has become solid, I do
>> > not think I've used -c myself.
>
> Perhaps, then, the user manual should either omit -c, or recommend
> users use --cc instead?

I do not think I'd miss "-c", but I do not know about others.

>> > I personally find that a very trivial merge resolution is far easier
>> > to read with --cc than --remerge-diff, the latter being way too
>> > verbose.
>
> Ah, indeed, for those that know the --cc output format well (it takes
> a bit to figure out for newcomers), your example demonstrates this
> nicely.  Thanks.

Yup.  And newcomers would take a bit to figure out remerge-diff
output, too, so my answers were written from the "nobody will stay
newcomer forever.  now once they get proficient enough, which ones
are good for them" viewpoint.
