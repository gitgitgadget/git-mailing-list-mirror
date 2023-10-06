Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF49E94136
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 23:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjJFXTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 19:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFXTo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 19:19:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458093
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 16:19:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CA7C287A8;
        Fri,  6 Oct 2023 19:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=AkypSb+n/mCvmt9dL6D2zxttmAgH689isiB2j1
        Qgp9w=; b=RvVJGMdGf6YsakDkq4148gdYLTakSvOqYySMkpNo+hBoSMG9zGZPOi
        mznkCoht8ogcTLMo+LrsSQ8HdJ/++OnwPkwjB6FkEyTgu7jXGwKOAttvFOM1so/f
        gBlm3MAhX0yW9hB1ledmr+EVQcOEtqtUd9VZqzUwr0lqcEv/h8LOA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 151FC287A7;
        Fri,  6 Oct 2023 19:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8FAEF287A6;
        Fri,  6 Oct 2023 19:19:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
In-Reply-To: <875y3jr42h.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        06 Oct 2023 21:36:22 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        <xmqq7cnzaav0.fsf@gitster.g> <875y3jr42h.fsf@osv.gnss.ru>
Date:   Fri, 06 Oct 2023 16:19:37 -0700
Message-ID: <xmqqv8bj5ofq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D20294DA-649E-11EE-9903-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>>> > +--cc::
>>>> > +     Produce dense combined diff output for merge commits.
>>>> > +     Shortcut for '--diff-merges=dense-combined -p'.
>>>>
>>>> Good.
>>>>
>>>> > +--remerge-diff::
>>>> > +     Produce diff against re-merge.
>>>> > +     Shortcut for '--diff-merges=remerge -p'.
>>>> ...
>>> Perhaps:
>>>
>>> Produce remerge-diff output for merge commits, in order to show how
>>> conflicts were resolved.
>>
>> I do not mind it, but then I'd prefer to see ", in order to show
>> how" also in the description of "--cc" and "-c" for consistency.
>>
>> A succinct way to say what they do may be hard to come by, but I
>> think of them showing places that did not have obvious natural
>> resolution.
>
> So, is it OK with both of you if I leave it as:
>
> "Produce remerge-diff output for merge commits."
>
> for now, and let you tweak the descriptions later on, if needed?

I do not know what Elijah would say, but in one of iterations of my
draft response to him indeed suggested that "in order to" here is
not necessary if it is described for the "--diff-merges=remerge"
option, because those who know enough to skip referring to the other
entry are expected to know why it exists.  So I think I am OK with
that.

Thanks.
