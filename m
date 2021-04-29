Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1203C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B95E6142A
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhD2A7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 20:59:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61344 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD2A7C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 20:59:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4285CFB26;
        Wed, 28 Apr 2021 20:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8IoCLwxE7bHjbug5S7+VZQOsQfOKS/5vQPBP2c
        OZfkI=; b=YAPnZEj/NmWPgImlPnLUECLW4JOU7pQ19TJlLLMsE0c05m8Ba5XqHS
        +w/2lGVfX+Q2NZzaCBYWA24q6b9epqkzgyrnRKHKde4oPdd250AyOB66BVVIw68o
        clDgoI2VM2qhJSwXzAPW6oZDrC+ANWWJJIY2rk7ZyloHSfEPL5fPw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4A16CFB25;
        Wed, 28 Apr 2021 20:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4522FCFB22;
        Wed, 28 Apr 2021 20:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Subject: Re: [PATCH V2] git-apply: modify prints to account for --3way changes
References: <20210427011314.28156-1-jerry@skydio.com>
        <20210427194005.14318-1-jerry@skydio.com> <xmqq7dkmc19x.fsf@gitster.g>
        <CAMKO5CvLW=XYFby1pBj7FHcXpNTM-qMB8UakDG+N=UXU2Gw7fQ@mail.gmail.com>
Date:   Thu, 29 Apr 2021 09:58:14 +0900
In-Reply-To: <CAMKO5CvLW=XYFby1pBj7FHcXpNTM-qMB8UakDG+N=UXU2Gw7fQ@mail.gmail.com>
        (Jerry Zhang's message of "Wed, 28 Apr 2021 11:26:09 -0700")
Message-ID: <xmqqlf91aoux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA938E7C-A885-11EB-AEA1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> On Wed, Apr 28, 2021 at 12:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jerry Zhang <jerry@skydio.com> writes:
>>
>> > Subject: Re: [PATCH V2] git-apply: modify prints to account for --3way changes
>>
>> Sorry that I missed this in the previous round, but what do you mean
>> by "prints" here?
>>
>> > "git apply" specifically calls out when it is falling back to 3way
>> > merge application.  Since the order changed to preferring 3way and
>> > falling back to direct application, continue that behavior by
>> > printing whenever 3way fails and git has to fall back.
>>
>> I am guessing it is safe to s/modify prints/adjust messages/ after
>> reading this explanation.
> Sure, do you want  a new patch for that?

It's not what *I* want ;-).  

If what you sent is not sufficiently clear to help readers, you
would want to update, no?

