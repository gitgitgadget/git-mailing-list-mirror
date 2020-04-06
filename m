Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EED6C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB32E206F8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SIKjFWDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFXqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:46:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56825 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFXqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 19:46:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56364CE37B;
        Mon,  6 Apr 2020 19:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HLI4RzQazHtuZDuSdFN511Ugv2U=; b=SIKjFW
        DPYlJgRVA3oaG6OVguwbkzUzBkT/2NABAuNI2U1NieXqaMRfKhKu4KcJHPmhKV2+
        abABEz9xMK4btgifsVRNtOkmllru/EoDs5nr++AGMgJ+HBPC6QcCWrx4OEdOMlKM
        VIjCkqrxO7s1/PzJ8jtqUSdUx8F11drIe2vXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JEz4Hw0teIEvxFicTTnRlIqB3rPa1Oaa
        +bD3CkpOounnc7oZAcguOijCSTgihatHLfw9MWViyG8vQjp43Kl/Son2tI37MGYA
        /if/3xry7+65G8reHH9VaBsJgxGnTBHmaRWAQ7U7WQKHZgGQzpufS0NMGpLSY4G7
        +EnNnS2Tifs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E261CE37A;
        Mon,  6 Apr 2020 19:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9515CCE377;
        Mon,  6 Apr 2020 19:46:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH 1/2] gitfaq: cleanup gitfaq.txt
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
        <20200406181216.5340-2-shouryashukla.oo@gmail.com>
Date:   Mon, 06 Apr 2020 16:46:28 -0700
In-Reply-To: <20200406181216.5340-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 6 Apr 2020 23:42:15 +0530")
Message-ID: <xmqqy2r8tbxn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6ED27E0-7860-11EA-ADEA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

[jc: All other changes in 1/2 turned out to be removal of SP when
there were dot-SP-SP at the end of a sentence, which I am omitted
here as they were so distracting.]

> -Such a shell command can be specified by starting the option value with an
> -exclamation point.  If your password or token were stored in the `GIT_TOKEN`,
> +Such a shell command can be specified by putting an exclamation point before
> +the option. If your password or token were stored in the `GIT_TOKEN`,
>  you could run the following command to set your credential helper:

Sorry, but I am not sure how this change is an improvement.  It is
not making it worse, but it is not making it any better, at least to
me.

> -How do I ignore changes to a tracked file?::
> -	Git doesn't provide a way to do this.  The reason is that if Git needs
> +How do I ignore changes made to a tracked file?::
> +	Git doesn't provide a way to do this. The reason is that if Git needs

Ah, strike what I said about your new section on ".gitignore"; this
is already the right place to describe it.

With or without 'made', I think the header says the same thing, but
I guess it does not hurt to be explicit.

By the way, if you still want to pursue "full-stop at the end of the
sentence MUST be followed by no more than one SP", I won't stop you,
but please do so in a separate patch that has NO OTHER CHANGES.
They drown other changes out that are not mechanical and makes them
hard to review.

Thanks.
