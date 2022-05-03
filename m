Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0209C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 06:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiECGpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiECGpm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 02:45:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CCEE6B
        for <git@vger.kernel.org>; Mon,  2 May 2022 23:42:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n14so7341590plf.3
        for <git@vger.kernel.org>; Mon, 02 May 2022 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vgs/V2xpAvGJaycCEFS3357XqLZMF0iR+1KEGlsbzjc=;
        b=Q2QfT4TqqlqGgEHksfCKDXreTmSl22yWbfhCiKVkuJAOMgElBEACFOrdZ6eZR/RKoc
         Yyl1hHovAqNeeo9t1f8Vh9RpfP141zben/Tc8ulRYM0KRJRUkxBpO5IDg7c9/jfvhLaa
         W7jbMvHpuRvb+JrMp5OKC7VUac3Ia1+nfKyrQiOlSLvqBzHFA8HNB75yExjynvpl0myp
         2ephG2+g5+hChk99rgOi9bzgsWZZOZGKc3mtbOxJDNyBJxG0WeYeA3ZKwNJe33t5G1r5
         QgrXvCIT++cwCTpMnpPkvBEZi0b0tRME3WNYmsY3p6k/Xzkc4+dnuNLPaWj5/efuePL6
         XV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vgs/V2xpAvGJaycCEFS3357XqLZMF0iR+1KEGlsbzjc=;
        b=Rw9liKZHtZqZt+XHqKn0uosEV9hXzgstO2DAfK8Jw7q6UB7eiDA6QdZPJV8snDkOgf
         B2wv9aD2OImOncQ06XZhxnqOyVGtiUfViz2bqcvbIj9vmgGRcx9hnf40W/HGIPnoi/2i
         a6mpTdku1kOaW6wok2JunEJa7dg1ThsYCeU5FKgFS9vo7Y8gEc17I12WHOK79qIpdA9j
         e1cDSMbWUFAOCYw6+LlSd3Gn8ZbmNjYt1gJUtWVbSuZoogjl+Pe7lOv0oh9ygBRdLwTD
         qXyCAqsvP1d4Z0qCTYG0HVnZd38cMxnJKKuW4ICv81hpKDBaWhIkXbxcuEycJ1B+ELCg
         AE/A==
X-Gm-Message-State: AOAM531S1168/vTryLMg52A1IDJEyHHYNHo1+S3Y9yKESf79OlDc6tWI
        N/oteGusaSQ+zAp/315FcaBTU+lYI6s=
X-Google-Smtp-Source: ABdhPJx8uW711p3Hy5R8hj2Nyv4zHi/PDsYzpS95yzE2WqlQYOLCS7c/bWV0puZ2Js66+qIaUxSimg==
X-Received: by 2002:a17:90b:2311:b0:1d9:2e43:c7ae with SMTP id mt17-20020a17090b231100b001d92e43c7aemr3150733pjb.47.1651560130983;
        Mon, 02 May 2022 23:42:10 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a630200b001d5c571f487sm725810pjj.25.2022.05.02.23.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 23:42:10 -0700 (PDT)
Message-ID: <bcb069c7-f104-a494-1862-30709dc6f8a0@gmail.com>
Date:   Tue, 3 May 2022 13:42:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Incorrect branch information after fetching (local branch !=
 remote branch)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <9b3a9023-cd73-2e9d-64f1-7cc7e53d9b54@gmail.com>
 <xmqq7d73rwnq.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqq7d73rwnq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/22 12:51, Junio C Hamano wrote:
> The verbose report left by "git fetch" tells us what branch they
> have is used to update what branch we have, so I think this is
> pretty much expected.
> 
> I am puzzled by your mention of 'net-next' (local).
> 
> You may have
> 
>     [branch "net-next"]
>         remote = net-next
> 	merge = master
> 
> and that is where your expectation on the local may be coming from,
> but it wouldn't be all that relevant to "git fetch". The update of
> the local branch will happen long after "git fetch" is done.
> 

Ah I see.

So the left-hand side of verbose report (local branch) is actually
the value of branch."net-next".merge, right?

-- 
An old man doll... just what I always wanted! - Clara
