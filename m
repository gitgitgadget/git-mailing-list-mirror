Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB261EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjHKRLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbjHKRK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:10:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4964F35BF
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:10:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8594A1A4A93;
        Fri, 11 Aug 2023 13:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OLowwkeHzYEl/h3lJnVTjwKDmt7j0RXrnYXWze
        Pn6nk=; b=lKH1cdlviSOWmWEWu+3uS4BC86xxsPc7G2XumRIQxtBpDwndq8R+yJ
        2W2s9cfZnVa9r4vpi31wXIFa8JZYlHvZJd7C/LrKYGXB8Ntp3ruTHlj7nuDJ1WWA
        W9CK8cRVgQJ11gmFAwWUYzDl//apKCt9W0M2fDPb864bMFmGmirYA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E72D1A4A92;
        Fri, 11 Aug 2023 13:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E88311A4A91;
        Fri, 11 Aug 2023 13:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Linus Arver <linusa@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
        <owly8raih8ho.fsf@fine.c.googlers.com>
        <b9f8c965-731d-84eb-f60e-fbed418f9ca2@gmail.com>
Date:   Fri, 11 Aug 2023 10:10:18 -0700
In-Reply-To: <b9f8c965-731d-84eb-f60e-fbed418f9ca2@gmail.com> (Phillip Wood's
        message of "Fri, 11 Aug 2023 16:08:14 +0100")
Message-ID: <xmqqmsyxtshx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F34C0830-3869-11EE-AAB6-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/08/2023 22:50, Linus Arver wrote:
>> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>> +DISCUSSION
>>> +----------
>>> +
>>> +While git creates a basic commit message automatically, you really
>>> +should not leave it at that. In particular, it is _strongly_
>>> +recommended to explain why the original commit is being reverted.
>>> +Repeatedly reverting reversions yields increasingly unwieldy
>>> +commit subjects; latest when you arrive at 'Reapply "Reapply
>>> +"<original subject>""' you should get creative.
>> The word "latest" here sounds odd. Ditto for "get creative". How
>> about
>> the following rewording?
>>      While git creates a basic commit message automatically, it is
>>      _strongly_ recommended to explain why the original commit is being
>>      reverted. In addition, repeatedly reverting the same commit will
>>      result in increasingly unwieldy subject lines, for example 'Reapply
>>      "Reapply "<original subject>""'. Please consider rewording such
>>      subject lines to reflect the reason why the original commit is being
>>      reapplied again.
>
> That's a good suggestion, I think having the example will help readers
> understand the issue being described.

Sounds very good.

