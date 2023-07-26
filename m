Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E41FC001DF
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 16:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGZQoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjGZQoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 12:44:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730E26BC
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 09:44:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA1F537F2B;
        Wed, 26 Jul 2023 12:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=63mfyL6KOIAcjV40CqzWGjSiq35BzVUnP4lehh
        pII7Y=; b=ulSyXXraeyv2QNvhlpBJ/rOgMQy/i0Yo2CI9QS9Cgm//547G0t4etV
        7dRiIrSiBn4KJcjjAW9V+v+fNVHq7mMIhRohNd9NMXivIBYj26dnfmjHw5POFalC
        jqHPDOgFmtkUuZLdJ6L6WXQNQhAIJvCoadWbD1uOvuuc4Kg4KPmVY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2B7437F2A;
        Wed, 26 Jul 2023 12:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2039537F26;
        Wed, 26 Jul 2023 12:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Majer <adamm@zombino.com>
Cc:     git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
        <ZLlNtbAbVcYH7eFb@adams> <xmqqr0p230rj.fsf@gitster.g>
Date:   Wed, 26 Jul 2023 09:44:05 -0700
In-Reply-To: <xmqqr0p230rj.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 Jul 2023 11:18:08 -0700")
Message-ID: <xmqqedkuei7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3372EC6-2BD3-11EE-A5E3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Adam Majer <adamm@zombino.com> writes:
>
>> I'll try again with inline patch.
>>
>> From 90be51143e741053390810720ba4a639c3b0b74c Mon Sep 17 00:00:00 2001
>
> Remove all the above lines (including the "From <commit object
> ...
>> Signed-off-by: Adam Majer <adamm@zombino.com>
>> ---
>>  Documentation/git.txt                      | 4 ++--
>>  Documentation/object-format-disclaimer.txt | 8 ++------
>>  2 files changed, 4 insertions(+), 8 deletions(-)
>> ...
> This side looks OK (just removing the single sentence).
>
>>  Git Commits
>>  ~~~~~~~~~~~
>> diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/object-format-disclaimer.txt
>> index 4cb106f0d1..1e976688be 100644
>> --- a/Documentation/object-format-disclaimer.txt
>> +++ b/Documentation/object-format-disclaimer.txt
>> @@ -1,6 +1,2 @@
>> ...
>
> The original did not have this problem because it had enough
> surrounding context, but the updated text now risks getting misread
> as if there are "regular" and "special" SHA-1 repositories, the
> latter of which might work better with SHA-256.
>
> And the message about SHA-256's non-experimental status can probably
> be a lot stronger, after the discussion we had recently.  How about
> saying something like:
>
>     Note: there is no interoperability between SHA-256 repositories
>     and SHA-1 repositories right now.  We historically warned that
>     SHA-256 repositories may need backward incompatible changes
>     later when we introduce such interoperability features, but at
>     this point we do not expect that we need to make such a change
>     when we do so, and the users can expect that their SHA-256
>     repositories they create with today's Git will be usable by
>     future versions of Git without losing information.
>
> which would probably be much closer to what you wanted to hear?

It has been a week.  Any news on this topic?

Thanks.
