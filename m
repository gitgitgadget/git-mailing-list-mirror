Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B551F597
	for <e@80x24.org>; Sat, 21 Jul 2018 19:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeGUUqC (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 16:46:02 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:39035 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeGUUqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 16:46:02 -0400
Received: by mail-ed1-f52.google.com with SMTP id w14-v6so12350292eds.6
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Jjt1ppVxqUFPv+GTlgkEIUQUBSCMnoCVnerEa7K2Nuc=;
        b=IF2iiFmHPpHI+Ocbz3GJf5bThSFTnyr8JSPpivbsfBSBTWJMZ+rzZpwe5SSIg33+jb
         uFYGYBeq0td5gfUaD3Fdz7lJK7Z2/ILi3EdwSi+yxeZ6uJBlxJTycVjh+hwNcTdwe/AR
         q/gutOlc4ZoyW0k2sNGYskUTbncSQiuY6vPSAGmOVh7gnQRw9cL5g0Qkr9L/koHCIRdv
         ik3dZwMrNGKAj2g0ae0YVE30HXprUw4uzumi57bki4/cPJ7HXoMsRsygRKzVwM+2WrOn
         so9k3qTsOrDlR28OIGydPwR2NlSQtylfcmUdZGomW5+YPAgv8laldI1CLIIOYdfakBPY
         LlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Jjt1ppVxqUFPv+GTlgkEIUQUBSCMnoCVnerEa7K2Nuc=;
        b=jqmjxKUvpLxDcvE9n47+wFInqqkh4g6lN5nODxSwuJkdZD8LDh/gC+GW4LitrXhEWE
         GUMjPszhQ2Z1shCYOjRlkWC7pUlvcnCBHlA6j9s03x7GjugX7aAiWmpZv1oGCJm19oyM
         0rvf0OF0R147vRRqCAeTCnZNECMr+MT6TtM83FXBAVsHaUKFm93wxP8JQ+5kwoxQ1Nod
         xZNud+QYvg7jH/Mn/AdTxDXOtBAqH1JZPaxzSkSyyimezzj1+diyqd5IjlVZXc94+t/Q
         6khQc/DvJp8upAuvL7D7ngjprV6i8YeHE3cWGEosUeGpVQ836RpUJD1pS8iJDV1F3s8a
         8Q4g==
X-Gm-Message-State: AOUpUlEjWyKhfMG62HmVPkQ/vTJSK9C/rSEVW/9tVbxLPJnMwHD3KYVW
        eJibpJ9byDp1RmPEQoo/RlY=
X-Google-Smtp-Source: AAOMgpcNtduwQmHDVpI5OdNOZXd6dZLkPkqApBprxT4+R5ICQnDSqZ/0ZsFiaVIcUnAN4C2hp7hiRw==
X-Received: by 2002:aa7:d588:: with SMTP id r8-v6mr2772717edq.130.1532202727154;
        Sat, 21 Jul 2018 12:52:07 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id p12-v6sm2066939eds.13.2018.07.21.12.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 12:52:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
        <20180609224913.GC38834@genre.crustytoothpaste.net>
        <20180611192942.GC20665@aiede.svl.corp.google.com>
        <20180720215220.GB18502@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180720215220.GB18502@genre.crustytoothpaste.net>
Date:   Sat, 21 Jul 2018 21:52:05 +0200
Message-ID: <87va98bc4a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 20 2018, brian m. carlson wrote:

> On Mon, Jun 11, 2018 at 12:29:42PM -0700, Jonathan Nieder wrote:
>> My understanding of the discussion so far:
>>
>> Keccak team encourages us[1] to consider a variant like K12 instead of
>> SHA3.
>>
>> AGL explains[2] that the algorithms considered all seem like
>> reasonable choices and we should decide using factors like
>> implementation ease and performance.
>>
>> If we choose a Keccak-based function, AGL also[3] encourages using a
>> variant like K12 instead of SHA3.
>>
>> Dscho strongly prefers[4] SHA-256, because of
>> - wide implementation availability, including in future hardware
>> - has been widely analyzed
>> - is fast
>>
>> Yves Orton and Linus Torvalds prefer[5] SHA3 over SHA2 because of how
>> it is constructed.
>
> I know this discussion has sort of petered out, but I'd like to see if
> we can revive it.  I'm writing index v3 and having a decision would help
> me write tests for it.
>
> To summarize the discussion that's been had in addition to the above,
> Ævar has also stated a preference for SHA-256 and I would prefer BLAKE2b
> over SHA-256 over SHA3-256, although any of them would be fine.
>
> Are there other contributors who have a strong opinion?  Are there
> things I can do to help us coalesce around an option?

I have a vague recollection of suggesting something similar in the past,
but can't find that E-Mail (and maybe it never happened), but for
testing purposes isn't in simplest if we just have some "test SHA-1"
algorithm where we pretent that all inputs like "STRING" are really
"PREFIX-STRING" for the purposes of hashing, or fake shortening /
lengthening the hash to test arbitrary lenghts of N (just by repeating
the hash from the beginning is probably good enough...).

That would make such patches easier to review, since we wouldn't need to
carry hundreds/thousands of lines of dense hashing code, but a more
trivial wrapper around SHA-1, and we could have some test mode where we
could compile & run tests with an arbitrary hash length to make sure
everything's future proof even after we move to NewHash.
