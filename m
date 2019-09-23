Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F68F1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 21:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502930AbfIWVM5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 17:12:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35738 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbfIWVM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 17:12:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id a24so8721680pgj.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EwFsuT9BzkOv/azBmbgN+9rThKqr6ZTzZ7YvU+iRFRw=;
        b=ZZN91Auj/8Pk7yR/pExanCSfJx9LqmDmyfuEnUhW1Fm6RSu1mP3XAlOqSjvLrAOglT
         am3hdrO8RMf99xR46SUyb6y+5sCnkGOmv458VwjBXsPhMu2I8TUDjCL1Kmga6KVTYAVr
         XYut6u3GkMQRJktu9Hp+KWSmQOqTSRkVXFTtUx9LWuDCfxPI3FvJhTUTsu9eJ44/6eSD
         iFwZY6G+g2LWg9Iv67hksglIUDQLFw7YrUS6CkNwsTXaiPsi5Fx28Yhho27duQ1gvsFF
         Edn52KOJFmdul599kybGHOfFfTGc511JpuN3R17FLBr4LZ/8XXoNpTIKUwe/kGxULPQg
         ImeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EwFsuT9BzkOv/azBmbgN+9rThKqr6ZTzZ7YvU+iRFRw=;
        b=LNaAjOZF1svZL1tiQMwIX0ezxa1pDbu8hWXUlg77D/LrW7hxjDbrJCiBgQODB9oWMc
         BoxOM5itwic/RAvzUaMUyDuVhAsGyd18EIqxizY6+7pODkPHcsqm+MiA3XF/gkj7l/my
         khnCvO//AAHjsfEcqfuYAZBKtGIIn2T5fHZvaXIZrPSOKhFXgjEr9bdipDrgMZMkZhHG
         TEJblF1oyPCCExzuo5JmKJ1LVm76gAztTiXsJzHs1uzzdeeG6yCLdtYq2AoPjw/xY5cn
         7OwuLcg4O1Fei6HXgfvLVoZZOrQc6sPreWsiQZyEI/3D8EyurA8sLjtQOdQIwqKHbxpE
         oCSQ==
X-Gm-Message-State: APjAAAXlNa/qI9tTqo2jvkETEm2IgBGn+j3tV4EUb4nQhJZutY9n7xoL
        30jtHy94He5ffNbfXijpvr0=
X-Google-Smtp-Source: APXvYqxruPcgxGr/zicyo1fVU7w3g/A69HroNw2WmC402HVN7OjUTul5KFfnrQKTU96/za0yj9xbag==
X-Received: by 2002:a62:870a:: with SMTP id i10mr1682090pfe.259.1569273176963;
        Mon, 23 Sep 2019 14:12:56 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:8:549d:4edf:133b:7cbf])
        by smtp.gmail.com with ESMTPSA id 26sm13709454pjg.21.2019.09.23.14.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:12:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] midx: add progress to write_midx_file Add progress
 to write_midx_file. Progress is displayed when the MIDX_PROGRESS flag is set.
To:     Junio C Hamano <gitster@pobox.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <3bc8677ea7655a3706914f9753c0a3b79dbf7e1f.1568998427.git.gitgitgadget@gmail.com>
 <xmqqlfuiu3sv.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <373fc8e9-2ef3-d501-b6e0-b953e047ac78@gmail.com>
Date:   Mon, 23 Sep 2019 14:12:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfuiu3sv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/19 1:10 PM, Junio C Hamano wrote:
>> diff --git a/midx.c b/midx.c
>> index b2673f52e8..54e4e93b2b 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -449,6 +449,8 @@ struct pack_list {
>>  	uint32_t nr;
>>  	uint32_t alloc;
>>  	struct multi_pack_index *m;
>> +	struct progress *progress;
>> +	uint32_t pack_paths_checked;
>>  };
> 
> What is the reason behind u32 here?  Do we want to be consistently
> limited to 4G on all platforms?
> 
> I have a feeling that we do not care too deeply all that much for
> the purpose of progress output, in which case, just an ordinary
> "unsigned" may be much less misleading.

I went with u32 here to match the data type used to track how many
entries are in the pack_list ('nr' is a u32).

I could switch to this to an unsigned but we would run the (extremely
unlikely) risk of having more than 65k packs on a system where
unsigned is 16 bits.

> FWIW, the function that uses this field is display_progress(), which
> takes uint64_t there.

Thanks for pointing this out.  Given that display_progress() expects a
u64 using that type here for 'pack_paths_checked' could help make things
more straightforward.

-William
