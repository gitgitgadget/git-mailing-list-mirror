Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2E81F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeKTXxq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:53:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35515 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeKTXxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:53:46 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so2773793qka.2
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 05:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WThpzlvhOQumMVMGcboizsT3SmSuODsCt4qJJHT+V/k=;
        b=a98H03GZCyk3R7Qy4WPjgikZExHvwdgWhAVmvCzRwI2NjIcdKu698IPk7y0hq+CGMy
         5huPcHMyzSkT2p+TdF4KPV0HqFsGpAaw2hq1z+fpUeYVYg289/r7FLhkAYgZp7gwBPPC
         p3M8hDjBH4sbFHHU0sw45oO4dnBX+/TaDDIhZLt5MGHYjF6LuJ6+5o8yVJNffdVYF94i
         dquR/sY/uPGIs7Hx1BUFajeQo+DYhxOu9Gi8PKhD2vBCRt7XoZMYCc4b0UpAPMp3up3N
         35kDTtj1FvEzMHAtD0D1HpfdnLQXx25Cwcj9Q0UcF7uDbLAJU4LqCvFhCLjxgGCEUPAg
         mCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WThpzlvhOQumMVMGcboizsT3SmSuODsCt4qJJHT+V/k=;
        b=gdoReiyG7MupUg4i0knsfe5i6jT30X8tnSkNbRnXLK0/rkcGZW0yy7sgOP8KtiVm4J
         UTSA2PwL/KhAEaoSsrjoCVZF7U9Vewzueab+CV/WErqGizhFtRw5EAAu8NE2H5TImrBD
         DdgioF7KuNLTrIuLdjSDIaw4YNSdRGSvsC1Um8eYKo35i9LjnGL1V4K77NlWPBLTAprc
         podSO07vtwoYjoUJS0BzIxp2naniEufLG9B3niu8VMEqwK8c0AahIW+yx/zTgXjHZ5Sf
         FFYfinORhXpvCMv6Kjy+yrzTel3mdbQKhSjLPGSMjaSty1hSZD0RltzyAcvzjjsSuoa4
         hNDw==
X-Gm-Message-State: AA+aEWaTXXORSJfDJg0a945lJUuygRCBm2erJABBdY/MDl3l1b9dn4Mu
        9EtrDxLTP9OwtGy7lXtr6mY=
X-Google-Smtp-Source: AFSGD/UJEG1IOcMNL6t5uV7622X2WyvaQhSk5fEdQ/3oketxZS4gMdqBvuv6Vj5DBTHuyrELE3w9cA==
X-Received: by 2002:a37:54a:: with SMTP id 71mr1659770qkf.253.1542720278483;
        Tue, 20 Nov 2018 05:24:38 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id i65sm28203462qkh.49.2018.11.20.05.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:24:37 -0800 (PST)
Subject: Re: [PATCH 4/5] index: make index.threads=true enable ieot and eoie
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com> <20181120061426.GE144753@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f4c28f3f-f3e0-8a23-ea12-70b4fef5d96c@gmail.com>
Date:   Tue, 20 Nov 2018 08:24:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181120061426.GE144753@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/2018 1:14 AM, Jonathan Nieder wrote:
> If a user explicitly sets
> 
> 	[index]
> 		threads = true
> 
> to read the index using multiple threads, ensure that index writes
> include the offset table by default to make that possible.  This
> ensures that the user's intent of turning on threading is respected.
> 
> In other words, permit the following configurations:
> 
> - index.threads and index.recordOffsetTable unspecified: do not write
>    the offset table yet (to avoid alarming the user with "ignoring IEOT
>    extension" messages when an older version of Git accesses the
>    repository) but do make use of multiple threads to read the index if
>    the supporting offset table is present.
> 
>    This can also be requested explicitly by setting index.threads=true,
>    0, or >1 and index.recordOffsetTable=false.
> 
> - index.threads=false or 1: do not write the offset table, and do not
>    make use of the offset table.
> 
>    One can set index.recordOffsetTable=false as well, to be more
>    explicit.
> 
> - index.threads=true, 0, or >1 and index.recordOffsetTable unspecified:
>    write the offset table and make use of threads at read time.
> 
>    This can also be requested by setting index.threads=true, 0, >1, or
>    unspecified and index.recordOffsetTable=true.
> 
> Fortunately the complication is temporary: once most Git installations
> have upgraded to a version with support for the IEOT and EOIE
> extensions, we can flip the defaults for index.recordEndOfIndexEntries
> and index.recordOffsetTable to true and eliminate the settings.
> 

This looks good.  I think this provides good default behavior while 
enabling fine grained control to those who want/need it.

I'm looking forward to the day when we can turn it back on by default so 
that people can take advantage of the speed improvements.

