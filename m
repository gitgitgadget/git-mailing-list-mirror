Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9331F453
	for <e@80x24.org>; Tue, 30 Oct 2018 05:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeJ3Olb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 10:41:31 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39807 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJ3Olb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 10:41:31 -0400
Received: by mail-pl1-f175.google.com with SMTP id b5-v6so4345414pla.6
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 22:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=LqrsQmT7Y5RfK95zHpomc4n6Fr6I82a0ifppbNAKpgM=;
        b=ODjP21VpYPKwSHk43us5hb8AvvIskMJywag8DQS2BzSTSNTbIubLFez2uMLSC8JmOn
         gXXQIoGm3ZMFkPPiZ+a7iaaDO7wsBoDniZF2hkRi+pHxHsFirC43zBNUJQjcV2q9E7O1
         OwTFzXsoPfPMly3uQx49sOGmKP34/pD7gGVCCdVm8m8dOlH/zoX9N/fEOuRLWTCzWnj1
         fOny/TnzfhLp7TsinXN8c7eeNKzLl6XHXeC70qZhXBR7kGNU4jilmSGu/k/EqJxzeiNH
         i6uulh0+r4avzC8cHXTc4CgUB9Vc3MHQ+hVnSl0axEg8oZJLoT8Ospe4vPOCg5TUwibg
         ph7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:autocrypt:subject:to:cc:from
         :message-id;
        bh=LqrsQmT7Y5RfK95zHpomc4n6Fr6I82a0ifppbNAKpgM=;
        b=NQfmYg2f0aC9vs0LvonhnJeZWY1gIm9Hz8XLhcKqNzewC0vitYPkMdxn68grWpGQHg
         X1zqpg+I8F0EOqdFgP80++pduXN6bMFqRbQdKuVmki7u+kZtGLNkWrWJjLFxBeZp9rIF
         /SHeNfHg4s5OIiK0nu2TtH5Qp9FeLZTRIA7nGlL13N/eYWDZ+nvkhs+P78/dPeGU7q2N
         6HikTYBoWXk8Pfo7Dr2AKXBWdXsklaatn9czdJ2qRcNN0UFFdUBi4t1H7L3d8aHJ1sEs
         Q0IuublsGGewexFf3DYoQjSCGT2tDNoW+OlEAeVLDoQ7+G0jJFz9fjqKPOFg8amO1bQy
         Gxtw==
X-Gm-Message-State: AGRZ1gIy1NvgRCKj31c7NtSYcYuuN4i8WhC0p3yF+MRzmZY1NX2YaJ6D
        UgLNTFJtA6LsaSZQpTZRyAyYkzHy
X-Google-Smtp-Source: AJdET5dk9rnOQbuIo0Me8gAenihnwebdnXOf4v7tWOzQm26yqpDSiVWgLBfJlKVK/UEn8VsUp4CLWQ==
X-Received: by 2002:a17:902:244:: with SMTP id 62-v6mr1711810plc.280.1540878567571;
        Mon, 29 Oct 2018 22:49:27 -0700 (PDT)
Received: from [192.168.0.15] ([182.74.112.250])
        by smtp.gmail.com with ESMTPSA id s13-v6sm58141890pgs.76.2018.10.29.22.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 22:49:26 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:19:21 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqtvl40zbw.fsf@gitster-ct.c.googlers.com>
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet> <xmqqftwsdevm.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810291418300.4546@tvgsbejvaqbjf.bet> <xmqqftwo2nig.fsf@gitster-ct.c.googlers.com> <CAPig+cTJR4Qhqf_VVCihNW91tGt8Mbi2Oy99jzg8NmAksKoXVA@mail.gmail.com> <xmqqtvl40zbw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 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
Subject: Re: js/mingw-http-ssl, was Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <B2DC2561-6AA2-48F6-8CAF-3F864AE6F9DC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On 30 October 2018 11:07:39 GMT+05:30, Junio C Hamano <gitster@pobox=2Ecom=
> wrote:
>Eric Sunshine <sunshine@sunshineco=2Ecom> writes:
>>>     On platforms with recent cURL library, http=2EsslBackend
>configuration
>>>     variable can be used to choose different SSL backend at runtime=2E
>>
>> s/choose/& a/
>>
>>>     The Windows port uses this mechanism to switch between OpenSSL
>and
>>>     Secure Channel while talking over the HTTPS protocol=2E
>
>Thanks=2E
>
>By the way, I am beginning to like this phrasing quite a lot=2E  It
>encourages those with other ports like Linux and Mac to see if they
>want a similar runtime switching by singling out Windows port, which
>was what I wanted to achive with the original one, but I think the
>updated text does so more effectively=2E

The new phrasing seems to be reading quite better indeed=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
