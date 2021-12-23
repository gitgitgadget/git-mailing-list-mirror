Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279DCC433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbhLWSSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:18:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62080 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349708AbhLWSSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:18:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46C2DEDB0D;
        Thu, 23 Dec 2021 13:18:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Glr7srp2e/FEY8JNDsOWa80A9n0F8+OcpHAy3
        T9Pjg=; b=vRWa2F2xuDFF22VI/j5eFv/cYnwCct5FRj+RCsT55+UxZVF6NcG4xy
        +IGgv6ikBLqCObrd6jh7EFZVJwYXQ3LxFAAtJGyTixJi1k4szTqHTGRW5PhFbqSw
        JVLCa8V0Kqa9dPpU1FS2JncievydFVchOsEzJ3jqph4qRe+yiJp1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D6DAEDB0C;
        Thu, 23 Dec 2021 13:18:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2D14EDB0B;
        Thu, 23 Dec 2021 13:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
        <xmqqlf0equs3.fsf@gitster.g>
        <a6f2a38b-926a-4b47-fd3f-b1327a7c3fcb@jeffhostetler.com>
        <xmqqwnjwdz9j.fsf@gitster.g>
        <84bce2d2-b6ff-547d-2d1f-a79200eb79a3@kdbg.org>
Date:   Thu, 23 Dec 2021 10:18:12 -0800
In-Reply-To: <84bce2d2-b6ff-547d-2d1f-a79200eb79a3@kdbg.org> (Johannes Sixt's
        message of "Thu, 23 Dec 2021 08:38:22 +0100")
Message-ID: <xmqqee63chi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B139A3F8-641C-11EC-8ABB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.12.21 um 23:56 schrieb Junio C Hamano:
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>> 
>>> I hadn't really thought about the term "TLS" in the context
>>> of crypto -- I had "thread local storage" on the brain.  I guess
>>> I've spent too much of my youth using Win32 thread APIs. :-)
>>>
>>> Let me take a look at removing those terms.
>> 
>> Nah, it may be just me.  As long as what TLS stands for is clear in
>> the context, it is fine.
>
> No, really, my first reaction was, too: what the hack has crypto to do
> with trace2? Are we now sending around trace output by email?

Ok, then it is not just me ;-)
>
> Please use "TLS" next to "CTX" only when it means "Transport Layer
> Security".
