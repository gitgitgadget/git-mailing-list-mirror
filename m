Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15FC1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 13:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeJaWCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 18:02:10 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:33323 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbeJaWCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 18:02:10 -0400
Received: by mail-qt1-f173.google.com with SMTP id i15-v6so17548315qtr.0
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tKbpqcdEdTZewQJ5QGk5RcWajfofnmS8wYx2OQ5nOsM=;
        b=JRep8rCXs/Cz8pjLTyMcts5BxsM3yMJC1YqX37sET4WTr1kZ/YQMWze2/bzB9d3hpI
         RAlsJ7j5XSttMnNZn6fwZaXErgMAr+v+21ltpVp1RT+qitUjk2zoLSNepExgANpDiv08
         roElzJu3hruwcViQCKLmQLIPt9D/EL/HL1Dtty7e0VlXOnmZ+Ow4G/CESnXhJ8cm+8v9
         4o+F7+ne24FihANiA0aBkzFl8jHZFEaf8RgrnZP96XD2ZPANnDo7UomI3JK4DlQd1fSo
         c99Jtxy1fc78oGfBcbFrB/6jCJI25m++NYM/MOcd5JYqXEnO8AjyMCH9hGxtrCniJVSD
         iyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tKbpqcdEdTZewQJ5QGk5RcWajfofnmS8wYx2OQ5nOsM=;
        b=K1fmQNa5tvkW+/16Iq1xOPo2AW+lkPLbr5d39fpYTRdUhvZkMGg33JOPUKgoUg0qqL
         6ppK/VxslQlGwiJ5IfkwMmH5b4Do4xCN5kBH17KdnsOwmYQUhOw4hGJDeAvfHSBaOif8
         hi1pn6w/b8PEEGU55HT0IRQUjzYb21DHHKKLzSHolZ4PzoQMMcpeUf+IeIB3ZFZKm70Z
         +AdyTcrpXd9g1Pw03h4fXExFDxONBNQ1rQhQyP93S3Qc1pkFGaGZaVgMvreJMHjodr0R
         oMpW/zbcdvqDGFerI+vVj9et6bAPpS4wGHD+7CGpybhgBsltksUj9PotR4F4DiOhqTx7
         FFGA==
X-Gm-Message-State: AGRZ1gJHzmmCfvbT6gBtAXbi/CRKDzHOlyYEHo1gSMJhgEZFF0XBMTm6
        P/He4yZX7Jcd/1rQWiT2+qI=
X-Google-Smtp-Source: AJdET5f4MALVybIDefmALO0D8zSCK79mcr8Eu4/O86DK01jdjCLNOSay8L0GXobQ0g7xdLnbPpAD6Q==
X-Received: by 2002:aed:2558:: with SMTP id w24mr2518527qtc.183.1540991052516;
        Wed, 31 Oct 2018 06:04:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1547:f48:38e6:a522? ([2001:4898:8010:0:fe7c:f48:38e6:a522])
        by smtp.gmail.com with ESMTPSA id i35-v6sm15565745qtb.16.2018.10.31.06.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:04:11 -0700 (PDT)
Subject: Re: [RFC] Generation Number v2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
 <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
 <875zxil1if.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6902dbff-d9f6-e897-2c20-d0cb47a50795@gmail.com>
Date:   Wed, 31 Oct 2018 09:04:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <875zxil1if.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31/2018 8:54 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Oct 30 2018, Junio C Hamano wrote:
>
>> Derrick Stolee <stolee@gmail.com> writes:
>>> In contrast, maximum generation numbers and corrected commit
>>> dates both performed quite well. They are frequently the top
>>> two performing indexes, and rarely significantly different.
>>>
>>> The trade-off here now seems to be: which _property_ is more important,
>>> locally-computable or backwards-compatible?
>> Nice summary.
>>
>> As I already said, I personally do not think being compatible with
>> currently deployed clients is important at all (primarily because I
>> still consider the whole thing experimental), and there is a clear
>> way forward once we correct the mistake of not having a version
>> number in the file format that tells the updated clients to ignore
>> the generation numbers.  For longer term viability, we should pick
>> something that is immutable, reproducible, computable with minimum
>> input---all of which would lead to being incrementally computable, I
>> would think.
> I think it depends on what we mean by backwards compatibility. None of
> our docs are saying this is experimental right now, just that it's
> opt-in like so many other git-config(1) options.
>
> So if we mean breaking backwards compatibility in that we'll write a new
> file or clobber the existing one with a version older clients can't use
> as an optimization, fine.
>
> But it would be bad to produce a hard error on older clients, but
> avoiding that seems as easy as just creating a "commit-graph2" file in
> .git/objects/info/.

Well, we have a 1-byte version number following the "CGPH" header in
the commit-graph file, and clients will ignore the commit-graph file
if that number is not "1". My hope for backwards-compatibility was
to avoid incrementing this value and instead use the unused 8th byte.

However, it appears that we are destined to increment that version
number, anyway. Here is my list for what needs to be in the next
version of the commit-graph file format:

1. A four-byte hash version.

2. File incrementality (split commit-graph).

3. Reachability Index versioning

Most of these changes will happen in the file header. The chunks
themselves don't need to change, but some chunks may be added that
only make sense in v2 commit-graphs.

Thanks,
-Stolee
