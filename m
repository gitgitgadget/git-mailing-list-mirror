Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA341F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeGaTMy (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:12:54 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:41951 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeGaTMy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:12:54 -0400
Received: by mail-qt0-f174.google.com with SMTP id e19-v6so16811942qtp.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a2QLZaJL8tqKOwCaGhDJyClUIqatHIN1ci6HjD+EM+A=;
        b=TNmAUYMAkcZtqOTR2fP33jHH0/uWSXywKfLcm3MlKGkIFiXe7FfC4wRKSbmtJ1Wm+E
         83pHbk3mAfdDZg7i3mSrXOQAPaWWUbwjm292icX2bquU0jltoRjkTA7U+mvDv5WAy/er
         MbRjwfBbZ1xxWEM9TeShLmH7fMR5AJGAC+E6eliaDEW+Lwq9h1TWlN4ctn1yUynVnLus
         eri7LQQyh34kyXjW82FRI/Z2xMQ6P2E0B5SXQJMi4Fxq10c8QQTMyTwpgIA39ksOFbma
         9U6EBGS2gWII6JwckPm8o8O6w4eIHTkmGBjk4dreHTRtvZJY6VZKooGz5VlZ4SZQsWaI
         YOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2QLZaJL8tqKOwCaGhDJyClUIqatHIN1ci6HjD+EM+A=;
        b=NHtUZ2akV6ToaEfpykLpXQBi1uHscjGWA+m5Qv9uOBkJAyCP7wm6CnsjUz5dPcrAxt
         T7DCVl/zlkTMUNP2bFyuPI8I7jRWoEeV+eR4XyRzd/3ht9k+iWjmbekSybMzQFrWR5kJ
         ONJix+rp8gWO7WyBIxBVlQaWBsAWELvNXJLimMNAkFF+c0YIoVw5tvNN5ohb4QdnEQHC
         thrSIDT+1GM+OVDEz2+eyMgst14q2rKLrK6fPgUIs15Q0HcB3uLfnW+CLTyTAjDRQLBt
         rD2C5vxpRV/Hb4ksLf2C/cl0UDzqRLlj7ZirNodI8dlPJeumImYG2AcU0QAN+K1Wq4Aq
         +Z+A==
X-Gm-Message-State: AOUpUlHfQvbOk6O/k4AP97zwhnhY43JtGND9cVFeF9/44Jsc799KKt9A
        5UFe8kFPD2ebZtHhyt/HtgU=
X-Google-Smtp-Source: AAOMgpftWk3kkplq3UVhppOd9y+5FFBewlVaCbBGTwMGd/S76taYTfJuYn44fQd9+f0QZdajaRBJhQ==
X-Received: by 2002:a0c:96eb:: with SMTP id b40-v6mr20229446qvd.235.1533058293334;
        Tue, 31 Jul 2018 10:31:33 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l5-v6sm9409049qte.20.2018.07.31.10.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:31:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Speed up unpack_trees()
From:   Ben Peart <peartben@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
 <9a9a309c-7143-e642-cfd8-6df76e77995a@gmail.com>
 <CACsJy8BUBjPngHz=icHomor-LJOkMLwZ9bQ6YJDxnoXGg++vjg@mail.gmail.com>
 <cc3c4dbb-d545-6a6c-b20e-6a8ca66fc210@gmail.com>
Message-ID: <57d146a2-9bf8-66c9-9cb4-c05f93b63319@gmail.com>
Date:   Tue, 31 Jul 2018 13:31:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cc3c4dbb-d545-6a6c-b20e-6a8ca66fc210@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/31/2018 12:50 PM, Ben Peart wrote:
> 
> 
> On 7/31/2018 11:31 AM, Duy Nguyen wrote:

>>
>>> In the performance game of whack-a-mole, that call to repair cache-tree
>>> is now looking quite expensive...
>>
>> Yeah and I think we can whack that mole too. I did some measurement.
>> Best case possible, we just need to scan through two indexes (one with
>> many good cache-tree, one with no cache-tree), compare and copy
>> cache-tree over. The scanning takes like 1% time of current repair
>> step and I suspect it's the hashing that takes most of the time. Of
>> course real world won't have such nice numbers, but I guess we could
>> maybe half cache-tree update/repair time.
>>
> 
> I have some great profiling tools available so will take a look at this 
> next and see exactly where the time is being spent.

Good instincts.  In cache_tree_update, the heavy hitter is definitely 
hash_object_file followed by has_object_file.

Name                               	Inc %	     Inc
+ git!cache_tree_update            	 12.4	   4,935
|+ git!update_one                  	 11.8	   4,706
| + git!update_one                 	 11.8	   4,706
|  + git!hash_object_file          	  6.1	   2,406
|  + git!has_object_file           	  2.0	     813
|  + OTHER <<vcruntime140d!strchr>>	  0.5	     203
|  + git!strbuf_addf               	  0.4	     155
|  + git!strbuf_release            	  0.4	     143
|  + git!strbuf_add                	  0.3	     121
|  + OTHER <<vcruntime140d!memcmp>>	  0.2	      93
|  + git!strbuf_grow               	  0.1	      25
