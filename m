Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2159A1F62D
	for <e@80x24.org>; Thu,  5 Jul 2018 19:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeGETNL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 15:13:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44861 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeGETNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 15:13:09 -0400
Received: by mail-qt0-f193.google.com with SMTP id b15-v6so8025517qtp.11
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=diQeU/bgALHm0yfJjM6cX4rbj6iimv+099SiORQkXcQ=;
        b=vN8tyvR/QQisXqIAo8l0hmw1DDmpVBQIKmIDtY15airUoj5vFyQrkmcVdMv/X4mcDC
         cn/RtOIuelKXr9SBya5K881dHq5sIhRS8hYTEOAAIyNOcPjQ8SeoK2FRIJF0hnNxBXPg
         i7ANpDVwKt405hGjEnzRzcMTVy+pUX+Izundf7Y1YdsT4KHu8gLewOxmbsEdlfTmd3DR
         F3yD7n4yeSwLHNn4M2epcp8AJ+4MhlvLwTvVeKwQtZKZNby5YeghmrvzNaWwCERUPIMf
         TaBYgKMMzp0cQzzbWMY55dedoM8sXZg5d9zi5owQK1Gm5MlPfteoOMiGfPjDIJANjkCh
         jGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=diQeU/bgALHm0yfJjM6cX4rbj6iimv+099SiORQkXcQ=;
        b=o8gw+jI9ZJPfxROTHkMAdQnOXbt0JY3w4q8oqwAXcFcl7vr92NafRVcY4kB1OUaK4g
         xF1odsVtW0gSrVJHXv79Cc+9vivGXzxVsMcO1BZLKtC4uzXgXgr+4YaNB3IxIJa044NM
         V9e0+bDDF5pgeFngMcje0Q3e6vjf0yu6BKJGR780qhIakQOrZkzjHZ/agIxegoRWOxSd
         7yUytaCo4d94+sRfA+TtR5WXN0mvB5PKasJxq9jTIHKs/xi8eC0K/d9+B3kAcQRT1JOD
         Y2DEMX6llWtTbnZ37+LNqv9btRAlm0gu+wPriiVk0qA2feCcK+t8QMGLTrPWgoV3QRrT
         CwGw==
X-Gm-Message-State: APt69E1swY7qxqyjpp/RpnRelAyhvYB0oUIPqomd53oIBxnKgKodAnIm
        BzdShD/3CbV9HC86FrL3TjQ=
X-Google-Smtp-Source: AAOMgpe6kxaPnN/BtO921RFgu5RvAHzU0BCaQUyvp8Xnmuc/c2vRs3p7Kng0rOCI7Uax/YGEzf5hYw==
X-Received: by 2002:ac8:25f1:: with SMTP id f46-v6mr6692490qtf.20.1530817989093;
        Thu, 05 Jul 2018 12:13:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a959:39a8:fc10:2939? ([2001:4898:8010:0:928f:39a8:fc10:2939])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4451633qku.3.2018.07.05.12.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 12:13:08 -0700 (PDT)
Subject: Re: [PATCH v2 05/24] midx: write header information to lockfile
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
 <20180625143434.89044-6-dstolee@microsoft.com>
 <xmqqmuvioeqq.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <41812292-3f1e-adaa-3faa-33f5e8f8e47a@gmail.com>
Date:   Thu, 5 Jul 2018 15:13:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqmuvioeqq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/25/2018 3:19 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> +#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>> +#define MIDX_VERSION 1
>> +#define MIDX_HASH_VERSION 1
>> +#define MIDX_HEADER_SIZE 12
>> +
>> +static char *get_midx_filename(const char *object_dir)
>> +{
>> +	return xstrfmt("%s/pack/multi-pack-index", object_dir);
>> +}
>> +
>> +static size_t write_midx_header(struct hashfile *f,
>> +				unsigned char num_chunks,
>> +				uint32_t num_packs)
>> +{
>> +	unsigned char byte_values[4];
>> +	hashwrite_be32(f, MIDX_SIGNATURE);
> WARNING: Missing a blank line after declarations
> #48: FILE: midx.c:21:
> +       unsigned char byte_values[4];
> +       hashwrite_be32(f, MIDX_SIGNATURE);
>
>> +	byte_values[0] = MIDX_VERSION;
>> +	byte_values[1] = MIDX_HASH_VERSION;
>> +	byte_values[2] = num_chunks;
>> +	byte_values[3] = 0; /* unused */
>> +	hashwrite(f, byte_values, sizeof(byte_values));
>> +	hashwrite_be32(f, num_packs);
>> +
>> +	return MIDX_HEADER_SIZE;
>> +}
>> +
>>   int write_midx_file(const char *object_dir)
>>   {
>> +	unsigned char num_chunks = 0;
>> +	char *midx_name;
>> +	struct hashfile *f;
>> +	struct lock_file lk;
>> +
>> +	midx_name = get_midx_filename(object_dir);
>> +	if (safe_create_leading_directories(midx_name)) {
>> +		UNLEAK(midx_name);
>> +		die_errno(_("unable to create leading directories of %s"),
>> +			  midx_name);
>> +	}
>> +
>> +	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>> +	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>> +	FREE_AND_NULL(midx_name);
> I am not sure why people prefer FREE_AND_NULL over free() for things
> like this.  It is on stack; it's not like this is a static variable
> visible after this function returns or anything like that.

I default to FREE_AND_NULL(X) because a later change may introduce logic 
to use X later in the same code block. In this case, we add a 'cleanup:' 
at the end which would fail in a success case if we don't set midx_name 
to NULL here.

I think there are some other FREE_AND_NULLs that are currently at the 
end of a code block, so I'll work to clean those up.

>
>> +	write_midx_header(f, num_chunks, 0);
>> +
>> +	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>> +	commit_lock_file(&lk);
>> +
>>   	return 0;
>>   }
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> index ec3ddbe79c..8622a7cdce 100755
>> --- a/t/t5319-multi-pack-index.sh
>> +++ b/t/t5319-multi-pack-index.sh
>> @@ -4,7 +4,8 @@ test_description='multi-pack-indexes'
>>   . ./test-lib.sh
>>   
>>   test_expect_success 'write midx with no packs' '
>> -	git multi-pack-index --object-dir=. write
>> +	git multi-pack-index --object-dir=. write &&
>> +	test_path_is_file pack/multi-pack-index
>>   '
>>   
>>   test_done

