Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341DB21848
	for <e@80x24.org>; Wed,  2 May 2018 16:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeEBQPq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 12:15:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38882 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeEBQPo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 12:15:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id i3so25327176wmf.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sAGmoo1h7qw5yxcbaPwFtICLBPsrXcFc3ihEjMkmMBM=;
        b=eMSvjWXLvNnlH4nbBBzzFuWwnQFMCfPtAFKhqy4i6Aaq/GDGf8o8RRS/7vPJYmAlGW
         PSWTyowx9KOv+6BfqPPSZuOSfw0TcCQ8JzIUFfbRwlkqLQql7qUgEABGzAOQy6gtYk0w
         Jh1OZNTxLAK5mQM0kd4xXGDQOTNiS++JgDsKWhzg3RB6jOjEcwu+Oce/sbVv5coLxq8k
         qNFQ96z7AERWwyNX9Lihe53JxgVsoSot5A0Q3c30uNcbafuXyNBWjoSpVwLwGoJiysrX
         kGFhVAmGPhuD9mtTf/qPisU5kucMt9UYTGUBWq4lDdRv5T9cIEcUqyumn5FmM0O0kNvm
         HGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=sAGmoo1h7qw5yxcbaPwFtICLBPsrXcFc3ihEjMkmMBM=;
        b=Xdi2d7JvEKZuKLh3mvEj2jVZvv+fNuiFNSmxmSTA+h8vdwpirq2mBjjA36SIFeUiuO
         PM0De8Q/UTV+NdXuBQxFIDKF2Zy5EYZMrr14GmpXU0YM8P0b9t2rzEYHAevk5VI7s4aD
         qCPH4bEYjPW+51RFECQBA3VPvr9EPXBSmtJv5EGkCyBJjw+P2nc/Ioy7nTi2dNr1Mens
         3wDxiba0wSN4oMTeHzZv9vKJJXOqfYv5rpkQTI6Aif2yPGLvj04l2IaBDF4zWGK3Lfb0
         eL6R1QZqTyA2eeV0AaEYvnanaMsJKvELP3PiDFaXQrFqy+vH4IkHoLFMk/ycLYXGkce9
         gNRQ==
X-Gm-Message-State: ALQs6tDfhQsg9L3l8D8NWXWC5WXV0UG87/bgrNz8tLzZZ+rWtMRyGd1A
        KWTjgvGYsPDDT6ZyoeVcKvw=
X-Google-Smtp-Source: AB8JxZosjdH41sKorDFQ2fUN0gLOS+D9SY538khRrmvVMTyvre2PVKx6aqb39AQCf6pU2YuTZT1hCA==
X-Received: by 10.28.194.213 with SMTP id s204mr12500600wmf.40.1525277743604;
        Wed, 02 May 2018 09:15:43 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egn45.neoplus.adsl.tpnet.pl. [83.21.77.45])
        by smtp.gmail.com with ESMTPSA id q2-v6sm12405839wrm.26.2018.05.02.09.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 09:15:42 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 03/10] commit-graph: compute generation numbers
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-4-dstolee@microsoft.com>
        <86r2myidmq.fsf@gmail.com>
        <0bd1ffe0-c727-653a-46a3-f9d4ea17bec2@gmail.com>
Date:   Wed, 02 May 2018 18:15:38 +0200
In-Reply-To: <0bd1ffe0-c727-653a-46a3-f9d4ea17bec2@gmail.com> (Derrick
        Stolee's message of "Tue, 1 May 2018 08:10:20 -0400")
Message-ID: <861seu11at.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 4/29/2018 5:08 AM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:

[...]
>> It is a bit strange to me that the code uses get_be32 for reading, but
>> htonl for writing.  Is Git tested on non little-endian machines, like
>> big-endian ppc64 or s390x, or on mixed-endian machines (or
>> selectable-endian machines with data endianness set to non
>> little-endian, like ia64)?  If not, could we use for example openSUSE
>> Build Service (https://build.opensuse.org/) for this?
>
> Since we are packing two values into 64 bits, I am using htonl() here
> to arrange the 30-bit generation number alongside the 34-bit commit
> date value, then writing with hashwrite(). The other 32-bit integers
> are written with hashwrite_be32() to avoid translating this data
> in-memory.

O.K., so you are using what is more effective and easier to use.
Nice to know, thanks for the information.

[...]
>>>   +static void compute_generation_numbers(struct commit** commits,
>>> +				       int nr_commits)
>>> +{
[...]
>>> +	for (i =3D 0; i < nr_commits; i++) {
>>> +		if (commits[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
>>> +		    commits[i]->generation !=3D GENERATION_NUMBER_ZERO)
>>> +			continue;

[...]

>>>   +	compute_generation_numbers(commits.list, commits.nr);
>>> +
>> Nice and simple.  All right.
>>
>> I guess that we do not pass "struct packed_commit_list commits" as
>> argument to compute_generation_numbers instead of "struct commit**
>> commits.list" and "int commits.nr" to compute_generation_numbers() to
>> keep the latter nice and generic?
>
> Good catch. There is no reason to not use packed_commit_list here.

Actually, now that v5 shows how using packed_commit_list looks like, in
my opinion it looks uglier.  And it might be easier to make mistake.

Also, depending on how compiler is able to optimize it, the version
passing packed_commit_list as an argument has one more indirection
(following two pointers) in the loop.

Best,
--=20
Jakub Nar=C4=99bski
