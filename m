Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BDC4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 15:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiJSPwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJSPw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 11:52:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F328E1A
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:49:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBE091480BF;
        Wed, 19 Oct 2022 11:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yGSwpGin5Vhg+kPJLpdnZktuABuH6oVOm/5KRU
        ExTJg=; b=HB7Irl1vCS2TwBFeSfy2RU9NDeD5Ux8hQyD8DFrYsUvtR6B9fqeqyQ
        goUzVUuJgbkDjHvpgAc1+PhrHGEMMenFXFY1W0YBjfs8QKmNxI2U97usR5Jrtwuc
        sh7d1U087HxM+k5LLrMOyLkrTMt/5BYbsQqY/zVRc0xeysddvlLS4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D45151480BE;
        Wed, 19 Oct 2022 11:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C1F61480BD;
        Wed, 19 Oct 2022 11:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julia Ramer <prplr@github.com>
Cc:     "Veronica Giaudrone (SHE/HER)" <Veronica.Giaudrone@microsoft.com>,
        "Bri Brothers (SHE/HER)" <brbrot@microsoft.com>,
        Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
        <xmqqa67h8zac.fsf@gitster.g>
        <CADq8SzUUoi6=6ggxkeTUf2y0WmeAMMjuq8_OCej0smF7OabPiQ@mail.gmail.com>
        <xmqqtu4rv2wb.fsf@gitster.g>
        <CADq8SzWW+_uGMOwyyyT9pFWpOQW2eWUh2Ndn4qYQJ1fAqtXnew@mail.gmail.com>
Date:   Wed, 19 Oct 2022 08:47:13 -0700
In-Reply-To: <CADq8SzWW+_uGMOwyyyT9pFWpOQW2eWUh2Ndn4qYQJ1fAqtXnew@mail.gmail.com>
        (Julia Ramer's message of "Tue, 18 Oct 2022 13:43:07 -0700")
Message-ID: <xmqq35bju872.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D5AFDC4-4FC5-11ED-88F0-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julia Ramer <prplr@github.com> writes:

>> In this hypothetical timeline:
>>
>>     A---B-B-B-B-B-B-B-B---C
>>
>>               D0----E0           D1----E1 (next month)
>> ...
>> If the coordinated release C falls after the deadline D0 for the
>> upcoming "monthly security updates" (not singling out Microsoft by
> ...
> If I am understanding this particular scenario, I believe you intended:
>
> s/coordinated release C/final B/

Thanks for sharp eyes.  You're correct.  As long as the final B
comes before the deadline of a packager, then they should be able to
work within their own constraint.  If the final B comes after their
deadline, and they still want to include the fix in E0, then the
package needs to be "creative".

> I can take a stab at concisely phrasing this to fit within this framework,
> first paragraph for context, second is the addition:
>
> Once the review has settled and everyone involved in the review agrees that
> the patches are ready, the Git maintainer and others determine a release date
> as well as the release trains that are serviced. The decision regarding which
> versions need a backported fix is based on input from the reporter, the
> contributor who worked on the patches, and from stakeholders (e.g. operators
> of hosting sites who may want to analyze whether the given bug is exploited
> via any of the repositories they host).
>
> While the Git community does its best to accommodate the specific timeline
> requests of the various binary packagers, the nature of the issue may preclude
> a prolonged release schedule. For fixes deemed urgent, it may be in the best
> interest of the Git users community to shorten the disclosure and release
> timeline, and packagers may need to adapt accordingly.

Exellent.  Thanks.
