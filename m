Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9DF61F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJLD1l (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 23:27:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43661 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJLD1k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 23:27:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so11007153wrt.10
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SUeL0ar9AWZwWNtZZih3ZZVdVjD863K4cfkA6XAdtF8=;
        b=iD5OnLSU45jSKyunxrhRzPI4YD2bzGgk9LFY/x36OXlZcsciO8q7P6TcI4rsU8laBd
         kIAxrCeGIOztdHUrWDiOBijuKdEOQOuwbs7y9kosxsCuuXhbbhvfBAoK5a1yP5pNAHWJ
         OLzzoz5pFzpIF6eXhv1LRb1j4gcFkN5rrlrePnLq5iv92fFuI+M1TB2zrhVRaP/JnaJ3
         1UE0xIgDh/Bl+UUXpHs2ZgNhGLGGdw3sewKMsIyvlRHCQ+7mCwnwyGqsJNzwE0hNU27H
         YQfCIc2xnNaUHN0sI+i7Pffn8g36EjqhCYrChumiggm5zzJdWCr2yTVt6N4YFEYEwfBq
         hHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SUeL0ar9AWZwWNtZZih3ZZVdVjD863K4cfkA6XAdtF8=;
        b=iTr9JQ7M8yIPZM/TXa+F2qAugYQ4cbXoCU380e5l/hVd6Vf9Em6RGQ3oBTpruLf/Ys
         4cl7NBYEz9Va/5QDPlB+30cNewqkepUSOjViqQl84mnRlVCwP7/yZel6C+rS3XLZwNCb
         gc2sZN8dEmxvbmPMlw8mn3L7O1l9gQqSn67PlJbWZPR2y2G7jwQ28n9Q92IoDlt3PlQm
         +3RZxMDnu/BcqvVBTDwoApWmWkM/m2ks4d1yUgN2vRXbEN+8SPR+EqJqNFH0hVL0AHWD
         aMfLU3DLXrXpMBaX39LXVsnEUvAqvk/MF0sl0lmyWUPIdxzviPcTMxG/JTIKK6Tn6h42
         Kn6w==
X-Gm-Message-State: ABuFfogfp4bwp9BZTSWnU1+RySB+aD2m463tnuGpodrVb4sl9PqcVBqA
        mbWKFEKWCtrzs70dWzrsjB0=
X-Google-Smtp-Source: ACcGV61oUfDytzlnuEvHRgEctYlgGIaixEwn/oII8dj7HLx5BsrVXdqs9lmsXg8dxCwX7k2IK+RDsQ==
X-Received: by 2002:adf:9367:: with SMTP id 94-v6mr2945474wro.211.1539287931402;
        Thu, 11 Oct 2018 12:58:51 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.gmail.com with ESMTPSA id e133-v6sm27307569wma.42.2018.10.11.12.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:58:50 -0700 (PDT)
Subject: Re: [PATCH 10/15] rebase-interactive: use todo_list_transform() in
 edit_todo_list()
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-11-alban.gruin@gmail.com>
 <f95102e3-3968-361f-2e2a-a22989519480@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <60846277-93f6-1514-26d8-2878be7b8f1c@gmail.com>
Date:   Thu, 11 Oct 2018 21:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f95102e3-3968-361f-2e2a-a22989519480@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 11/10/2018 à 17:16, Phillip Wood a écrit :
> On 07/10/2018 20:54, Alban Gruin wrote:
>> Just like complete_action(), edit_todo_list() used a
>> function (transform_todo_file()) that read the todo-list from the disk
>> and wrote it back, resulting in useless disk accesses.
>>
>> This changes edit_todo_list() to call directly todo_list_transform()
>> instead.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>>   rebase-interactive.c | 40 +++++++++++++++++++---------------------
>>   1 file changed, 19 insertions(+), 21 deletions(-)
>>
>> diff --git a/rebase-interactive.c b/rebase-interactive.c
>> index 7c7f720a3d..f42d48e192 100644
>> --- a/rebase-interactive.c
>> +++ b/rebase-interactive.c
>> @@ -78,39 +78,37 @@ void append_todo_help(unsigned edit_todo, unsigned
>> keep_empty,
>>     int edit_todo_list(unsigned flags)
>>   {
>> -    struct strbuf buf = STRBUF_INIT;
>>       const char *todo_file = rebase_path_todo();
>> +    struct todo_list todo_list = TODO_LIST_INIT;
>> +    int res = 0;
>>   -    if (strbuf_read_file(&buf, todo_file, 0) < 0)
>> +    if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>           return error_errno(_("could not read '%s'."), todo_file);
>>   -    strbuf_stripspace(&buf, 1);
>> -    if (write_message(buf.buf, buf.len, todo_file, 0)) {
>> -        strbuf_release(&buf);
>> -        return -1;
>> -    }
>> -
>> -    strbuf_release(&buf);
>> +    strbuf_stripspace(&todo_list.buf, 1);
>> +    if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
>> +        todo_list_transform(&todo_list, flags | TODO_LIST_SHORTEN_IDS);
>>   -    transform_todo_file(flags | TODO_LIST_SHORTEN_IDS);
>> -
>> -    if (strbuf_read_file(&buf, todo_file, 0) < 0)
>> -        return error_errno(_("could not read '%s'."), todo_file);
>> +    append_todo_help(1, 0, &todo_list.buf);
>>   -    append_todo_help(1, 0, &buf);
> 
> I think this patch is fine, I was just wondering if you meant to move
> the call to append_todo_help() above the blank line?
> 

No

> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

