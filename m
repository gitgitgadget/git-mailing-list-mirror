Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D811F403
	for <e@80x24.org>; Wed, 20 Jun 2018 13:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeFTNNj (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 09:13:39 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43565 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFTNNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 09:13:38 -0400
Received: by mail-qt0-f195.google.com with SMTP id y89-v6so2817627qtd.10
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zzmmyBJyR32BNB6THO5BPZvZ1OGz4OQxvXA1/JX6KNs=;
        b=VrhWJkUjWmZWR4Fp7begL0C75ItwPsTe+PCCPbaEOS3krgc8wS1Wd4g/b4gnzI+zkU
         qUs2aY8ay95ZUN22HurybmQ6QXKiMpjAm/NvceZQq6+IRYnxoXWGZPInY1/CPslEroDo
         8IJTPOhQVvSGG8g0XOLMyg/Ef6WzmtVtfvKtzWevWTmDr9RZNbNxUa+w+oq+KpQVAj4+
         DccEzJOEGqytQ0CtaTnEKQwjUB4LQnufd95Sn3KU+8TeogEUt+dWer0CzHWMxGweHnS9
         8pvApZh6gpGDfjCDRH56XOADAE8eZcPU2ORpikq6UGutQzpGBGNPia/0HHoDMuwGasqq
         9Egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zzmmyBJyR32BNB6THO5BPZvZ1OGz4OQxvXA1/JX6KNs=;
        b=WMJrtb18Yo1iJON81UJsfSHePEvxu20IQ/8ipOPsBA8o3XZ7MVLnjIpgW+jD/30XSc
         Ct9dcZoau2sDc8XwOMHeiM8Y8nS8EIbGjpg8sT1cJukS832uNibCxklNV0zLwvnuBlCx
         J85owf3jhblOEFfOqJGaGcU6E8TVzJ0QnzwMsL/TsK67ny6qnu0yuBFT++teCY1hTK97
         NiUJ+I3Wx8uaa6gibD3MVhJ1I3TpvzJTw/f+ZOsWB0T6VXRrQRxI8P88LPqzgGjhyC3s
         p44OsG92s+qza2qTdtRwKjWn/TaK1MlUIjTS5PVbAMfBP23Fl7YfKF3/shpAd0bkFzsg
         qZWg==
X-Gm-Message-State: APt69E2csFaNQm9HqXODUS2x46gumwlq1PjzOharEaB8bg7vu8ptDJ8v
        LpuiyyFHJk362EYCxHOAoDA=
X-Google-Smtp-Source: ADUXVKL6b8+c8RIgKpCLchCC+zgBOUBqZw/WLb2mn4tSW9P0OALSYnWb5xeX2wPhyBBi4W/CcTVEpw==
X-Received: by 2002:ac8:2f2c:: with SMTP id j41-v6mr18813846qta.366.1529500418037;
        Wed, 20 Jun 2018 06:13:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:111c:d99:f232:cfaa? ([2001:4898:8010:0:fa51:d99:f232:cfaa])
        by smtp.gmail.com with ESMTPSA id y15-v6sm852612qky.11.2018.06.20.06.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 06:13:37 -0700 (PDT)
Subject: Re: [PATCH 06/23] midx: struct midxed_git and 'read' subcommand
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-7-dstolee@microsoft.com>
 <CACsJy8A3qVRXrQ9YiiN3Ggrcc5XFJWaWRrTbdO8E_48yRmzrqQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3827f4ce-7f78-6566-d9c8-1830afb3c09c@gmail.com>
Date:   Wed, 20 Jun 2018 09:13:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8A3qVRXrQ9YiiN3Ggrcc5XFJWaWRrTbdO8E_48yRmzrqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2018 1:54 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> As we build the multi-pack-index feature by adding chunks at a time,
>> we want to test that the data is being written correctly.
>>
>> Create struct midxed_git to store an in-memory representation of a
> A word play on 'packed_git'? Amusing. Some more descriptive name would
> be better though. midxed looks almost like random letters thrown
> together.

I'll use 'struct multi_pack_index'.

>
>> multi-pack-index and a memory-map of the binary file. Initialize this
>> struct in load_midxed_git(object_dir).
>> +static int read_midx_file(const char *object_dir)
>> +{
>> +       struct midxed_git *m = load_midxed_git(object_dir);
>> +
>> +       if (!m)
>> +               return 0;
> This looks like an error case, please don't just return zero,
> typically used to say "success". I don't know if this command stays
> "for debugging purposes" until the end. Of course in that case it does
> not really matter.

It is intended for debugging and testing. Generally, it is not an error 
to not have a MIDX in an object directory.

>> +struct midxed_git *load_midxed_git(const char *object_dir)
>> +{
>> +       struct midxed_git *m;
>> +       int fd;
>> +       struct stat st;
>> +       size_t midx_size;
>> +       void *midx_map;
>> +       const char *midx_name = get_midx_filename(object_dir);
> mem leak? This function returns allocated memory if I remember correctly.
>
>> +
>> +       fd = git_open(midx_name);
>> +       if (fd < 0)
>> +               return NULL;
> do an error_errno() so we know what went wrong at least.
>
>> +       if (fstat(fd, &st)) {
>> +               close(fd);
>> +               return NULL;
> same here, we should know why fstat() fails.
>
>> +       }
>> +       midx_size = xsize_t(st.st_size);
>> +
>> +       if (midx_size < MIDX_MIN_SIZE) {
>> +               close(fd);
>> +               die("multi-pack-index file %s is too small", midx_name);
> _()
>
> The use of die() should be discouraged though. Many people still try
> (or wish) to libify code and new die() does not help. I think error()
> here would be enough then you can return NULL. Or you can go fancier
> and store the error string in a strbuf like refs code.
>
>> +       }
>> +
>> +       midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
>> +
>> +       m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
>> +       strcpy(m->object_dir, object_dir);
>> +       m->data = midx_map;
>> +
>> +       m->signature = get_be32(m->data);
>> +       if (m->signature != MIDX_SIGNATURE) {
>> +               error("multi-pack-index signature %X does not match signature %X",
>> +                     m->signature, MIDX_SIGNATURE);
> _(). Maybe 0x%08x instead of %x
>
>> +               goto cleanup_fail;
>> +       }
>> +
>> +       m->version = *(m->data + 4);
> m->data[4] instead? shorter and easier to understand.
>
> Same comment on "*(m->data + x)" and error() without _() for the rest.
>
>> +       if (m->version != MIDX_VERSION) {
>> +               error("multi-pack-index version %d not recognized",
>> +                     m->version);
> _()
>> +               goto cleanup_fail;
>> +       }
>> +
>> +       m->hash_version = *(m->data + 5);
> m->data[5]
>
>> +cleanup_fail:
>> +       FREE_AND_NULL(m);
>> +       munmap(midx_map, midx_size);
>> +       close(fd);
>> +       exit(1);
> It's bad enough that you die() but exit() in this code seems too much.
> Please just return NULL and let the caller handle the error.

Will do.

>
>> diff --git a/midx.h b/midx.h
>> index 3a63673952..a1d18ed991 100644
>> --- a/midx.h
>> +++ b/midx.h
>> @@ -1,4 +1,13 @@
>> +#ifndef MIDX_H
>> +#define MIDX_H
>> +
>> +#include "git-compat-util.h"
>>   #include "cache.h"
>> +#include "object-store.h"
> I don't really think you need object-store here (git-compat-util.h
> too). "struct mixed_git;" would be enough for load_midxed_git
> declaration below.
>
>>   #include "packfile.h"
>>
>> +struct midxed_git *load_midxed_git(const char *object_dir);
>> +
>>   int write_midx_file(const char *object_dir);
>> +
>> +#endif
>> diff --git a/object-store.h b/object-store.h
>> index d683112fd7..77cb82621a 100644
>> --- a/object-store.h
>> +++ b/object-store.h
>> @@ -84,6 +84,25 @@ struct packed_git {
>>          char pack_name[FLEX_ARRAY]; /* more */
>>   };
>>
>> +struct midxed_git {
>> +       struct midxed_git *next;
> Do we really have multiple midx files?

There is one per object directory currently, but you may have one 
locally and one in each of your alternates. I do need to double-check 
that we populate this list later in the series. (And I'll remove it from 
this commit and save it for when it is needed.)

>
>> +
>> +       int fd;
>> +
>> +       const unsigned char *data;
>> +       size_t data_len;
>> +
>> +       uint32_t signature;
>> +       unsigned char version;
>> +       unsigned char hash_version;
>> +       unsigned char hash_len;
>> +       unsigned char num_chunks;
>> +       uint32_t num_packs;
>> +       uint32_t num_objects;
>> +
>> +       char object_dir[FLEX_ARRAY];
> Why do you need to keep object_dir when it could be easily retrieved
> when the repo is available?
>
>> +};
>> +
>>   struct raw_object_store {
>>          /*
>>           * Path to the repository's object store.

