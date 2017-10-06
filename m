Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C8F1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 16:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbdJFQVX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 12:21:23 -0400
Received: from mout.web.de ([212.227.15.14]:51176 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbdJFQVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 12:21:21 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTzc-1dtvlq39tA-00Sci5; Fri, 06
 Oct 2017 18:21:14 +0200
Subject: Re: [PATCH v2] fsck: handle NULL return of lookup_blob() and
 lookup_tree()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Martin Koegler <martin.koegler@chello.at>
References: <20171003102215.9952-1-szeder.dev@gmail.com>
 <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
 <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de>
 <6bbe21c0-024e-ceed-6076-25f2330e598d@web.de>
 <xmqq8tgpypyl.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <954958d2-5d5a-15e0-0e2b-421f859c1227@web.de>
Date:   Fri, 6 Oct 2017 18:21:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tgpypyl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:MVXQot3ZLfa8UDnv/LKy6px687efvfIQcLhJdX0KC6wU/5TDt/5
 HAm5moJdB3BMfcb/G8H4v0mXBj6WMmE0CWy8Gj1/hpvaGJhi8otRWXV3eatSToRWXj9uKvc
 uG/xdazrtLmI3IHiL8+PMB2sGfzN4/5JMC8UTFWbJJZ8TDsUEAPD6XYiZXOk9qJVm6DoLNF
 3+ah437gbIttEsOWVssYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e0DrZxPQSBw=:BqvG/FrFJg32R41ryTJ2/m
 DiVjT49z0cax90wkhQPNYD96LLd2Jp4st/tOSf4wBB4VBkTpXi8q6ynZCKXcCRughluqxqNVi
 Vs7faKqYc7mrKRgWkokclDvTiAFOD7W4SAVE5LEnqwWQZSfVnhIrbwEigpZGNu5zPFSVpm9/S
 0XtJRzix1nTusSbNV4K+bQ80grecV/WEh1EOgNEvw8OnzurmR3+TPPuDtcki5L70w4317PRZw
 1KbWxgnusLgV0/k3g+RNxiaizxEC+QaHHZZ8v/7wZNRQvbu8y01pxdivRsBbug1gPUiChgN7B
 AH+bsv0yF7z3VEWr6ZSGKUzY9hUEJnuTBQHiN8w5EdGbEGBnWrzrDubqC+vyYmfyuyZ6PNY4L
 yNEzZbeukjwBvc8RQBBC3U/IZ0gH5vNVGTKzdCK+tcNb7+ihKMiwzd3Q0oplkFBGyJ4kUTcDY
 48wrIER9mRbpXGlqFhP5N2zq4hduswLJy4B6KJt9ahxJz5eqNy1OMrURq1+pRZwuUlgLjJUeq
 4yonUlU7ZN9hkOcxC1qbGMiFwUEzc0FBCzEohQdkfXv0dbk4WqqBLa2MeSFZiqK3JVebNjow1
 Mv5pIFLkNJmYr26l/Y23RGWYd/qlfSr0O+HL7u4J/OBxlccBrMmoqYZZROFipj2TM2Rez2cC6
 5g3OyojoZ/f48vwZrjkvfnHf46RX8muEJmZ41xfLKjTfrhvEDVj6+b8Nv6uauXaULq/dsRudK
 yJ8WtIixWsV4I/TLfyezyND3d4esrVUpm7fkGnwSM2nuTG7lvpLNlQIJFuN7MOSHk/WXOAlmK
 eGDr7YtRbdv0Rx/Kdf5O1uhTxw7xmvMYYslRJ1JC5PNoLRETuQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.10.2017 um 04:23 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
>> +	blob_bin=$(echo $blob | hex2oct) &&
>> +	tree=$(
>> +		printf "40000 dir\0${blob_bin}100644 file\0${blob_bin}" |
> 
> Wow, that's ... cute.
> 
>> +		git hash-object -t tree --stdin -w --literally
> 
> Makes me curious why --literally is here.  Even if we let
> check_tree() called from index_mem() by taking the normal path,
> it wouldn't complain the type mismatch, I suspect.  I guess doing it
> this way is a future-proof against check_tree() getting tightened in
> the future, in which case I think it makes sense.
> 
> And for the same reason, hashing "--literally" like this patch does
> is a better solution than using "git mktree", which would have
> allowed us to avoid the hex2oct and instead feed the tree in a bit
> more human-readable way.

git mktree errors out already, complaining about the object type
mismatch.  But I added "--literally" only accidentally, when I copied
the invocation from a few lines up.  The test works fine without that
flag currently.  The flag captures the intent, however, of knowingly
building a flawed tree object.

René
