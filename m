Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519BD1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 17:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeHVU2o (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 16:28:44 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52376 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeHVU2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 16:28:44 -0400
Received: by mail-wm0-f47.google.com with SMTP id y139-v6so2643933wmc.2
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B0p3eEqRmi2bL4q9l3vJ94DCZm0wT83AyxbWt+RnXjw=;
        b=lMrBOUkvO9KzKvgWVaGdy+mTsQ37i9+440ww0Oebmhre9Bu4F3Bg+lJtj9PnP6AAEz
         JXQI0yaCBVW6X4ZYJ6j1uGmZMWy/CMNP5zPXMxk5uqAcxjCehPyIiGzCgfnEw6aZPXsG
         tYsDccwzL8ItgR8kRbPiqSq6AbDraaS2AT8tUr8dmyiih8Dt2mpN0EDOgHwQJ1tDNt8x
         5pn62qsx1n6MMfkJIokkz1Qya5jK2ytsmYv1qJuqpZRG/VG6vnhSBTVGsBCr3B7/DwsJ
         R/w9g/l04h/0nP+ujhVKaZ3B+2Dk516Cvyk6FxpyzLYEUk/LWXqP2ALE9xyHq5StZ6tp
         CmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B0p3eEqRmi2bL4q9l3vJ94DCZm0wT83AyxbWt+RnXjw=;
        b=FybEycMBOGjSTWlEfjTHpFK5jkJeL8hQOS+xYhNnusKsw8CjMXOCMIqAwW/pu0JVWU
         ae1GaMem5iFfYhRiPyyS0DOkb+hk8LNFj+StUBVeFoS2mNgpSZSwXWeOZoXKKBXhx+q0
         Hv/ccgMoCn7WYrgOu+QEhxMezBbmpV+UAX2vt3EjIio0t2RNjnvaYew71qP2R8zW3Jkh
         +eampWlfmmbJJqKewuWcOBp9WQRBVD0jfXcjGOfkuugxyL/qFT4ehbi3w6isCi2gzGKW
         cWlcKdps2wVtd5px1QQjrsb97A64ssSk0Bsi8FlvzGf5DYIVZNuGSWaPBWfs6cI3gVEC
         pSPA==
X-Gm-Message-State: APzg51BU+OkHpbd6Tr6JLagnaQ4BWkliNl+/Mrm8VaX+4gS4b8MgN2t3
        RzE9uCa87zwSVoj2wDLEeS4=
X-Google-Smtp-Source: ANB0VdYwgB3fMkeS/Q23VnILPRoLoa0g+BNaWTPxqzF9mJxIvqhGEd/ljlJnkAibkK9VhSbRo9vsgg==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr2756019wma.128.1534957381520;
        Wed, 22 Aug 2018 10:03:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm2932431wmd.7.2018.08.22.10.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 10:03:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
References: <20180822030344.GA14684@sigill.intra.peff.net>
        <20180822053626.GB535143@genre.crustytoothpaste.net>
        <20180822060735.GA13195@sigill.intra.peff.net>
        <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
        <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com>
        <20180822151703.GB32630@sigill.intra.peff.net>
        <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
        <CACsJy8DifmYtDE4D58yVM7rYhfJFe8p-t9bXgMmMsw=txxmzHA@mail.gmail.com>
        <20180822162609.GA11904@sigill.intra.peff.net>
        <7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com>
        <20180822165923.GA14878@sigill.intra.peff.net>
Date:   Wed, 22 Aug 2018 10:02:59 -0700
In-Reply-To: <20180822165923.GA14878@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 22 Aug 2018 12:59:23 -0400")
Message-ID: <xmqqtvnmmj0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 22, 2018 at 12:49:34PM -0400, Derrick Stolee wrote:
>
>> > Yes, that was what I meant. We actually did switch to that hand-rolled
>> > loop, but later we went back to memcmp in 0b006014c8 (hashcmp: use
>> > memcmp instead of open-coded loop, 2017-08-09).
>> 
>> Looking at that commit, I'm surprised the old logic was just a for
>> loop, instead of a word-based approach, such as the following:
>> [...]
>> +struct object_id_20 {
>> +       uint64_t data0;
>> +       uint64_t data1;
>> +       uint32_t data2;
>> +};
>> +
>>  static inline int hashcmp(const unsigned char *sha1, const unsigned char
>> *sha2)
>>  {
>> -       return memcmp(sha1, sha2, the_hash_algo->rawsz);
>> +       if (the_hash_algo->rawsz == 20) {
>> +               struct object_id_20 *obj1 = (struct object_id_20 *)sha1;
>> +               struct object_id_20 *obj2 = (struct object_id_20 *)sha2;
>
> I wonder if you're potentially running afoul of alignment requirements
> here.

Yup, and I think that all was discussed in that old thread ;-)
