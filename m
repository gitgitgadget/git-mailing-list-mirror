Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881E02095B
	for <e@80x24.org>; Mon, 20 Mar 2017 14:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbdCTO3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 10:29:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49844 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754295AbdCTO3K (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 10:29:10 -0400
X-AuditID: 1207440e-ccbff7000000340b-b1-58cfe73322fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 94.35.13323.337EFC85; Mon, 20 Mar 2017 10:29:08 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KET43M002938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 10:29:05 -0400
Subject: Re: [PATCH v6 17/27] refs: move submodule code out of files-backend.c
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-18-pclouds@gmail.com>
 <3738362d-6c76-cba7-824a-d689bbe290c6@alum.mit.edu>
 <CACsJy8CHjSMV1qOAB-7-F562jx+3XKtQOjuPOFz0wu-pYR3aeA@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <77d37131-535d-c4ed-0785-1b7cf91f01ad@alum.mit.edu>
Date:   Mon, 20 Mar 2017 15:29:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CHjSMV1qOAB-7-F562jx+3XKtQOjuPOFz0wu-pYR3aeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1DV5fj7CYPIKSYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZXSsqyx4xFnx4vhVxgbG7+xdjJwcEgImEmu/NLF1MXJx
        CAnsYJL4fOcNSxcjB5BzgUniBxNIjbCAn8T+Kd2sILaIgJLEm45tzBD1fUwSB+bcBWtmFpjF
        JHFx7yI2kCo2AV2JRT3NYN28AvYSX9ZeB9vGIqAqsXTVF7C4qECIxJyFDxghagQlTs58AraY
        UyBQ4s5/sHJmAXWJP/MuMUPY8hLb385hnsDIPwtJxywkZbOQlC1gZF7FKJeYU5qrm5uYmVOc
        mqxbnJyYl5dapGusl5tZopeaUrqJERLofDsY29fLHGIU4GBU4uFdceV8hBBrYllxZe4hRkkO
        JiVR3qe3gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeI1BcrwpiZVVqUX5MClpDhYlcV61Jep+
        QgLpiSWp2ampBalFMFkZDg4lCV7RR0CNgkWp6akVaZk5JQhpJg5OkOE8QMObQGp4iwsSc4sz
        0yHypxgVpcR53zwASgiAJDJK8+B6YYnoFaM40CvCvGtB2nmASQyu+xXQYCagwctunAEZXJKI
        kJJqYIyJfWf5yfViT3xJ/O7p77P8dje/CV94hFHN5oza6QeGhTlOf1MWxEUe0IuxPv51Y2OY
        jmHX9cc77YVz+6bezZhuUbHV51PEmWtqCxzvfn905XfJ8xeP7NtaN0QZTQtYp3b4b2nz+f8P
        fTVmzvDSKxbb/HrG3B+Nzg4yZ49lXxU65+CosGLb5glKLMUZiYZazEXFiQC5oh0WHwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20/2017 01:09 PM, Duy Nguyen wrote:
> On Mon, Mar 20, 2017 at 4:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> [...]
>>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>>> index f732473e1d..dfa1817929 100644
>>> --- a/refs/refs-internal.h
>>> +++ b/refs/refs-internal.h
>>> @@ -482,12 +482,11 @@ struct ref_store;
>>>  /* refs backends */
>>>
>>>  /*
>>> - * Initialize the ref_store for the specified submodule, or for the
>>> - * main repository if submodule == NULL. These functions should call
>>> - * base_ref_store_init() to initialize the shared part of the
>>> - * ref_store and to record the ref_store for later lookup.
>>> + * Initialize the ref_store for the specified gitdir. These functions
>>> + * should call base_ref_store_init() to initialize the shared part of
>>> + * the ref_store and to record the ref_store for later lookup.
>>
>> Maybe mention that the function will make its own copy of `gitdir`?
> 
> I would think that's the default/sane behavior and not need to be
> mentioned? A function that keeps a pointer even after it exits, now
> that's something that must be documented.

I guess you're right, and I hope that everybody really documents such cases.

Michael

