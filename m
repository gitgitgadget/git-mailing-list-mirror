Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7406C1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfBURiK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:38:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32936 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBURiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:38:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so31634624wrw.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 09:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YCoIBngrwQzVsdcEtomd6auLNV7g527fPKBaWFwKHwI=;
        b=KcranNYvm6k93kONGNA8firC0HKjR6e7P4LR/NhC+HCbtnFDqmCk9goPE0Gaf+6klm
         GzUucgRIx31W4qnkVbgbIYwoBa5KYDY/w5ntTZaXaISgv+Fr3dXZ4tCdKGq4t/c1jdLA
         i8zGW8/quBS11LCgg7NkklqfJtsNXYqFLcTtM+ogFP22GJXicwUATixxHkQVf/6nMEXb
         s7DO7vQT9hBP0q2+JxeemZb9jYatFF6NwlaQGBehMt5T7OYGKKc50wpUWaJrhR3in5U/
         CYnfXxhOUbVIo9k+G8DpAUAcAw1zdHYE+9/0Egpx2jO/sBfVDkYs+l/rOCDDifljC/d1
         u8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YCoIBngrwQzVsdcEtomd6auLNV7g527fPKBaWFwKHwI=;
        b=D3t6QCHLfeoUXNmAyzI55nHALVMnZO14YVyESRSlNdMjtYGMoIXzVi8aypwbmvWxFu
         VV8iyJlppvCQdZc+blG9m4ra55/ER8izNlrBkn08rA+z68kxqgqTUkajmwAaR9EV1ZTQ
         9h4Cl1pOmECEiBMqXSy3LMw0gr/m+OIemTBIO9c2S+NgbXrcKwd/Ifn0l4Ybepm5nzjd
         t6phEp6EIRuunG07qXys00Y7pokHWb+X5PQgw9lsy23SrRYh+TZ+Lr3RPIf8eEb3y3lB
         6lQCEo54rAsJDUjxRHsIo3+p5MPy0XPLFXlA4IePaU4bwlbnyG2uGNupAIG8D6r+9TMs
         1z4g==
X-Gm-Message-State: AHQUAua7l4Ulhyw0jivI0xq8E5L60BgAPdbgUMXnXdMezyCUUzWrZFU2
        QCQsMOd3Qs63PYAhFpOKtpA=
X-Google-Smtp-Source: AHgI3Iam386Gb0+NcE+kn2+V1I8RVq6yFDTXmnogNSLsry96wvQqT84Tw0bbhSReTNdQ/2R6Yp3lOw==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr29057891wrp.29.1550770687690;
        Thu, 21 Feb 2019 09:38:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x24sm16337879wmi.5.2019.02.21.09.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 09:38:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] protocol-capabilities.txt: document symref
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
        <cb1b2834b7365f6277d1ec573cee7fd68a7329d0.1550100949.git.steadmon@google.com>
        <20190214035602.GA7209@sigill.intra.peff.net>
        <20190220003248.GA160251@google.com>
Date:   Thu, 21 Feb 2019 09:38:05 -0800
In-Reply-To: <20190220003248.GA160251@google.com> (Josh Steadmon's message of
        "Tue, 19 Feb 2019 16:32:48 -0800")
Message-ID: <xmqqd0nlujnm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2019.02.13 22:56, Jeff King wrote:
> ...
>> may say "...and you can use capabilities from protocol-capabilities.txt
>> here". But it doesn't. It newly lists the capabilities, which makes this
>> paragraph the right thing to say.
>> 
>> It does mean that if we teach v1 a new capability, we'll have to
>> document it in both places. But moving forward, we'd hopefully not be
>> doing that too often (I haven't seen talk of flipping the v2 switch yet
>> by default, but obviously that's where we want to end up).

Yes.

>> I probably would have put this in its own patch, but barring that we
>> should probably at least mention in the commit message what this
>> paragraph is doing here.
>> 
>> -Peff
>
> Done in V3. Thanks!

Will replace (easy to do as nothing is moving to 'next', unless it
is for the upcoming release, during the freeze anyway ;-)

Thanks.
