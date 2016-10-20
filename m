Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996BC1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 22:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbcJTWpi (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 18:45:38 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34593 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbcJTWph (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 18:45:37 -0400
Received: by mail-pf0-f173.google.com with SMTP id r16so44455274pfg.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 15:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AhcAgsv6gNc+/lj9mHy3uyTPz3EihG+mHsm+vTRCnqc=;
        b=MVhHhAqyBevXI+vLHv4+Ka40JgdzrMkiTdKzTsOlnelAUipA2W/EhO88rG9QLQ4jTL
         jpRrrmWx12+Bqru6/DeabqOohBJ4NQmgGGP1aezCtkbq9kIeV+20C07PJDzdJslZYwjD
         50YYP1iEfzH7LVRmeBwnPUlcXAWEIbWVWCjUsQRcGwMpcRRmX0+R5ak0+MetzZVfh8Hf
         0nRfZZigjLIqSmU3a0okTo/MWW2pj+fJEVvbmqmgBo3uPcm6lcQVZfRff4Ww/NuypW2S
         PalUrFUIsTy02WXVXxOis13TugIR0cLmlGAeiSWK9UwuYXWe+ki4IEQa0lhRMmBre9g6
         DMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AhcAgsv6gNc+/lj9mHy3uyTPz3EihG+mHsm+vTRCnqc=;
        b=GqMDFwNSGK0cF2yoKO+Rvz8TZnzYaZvFEznZ8tcDcA80el+lbiTt4DGRsm8mfO2Ogk
         FLSaedj5CL4pnkly/gpmz06aMHbh/34ili1ZLE3gUn+uIs2JemaYwxwoYAGnygnCAXKW
         FtgRKzD6bxGauC9a0b/jnStkukwoCTQCLffghTrZrpWCxD0zptMadpZg5beHqFd5tC9I
         GbeFGKeIDTHS89zIlSSsCPJP5Rh5L2slmGobOx2vWnDzygpTPYBIYp07xxY5fkdhk8eX
         /XKl0LYHQd15IwNvWKYQOn71vIe/1Y7IBjEhR3RFhOlp3X/gDgAO4vSCoLHMFCkZ4ZJt
         4Ytw==
X-Gm-Message-State: AA6/9RlsbA/vstFWxd0CE8iwizW2LV21zrfVV91Hen6lIlgmMpafmbOPKLlgapmaQuvIXYsd
X-Received: by 10.99.116.76 with SMTP id e12mr4573569pgn.20.1477003536586;
        Thu, 20 Oct 2016 15:45:36 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:7cf8:6ddc:3f3c:18d4])
        by smtp.gmail.com with ESMTPSA id z3sm29613698paw.48.2016.10.20.15.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2016 15:45:35 -0700 (PDT)
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476998988.git.jonathantanmy@google.com>
 <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
 <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
 <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
 <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <d7d2c001-a411-424c-7da0-4ef615da9a54@google.com>
Date:   Thu, 20 Oct 2016 15:45:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/20/2016 03:40 PM, Jonathan Tan wrote:
> On 10/20/2016 03:14 PM, Junio C Hamano wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> +static int find_separator(const char *line)
>>>> +{
>>>> +       const char *c;
>>>> +       for (c = line; ; c++) {
>>>> +               if (!*c || *c == '\n')
>>>> +                       return -1;
>>>> +               if (*c == '=' || strchr(separators, *c))
>>>> +                       return c - line;
>>>> +       }
>>>
>>> I was about to suggest this function can be simplified and maybe
>>> even inlined by the use of strspn or strcspn, but I think manual
>>> processing of the string is fine, too, as it would not really be
>>> shorter.
>>
>> Hmm, I fear that iterating over a line one-byte-at-a-time and
>> running strchr(separators, *c) on it for each byte has a performance
>> implication over running a single call to strcspn(line, separators).
>
> If we do that, there is also the necessity of creating a string that
> combines the separators and '=' (I guess '\n' is not necessary now,
> since all the lines are null terminated). I'm OK either way.
>
> (We could cache that string, although I would think that if we did that,
> we might as well write the loop manually, like in this patch.)

Actually I guess we could generate the separators_and_equal string 
whenever we obtain new separators from the config. I'll do this in the 
next reroll.
