Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDFA1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 14:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeF0Oys (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 10:54:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45170 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933868AbeF0Oyr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 10:54:47 -0400
Received: by mail-wr0-f193.google.com with SMTP id u7-v6so2350489wrn.12
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FVUkj0mKYyKhcL55v/EH+Z4O90IOz527PNHJgx0lvvk=;
        b=dxgC0sXQQvtkSX6rwYfY8L3yYUaEiQkL0M8fiwVJY2vQK17B5mcLogx1IIahTUSsPY
         GeYxqII5jPxH1OSPsnmVSqLO2QUUbdzNWCCulx0bnp08O/IdhlFiyaocIqb2b7ybvd5B
         eQRG/UXQSzbZU0zxINwHyNnzQjTrpCeIaIrSCslvghJr40Rs5C9ojJIrZY6Q7Ndqdm5L
         cmO9TP/fiGLrG5/QouMj3sK2zki86xODTKGA/TVGZt9jZ5P8+V6PRHKK5iEc+cUNF5ab
         +Nw7VyRdTK18nEBXmpRjlqFyskZEti0+UYKgboRpsGT7tLdKJUhlrQDQ9yajmb08cC5Q
         8+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVUkj0mKYyKhcL55v/EH+Z4O90IOz527PNHJgx0lvvk=;
        b=tGdHmcwt8PqAkjxC8L1QCp5v5LucHeNuqhRwKvDYAYOXKowLIwdWoopJ5NqU5xN7Ry
         CztDx8ZSIUgccuJucDLn3iEA/mhbFb4djZh3ntdfsuOu7Sm+MKZCES86VLO0Sj/xW1w0
         oUBSZ7kLMI/OVYizfmQNCf74prAQG+7qz14cx/Bb2iy2k50H1lW3ebmPfobJJvHol0oq
         CMW1FNTOvXmdSrx1QyZdYdxT//WLzAhUdZUGWaEYHxYzJUT8s4OGJwvYX+vsYQ1EznO2
         g1nBeftPb0jIF0ras8UlfWpDoV6LxYXCEbPKeCKXBWb59J/7x9KKivB8jGjoD5xhKHa8
         CEHA==
X-Gm-Message-State: APt69E0GCA1FbiE9S/jmR//z6gqdSDMXMaSCt5TAq6THms9pIzmSu1kc
        57qMj+LBXAM9TJUtVN3JOeQ=
X-Google-Smtp-Source: AAOMgpeJS8ZRq/PHVkd0hwf8BaPsLu91Ec/oKIAFQuFog+hDaqiDv8H5M2ywlxygeVvcZsvF4YwQjw==
X-Received: by 2002:adf:a18f:: with SMTP id u15-v6mr5399403wru.194.1530111286625;
        Wed, 27 Jun 2018 07:54:46 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.gmail.com with ESMTPSA id r123-v6sm7004489wmb.21.2018.06.27.07.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 07:54:45 -0700 (PDT)
Subject: Re: [GSoC][PATCH v4 1/2] sequencer: make two functions and an enum
 from sequencer.c public
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
References: <20180607103012.22981-1-alban.gruin@gmail.com>
 <20180626161643.31152-1-alban.gruin@gmail.com>
 <20180626161643.31152-2-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.1806262337360.21419@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <e2d8310a-0bbc-b786-97c1-e32c2090aca9@gmail.com>
Date:   Wed, 27 Jun 2018 16:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1806262337360.21419@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 26/06/2018 à 23:41, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Tue, 26 Jun 2018, Alban Gruin wrote:
> 
>> diff --git a/sequencer.h b/sequencer.h
>> index c5787c6b5..08397b0d1 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -3,6 +3,7 @@
>>  
>>  const char *git_path_commit_editmsg(void);
>>  const char *git_path_seq_dir(void);
>> +const char *rebase_path_todo(void);
>>  
>>  #define APPEND_SIGNOFF_DEDUP (1u << 0)
>>  
>> @@ -57,6 +58,10 @@ struct replay_opts {
>>  };
>>  #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
>>  
>> +enum check_level {
>> +	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
>> +};
>> +
> 
> While this is contained within scopes that include `sequencer.h`, it *is*
> public now, so I am slightly uneasy about keeping this enum so generic.
> Maybe we want to use
> 
> enum missing_commit_check_level {
> 	MISSING_COMMIT_CHECK_IGNORE = 0,
> 	MISSING_COMMIT_CHECK_WARN,
> 	MISSING_COMMIT_CHECK_ERROR
> };
> 
> instead?
> 

You’re right, this would be better.

Cheers,
Alban

