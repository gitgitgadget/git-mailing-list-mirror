Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AD51F453
	for <e@80x24.org>; Tue, 23 Oct 2018 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJXDMW (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:12:22 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37916 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeJXDMW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:12:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id a202so1544332vsd.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+yPlaFsuCGMqsd7timWg8NprujASjfaHPDDWShPcUKI=;
        b=EMsS3ybc33FEhWnecgcX9kwF7NcdFpRTM0mrPVu/cpayI6HXYKWaKdcOZ8N01cD3Ow
         xOAbKtbg5MiZDehsjI7HW5E3sfc7AsTnSFlEiG/iYGhYxW7kIZuVy6CPie97VVwNxMaw
         Gprv8mxAXCi3IpBm1RT16rLdmtjKdTp75OglW6nfn+ULGXe9ovZnyzsTuzlV22FU6PL9
         zxgIQEGrtAKIkCC8ibSQhO93A7NnoOUsyn05hLRfNV8y6JmVvdYg483L2c9INVvZapYy
         rHcyaZVIHggI3h1ggZgXCFovS7ryPHRkA4FbTeloZA+AU/I7h6rhiPvQ81bygFm+YUxF
         ESoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+yPlaFsuCGMqsd7timWg8NprujASjfaHPDDWShPcUKI=;
        b=UmaMm4AcFjiQhX4mS+uGvHNoVQ2WED49ql54apIYXq0Z9FQBlulyMCsrGqb1wsIBl9
         hrEcuFEnLMv+AOps9oMh6CKFxZP6o7TClW+xKssLEHba6Sh7/w2or9mh5CdQXejgNyYb
         B+HEbVuPT4KNNgVVqk7kFv0oy2Aaw11DQaHFR0lfqsfaRAs1z6S47mpRErV7lGhP554p
         q7IFzxKf5/TDwlXpiag6AKJ0Szvkx2AkElLWPZhIbap9Y6f9IBTCqoABl6vK+Vgrpwmn
         7pVpFwFwOPcChmKNt8TsEn44B7JCgR6JSuAmDa+GlQQk1DDoEV0XWw+hGX7w5LVona+A
         8hJA==
X-Gm-Message-State: ABuFfojU8QRdn/4c3ywDbPoEsFH0zfsxOfdcoO/tHRBJ5/oQIUDZQraA
        L5yJ//3dGMafj32Y6BKDZa8=
X-Google-Smtp-Source: ACcGV61v8DXcPlS4DQVXIZrY3Uy9Vwnn0CRs8e/T6KmsMsE4Oo2Zrey7jGlu16Maqt1dDbwivtjVcg==
X-Received: by 2002:a67:1b85:: with SMTP id b127mr21471789vsb.190.1540320465523;
        Tue, 23 Oct 2018 11:47:45 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b134sm492789vke.17.2018.10.23.11.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 11:47:44 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-3-peartben@gmail.com>
 <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com>
Date:   Tue, 23 Oct 2018 14:47:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/2018 10:45 AM, Duy Nguyen wrote:
> On Mon, Oct 22, 2018 at 3:38 PM Ben Peart <peartben@gmail.com> wrote:
>>
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> Add a reset.quiet config setting that sets the default value of the --quiet
>> flag when running the reset command.  This enables users to change the
>> default behavior to take advantage of the performance advantages of
>> avoiding the scan for unstaged changes after reset.  Defaults to false.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>   Documentation/config.txt    | 3 +++
>>   Documentation/git-reset.txt | 4 +++-
>>   builtin/reset.c             | 1 +
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index f6f4c21a54..a2d1b8b116 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2728,6 +2728,9 @@ rerere.enabled::
>>          `$GIT_DIR`, e.g. if "rerere" was previously used in the
>>          repository.
>>
>> +reset.quiet::
>> +       When set to true, 'git reset' will default to the '--quiet' option.
>> +
> 
> With 'nd/config-split' topic moving pretty much all config keys out of
> config.txt, you probably want to do the same for this series: add this
> in a new file called Documentation/reset-config.txt then include the
> file here like the sendemail one below.
> 

Seems a bit overkill to pull a line of documentation into a separate 
file and replace it with a line of 'import' logic.  Perhaps if/when 
there is more documentation to pull out that would make more sense.

>>   include::sendemail-config.txt[]
>>
>>   sequence.editor::
