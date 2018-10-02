Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9121F453
	for <e@80x24.org>; Tue,  2 Oct 2018 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJBV5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:57:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43918 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeJBV5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:57:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so2282260qtq.10
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Kx/EiZqVomhFsCPzoMZjM5pdgvJAXjIPQqqJwbpJHQ=;
        b=CVqXhRJZpDSau5UhYdgpGu/uUlnoXDxIjtgtZYSH0f1nzwHtU6Onk4hWKP7XCYrzcK
         RjzsxzI3CyYiODgeULUrCQBYjk6EwdA335fWlpKhYilEM3q4hWee/DF+y59B7sMLYt5D
         gXhxdHCONuOju1jGf5CuEvE0wvuBhEDvuEkirdyilS/egz7f5HGdz+nsJnAuz31zjePw
         UiMRm0+V/6lh3kFhAnIoLet0mVGC6uwk+T7Y3mj4JrPFtlbPt039BvmbnKBLLDNcwRfV
         jiRk2Jh3rdtImXFNRKzl2JxRcw/a7upfUoDoAO5VflcWTrw3NruMpAGvYH7UNzSwSXih
         WtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Kx/EiZqVomhFsCPzoMZjM5pdgvJAXjIPQqqJwbpJHQ=;
        b=STc1zcTsqdDKChB/1TJ5IheFwTcx4zEhFtqISs9HOOLAn9qHGGeYl/hhgs8fkNSppk
         Xnr4Q4IgFDGM4r2FS2f1KxLg1hmwJQNiUVZigN26eyW7a2lRr8lZlplSRnGYrDW9rE1P
         qcrJuxX6LG/VEmIPWpc/L5qX0I1aIyxoOOR9hjfw1ndAVttU0MT7fuGVHW1STLW2g+Mm
         1zk3MbksYEo2SUTTkJoYgN8Y6dq62vPuWR5VjpD9WL4WSE5Pc8zrx1GbQOfuSUptjsf6
         0F/KZZ+4qlpgpRlcK+rtMjUSPKaA4KtAG9bg0TytGdfoyVFHRX26yyKFbKJgIRa2L0M3
         f+Og==
X-Gm-Message-State: ABuFfoh3tQgSrYVYHyJqhSHK/Bw8ddnwXX4JwT+hPzykx5vjiUATt2Vx
        U1Iyhk3tlh9G4LOXNAj0Jxw=
X-Google-Smtp-Source: ACcGV60dxzaY4lLYa5UW+NnHghIRo8PCD3BaBfJHjYBiwBVUVv0hVQTa8c0KQTOxRHDcTmm/ex0sLg==
X-Received: by 2002:ac8:32c9:: with SMTP id a9-v6mr12978758qtb.41.1538493188417;
        Tue, 02 Oct 2018 08:13:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id r82-v6sm11806913qkh.28.2018.10.02.08.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:13:07 -0700 (PDT)
Subject: Re: [PATCH v7 3/7] eoie: add End of Index Entry (EOIE) extension
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
 <20181001134556.33232-4-peartben@gmail.com>
 <CACsJy8CX0TwVydzmqsjHK+W7tcaDgRCgeU3Gmc-bA1Ecf=Yz6A@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <424326cc-0cfe-3af8-d2f7-6c124cb077cd@gmail.com>
Date:   Tue, 2 Oct 2018 11:13:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CX0TwVydzmqsjHK+W7tcaDgRCgeU3Gmc-bA1Ecf=Yz6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/1/2018 11:30 AM, Duy Nguyen wrote:
> On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
>> @@ -2479,6 +2491,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>          if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
>>                  return -1;
>>
>> +       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> 
> Note, lseek() could in theory return -1 on error. Looking at the error
> code list in the man page it's pretty unlikely though, unless
> 

Good catch. I'll add the logic to check for an error.

>> +static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
>> +{
>> +       /*
>> +        * The end of index entries (EOIE) extension is guaranteed to be last
>> +        * so that it can be found by scanning backwards from the EOF.
>> +        *
>> +        * "EOIE"
>> +        * <4-byte length>
>> +        * <4-byte offset>
>> +        * <20-byte hash>
>> +        */
>> +       const char *index, *eoie;
>> +       uint32_t extsize;
>> +       size_t offset, src_offset;
>> +       unsigned char hash[GIT_MAX_RAWSZ];
>> +       git_hash_ctx c;
>> +
>> +       /* ensure we have an index big enough to contain an EOIE extension */
>> +       if (mmap_size < sizeof(struct cache_header) + EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)
> 
> Using sizeof() for on-disk structures could be dangerous because you
> don't know how much padding there could be (I'm not sure if it's
> actually specified in the C language spec). I've checked, on at least
> x86 and amd64, sizeof(struct cache_header) is 12 bytes, but I don't
> know if there are any crazy architectures out there that set higher
> padding.
> 

This must be safe as the same code has been in do_read_index() and 
verify_index_from() for a long time.
