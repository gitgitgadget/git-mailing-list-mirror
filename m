Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A03D1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 15:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfKDPLJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 10:11:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41932 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfKDPLI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 10:11:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so17485665wrm.8
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 07:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J6FyvWQpXxz8qrRHlCp/Jr4UXQpTS+Yo82hoqyKsqTg=;
        b=a/z6lTQ4vpfD79Bo5nizkh+R0KqrVsnC1+bYt68LmIjWw6Dq+c1VvNcVQITWBRi/jq
         xq4FOHnatK0AdE+msz1YAb3MaG/IUwUliKndwRN7NT36ZoY6F+W+XrGpVaocZ/cpZknh
         mtGijgQGAv5TPW6KvZ8YtUfD9M7wKjmmWVKCmFG7xiJNg5GoZ3w2do4LY14LIPdgBupV
         s+zsbx6FCTb5/sR2pq2fmZHk3KvKY9PHL8VpibEMiWfCd47zGS8MXVkpHGCg+TyYp/dW
         xtF6cYfe0A/nXwcwPUt8zQUcJ5UW27HqIzdNHsO9NoE/BhKVBHgVQ/qD5cOVUnAyB5v6
         lHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J6FyvWQpXxz8qrRHlCp/Jr4UXQpTS+Yo82hoqyKsqTg=;
        b=EapVFyvstHSo3bJ8O+JNg5JSWc5h7Y9eIpm9XNxClxiBwhi5TOWujx3j8I0j4iw1YS
         CSfYD6TQXGuLuQAbbW32ph7ZbmfY1HwqxRXLuUq0P+u5R1qIFubNkecMTPiTinR4Vkad
         LE2xcn8qPx07noE7CV+871/6dasAnaIE37rPa8P7DpdEVG1L14scDCKgcdoz86GqWx5n
         Mj0RP0X/JSVOwe4eghx2wOGroM8SfFvBeDfWxPlaWqYQV1Y+hB+DwxvTz/xb6JNY3U73
         loa8lSkUJsbQm0lJDofDNG5koF2QQJ41gGB3Gr0G2u3SbesCvwRZ92W3Z2R7LMhUuWDr
         sjtw==
X-Gm-Message-State: APjAAAVYZDg0ZUn/7Y4e4KEU9Sn8LRPJjcKVNNrZTqR4fDR8wF58TX5w
        ny9SDiS55lSH/hzsPs8yk+8tW1zu
X-Google-Smtp-Source: APXvYqz/oRfN0ZqnIx5H75X7Me05GYq30cTpJHL0DoIXBI6EVcw1I4TASifAmH22Y4o7kLo6BJsFaw==
X-Received: by 2002:adf:e505:: with SMTP id j5mr12874452wrm.46.1572880266088;
        Mon, 04 Nov 2019 07:11:06 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-26-138.as13285.net. [92.22.26.138])
        by smtp.gmail.com with ESMTPSA id g8sm4991823wmk.23.2019.11.04.07.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 07:11:05 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 30/32] ident.c: fix LGTM warning on the possible abuse of
 the '=' operator
To:     Elia Pinto <gitter.spiros@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
 <20191104102612.GE4348@szeder.dev>
 <CA+EOSBncQa0h1of+R2BBSw=tSNFmSASi2V5EJPaRNEO_ctvbkw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <98f12b0a-d16b-13e2-e413-9230d3d31783@gmail.com>
Date:   Mon, 4 Nov 2019 15:11:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CA+EOSBncQa0h1of+R2BBSw=tSNFmSASi2V5EJPaRNEO_ctvbkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elia

On 04/11/2019 13:55, Elia Pinto wrote:
> Il giorno lun 4 nov 2019 alle ore 11:26 SZEDER Gábor
> <szeder.dev@gmail.com> ha scritto:
>>
>> On Mon, Nov 04, 2019 at 09:59:21AM +0000, Elia Pinto wrote:
>>> Fix the LGTM warning of the rule that finds uses of the assignment
>>
>> What is an "LGTM warning"?
>>
>> I think including the actual compiler warning in the commit message
>> would be great.
> Yes indeed. I thought I did it, do you think i can do better? Thanks
> 
> https://lgtm.com/rules/2158670641/

It would have been helpful to explain that LGTM was a static analyser 
for those of us who did not know. As far the patch is concerned I'm not 
convinced it is an improvement. There are loads of places where git uses 
this pattern ("git grep 'if (([^=)]*=[^)]*)' | wc" shows 212). So long 
as the assignment is inside its own set of parentheses it's safe and gcc 
will warn if the parentheses are missing.

Best Wishes

Phillip

>>
>>> operator = in places where the equality operator == would
>>> make more sense.
>>>
>>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>>> ---
>>>   ident.c | 13 ++++++++-----
>>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/ident.c b/ident.c
>>> index e666ee4e59..07f2f03b0a 100644
>>> --- a/ident.c
>>> +++ b/ident.c
>>> @@ -172,12 +172,15 @@ const char *ident_default_email(void)
>>>                        strbuf_addstr(&git_default_email, email);
>>>                        committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>>>                        author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>>> -             } else if ((email = query_user_email()) && email[0]) {
>>> -                     strbuf_addstr(&git_default_email, email);
>>> -                     free((char *)email);
>>> -             } else
>>> -                     copy_email(xgetpwuid_self(&default_email_is_bogus),
>>> +             } else {
>>> +                     email = query_user_email();
>>> +                     if (email && email[0]) {
>>> +                             strbuf_addstr(&git_default_email, email);
>>> +                             free((char *)email);
>>> +                     } else
>>> +                             copy_email(xgetpwuid_self(&default_email_is_bogus),
>>>                                   &git_default_email, &default_email_is_bogus);
>>> +             }
>>>                strbuf_trim(&git_default_email);
>>>        }
>>>        return git_default_email.buf;
>>> --
>>> 2.24.0.rc0.467.g566ccdd3e4.dirty
>>>
