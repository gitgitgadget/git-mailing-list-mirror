Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFFCC4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJSVut (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJSVur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 17:50:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF9E148FEA
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 14:50:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 198711C2F83;
        Wed, 19 Oct 2022 17:50:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JsVPCxBOXlUF
        Hq6IhMnL6xrcwhIiAfAgjZ5i51+HOGc=; b=rs9Z7CgToStFEZAefy8Cd/NWdZIZ
        umD6aa67Z3yYwF0dzUfW3/woJA7lIJqvDlW8y8jZt/x6ZGLxWyRHFPGlJhOssXry
        vQ578dtPVIxbZzzdCdQ5fPPd3vku1FlfPJWR2iySxcQo7AcbRLxPQwGnExNLteXt
        sHI06bcMD3EiyiI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11A431C2F82;
        Wed, 19 Oct 2022 17:50:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42D7F1C2F81;
        Wed, 19 Oct 2022 17:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v2] embargoed releases: also describe the git-security
 list and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
        <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
        <Y1Bo18aU7YKKX9yh@nand.local>
Date:   Wed, 19 Oct 2022 14:50:41 -0700
In-Reply-To: <Y1Bo18aU7YKKX9yh@nand.local> (Taylor Blau's message of "Wed, 19
        Oct 2022 17:15:03 -0400")
Message-ID: <xmqqfsfjpjny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13E9BF34-4FF8-11ED-B7B3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +A bug's life: Typical timeline
>> +------------------------------
>> +
>> +- A bug is reported to the `git-security` mailing list.
>> +
>> +- Within a couple of days, someone from the core Git team responds wi=
th an
>> +  initial assessment of the bug=E2=80=99s severity.
>
> A few nitpicks on this and the above bullet point:
>
>   - The git-security list isn't for bug reports, though there can be a
>     security component to something that looks like a bug report.
>
>     Perhaps to be clearer we should swap "bug" for "potential
>     vulnerability"?

Good point and good idea.

>   - On "within a couple of days", I think that this is aspirationally
>     true, though not always the case. Perhaps, "as soon as possible"
>     instead? That's vague enough that I wouldn't worry about somebody
>     reading this document >2 days after submitting a potential
>     vulnerability wondering why nobody has gotten back to them ;-).

The purpose of giving a "Typical" timeline is primarily to guide
readers what to expect once they raise an issue, and to bind us with
at least "aspirational" deadline (which is not a bad thing), isn't
it?  Saying "As soon as possible" there is the same as not saying
anything at all, even though in reality it sometimes may be "when
somebody feels like it is worth looking into" ;-)

Depending on the nature of vulnerability, the time it takes to reach
a satisfactory conclusion may range from a few days to a few weeks,
so we may not be able to give even a "Typical" timeline, but I do
not think it is unreasonable to hold us to a few days turnaround
time at least for an initial reaction.

That's a roundabout way to say "I think the original text is good".

>   - Finally, consider replacing "core Git team" with "member of the
>     git-security list".

I am torn.

The folks who are deep into core git development may have better
ability to assess the severity of a particular bug and the
complexity of possible solutions than others, but platform
stakeholders know how Git is used within their system and how old
the target track they wish to be updated better than us.  So in that
sense, limiting assessment to core developers may not be ideal.

But on the other hand, the initial report to the list are seen only
by the security list participants and nobody else, so by definition,
any response would come from them ;-)

> The private forks tied to a security advisory are often convenient
> (assuming that the reporter has a GitHub account) since they provide a
> shared workspace. But I think we usually avoid them when working on
> preparing a release for more than one vulnerability.

Yes, it is convenient for simple things, but not necessarily the
best option when we need to roll it upwards to produce releases for
multiple maintenance tracks.

The rest of your comments and suggestions address all good points.

Thanks.
