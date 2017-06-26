Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19E1207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 15:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdFZPtL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 11:49:11 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33571 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdFZPtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 11:49:09 -0400
Received: by mail-pg0-f48.google.com with SMTP id f127so2181705pgc.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TwXj16m6Cf0xbPOY0ergMKj0mU8BRefNd4XKzMyO/lc=;
        b=ihitac17BhDtBcTANtSrKptwd/l2hbxxnbQx77hlIgGLZT9VTxwKnOZvhq3ys4R7xC
         fV/vmuz0aqWApswycoxjZd0uw4QFa9dHfD7mHFq7ehIzAxtLgNgWOdHwg6GM2O8pQTdf
         WzJoSWnDNxCwuFlQKKKHYqVhP3xXFH84KAINZAWkhLBx8dFFd2ZpOeBdX6x3wBjt2Hph
         TUrB2az6ErSCp4q3qOYcJVsTGcuG27EW4i8pvhvqTugVmxx9WfrtjrIrQczpBuTrKWKB
         CUokBXu2kq53FEZhV7Iz0U48bUKE3I46lZWhlqHTZZ5yMnXa0UxMj4PP30RjrMO7oM79
         qY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TwXj16m6Cf0xbPOY0ergMKj0mU8BRefNd4XKzMyO/lc=;
        b=VMFBS1Pri6MSP3B9uSm8XXHuZheMlp/0ZS3BCS+DwJ0YTqu/5yjwNFKR4JAkWGhxNu
         M3J7GGFxTQm7f05osXgeGqo+q+2jjiC7oo13dreU0w6J2cWN5AEe6mmthgCEX+OeUhxN
         o2HPUZSB8wLrdc6Tdvk5Aia9veGF7zdgSRnTTNhM0DUt4/8BoIBRt1ve02l7d5kH6+O4
         YZToEnCBMgi/L6eXK0EunWfptqiYyfOEv5CMsvx7anCenkj1T7P5UBPHGo2vtcHKAJYf
         i/NCAq2KVV80XrSOpSdem7JyLxBgmTvOJOVC3caL8QuJNo6c4xAjl6/Ce3nlqLbuGgly
         SNMQ==
X-Gm-Message-State: AKS2vOzIu/12yjqucbtMl98mlVg0Bfc7hWyFNQwbCLAePsC95aJzJNcZ
        05yrTEyzaKKg5g==
X-Received: by 10.101.69.135 with SMTP id o7mr759469pgq.242.1498492148839;
        Mon, 26 Jun 2017 08:49:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id r63sm641136pgr.65.2017.06.26.08.49.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 08:49:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #07; Sat, 24)
References: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com>
        <BDD05B04-C845-43B5-8E22-D215403D2A6E@gmail.com>
        <87k23zccc2.fsf@gmail.com>
        <D0D3C60B-84E3-431B-A600-546ABA1D1209@gmail.com>
Date:   Mon, 26 Jun 2017 08:49:07 -0700
In-Reply-To: <D0D3C60B-84E3-431B-A600-546ABA1D1209@gmail.com> (Lars
        Schneider's message of "Mon, 26 Jun 2017 11:54:16 +0200")
Message-ID: <xmqq8tke7nrg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 26 Jun 2017, at 11:44, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> 
>> If we're cloning the submodule, which from this output, and AFAIK in
>> general happens with all Travis builds, but correct me if I'm wrong
>> we'll set DC_SHA1_SUBMODULE=auto due to this bit in the Makefile:
>> 
>>    ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
>>    DC_SHA1_SUBMODULE = auto
>>    endif
>> 
>> So if (and I think this is the case) Travis just does a clone with
>> --recurse-submodules then this is already being CI'd.
>
> Do you see some other way to check if this is part of the build?
> Would it make sense to add this info to "git --version --build-options"?
>
> I am not familiar with the SHA1 machinery... but does it work on macOS
> even though we generally use APPLE_COMMON_CRYPTO?

I thought that we allowed "Use apple-common-crypto for the real
openssl thing (like curl and imaps) but use the hash function from
this other thing (like block-sha/)" and was hoping that we can test
sha1dc/ and/or sha1collisiondetection/ with that mechanism.

OTOH, if the binary packaged one on MacOS uses everything from
apple-common-crypto, then not testing with that gives us a larger
coverage gap, so unless we add a _new_ target that uses sha1dc/ on
MacOS, it may not worth be worrying about.

