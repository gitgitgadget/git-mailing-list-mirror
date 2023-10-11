Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CE8CDB482
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjJKWX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJKWX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:23:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E34C91
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:23:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3768F1B77C8;
        Wed, 11 Oct 2023 18:23:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yCeST7/ceypb
        MDTOaXB+llnitqE35JvLQNVu8W87Ah0=; b=BhoHgy8dbScJY/trZkocqiYsXj9F
        2r4cDz8tINLX3zzGPQEKHC1Km16Xa9mFYcIVSHuDSwdJB4ACbhJHF1OvXM+dBaXe
        K8oPOeTRXtCScyN8zOY8J9qmckdVemDjsWcVR0Q1C5aPmQRfRotJaZ4xSB3pn8br
        VgmmpRryI8we5Lw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E7271B77C7;
        Wed, 11 Oct 2023 18:23:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 961121B77C6;
        Wed, 11 Oct 2023 18:23:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
        (Christoph Anton Mitterer's message of "Thu, 12 Oct 2023 00:19:40
        +0200")
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
Date:   Wed, 11 Oct 2023 15:23:20 -0700
Message-ID: <xmqqa5sokdd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C93DE072-6884-11EE-B749-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.org> writes:

> But I still don't get from that why X would be needed?
>
> My less manpage documents it as:
>> -X or --no=E2=80=90init
>>     Disables sending the termcap initialization and deinitialization
>>     strings to the terminal.  This is sometimes desirable if the
>>     deinitialization string does something unnecessary, like clearing
>>     the screen.
>
> Is it to avoid clearing the screen?

I think that was the reason we added it back in 2005.  In any case,
asking "why" is not a useful use of anybody's time, because it is
very unlikely to change in the official version we ship, and because
it is so easy for any individual who does not like it to drop by
exporting the $LESS environment variable.

Thanks.
