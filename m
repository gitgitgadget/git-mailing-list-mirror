Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8874B1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934687AbeGFTUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:20:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34862 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933150AbeGFTUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:20:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id h40-v6so5135314wrh.2
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CSsD83MOtq+MfY+gFvt9wc4kHeWu0AX794lVDZjjOL4=;
        b=j5pnwZmZ+Q8cMTfJfPFfUsjZePhtF8pClZsvluPNzeO9mvO6pFCsbJZWPOqOsv888I
         es/V/cr08mTvdcClyTqXNgvN5fA3JqwFSe70/d0xNlXf7z8Y85uur3LbUvY0wFsKH9D3
         /13F7X+5gfxpqWTr5mATEvNBDsfUUM/TaHe2/xNZdQNN1jKiQblU3Ipu0tmeQTORMobt
         VE3oX2QiTT7oboQ05q0I7BLdV6PbfRx3tfA1eaTxlVC1FXLJFoVFP/nnfKm2dTZhCrB1
         6fDQ+Oxo4RzEsL2rhzz264nszNNPcP86Won8n62EJhtR8QtzMpQf+XecYCZj1d/xkPFJ
         61Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CSsD83MOtq+MfY+gFvt9wc4kHeWu0AX794lVDZjjOL4=;
        b=tlqkgBew2HpJfuHFL4hV+56CN/3k8PbFZ/Jg/1ANZQKnok1uI+vKQXK5KOCsDUKmgx
         gCjp+0ODVRdLas10rAfRKRfKi3qH0YU+yytmLL5TfXtqx4g3qgVvj6yPs6VqJjy6oHaJ
         2R+JDhI6gDjCR+gKfJdDjj25hv50MCW9/JeilvamGXG2c6shJ7QyXIHGCazeaUpQXEwy
         KXIPF5RE/JVGu0wCebF2miUXHL5JZOqzQ1Ty2xs4kY0xq6Y/UaDC/3nQnJBicKVBioEn
         yreKMaYy/kSCgESp9pPZivwq6XCGWjzuvhwY2YU2i33KggM+twR2z41XIcnc6R4R16z6
         tT8A==
X-Gm-Message-State: APt69E2uWkhhEsyc7Ju0efM1abs1tz4HDRER8CRTTdsGG+ealarrxiGt
        xWldkdVReazzxfR6Ev/SlQk=
X-Google-Smtp-Source: AAOMgpfJTTbJLNgM1WejTw+Myi91cNRRcdE1vVO523mHYFTbJ/rwgmx99qfjSyygjR2aINDb+A5spQ==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr8816843wrb.127.1530904831908;
        Fri, 06 Jul 2018 12:20:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 5-v6sm19155336wmv.48.2018.07.06.12.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:20:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/24] multi-pack-index: load into memory
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180625143434.89044-1-dstolee@microsoft.com>
        <20180625143434.89044-7-dstolee@microsoft.com>
        <xmqqfu1aodw3.fsf@gitster-ct.c.googlers.com>
        <2bb2a12f-f22d-990b-636c-73b2b805d12d@gmail.com>
        <CAPig+cTVD5OpVnxAqQnO_CkzFRRkZ3YWsRC4ZwUmAELSZzcDKw@mail.gmail.com>
Date:   Fri, 06 Jul 2018 12:20:30 -0700
In-Reply-To: <CAPig+cTVD5OpVnxAqQnO_CkzFRRkZ3YWsRC4ZwUmAELSZzcDKw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 5 Jul 2018 14:58:22 -0400")
Message-ID: <xmqq601skw75.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 5, 2018 at 10:20 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 6/25/2018 3:38 PM, Junio C Hamano wrote:
>> While I don't use substitutions in this patch, I do use them in later
>> patches. Here is the final version of this method:
>>
>> midx_read_expect () {
>>          NUM_PACKS=$1
>>          NUM_OBJECTS=$2
>>          NUM_CHUNKS=$3
>>          EXTRA_CHUNKS="$5"
>>          cat >expect <<-\EOF
>>          header: 4d494458 1 $NUM_CHUNKS $NUM_PACKS
>>          chunks: pack_names oid_fanout oid_lookup
>> object_offsets$EXTRA_CHUNKS
>>          num_objects: $NUM_OBJECTS
>>          packs:
>>          EOF
>>
>> Using <<-\EOF causes these substitutions to fail. Is there a different
>> way I should construct this method?
>
> When you need to interpolate variables into the here-doc, use <<-EOF;
> when you don't, use <<-\EOF.

I think what was said is "in an early step there is no need to
interpolate but the same here-doc will need substitution in a later
step, and that is why I started an early step with a form without
quoting", which is different from "when should I use the form with
and without quoting?"

I think a reasonable response would have been "then please do use
the quoted form in the early step to help reviewers to let them know
there is not yet any substitutions, and then switch to quote-less form
at the step that starts needing substitution.  That way, reviewers can
see the test started to become "interesting" by interpolating variable
bits in the test vector by seeing the line with "<<EOF" appear in
the patch as modified".


