Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E349AC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbiEKWJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbiEKWJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 18:09:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AA2016D1
        for <git@vger.kernel.org>; Wed, 11 May 2022 15:09:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D1DD192826;
        Wed, 11 May 2022 18:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N2U1n0o9CYG94ma/+/jUP497wqtC6ybftCWKxh
        zdqZo=; b=j+7mtb/wtf70O1DHB1uhfmyvP3HFxhnlIZ5d9AGcNLCiNO1FjylPQV
        Gzn8yjVoUyZRFGGstG7ip+m6++Cf1WC3NYDWZvTr4rhBmBKMW8OchbrcBio5GI1g
        VNyKgtsYfLHFZF1NNCRLQWBSiMu4SMxVOg4yt86i08pKUR9757TMQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 413A8192825;
        Wed, 11 May 2022 18:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31DE2192823;
        Wed, 11 May 2022 18:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] MyFirstContribution: add "Anatomy of a Patch
 Series" section
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
        <YntVo0G8G2mQYCLZ@debian.me> <xmqqh75viwoo.fsf@gitster.g>
        <9e766e57-3b6c-494e-84b6-406a91ccf6ea@gmail.com>
Date:   Wed, 11 May 2022 15:09:05 -0700
In-Reply-To: <9e766e57-3b6c-494e-84b6-406a91ccf6ea@gmail.com> (Philippe
        Blain's message of "Wed, 11 May 2022 17:48:29 -0400")
Message-ID: <xmqq4k1viuwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9664498-D176-11EC-8921-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>>> On Wed, May 11, 2022 at 01:47:30AM +0000, Philippe Blain via GitGitGadget wrote:
>>>> +We can note a few things:
>>>> +
>>>> +- Each commit is sent as a separate email, with the commit message title as
>>>> +  subject, prefixed with "[PATCH _i_/_n_]" for the _i_-th commit of an
>>>> +  _n_-commit series.
>>>> +- Each patch is sent as a reply to an introductory email called the _cover
>>>> +  letter_ of the series, prefixed "[PATCH 0/_n_]".
>>>> +- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
>>>> +  v3]", etc. and sent with a new cover letter, itself a reply to the cover
>>>> +  letter of the previous iteration (more on that below).
>>>> +
>>>> +At this point the tutorial diverges, in order to demonstrate two
>>>>  different methods of formatting your patchset and getting it reviewed.
>>>>
>>>
>>> In case of single-patch series submissions, the anatomy is simple: first
>>> the email subject is commit message title prefixed with "[PATCH]" or
>>> "[PATCH v_n_]" (in case of n-th iteration), then commit message and the
>>> actual diff.
>> 
>> Correct.  There is no single-patch topic in the summary view shown
>> in the document, so it does not belong to the above "We can note a
>> few things" list.  But I agree that there should be a mention for a
>> single-patch topic somewhere in this document, both for a patch and
>> (the usual lack of) cover-letter for such a topic.
>> 
>> The sample topic this tutorial uses is a multi-patch series and
>> everything in the document revolves around handing a multi-patch
>> series, so finding a good place to fit it may be a bit tricky,
>> though.
>
> There is already a small section on single-patch topics, at the end of
> the 'git send-email' section [1]. And I add a link to it in the GGG
> section in patch 5/5.
>
> [1] https://git-scm.com/docs/MyFirstContribution#single-patch

Yup, I was wondering if there is an easy way to move it to this
section, which imparts a knowledge common across different method of
patch submission.  If we can do so somewhere nearby, it would be
ideal.  Perhaps in "We can note a few things" list or as a side note
immediately after the list, we can add

    - A single-patch topic is sent with "[PATCH]", "[PATCH v2]",
      etc. without _i_/_n_ numbering (in the above thread overview,
      no single-patch topic appears, though).

Or we can redo the lore screenshot to include such a topic, perhaps,
then we can lose the comment in the parentheses.

That reminds me of one small bug in your patch, where it says

>>>> +- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
>>>> +  v3]", etc. and sent with a new cover letter, itself a reply to the cover
>>>> +  letter of the previous iteration (more on that below).

    Subsequent interations of the patches and the cover letter use
    "PATCH v2", "PATCH v3", etc. in place of "PATCH". "[PATCH v2
    1/3]" would be the first of three patches in the second
    iteration, for example, and replies to "[PATCH v2 0/3]" which is
    the cover letter for the iteration, which in turn replies to the
    cover letter of the first iteration.

Thanks.
