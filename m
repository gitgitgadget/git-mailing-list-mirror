Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707921F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbcJTWkO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 18:40:14 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33514 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbcJTWkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 18:40:13 -0400
Received: by mail-pf0-f180.google.com with SMTP id 128so44608601pfz.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=09yXXa9ZYB09ynV25PjMgVeXp9SqaavxjIocEioCNx8=;
        b=gsdnIYXpuhoa6v/j6JXskb+hjJQWcbofcsosFtrXtzF4Y/bTZGB97ELo70q1aKfSDp
         vN4JNu6ItzNRxekqbZZqK6Wnw3Xe9p1pD+lW0yMaenWKsLHmHn6/KGVvSpGfO4ymCJNR
         JtQPLA92NZ+/DEtEQzJMOHVat++BLeBm4+ObqPSYN85dvxAMKev8pFcYhtvaA7FcAI9E
         RrSY2F4lNppmbp57C5LNrZAIkhc5kQMup9kD2KmDuitjdajbjI0Ly5aWK+EK24wVCY26
         LizypccQPRrscRg5jskWB2+O7daz8Sn34H87y9d7b/C1WrcC7pGC+kCUPwt1QXxuP4W/
         tZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=09yXXa9ZYB09ynV25PjMgVeXp9SqaavxjIocEioCNx8=;
        b=Ae9PBWd2xnNf+o1oRa6nOECzjxyRqJVyp6191Br/0eQirojiAOCivWtIO2OrFbbOC6
         0A4mS57XvXWC9WRoZ4diTJbiSVhclRFVYjWMzXu4ERMNX6KsQzoaCob5BMpbs8Osmh5k
         ydIXLXmk4ze01gQ+ONlEvG3Uldix7O/+7yLvRbl485/q1PAUFkZ7DGn8wM/BxgxUcr7F
         JbcOyq+HB1UrpvTSZlQge4jFE+V+5JlTEVanv8BIG2cG2lfF/tE8GmkMLKeH/SGoVx8i
         wo1PjUu88wcOZGNLZw7dqYLW3UBGGSLsPDeU0jG7yCgdwIW2w5kjTO2C6IqHNwndD98e
         j3bw==
X-Gm-Message-State: AA6/9Rmt8kmPW6TaBuQDOYkoxSVRFdA63QB9o9ulnQ5JuW7RW/Y4tzTKTdhRAP9NJCKaVrnw
X-Received: by 10.98.25.67 with SMTP id 64mr5572819pfz.46.1477003212698;
        Thu, 20 Oct 2016 15:40:12 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:7cf8:6ddc:3f3c:18d4])
        by smtp.gmail.com with ESMTPSA id p3sm13519625pfg.48.2016.10.20.15.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2016 15:40:10 -0700 (PDT)
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476998988.git.jonathantanmy@google.com>
 <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
 <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
 <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
Date:   Thu, 20 Oct 2016 15:40:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/20/2016 03:14 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> +static int find_separator(const char *line)
>>> +{
>>> +       const char *c;
>>> +       for (c = line; ; c++) {
>>> +               if (!*c || *c == '\n')
>>> +                       return -1;
>>> +               if (*c == '=' || strchr(separators, *c))
>>> +                       return c - line;
>>> +       }
>>
>> I was about to suggest this function can be simplified and maybe
>> even inlined by the use of strspn or strcspn, but I think manual
>> processing of the string is fine, too, as it would not really be shorter.
>
> Hmm, I fear that iterating over a line one-byte-at-a-time and
> running strchr(separators, *c) on it for each byte has a performance
> implication over running a single call to strcspn(line, separators).

If we do that, there is also the necessity of creating a string that 
combines the separators and '=' (I guess '\n' is not necessary now, 
since all the lines are null terminated). I'm OK either way.

(We could cache that string, although I would think that if we did that, 
we might as well write the loop manually, like in this patch.)
