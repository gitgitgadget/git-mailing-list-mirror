Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BFC20954
	for <e@80x24.org>; Tue,  5 Dec 2017 03:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdLEDmr (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 22:42:47 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:44071 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdLEDmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 22:42:46 -0500
Received: by mail-it0-f44.google.com with SMTP id b5so18174099itc.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 19:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VJ4NddSejhztsgZDgINs3KvPr1zudoSIDoV6SJK+xtE=;
        b=I5RAg26x+zGtFLWtJFe17VFlf0VZkvVD2lGj9Cm9mDeor64mAEeO5J9uW7D0Ng83px
         G8TzG2qITQhvutbOqyOJ0lRzdJyAwRd090l6nu8F3tOMa+tgiTsZ7xmyff3x2Kq/FQj0
         WD2np7MmVvwucChwgfvIHAce73WSASWtfb5fn3e3Ok0AKWhATcaB+ZHMsi+r28S7M7kp
         Xhm6cgbP8//5subPVuBxb42YeB5LRr13PL2KC0k2HE+P3Pylr+EKseISTqSqG3aztued
         XDEx/1iXdSpzoLgyVYqFVFPguUATVHrjR351NCLJLKjM9IU59QrLMPaaVLo7MU1orD5W
         LPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJ4NddSejhztsgZDgINs3KvPr1zudoSIDoV6SJK+xtE=;
        b=QTV13hCK07Sy5NF7O3gTLAUzoTC8Zuqpve/uXz9BELkomBbYfz0LtXWuQnLRdpJWm3
         oaUE3hamfDkkstGibq6ilS7NK1r1AkIKbZ+saXYVOG1CsL5EhhIsBW+Tff3puWLl665T
         IVEJZQhpHcq3JaQu7tZxcXMcjJOwabJtzeM4hJjgOgjhYgX6/Xhr4E4JO3U7pX5xfIMV
         iwbKCK+Hc+KG5n72EELNjpCcL9CPOGDbErnpt8xtlTYnmE4y4rxu7JrCJCj6zaLCKPtD
         SAAyQPnPmYetpH8T2Fu6SS3hHc6/Bl1EZ7iNGE52rs3FbWdJRHsRenmLjsCcfG8zZ0rk
         5ZZA==
X-Gm-Message-State: AJaThX6wS8hGg2/6FQVi+DbUEmUDn02aZe4Wy9huawLhII7rHxTo05R6
        V69LG5Lh+0z5lLmwi/M/mUo=
X-Google-Smtp-Source: AGs4zMZ2+9qbOyp9fw07KnL9JsHFOT4ZtZtHj5fmFb5S023aWc6ABb5JYm1n3WssRY0fj/9OKnb3SQ==
X-Received: by 10.107.198.23 with SMTP id w23mr25491830iof.181.1512445365474;
        Mon, 04 Dec 2017 19:42:45 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id b74sm4616532itd.19.2017.12.04.19.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 19:42:45 -0800 (PST)
Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-7-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <22f665eb-0ed1-27d4-7184-e6063ea5b47e@gmail.com>
Date:   Mon, 4 Dec 2017 22:42:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 04/12/17 10:46 AM, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Sun, 3 Dec 2017, Liam Beguin wrote:
> 
>> diff --git a/sequencer.h b/sequencer.h
>> index 4e444e3bf1c4..3bb6b0658192 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -45,10 +45,12 @@ int sequencer_continue(struct replay_opts *opts);
>>  int sequencer_rollback(struct replay_opts *opts);
>>  int sequencer_remove_state(struct replay_opts *opts);
>>  
>> -int sequencer_make_script(int keep_empty, FILE *out,
>> -		int argc, const char **argv);
>> +#define TODO_LIST_KEEP_EMPTY (1U << 0)
>> +#define TODO_LIST_SHORTED_IDS (1U << 1)
> 
> Maybe SHORTEN_IDs? And either revert back to transform_todo_ids() or use
> SHORTEN_INSNS...
> 

I'll change it to TODO_LIST_SHORTED_IDs. TODO_LIST_SHORTED_INSNS would
suggest the flag changes both parts of the todo.

> Maybe also TRANSFORM_TODO_LIST_* and maybe move the #define's above the
> transform_todo_ids() function, i.e. one line further down?
> 
>> +int sequencer_make_script(FILE *out, int argc, const char **argv,
>> +			  unsigned flags);
>>  
>> -int transform_todo_insn(int shorten_ids);
>> +int transform_todo_insn(unsigned flags);
>>  int check_todo_list(void);
>>  int skip_unnecessary_picks(void);
>>  int rearrange_squash(void);
> 
> Ciao,
> Johannes
> 

Thanks, 
Liam
