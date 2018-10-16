Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406451F453
	for <e@80x24.org>; Tue, 16 Oct 2018 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeJPXwV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:52:21 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39614 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:52:21 -0400
Received: by mail-ua1-f67.google.com with SMTP id f12so3562248uan.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LTFYI6aoisOidqPaLEV8GvIFMgWjMTKro3vzprnepqE=;
        b=q6X9fslQj8CO/XZplOusswA/Qc4SJN1ARXiQuN/f99asaJHSvH+RqxQFA+RdITVUIm
         3G0AfdiRrnFCB2I4BBlhhXB/XggY0WFpYGgsCy49uAo3jlsUSsF9dMw0xJSC2cEreh2u
         HVY57lA19Nq7Bcu+j2wlSJ4GmiKi6vz01P/F80KGOcJSMN+J7OSET/BSir3/uwR47FIz
         DBTABqWptyvd0G6IMN2vWEMFnOaOF+/Y5R6ru++/US5EYooL0AZy8ulkb8mZ0vKwt6yo
         qK8InmKPoDu1hhbWkOqmccdfmkmSYJ2Zhrl9lnC4EsKQc406lDwC3aBny1m8KYQeycw3
         IRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LTFYI6aoisOidqPaLEV8GvIFMgWjMTKro3vzprnepqE=;
        b=DpDGKvJ71BO07AIcZfjV5r0NCW64CXQstAAcTzpSxZZlxEwCwevBlcHIQ3ybu3qD9B
         0sL+OzD8TZrlG14HHdyQTWvAktByGLKbhPeeeGQs6DlKTkM39O/FekMU37bQeTRnfvO3
         OcxXzTuFUbBxeyUR0GGeJglBqB0qocznitg0WiBExYwJxxfD7bGVrLcGHaKVlMco+EAZ
         0wTN15o7IUFbGsWIEjpspZbWlW7MR8NwfJFjwjdOGt4YMImx+GBJnvNaSDjzV51vZJP1
         3bhsvv4s1isryFq9LldbYwitp27gBZMlOgTi/b4bMiCoMPWaQyE8at9KuxPIuq266aYz
         pGgw==
X-Gm-Message-State: ABuFfoipFecZDiGyOz1mMY4oTsrWPCj94TAQ68Xz0uULqmeLgp5vHTIt
        DwtXPaOnbncLUaqDPRzP50A=
X-Google-Smtp-Source: ACcGV63EkD17VFo+t5ENIWbKBuziHn9AQk7o9XIVGltLo2/86lkHAPOUO/Pp0TfGNFThuUj5NFM3Rg==
X-Received: by 2002:ab0:73d7:: with SMTP id m23mr9782759uaq.128.1539705674222;
        Tue, 16 Oct 2018 09:01:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:293d:4c41:9115:1167? ([2001:4898:8010:0:1273:4c41:9115:1167])
        by smtp.gmail.com with ESMTPSA id z73sm1460766vsc.16.2018.10.16.09.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 09:01:13 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
To:     Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
 <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com>
Date:   Tue, 16 Oct 2018 12:01:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2018 11:35 AM, Duy Nguyen wrote:
> On Mon, Oct 15, 2018 at 4:23 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> Since the commit-graph code wants to serialize the hash algorithm into
>> the data store, specify a version number for each supported algorithm.
>> Note that we don't use the values of the constants themselves, as they
>> are internal and could change in the future.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>>   commit-graph.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 7a28fbb03f..e587c21bb6 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
>>
>>   static uint8_t oid_version(void)
>>   {
>> -       return 1;
>> +       switch (hash_algo_by_ptr(the_hash_algo)) {
>> +               case GIT_HASH_SHA1:
>> +                       return 1;
>> +               case GIT_HASH_SHA256:
>> +                       return 2;
> Should we just increase this field to uint32_t and store format_id
> instead? That will keep oid version unique in all data formats.
Both the commit-graph and multi-pack-index store a single byte for the 
hash version, so that ship has sailed (without incrementing the full 
file version number in each format).

It may be good to make this method accessible to both formats. I'm not 
sure if Brian's branch is built on top of the multi-pack-index code. 
Probably best to see if ds/multi-pack-verify is in the history.

Thanks,
-Stolee
