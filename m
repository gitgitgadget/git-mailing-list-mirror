Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B5C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB40761A63
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhI3V2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 17:28:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55631 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhI3V2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 17:28:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FC3615C8E7;
        Thu, 30 Sep 2021 17:26:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NCIu2g6/2IvHcN8llJr64GdaJR64kidY8fw4jD
        8pwwY=; b=BLpoKbLLbfAPx7kD7FDtauokyRx/2daRrixivWMRRfsqcaAm8gz9gR
        p9O/PkokaDK8A6aq8JdcSW3Y1wYtri4U76lSK0HjxTCGWucdtciZvLGxOa79GWdm
        p1mBr52ySnVdp/29KBSoUdV6bg0siB5oHfsT/mx8Nc0c5AVrEYqVU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F4C015C8E6;
        Thu, 30 Sep 2021 17:26:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E7E0815C8E2;
        Thu, 30 Sep 2021 17:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <fd244131-84d4-7152-c88c-45f9ada6b609@gigacodes.de>
Date:   Thu, 30 Sep 2021 14:26:12 -0700
In-Reply-To: <fd244131-84d4-7152-c88c-45f9ada6b609@gigacodes.de> (Fabian
        Stelzer's message of "Wed, 29 Sep 2021 10:12:38 +0200")
Message-ID: <xmqqo889ah6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A18DF68-2235-11EC-AC69-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 28.09.21 02:52, Junio C Hamano wrote > * fs/ssh-signing (2021-09-10)
> 9 commits
>>  - ssh signing: test that gpg fails for unknown keys
>>  - ssh signing: tests for logs, tags & push certs
>>  - ssh signing: duplicate t7510 tests for commits
>>  - ssh signing: verify signatures using ssh-keygen
>>  - ssh signing: provide a textual signing_key_id
>>  - ssh signing: retrieve a default key from ssh-agent
>>  - ssh signing: add ssh key format and signing code
>>  - ssh signing: add test prereqs
>>  - ssh signing: preliminary refactoring and clean-up
>> 
>>  Use ssh public crypto for object and push-cert signing.
>> 
>>  On hold.
>>  cf. <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
>>  cf. <532d97e7-8c91-df6a-6d90-70668256f513@gigacodes.de>
>> 
>>
> Openssh 8.8 has been released a few days ago and includes the needed fix
> for the find-principal segfault.
> I ran the full git testsuite against it without issues.
>
> Also, we (~30developers) have been running this patch with
> openssh-portable (2d678c5e3bdc2f5c99f7af5122e9d054925d560d / post 8.7 -
> pre 8.8) in our organization for the last 2 weeks without problems.
> ...
> But vverall i think this is ready for some broader usage/testing via next.
>
> I'd suggest to send the additional patches for valid-before/after
> functionality in a new patchset for review after.

OK, so with the new OpenSSH, there wasn't anything that contradicts
what the above set of patches wanted to do and the series is good to
go?  Let's merge it to 'next' for wider audience, then.

Thanks.
