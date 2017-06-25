Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B0020401
	for <e@80x24.org>; Sun, 25 Jun 2017 04:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdFYEjl (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 00:39:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34809 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdFYEjk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 00:39:40 -0400
Received: by mail-it0-f65.google.com with SMTP id y134so10877170itc.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 21:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bw3q9tdtrkKVrK1SqwxKf56PuIh0h5bS9utB1YcyfnI=;
        b=PoPniVM7s3+f0puLTlLSks5wJECx7vaRQkT6KWwKpMAgQAJ8WXQKCUrBXuEIJp5xt5
         YXNn8e7tgt8LfFxViWOUeHnmHILIo5fctbl9qBwnh8pR9uxSYCifV489kM4FfEYDylAw
         9GfA/tchLGLyZddpyLasvaufVInabgDLDcOYmyu5i4yyo1UKr3VC/zJmkK3mN4h8OE29
         eAruOv5pDHda/LrFj/gauhdNd/KkGkrgTPiesmO/H6JcF8GOpY06uDwDo5osWLVuesTF
         ZXMgBzFx/23/ZYnonKd+Xfz112aStt9gyJV68pmuom47v1qEK5C7UCI8OH99+Rj70AFG
         Krrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bw3q9tdtrkKVrK1SqwxKf56PuIh0h5bS9utB1YcyfnI=;
        b=SQL0+mawLKHBDhC2g2eTtg65/jKnmz98svlef4Qd9hRko4vIoIEKnGZK3Kr/JNtAxn
         ak09AAJ9P8OI1hzbFjntGJrNmsA8kcFMym97LiNRp7fsvNszh/+bw4qJeMjHejppCD/k
         sFO346CdAZMycz6k43gNyuVhMQBnU4YC9Hn8/kbFoNYOg+cJcgUhixUehv3ZGHgEC5Ho
         3kNLRRSpGvCLtjJ7B6smdrksytnnqoac3oLb2JTTDXmrnKen0hBHJ4DLvxy2tvtWNavW
         C3GzLXsrAzNRRaV+iczAxBVc1vArmYYr5hXggvdra18ZH4Bujaga0forvS4MIBafs8Mq
         815g==
X-Gm-Message-State: AKS2vOxfrKUkg91RNYOSZ+Hs5yqyvbuohIdNhvf3DeA57+wSKJrIoqO/
        EApl/ID6HrxOCeQvRmiMf2HIlfEcrA==
X-Received: by 10.36.33.210 with SMTP id e201mr15658871ita.112.1498365579704;
 Sat, 24 Jun 2017 21:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Sat, 24 Jun 2017 21:39:39 -0700 (PDT)
In-Reply-To: <xmqqwp82bb39.fsf@gitster.mtv.corp.google.com>
References: <20170623151640.24082-1-chriscool@tuxfamily.org>
 <20170623151640.24082-3-chriscool@tuxfamily.org> <xmqqwp82bb39.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 25 Jun 2017 06:39:39 +0200
Message-ID: <CAP8UFD2QV-HkL+nwq+gvwE9V6TbuacioJwmcztNqGmF913Bo2A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t1700: make sure split-index respects core.sharedrepository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 12:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Add a few tests to check that both the split-index file and the
>> shared-index file are created using the right permissions when
>> core.sharedrepository is set.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  t/t1700-split-index.sh | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index af3ec0da5a..2c5be732e4 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -370,4 +370,21 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
>>       test $(ls .git/sharedindex.* | wc -l) -le 2
>>  '
>>
>> +while read -r mode modebits filename; do
>
> Style.

Fixed in the version (v3) I just sent.

> Running this twice in a loop would create two .git/sharedindex.*
> files in quick succession.  I do not think we want to assume that
> the filesystem timestamp can keep up with us to allow "ls -t" to
> work reliably in the second round (if there is a leftover shared
> index from previous test, even the first round may not catch the
> latest one).

Yeah, it might be a problem on some systems.

> How about doing each iteration this way instead?  Which might be a
> better solution to work around that.
>
>     - with core.sharedrepository set to false, force the index to be
>       unsplit; "index" will have the default unshared permission
>       bits (but we do not care what it is and no need to check it).
>
>     - remove any leftover sharedindex.*, if any.
>
>     - with core.sharedrepository set to whatever mode being tested,
>       do the adding to force split.
>
>     - test the permission of index file.
>
>     - test the permission of sharedindex.* file; there should be
>       only one instance, so erroring out when we see two or more is
>       also a good test.
>
> The last two steps may look like:
>
>         test_modebits .git/index >actual && test_cmp expect actual &&
>         shared=$(ls .git/sharedindex.*) &&
>         case "$shared" in
>         *" "*)
>                 # we have more than one???
>                 false ;;
>         *)
>                 test_modebits "shared" >actual &&
>                 test_cmp expect actual ;;
>         esac

Ok, it does what you suggest in v3.

Thanks.
