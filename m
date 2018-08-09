Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B221F405
	for <e@80x24.org>; Thu,  9 Aug 2018 13:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeHIPzn (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 11:55:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39946 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIPzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 11:55:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so5159573wrs.7
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zuaWWAHXFc91xn1ChxcBMaZYDmFFyyYdOke6K0PsH1U=;
        b=OZJWQ2Ge1Oa1UwL5Afw8EmvE9vYABDdxUmLYTJSEGsRSaVeJq0A64y1OaQH6vIKpXk
         JDGATy97EvpLk5hGmMGUQulmo9ZtjSATA0g3nmYvL8Je93gyaqMykXKbKGjC/kXWZ/xe
         NQRcCWqjrlwlgh0xVrrZAgVuQw03pG4775UiCbT/UlljC3tqQgaVVC8G330WJiRD+cBf
         CHxsACeUWidEUHp2QiGvijiUfIV8KVssOuRty9EOOve5ouSMO/GzA7y0S8pzsLrpZS5C
         Yqg1+vfrIIGbZGfhosF62Kuwy+dLsz1HfTCY1W8J+5VGxfDujzcvcZ6namhyDtz0uxd8
         VWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zuaWWAHXFc91xn1ChxcBMaZYDmFFyyYdOke6K0PsH1U=;
        b=UWDqSm4ZbrmwGNofkfsrY2NSF+Qo+OLKn6yMuuJ/+ZAp24cRTrK4Hd62FTiW0i8R1N
         bulnTkfI8kax74QtolI0+f1ndcJ8EoWZb6N/TqdzQ5rMgEAdGGCW1yhbj6uDF2IEhw9J
         HszK/qhE635jPg4DxYyIr4hcRedQs234Vy47V88ggTskj1WvK2Wr+kFpZeg5GveEivHP
         F56rBuc+YN+H2qBdlZ2TF4povl+B084krV+sopJQwg9UcI8oxjZmt8lzQ11fI7j6R43S
         Tl2jR4+jXrsCIQsmLKUjwxIXtjusuTLDvgvfDouO8f0hWzwaEcjmt4+VA6batm1JK2UJ
         OVig==
X-Gm-Message-State: AOUpUlFcbR7hZDpe1agyIkhYDoLPYeOCIHqCtTz0EuI0yAmA0qs19rDq
        ObO20KBlJsCSAsibSVWPo7g=
X-Google-Smtp-Source: AA+uWPy5HwI7To7V+ghn0l1eS1UuVSPjsSqaSYQiZruh5YN/JiOybzkRZvc1p1+ihIZTm+gzHJDR3Q==
X-Received: by 2002:adf:a211:: with SMTP id p17-v6mr1502455wra.196.1533821446258;
        Thu, 09 Aug 2018 06:30:46 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-30-228.w86-222.abo.wanadoo.fr. [86.222.29.228])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7778440wru.93.2018.08.09.06.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 06:30:45 -0700 (PDT)
Subject: Re: [GSoC][PATCH v5 04/20] rebase -i: rewrite the edit-todo
 functionality in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-5-alban.gruin@gmail.com>
 <325fd5d2-2a93-2270-7d1e-394c265f42d4@talktalk.net>
 <6826d318-b0ab-4e8e-e2ba-5425e3bf6f5f@gmail.com>
 <75549397-9080-3b5a-8655-cea04065b2eb@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <bc07317b-ba44-7a3c-7cb4-504b7dbc7c34@gmail.com>
Date:   Thu, 9 Aug 2018 15:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <75549397-9080-3b5a-8655-cea04065b2eb@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 08/08/2018 à 18:04, Phillip Wood a écrit :
>>>> +int edit_todo_list(unsigned flags)
>>>> +{
>>>> +    struct strbuf buf = STRBUF_INIT;
>>>> +    const char *todo_file = rebase_path_todo();
>>>> +    FILE *todo;
>>>> +
>>>> +    if (strbuf_read_file(&buf, todo_file, 0) < 0)
>>>> +        return error_errno(_("could not read '%s'."), todo_file);
>>>> +
>>>> +    strbuf_stripspace(&buf, 1);
>>>> +    todo = fopen_or_warn(todo_file, "w");
>>>
>>> This truncates the existing file, if there are any errors writing the
>>> new one then the user has lost the old one. write_message() in
>>> sequencer.c avoids this problem by writing a new file and then renaming
>>> it if the write is successful, maybe it is worth exporting it so it can
>>> be used elsewhere.
>>>
>>>> +    if (!todo) {
>>>> +        strbuf_release(&buf);
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    strbuf_write(&buf, todo);
>>>> +    fclose(todo);
>>>
>>> There needs to be some error checking after the write and the close
>>> (using write_message() would mean you only have to check for errors in
>>> one place)
>>>
>>
>> Right.  Should I find a new nawe for write_message()?
> 
> That might be a good idea, I'm not sure what it should be though, maybe
> write_file()?, perhaps someone else might have a better suggestion.
> 

write_file() already exists in wrapper.c.  I wondered, as this make use
of the lockfile API, perhaps it could be moved to lockfile.{c,h}, and
renamed to something like write_file_with_lock().

Cheers,
Alban

