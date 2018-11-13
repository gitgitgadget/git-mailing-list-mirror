Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55AA51F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeKNBYb (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:24:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40249 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbeKNBYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:24:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so20011367qki.7
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UuEJmwQNyXFdy61Ckk7R4UqgpkVaqRr//sAeNcTwPfk=;
        b=fVe8cRuNQj97iWqbjLzPmL//TYeNhXqH/wlHG0U+VJiYqaZKbLGU/gh2nQXrh7Jg3k
         HOhkulMXcFKMfGUAKYco3KHjklZh78ZQyFtPkktBOj9ckUXyo6fNT6lv6Ptk4vSu/WgA
         Xyiwmd0ol0SuS15ajjUU4pkco7gn/spLQXgibOzQuoU+ZseILcvy5vtqQMV7QrloOc2j
         7/bC/wcSzzL+5eaDb+OH+0PiBHqLGRGc49tkVtwqgUUSPd13Yn47VzRVuqmbr5l6mfxq
         vSd4ZHwSudbPf/Lilm5IqR1rTh8fgz+7bLcg4NGd8hApiS2WXC9QN3kfAun7N6ww67tt
         FVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UuEJmwQNyXFdy61Ckk7R4UqgpkVaqRr//sAeNcTwPfk=;
        b=Zs7xAELZhUOgvyRf9bhSvR7isFKXkC6ojZcYQQf3hG+0XvUNcEH8Ryydx4/0mFisXv
         ykGr9DDB1mpX6wCgXdw59EZSzfyuGdnph9vU7WwWcfW4UH1V4P0IGzOjXX52fMcwh0Ud
         Q2Nc3Tb+f+Seq8ALqzcvzaQ/pwtQ7xpdjEXJqq4l4k4OFp6O+zTX1W/uQEbIv1FMf5Iw
         BpqXu7/NKQundl2yk0E7fkaagKiaCfTIbuw2NxJHQuxY6vy1BDK2/hm7dnZc/e4lt4lc
         BAaLfL3+lKVAwHj5AtW93pxZ3ST2H9LWRMaE/SMD0wKjPpwmjObIj8evpiuUu7zggYOz
         laHQ==
X-Gm-Message-State: AGRZ1gKJpkacINaHTaL89n5k+Hog6P7s7Cn24ptC3h8VoJYGALg2Y/pd
        TkYRiuzNVKHgl+MsV7EAAO0hq7Ij
X-Google-Smtp-Source: AJdET5cdH9tyjoFPIaUnNMs36X3L9tvwzH8oFgh9XY3fmcHorPb4g53kB58WZNj/kHxFbjfkrkjePw==
X-Received: by 2002:ac8:2bd4:: with SMTP id n20mr5375001qtn.172.1542122754117;
        Tue, 13 Nov 2018 07:25:54 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h67-v6sm9845293qkf.32.2018.11.13.07.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:25:53 -0800 (PST)
Subject: Re: [PATCH 3/3] index: do not warn about unrecognized extensions
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113004019.GD170017@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8e7c3e05-ae60-0801-ab2d-5ead02192695@gmail.com>
Date:   Tue, 13 Nov 2018 10:25:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113004019.GD170017@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/12/2018 7:40 PM, Jonathan Nieder wrote:
> Documentation/technical/index-format explains:
> 
>       4-byte extension signature. If the first byte is 'A'..'Z' the
>       extension is optional and can be ignored.
> 
> This allows gracefully introducing a new index extension without
> having to rely on all readers having support for it.  Mandatory
> extensions start with a lowercase letter and optional ones start with
> a capital.  Thus the versions of Git acting on a shared local
> repository do not have to upgrade in lockstep.
> 
> We almost obey that convention, but there is a problem: when
> encountering an unrecognized optional extension, we write
> 
> 	ignoring FNCY extension
> 
> to stderr, which alarms users.  This means that in practice we have
> had to introduce index extensions in two steps: first add read
> support, and then a while later, start writing by default.  This
> delays when users can benefit from improvements to the index format.
> 
> We cannot change the past, but for index extensions of the future,
> there is a straightforward improvement: silence that message except
> when tracing.  This way, the message is still available when
> debugging, but in everyday use it does not show up so (once most Git
> users have this patch) we can turn on new optional extensions right
> away without alarming people.
> 

The best patch of the bunch. Glad to see it.

I'm fine with doing this via advise.unknownIndexExtension as well.  Who 
knows, someone may actually want to see this and not have tracing turned 
on.  I don't know who but it is possible :-)

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thanks for reading.  Thoughts?
> 
> Sincerely,
> Jonathan
> 
>   read-cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 290bd54708..65530a68c2 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1720,7 +1720,7 @@ static int read_index_extension(struct index_state *istate,
>   		if (*ext < 'A' || 'Z' < *ext)
>   			return error("index uses %.4s extension, which we do not understand",
>   				     ext);
> -		fprintf(stderr, "ignoring %.4s extension\n", ext);
> +		trace_printf("ignoring %.4s extension\n", ext);
>   		break;
>   	}
>   	return 0;
> 
