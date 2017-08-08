Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756E820899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbdHHWeN (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:34:13 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34219 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdHHWeM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:34:12 -0400
Received: by mail-pf0-f177.google.com with SMTP id o86so19973153pfj.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Cfl6icYz6rVOfJX5kU6crFSN7qz/unHwMDuHmMJ7iE=;
        b=cyBMiVnTwQxt3lckG5C3dO0B4WYv4V7GmHaJ6lSHMp23rcf+zVHo95aD4y061c2ooM
         jYQikmTGEOosyOZ/wNnNZnJTbDG7TDxPAF0vgp/q+lvql2FFanxDsDMX3TkyzzbcLNy+
         FGrZ2yeinAMsId5ncbiRmffTzvAnW7nXL/4xtALKMsNZt9FhPZA+a44jWooQDyd3+Te4
         JlqVZSDUbhgbZqsIhSo3jOCyC4LLE2dA58cJt8HozYh9h4NTXVwKtAE7APXsPsiU7KSR
         JuN03FIZyE42bwEG7daQwRUBwDDLZX4ktFZnnVr9/zHQpiZPRBIwRhX/Ukr3GwyEYj0p
         Z34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Cfl6icYz6rVOfJX5kU6crFSN7qz/unHwMDuHmMJ7iE=;
        b=QsT4+p7x7/Ok7OErlsf9AqWMbVs3j6pITcEbcSU/+gHGdXislZsjBf5PBk3B3nWDD+
         DcysKr/52IayR6Xeg9XljuqB2LW7G+yJArmrz2KTAx1QhPcic/IAOGyeX/kibvqFDn9X
         x8/K7uHhUjg/4uOvjKD+DH/hDoZejUucWCk/1HZFEpy1oKmwRUoSMaKc7AG6g4cPjHS+
         Tw/kkctzuga7BgCf+CbULw1dvOvzhZZ+QqcbUIQBc3h8ytQLYfqYQTDCmXXMBVXY7nA7
         IQG4QAFoP+8fGO5GPRVFvEHC6IXaD4yxMAsm8sFvSdwvrbWG8IiKlDJZLmSHujVdbfbW
         BCvg==
X-Gm-Message-State: AHYfb5hDJQ1/uqFklkMCyMQ8BZh5OUoRbt0YNVvxblheJkGO1/qzqRW0
        ygJJo0JYNEKKxg==
X-Received: by 10.98.193.68 with SMTP id i65mr6198693pfg.142.1502231651893;
        Tue, 08 Aug 2017 15:34:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:d173:771d:dd07:d344])
        by smtp.gmail.com with ESMTPSA id 67sm4139488pfa.75.2017.08.08.15.34.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 15:34:10 -0700 (PDT)
Date:   Tue, 8 Aug 2017 15:34:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/add: add a missing newline to an stderr message
Message-ID: <20170808223407.GB169894@aiede.mtv.corp.google.com>
References: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
 <2821200b-0428-a5dd-9680-f291cee0ec47@web.de>
 <xmqqefslaerf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqefslaerf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:

>>> diff --git a/builtin/add.c b/builtin/add.c
>>> index e888fb8c5..385b53ae7 100644
>>> --- a/builtin/add.c
>>> +++ b/builtin/add.c
>>> @@ -43,7 +43,7 @@ static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
>>>   			continue;
>>>   
>>>   		if (chmod_cache_entry(ce, force_mode) < 0)
>>> -			fprintf(stderr, "cannot chmod '%s'", ce->name);
>>> +			fprintf(stderr, "cannot chmod '%s'\n", ce->name);
>>>   	}
>>>   }
>>
>> FYI: I brought this up yesterday in the original thread, along with a
>> few other observations:
>>
>>   https://public-inbox.org/git/3c61d9f6-e0fd-22a4-68e0-89fd9ce9b944@web.de/
>>
>> Not sure if the discussion can or should be revived after all this
>> time, though; just sending patches like yours might be the way to go.
>
> Thanks, so it should become
>
> 	fprintf(stderr, "cannot chmod %c '%s'\n", force_mode, ce->name);
>
> in the final version to be queued?

I don't believe the force_mode without an 'x' provides a clear signal
to the end user.  Perhaps you meant %cx?

Thanks,
Jonathan
