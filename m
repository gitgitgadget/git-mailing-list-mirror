Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73ECC0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 05:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjG1FLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjG1FLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 01:11:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19BB2D75
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 22:10:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A0C41A29D7;
        Fri, 28 Jul 2023 01:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YHppkEz8OoNr3NaKWaLTolvrdqDvX45/QgVAAI
        Ov8ME=; b=HvXyDr5uMvVZ6ythB9uUbObF4t94T7gfJtWs2YgkBUNd+zJIxK7LSI
        PiuQRCfurOmNTLM+0Ymz6JoMROvq53lFn0UABt93OB58GAX5xlccCb5zV5nLtFUV
        BypLOXZU3LVrvQoV7pAf3TqzwtomjRagMx7OyNxo8WKVk0mkn7+Wo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62A0F1A29D4;
        Fri, 28 Jul 2023 01:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DDA71A29D3;
        Fri, 28 Jul 2023 01:10:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4] MyFirstContribution: refrain from self-iterating too
 much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
        <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
        <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g>
        <eaky7y2tprkzvhjdcg5vv2asekclywfcthzolpfu5o363423ca@b3p33bsbcqi5>
Date:   Thu, 27 Jul 2023 22:10:27 -0700
In-Reply-To: <eaky7y2tprkzvhjdcg5vv2asekclywfcthzolpfu5o363423ca@b3p33bsbcqi5>
        (Jacob Abel's message of "Fri, 28 Jul 2023 02:07:25 +0000")
Message-ID: <xmqq7cqk8vuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 117F3428-2D05-11EE-A134-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> On 23/07/27 05:43PM, Junio C Hamano wrote:
>> Finding mistakes in and improving your own patches is a good idea,
>> but doing so too quickly is being inconsiderate to reviewers who
>> have just seen the initial iteration and taking their time to review
>> it.  Encourage new developers to perform such a self review before
>> they send out their patches, not after.  After sending a patch that
>> they immediately found mistakes in, they are welcome to comment on
>> them, mentioning what and how they plan to improve them in an
>> updated version, before sending out their updates.
>> 
>> [...]
>>
>> +Please be considerate of the time needed by reviewers to examine each
>> +new version of your patch. Rather than seeing the initial version right
>> +now (followed by several "oops, I like this version better than the
>> +previous one" patches over 2 days), reviewers would strongly prefer if a
>> +single polished version came 2 days later instead, and that version with
>> +fewer mistakes were the only one they would need to review.
>> +
>> +
>> [...]
>
> Speaking as a fairly green contributor to the project, it may be helpful
> to include some guidance on what is "too long" vs "too short" when
> waiting to send out the next revision. 

We generally do not want to be too prescriptive, as the right
interval depends on many factors like the complexity of the topic,
how busy the reviewers are otherwise, etc.  And that is why I did
not go any more specific than "several rounds within 2 days is way
too frequent".

But as a general common-sense guideline, I would encourage people to
wait for at least one earth rotation, given that there are list
participants across many timezones.  I do not know offhand how to
fit that well in the narrative being proposed, though.

> Likewise it may be worthwhile to mention how the expected "minimum time
> between revisions" will generally shrink as you get to higher revision
> counts and fewer changes between revisions.

I am not sure if I follow.  As a topic gets iterated and getting
closer to completion, maximum time allowed between revisions to keep
the minds of those involved in the topic fresh may shrink, but I do
not think it would affect the minimum interval too much.

Thanks.
